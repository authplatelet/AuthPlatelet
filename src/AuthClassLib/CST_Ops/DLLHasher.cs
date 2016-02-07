using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Security.Cryptography;
using System.Reflection;
using System.Xml.Linq;
using System.Configuration;
using System.Web.Configuration;
using System.Web;

namespace CST
{
    public class DLLHasher
    {
        public string CSTFolder = @"C:\CST";
        public string dllFolderName = @"dlls\";
        public string dllsFolder = @"C:\CST\dlls\";
        public string defaultSHA = "0000000000000000000000000000000000000000";
        private string token;

        public DLLHasher()
        {
            if (HttpContext.Current == null) return;

            Configuration webConfig = WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);

            if (webConfig.AppSettings.Settings.Count > 0)
            {
                KeyValueConfigurationElement customSetting =
                    webConfig.AppSettings.Settings["CSTFolderPath"];
                if (customSetting != null) {
                    CSTFolder = customSetting.Value;
                }
                else
                {
                    CSTFolder = @"C:\CST";
                }
                KeyValueConfigurationElement tokenSetting =
                    webConfig.AppSettings.Settings["Token"];
                if (tokenSetting != null)
                {
                    token = tokenSetting.Value;
                }
            }

            dllsFolder = CSTFolder + @"\" + dllFolderName;
        }

        public void ReadWebConfig(string webConfig)
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
                    dllsFolder = CSTFolder + @"\" + dllFolderName;
                }
                else if (key == "Token")
                {
                    token = value;
                }
            }

        }

        public byte[] GenerateHash(string path, string name)
        {
            string depPath = path + @"\" + name + ".dep";
            string dllPath = path + @"\" + name + ".dll";
            FileStream depFS = null;
            FileStream dllFS = null;
            try
           {
                depFS = File.OpenRead(depPath);
                dllFS = File.OpenRead(dllPath);
                byte[] fileInByte = new byte[depFS.Length];
                byte[] fileIndllBytes = new byte[dllFS.Length];

                depFS.Read(fileInByte, 0, Convert.ToInt32(depFS.Length));
                dllFS.Read(fileIndllBytes, 0, Convert.ToInt32(dllFS.Length));

                return GenerateHash(fileInByte, fileIndllBytes);
            }
            finally
            {
                if (depFS != null)
                {
                    depFS.Close();
                    depFS.Dispose();
                }
                if (dllFS != null)
                {
                    dllFS.Close();
                    dllFS.Dispose();
                }
            }
        }

        public void RemoveHashInDLLByte(byte[] dllBytes, string sha)
        {
            byte[] curSHA = Encoding.Default.GetBytes(sha);

            for (int i = 0; i < dllBytes.Length; i++)
            {
                int j = i;

                for (; j - i < curSHA.Length && dllBytes[j] == curSHA[j - i]; j++) ;

                if (j == i + 40)
                {
                    for (int k = i; k < j; k++)
                        dllBytes[k] = 0x30;
                    break;
                }
            }
        }

        public string GetSHAFromDLL(string dll_file_path)
        {
            if (File.Exists(dll_file_path))
            {
                byte[] dep = File.ReadAllBytes(dll_file_path.Substring(0, dll_file_path.Length - 4) + ".dep");
                byte[] file = File.ReadAllBytes(dll_file_path);

                for (int i = 0; i < file.Length; i++)
                {
                    if (file[i] == '(')
                    {
                        bool is_sha = true;
                        int j;
                        for (j = i + 1; j < i + 1 + 40; j++)
                        {
                            if (!((file[j] >= '0' && file[j] <= '9') || (file[j] >= 'A' && file[j] <= 'F')))
                            {
                                is_sha = false;
                                break;
                            }
                        }

                        if (is_sha)
                        {
                            byte[] sha_byte = new byte[40];

                            for (j = i + 1; j < i + 1 + 40; j++)
                            {
                                sha_byte[j - i - 1] = file[j];
                                file[j] = (byte)'0';
                            }

                            string sha = System.Text.Encoding.UTF8.GetString(sha_byte);

                            string generated_sha = GenerateHashInHexStr(dep, file);

                            if (sha == generated_sha)
                                return sha;
                        }

                        i = j;
                    }

                }
            }

            return defaultSHA;
        }

        public string GenerateHashInHexStr(byte[] fileInByte, byte[] fileIndllBytes)
        {
            return BitConverter.ToString(GenerateHash(fileInByte, fileIndllBytes)).Replace("-", string.Empty);
        }

        public byte[] GenerateHash(byte[] fileInByte, byte[] fileIndllBytes)
        {
            byte[] fileOutByte = new byte[fileInByte.Length + fileIndllBytes.Length];

            Buffer.BlockCopy(fileInByte, 0, fileOutByte, 0, fileInByte.Length);
            Buffer.BlockCopy(fileIndllBytes, 0, fileOutByte, fileInByte.Length, fileIndllBytes.Length);

            byte[] result = new SHA1CryptoServiceProvider().ComputeHash(fileOutByte);

            return result;
        }

        private object SHA1CryptoServiceProvider()
        {
            throw new NotImplementedException();
        }

        public string GenerateHashInHexStr(string path, string name)
        {
            return BitConverter.ToString(GenerateHash(path, name)).Replace("-", string.Empty);
        }

        public void CopyDLL(string generated_SHA, string build_path, string output_path, string name) //string depPath, string dllPath)
        {
            if (!Directory.Exists(dllsFolder + @"\" + name + "." + generated_SHA))
            {
                Directory.CreateDirectory(dllsFolder + @"\" + name + "." + generated_SHA);
            }

            try
            {
                string depPath = output_path + @"\" + name + ".dep";
                string dllPath = output_path + @"\" + name + ".dll";
                string depFile = Path.GetFileName(depPath);
                string dllFile = Path.GetFileName(dllPath);

                if (File.Exists(depPath))
                {
                    File.Copy(depPath, dllsFolder + @"\" + name + "." + generated_SHA + @"\" + depFile, true);
                }
                if (File.Exists(dllPath))
                {
                    File.Copy(dllPath, dllsFolder + @"\" + name + "." + generated_SHA + @"\" + dllFile, true);
                }

            }
            catch (IOException ex)
            {
                Console.WriteLine("\nMessage ---\n{0}", ex.Message);
                Console.WriteLine("\nStackTrace ---\n{0}", ex.StackTrace);
            }
        }

        public bool verifySHA1(string path, string name, string sha1)
        {
            string generatedSHA1 = GenerateHashInHexStr(path, name);

            if (generatedSHA1.Equals(sha1)) return true;

            return false;
        }
        
        public void saveToCSTFolder(string depFileName, byte[] depFileData, string dllFileName, byte[] dllFileData, string sha)
        {
            string name = Path.GetFileNameWithoutExtension(depFileName);

            if (!Directory.Exists(dllsFolder + @"\" + name + "." + sha))
            {
                Directory.CreateDirectory(dllsFolder + @"\" + name + "." + sha);
            }

            try
            {
                var depFile = File.Create(dllsFolder + @"\" + name + "." + sha + @"\" + depFileName);
                var dllFile = File.Create(dllsFolder + @"\" + name + "." + sha + @"\" + dllFileName);

                depFile.Write(depFileData, 0, depFileData.Length);
                dllFile.Write(dllFileData, 0, dllFileData.Length);

                depFile.Close();
                dllFile.Close();
            }
            catch
            {
            }
        }
    }
}
