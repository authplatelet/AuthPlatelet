using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Xml;
using System.Collections.Concurrent;
using System.Configuration;
using System.Web.Configuration;

namespace CST
{
    public class CST_Ops
    {
        private static ConcurrentDictionary<string, MethodRecord> methodSHADict = new ConcurrentDictionary<string, MethodRecord>();
        private static ConcurrentDictionary<string, MethodRecord> methodSHADictKEYSHA = new ConcurrentDictionary<string, MethodRecord>();
        private static ConcurrentDictionary<string, bool> SymTResultCache = new ConcurrentDictionary<string, bool>();
        private static DLLServerUploader uploader = new DLLServerUploader();
        private static DLLServerDownloader downloader = new DLLServerDownloader();
        static public string myPartyName;
        static public HashSet<string> trustedParties = new HashSet<string>();
        private static ConcurrentDictionary<string, bool> VerificationCache = new ConcurrentDictionary<string, bool>();

        static CST_Ops()
        {
            if (HttpContext.Current == null) return;

            Configuration webConfig = WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);

            if (webConfig.AppSettings.Settings.Count > 0)
            {
                KeyValueConfigurationElement partySetting =
                    webConfig.AppSettings.Settings["MyPartyName"];
                if (partySetting != null)
                {
                    myPartyName = partySetting.Value;
                }
                else
                {
                    myPartyName = @"";
                }

                KeyValueConfigurationElement truestedPartySetting =
                    webConfig.AppSettings.Settings["TrustedParty"];
                if (truestedPartySetting != null)
                {
                    string trustedP = truestedPartySetting.Value;
                    trustedParties = new HashSet<string>(trustedP.Split(new char[] { ',', ' ' }));
                }
                trustedParties.Add(myPartyName);
            }
        }


        public static void recordme(Object o, CST_MSG in_msg, CST_MSG out_msg, bool signed)
        {
            StackTrace st = new StackTrace();
            StackFrame sf = st.GetFrame(1);
            Type t = st.GetType();
            Console.WriteLine(t);
            MethodInfo mi = (MethodInfo)sf.GetMethod();

            recordme(o, in_msg, out_msg, mi, myPartyName, signed, false);
        }
        public static void recordme(Object o, CST_MSG in_msg, CST_MSG out_msg, bool signed, bool server_to_server)
        {
            StackTrace st = new StackTrace();
            StackFrame sf = st.GetFrame(1);
            Type t = st.GetType();
            Console.WriteLine(t);
            MethodInfo mi = (MethodInfo)sf.GetMethod();

            recordme(o, in_msg, out_msg, mi, myPartyName, signed, server_to_server);
        }

        public static void recordme(Object o, CST_MSG in_msg, CST_MSG out_msg)
        {
            StackTrace st = new StackTrace();
            StackFrame sf = st.GetFrame(1);
            Type t = st.GetType();
            Console.WriteLine(t);
            MethodInfo mi = (MethodInfo)sf.GetMethod();

            recordme(o, in_msg, out_msg, mi, myPartyName, false, false);
        }

        public static void recordme(Object o, CST_MSG in_msg, CST_MSG out_msg, MethodInfo mi, string partyName, bool signed, bool server_to_server)
        {
            Type objT = o.GetType();
            var t = mi.ReflectedType;

            string rootClass = GetRootClassName(t);

            string className = objT.FullName;
            className = className.Replace("\\", string.Empty).Replace('+', '.');

            string methodName = mi.Name;

            ParameterInfo[] pi = mi.GetParameters();
            string[] args = new string[pi.Length];
            string argType = "";

            if (pi.Length > 0)
            {
                argType = pi[0].ParameterType.FullName;
                argType = argType.Replace("\\", string.Empty).Replace('+', '.');

            }

            string returnType = mi.ReturnType.FullName;

            returnType = returnType.Replace("\\", string.Empty).Replace('+', '.');

            string methodkey = returnType + " " + className + " " + rootClass + "." + methodName + "(" + argType + ")";
            string sha = "0000000000000000000000000000000000000000";
            
            if (!methodSHADict.ContainsKey(methodkey))
            {
                string dllName = objT.Module.FullyQualifiedName;

                string path = Path.GetDirectoryName(dllName);
                string name = Path.GetFileNameWithoutExtension(dllName);

                var descriptionAttribute = objT.Module.Assembly
                                                    .GetCustomAttributes(typeof(AssemblyDescriptionAttribute), false)
                                                    .OfType<AssemblyDescriptionAttribute>()
                                                    .FirstOrDefault();

                if (descriptionAttribute != null)
                    sha = descriptionAttribute.Description;

                MethodRecord mr = new MethodRecord(className, rootClass, methodName, argType, returnType, name + "." + sha);

                MethodHasher.saveMethod(mr);

                uploader.uploadMethodRecord(MethodHasher.methodsFolder + "\\" + mr.getSHA() + ".txt", mr.getSHA());

                methodSHADict.AddOrUpdate(methodkey, mr, (k, v) => v);
                methodSHADictKEYSHA.AddOrUpdate(mr.getSHA(), mr, (k, v) => v);

                sha = mr.getSHA();
            }
            else
            {
                sha = methodSHADict[methodkey].getSHA();
            }

            string colons = ":";

            if (signed)
                colons = "::";

            string in_msg_symT = in_msg.SymT;

            if (server_to_server)
            {
                int idx = in_msg_symT.IndexOf('(');

                if (idx != -1)
                    in_msg_symT = '(' + in_msg_symT.Substring(0, idx) + '(' + in_msg_symT.Substring(idx, in_msg_symT.Length - idx) + "))";
            }

            out_msg.SymT = partyName + colons + sha + "(" + in_msg_symT + ")";
        }

        public static string GetRootClassName(Type type)
        {
            while (type.BaseType != typeof(Object))
            {
                type = type.BaseType;
            }

            return type.Name;
        }

        public static bool Certify(CST_MSG msg)
        {
            RemoveUntrustedSymTPart(msg);

            if (!SymTResultCache.ContainsKey(msg.SymT))
            {
                bool resultOfVerification = uploader.verify(msg.SymT);

                SymTResultCache[msg.SymT] = resultOfVerification;
            }

            return SymTResultCache[msg.SymT];
        }

        public static bool CertifyLocally(CST_MSG msg)
        {
            RemoveUntrustedSymTPart(msg);

            if (!SymTResultCache.ContainsKey(msg.SymT))
            {
                List<MethodRecord> mrList = MethodHasher.getDehashedRecords(methodSHADictKEYSHA, msg);

                VProgramGenerator.EditCSproj(mrList);
                VProgramGenerator.generateVProgram(mrList);

                bool resultOfVerification = VProgramGenerator.verify();
                SymTResultCache[msg.SymT] = resultOfVerification;
            }

            return SymTResultCache[msg.SymT];
        }

        public static bool Certify(string SymT, string vPath)
        {
            List<MethodRecord> methodList = MethodHasher.getDehashedRecords(SymT);

            VProgramGenerator.generateVProgram(methodList, vPath);
            VProgramGenerator.EditCSproj(methodList, vPath);
            bool resultOfVerification = VProgramGenerator.verify(vPath);

            return resultOfVerification;
        }

        private static void RemoveUntrustedSymTPart(CST_MSG msg)
        {
            string peeledSymT = msg.SymT;
            int pos = 0, st_of_sym = 0, brk_cnt = 0;
            bool signed_symT = true;

            for (; pos < msg.SymT.Length && msg.SymT[pos] != ')'; pos++)
            {
                if (msg.SymT[pos] == ':')
                {
                    if (msg.SymT[pos + 1] == ':' || signed_symT)
                    {
                        string partyN = msg.SymT.Substring(st_of_sym, pos-st_of_sym);

                        if (!trustedParties.Contains(partyN))
                        {
                            peeledSymT = peeledSymT.Substring(0, st_of_sym) + new String(')', brk_cnt);
                            break;
                        }

                        if (msg.SymT[pos + 1] == ':')
                            pos++;
                    }
                    else
                    {
                        peeledSymT = peeledSymT.Substring(0, st_of_sym) + new String(')', brk_cnt);
                        break;
                    }
                }
                if (msg.SymT[pos] == '(')
                {
                    brk_cnt++;
                    if (msg.SymT[pos + 1] == '(')
                    {
                        signed_symT = true;
                        pos++;
                        brk_cnt++;
                    }
                    else
                        signed_symT = false;

                    st_of_sym = pos + 1;
                }
            }

            msg.SymT = peeledSymT;
        }

        static string dehash_server_host = "http://protoagnostic.cloudapp.net:8500/";
        static string upload_path = "Hash/CodeToHash";
//        static string dehash_path = "Hash/HashToCode";
        static Dictionary<string, string> codeHashMap = new Dictionary<string, string>();

        //a.com:CALL1    -- colon controlled by bSelfSuppliedInput
        static public string ConstructSymT(string methodCall, bool bSigned)
        {
            return String.Format("{0}{1}{2}", myPartyName, bSigned ? "::" : ":", methodCall);
        }

        //hash1(Sym_T1)    -- parentheses controlled by bSelfSuppliedInput
        static public string ConstructSimpleCall(string srcHash, string SymT_in, bool bSelfSuppliedInput)
        {
            return String.Format("{0}{1}{2}{3}", srcHash,
                                bSelfSuppliedInput ? "((" : "(",
                                SymT_in,
                                bSelfSuppliedInput ? "))" : ")");
        }

        //input = a.com:hash1(...) and hash2
        //output= hash2((a.com:hash1((...))))
        static public string ConstructServerServerCall(string SymT_ServerServerCall, string srcHash_postCall)
        {
            SymT_ServerServerCall = ChangeToDoubleParentheses(SymT_ServerServerCall);
            return String.Format("{0}(({1}))", srcHash_postCall, SymT_ServerServerCall);
        }

        static string ChangeToDoubleParentheses(string SymT_ServerServerCall)
        {
            int pos = SymT_ServerServerCall.IndexOf(myPartyName);
            if (pos < 2) return SymT_ServerServerCall;
            if (SymT_ServerServerCall[pos - 1] == '(' && SymT_ServerServerCall[pos - 2] != '(')
                return String.Format("{0}({1})", SymT_ServerServerCall.Substring(0, pos - 1), SymT_ServerServerCall.Substring(pos - 1));
            else
                return SymT_ServerServerCall;
        }

        //this function converts a piece of code to a hash
        public static string code_to_hash(string code)
        {

            foreach (KeyValuePair<string, string> entry in codeHashMap)
            {
                if (entry.Value == code)
                {
                    return entry.Key;
                }
            }

            //resp is in the format of OK|HASH or Error: ERROR MESSAGE
            string resp = HTTP.HTTPComm.HttpPost(dehash_server_host + upload_path, code);
            string hash = "";

            if (resp.IndexOf("Error") != -1)
            {
                Console.WriteLine(resp);
            }
            else
            {
                string[] split = resp.Split(new char[] { '|' });
                hash = split[1];
            }

            return hash;
        }

    }
}