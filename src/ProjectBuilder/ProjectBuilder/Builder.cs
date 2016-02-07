using CST;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;
using System.Text.RegularExpressions;
using System.Reflection;
using System.Diagnostics;

namespace ProjectBuilder
{

    class Builder
    {
        public static string CSTFolder = @"C:\CST\";
        public static string dllFolderName = @"dlls";
        public static string dllsFolder = @"C:\CST\dlls\";
        public static string builder_path = @"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe";
        public static string projNameTag = "AssemblyName";
        public static string sha_default = "0000000000000000000000000000000000000000";
        private static XNamespace msbuild = "http://schemas.microsoft.com/developer/msbuild/2003";
        private static DLLServerUploader uploader = new DLLServerUploader();
        private static DLLHasher hasher = new DLLHasher();
        private static string token;
        private static string token_file_name = "CIL_Server_token";

        public static void ReadWebConfig(string webConfig)
        {
            if (!File.Exists(webConfig)) return;

            XDocument projDefinition = XDocument.Load(webConfig);
            XElement configuration = projDefinition
                .Element("configuration");

            if (configuration == null) return;
            IEnumerable<XElement> settingList = configuration
                .Element("appSettings")
                .Elements("add");

            foreach (XElement element in settingList)
            {
                string key = element.Attribute("key").Value;
                string value = element.Attribute("value").Value;

                if (key == "CSTFolderPath")
                {
                    CSTFolder = value;
                    if (CSTFolder.EndsWith("\\"))
                        dllsFolder = CSTFolder + dllFolderName + @"\";
                    else
                        dllsFolder = CSTFolder + @"\" + dllFolderName + @"\";
                }
                else if (key == "Token")
                {
                    token = value;
                }
            }

        }


        public static void Build(string build_file)
        {
            string build_cmd = builder_path + " \"" + build_file + "\"";

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/c " + build_cmd;
            process.StartInfo = startInfo;
            process.Start();
            process.WaitForExit();
        }

        public static void CreateDep(string name, List<string> dependsList)
        {
            string output = CreateDepString(dependsList);
            string depFileName = name.Substring(0,name.Length-4) + ".dep";
            File.WriteAllText(depFileName, output);
        }

        public static string CreateDepString(List<string> dependsList)
        {
            StringBuilder sb = new StringBuilder();

            sb.Append("<References>\n");
            foreach (string dependency in dependsList)
            {
                sb.Append("\t<Reference>\n");
                sb.Append("\t\t" + dependency + "\n");
                sb.Append("\t</Reference>\n");
            }

            sb.Append("</References>\n");

            return sb.ToString();
        }

        public static List<string> GetDLLReference(IEnumerable<XElement> references, string build_file, string mode)
        {
            List<string> refList = new List<string>();

            foreach (XElement reference in references)
            {
                if (reference.Element(msbuild + "HintPath") != null)
                {
                    //                if (reference.Element(msbuild + "HintPath") != null)
                    //                {
                    //                    string dll_name = reference.Element(msbuild + "HintPath").Value;
                    string refered_prj = "", dll_name = "", dll_path = "";

                    dll_name = reference.Element(msbuild + "HintPath").Value;
                    dll_path = Path.GetDirectoryName(build_file) + @"\" + dll_name;


                    if (!File.Exists(dll_path.Substring(0, dll_path.Length - 4) + ".dep"))
                        continue;


                    string shaFromDLL = hasher.GetSHAFromDLL(dll_path);

                    if (shaFromDLL != null && shaFromDLL != "0000000000000000000000000000000000000000")
                    {
                        string[] folder = dll_name.Split('\\');

                        string dll = folder[folder.Length - 1];

                        string dll_path_in_CST = dllsFolder + dll.Substring(0, dll.Length - 3) + shaFromDLL + @"\" + dll;

                        if (!Directory.Exists(dll_path_in_CST))
                        {
                            DLLServerDownloader.downloadDLLandDep(dll.Substring(0, dll.Length - 3) + shaFromDLL);
                        }
                        refList.Add(dll_path_in_CST);
                    }
                }
            }

            return refList;
        }

        public static List<string> GetProjReference(IEnumerable<XElement> references, string build_file, string mode)
        {
            List<string> refList = new List<string>();

            foreach (XElement reference in references)
            {
                if (reference.Attribute("Include") != null)
                {
                    //                if (reference.Element(msbuild + "HintPath") != null)
                    //                {
                    //                    string dll_name = reference.Element(msbuild + "HintPath").Value;
                    string refered_prj = "", dll_name = "", dll_path = "";

                    refered_prj = Path.Combine(Path.GetDirectoryName(build_file), reference.Attribute("Include").Value);
                    dll_name = GetAssemblyName(refered_prj) + ".dll";
                    string refered_prj_output = GetBuildPath(refered_prj, mode);
                    dll_path = Path.Combine(Path.GetDirectoryName(refered_prj), refered_prj_output, dll_name);

                    if (!File.Exists(dll_path.Substring(0, dll_path.Length - 4) + ".dep"))
                        continue;


                    string shaFromDLL = hasher.GetSHAFromDLL(dll_path);

                    if (shaFromDLL != null && shaFromDLL != "0000000000000000000000000000000000000000")
                    {
                        string[] folder = dll_name.Split('\\');

                        string dll = folder[folder.Length - 1];

                        string dll_path_in_CST = dllsFolder + dll.Substring(0, dll.Length - 3) + shaFromDLL + @"\" + dll;

                        if (!Directory.Exists(dll_path_in_CST))
                        {
                            DLLServerDownloader.downloadDLLandDep(dll.Substring(0, dll.Length - 3) + shaFromDLL);
                        }
                        refList.Add(dll_path_in_CST);
                    }
                }
            }

            return refList;
        }

        public static List<string> GetReferenceFromCSPROJ(string build_file, string mode)
        {
            List<string> refList = new List<string>();

            XDocument projDefinition = XDocument.Load(build_file);
            IEnumerable<XElement> proj_ref = projDefinition
                .Element(msbuild + "Project")
                .Elements(msbuild + "ItemGroup")
                .Elements(msbuild + "ProjectReference");

            IEnumerable<XElement> dll_ref = projDefinition
                .Element(msbuild + "Project")
                .Elements(msbuild + "ItemGroup")
                .Elements(msbuild + "Reference");

            refList.AddRange(GetDLLReference(dll_ref, build_file, mode));
            refList.AddRange(GetProjReference(proj_ref, build_file, mode));

            return refList;
        }

        public static string CreateDepForProj(string build_file, string output_path, string prj_name, string mode)
        {
            string[] fileEntries = Directory.GetFiles(output_path, "*.dll");
            string project_dll = "";
            List<string> depDLLList = GetReferenceFromCSPROJ(build_file, mode);
            IEnumerable<string> depPrjList = GetDependentPrjList(build_file);
            string project_path = Path.GetDirectoryName(build_file);

            foreach (string fileEnt in fileEntries)
            {
                string dll_name = Path.GetFileName(fileEnt);

                if (dll_name.StartsWith(prj_name))
                {
                    project_dll = fileEnt;
                    break;
                }
            }

            if (project_dll.Length > 0)
            {
                foreach (string s in depPrjList)
                {
                    string depAssm = GetAssemblyName(Path.GetDirectoryName(build_file) + @"\" + s);
                    string generatedSHA = hasher.GenerateHashInHexStr(output_path, depAssm);

                    foreach (string fileEnt in fileEntries)
                    {
                        if (!File.Exists(fileEnt.Substring(0, fileEnt.Length - 4) + ".dep"))
                            continue;

                        string shaFromDLL = hasher.GetSHAFromDLL(fileEnt);

                        if (shaFromDLL.Equals(generatedSHA))
                        {
                            string dl = Path.GetFileNameWithoutExtension(fileEnt);
                            depDLLList.Add(dllsFolder + dl + "." + shaFromDLL + @"\" + Path.GetFileName(fileEnt));
                        }
                    }
                }
                CreateDep(project_dll, depDLLList);
                string proj_n = Path.GetFileName(project_dll);
                string sha = hasher.GenerateHashInHexStr(output_path, proj_n.Substring(0, proj_n.Length - 4));

                EditDLLASM(sha, project_dll);
                hasher.CopyDLL(sha, project_path, output_path, proj_n.Substring(0, proj_n.Length - 4));

                uploader.uploadDllDep(project_dll, project_dll.Substring(0, project_dll.Length - 4) + ".dep", proj_n.Substring(0, proj_n.Length - 4) + "." + sha);

                return sha;
            }
            return "";
        }

        public static string GetAssemblyName(string build_file)
        {
            XDocument projDefinition = XDocument.Load(build_file);
            IEnumerable<XElement> references = projDefinition
                .Element(msbuild + "Project")
                .Elements(msbuild + "PropertyGroup")
                .Elements(msbuild + "AssemblyName");
            
            foreach (XElement reference in references)
            {
                string assembly_name = reference.Value;

                return assembly_name;
            }
            return "";
        }

        public static void EditDllPath(string build_path, string parent_project, string sha)
        {
            string build_file = Directory.GetFiles(build_path, "*.csproj")[0];

            XDocument projDefinition = XDocument.Load(build_file);
            XElement reference = projDefinition
                .Element(msbuild + "Project")
                .Elements(msbuild + "ItemGroup")
                .Elements(msbuild + "Reference")
                .Where(x => x.Attribute("Include").Value.Split(',')[0].Equals(parent_project))
                .SingleOrDefault();

           if (reference != null)
           {
               XElement path = reference.Element(msbuild + "HintPath");

               path.SetValue(hasher.dllsFolder + sha + "\\" + parent_project + ".dll");
           }
           projDefinition.Save(build_file);
        }

        public static void ChangeAssemblyInfo(string path)
        {
            string asmInfo = "";
            string asm0Description = "[assembly: AssemblyDescription(\"0000000000000000000000000000000000000000\")]";
            string asmStart = "[assembly: AssemblyDescription(";

            if (File.Exists(path))
                asmInfo = File.ReadAllText(path);


            if (asmInfo.IndexOf(asmStart) >= 0 && asmInfo.IndexOf(asm0Description) == -1)
            {
                File.WriteAllText(path,
                    Regex.Replace(
                        asmInfo,
                        @"(\[assembly: AssemblyDescription\(""[0-9]*""\)\])",
                        @"[assembly: AssemblyDescription(""0000000000000000000000000000000000000000"")]"
                    )
                );
            }
        }


        public static void EditDLLASM(string sha, string dll_file)
        {
            if (File.Exists(dll_file))
            {
                string currentSHA = hasher.GetSHAFromDLL(dll_file);

                byte[] file = File.ReadAllBytes(dll_file);
                byte[] curSHA = Encoding.Default.GetBytes(currentSHA);

                for (int i = 0; i < file.Length; i++)
                {
                    int j = i;

                    for (; j - i < curSHA.Length && file[j] == currentSHA[j - i]; j++) ;

                    if (j == i + 40)
                    {
                        byte[] shaBytes = Encoding.Default.GetBytes(sha);
                        for (int k = i; k < j; k++)
                            file[k] = shaBytes[k - i];
                        break;
                    }
                }
                File.WriteAllBytes(dll_file, file);
            }
        }

        public static string GetBuildPath(string csproj, string compileMode)
        {
            string path = @"bin\Debug\";

            XDocument projDefinition = XDocument.Load(csproj);

            IEnumerable<XElement> modeList = projDefinition
                .Element(msbuild + "Project")
                .Elements(msbuild + "PropertyGroup")
                .Where(x => (x.Attribute("Condition") != null && x.Attribute("Condition").Value.Contains(compileMode)));

            foreach (XElement mode in modeList)
            {
                return mode.Element(msbuild + "OutputPath").Value;
            }

            return path;
        }

        public static IEnumerable<string> GetDependentPrjList(string csproj)
        {
            XDocument projDefinition = XDocument.Load(csproj);
            IEnumerable<string> referenceList = projDefinition
                .Element(msbuild + "Project")
                .Elements(msbuild + "ItemGroup")
                .Elements(msbuild + "ProjectReference")
                .Select(st => st.Attribute("Include").Value);

            return referenceList;
        }

        public static void GatherDependentsDep(string csproj, string mode)
        {
            IEnumerable<string> DependentPrjList = GetDependentPrjList(csproj);

            string buildPath = Path.GetDirectoryName(csproj) + @"\" + GetBuildPath(csproj, mode);

            foreach (string dependentPrj in DependentPrjList)
            {
                string depCsproj = Path.GetDirectoryName(csproj) + @"\" + dependentPrj;

                string depBuildPath = Path.GetDirectoryName(Path.GetDirectoryName(csproj) + @"\" + dependentPrj) + @"\" + GetBuildPath(depCsproj, mode);

                string[] files = Directory.GetFiles(depBuildPath, "*.dep");

                foreach (string file in files) {
                    if (!File.Exists(buildPath + Path.GetFileName(file)))
                    {
                        try
                        {
                            File.Copy(file, buildPath + Path.GetFileName(file), true);
                        }
                        catch (IOException)
                        {
                        }
                    }
                }
            }
        }

        public static void Read_Token_File()
        {
            string token_path = Path.Combine(Path.GetDirectoryName(Environment.GetCommandLineArgs()[0]), token_file_name);
            if (File.Exists(token_path))
            {
                token = File.ReadAllText(token_path);
                DLLServerUploader.token = token;
                DLLServerDownloader.token = token;
            }
        }

        public static string GenerateDep(string build_file, string outputPath, string prj_name, string mode)
        {
            Read_Token_File();
            hasher.ReadWebConfig(Path.GetDirectoryName(build_file) + @"\Web.config");
            uploader.ReadWebConfig(Path.GetDirectoryName(build_file) + @"\Web.config");
            ReadWebConfig(Path.GetDirectoryName(build_file) + @"\Web.config");

            GatherDependentsDep(build_file, mode);
            string sha = CreateDepForProj(build_file, outputPath, prj_name, mode);

            return sha;
        }

        static void Main(string[] args)
        {
            if (args.Length == 1)
            {
                Console.WriteLine("Not enough Arguments!");
            }
            else if (args.Length > 1)
            {
                if (args[1].EndsWith("\""))
                    args[1] = args[1].Substring(0, args[1].Length - 1);

                switch (args[0])
                {
                    case "-a":
                        string a_info = args[1] + @"\Properties\AssemblyInfo.cs";
                        Builder.ChangeAssemblyInfo(a_info);

                        break;
                    case "-dep":
                    case "-d":

                        Builder.GenerateDep(args[1], args[2], args[3], args[4]);
                        
                        break;
                    case "-c":
                        Console.WriteLine(args[1]);
                        Builder.EditDllPath(args[1], args[2], args[3]);
                        break;

                    case "-g":
                        break;
                }

            }
            else
            {
                string a = @"C:\Users\AuthPlatelet\Desktop\AuthClassLib\src\Examples\LiveIDLogin\LiveIDExample\LiveIDExample.csproj";
                string b = @"C:\Users\AuthPlatelet\Desktop\AuthClassLib\src\Examples\LiveIDLogin\LiveIDExample\bin";
                string c = "LiveIDExample";
                Builder.GenerateDep(a, b, c, "Debug");
                Console.ReadKey();

            }

        }
    }
}