using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mime;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Xml.Linq;

namespace CST
{

    public class DLLServerUploader
    {
        public static string CSTFolder = @"C:\CST";
        public static string methodsFolderName = "methods";
        public static string dllFolderName = "dlls";
        public static string methodsFolder = CSTFolder + @"\" + methodsFolderName + @"\";
        public static string dllsFolder = CSTFolder + @"\" + dllFolderName + @"\";
        public static string server_url = "http://protoagnostic.cloudapp.net:8700/";
        public static string depdown_page = "Account/DepHandle";
        public static string dlldown_page = "Account/DllHandle";
        public static string methoddown_page = "Account/DownloadMethodRecord";
        public static string dllanddepUp_page = "Account/UploadDll";
        public static string methodup_page = "Account/UploadMethodRecord";
        public static string sha_parameter_name = "USER_SHA";
        public static string verify_page = "Account/Verify";
        public static string token = "";
        public static string vprogram_path = "";

        public class FileParameter
        {
            public byte[] File { get; set; }
            public string FileName { get; set; }
            public string ContentType { get; set; }
            public FileParameter(byte[] file) : this(file, null) { }
            public FileParameter(byte[] file, string filename) : this(file, filename, null) { }
            public FileParameter(byte[] file, string filename, string contenttype)
            {
                File = file;
                FileName = filename;
                ContentType = contenttype;
            }
        }

        public DLLServerUploader()
        {
            if (HttpContext.Current != null)
            {
                Configuration webConfig = WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);

                if (webConfig.AppSettings.Settings.Count > 0)
                {
                    KeyValueConfigurationElement customSetting =
                        webConfig.AppSettings.Settings["CSTFolderPath"];
                    if (customSetting != null)
                    {
                        CSTFolder = customSetting.Value;
                    }

                    KeyValueConfigurationElement dllSetting =
                        webConfig.AppSettings.Settings["DLLServerAddress"];
                    if (dllSetting != null)
                    {
                        server_url = dllSetting.Value;
                    }

                    KeyValueConfigurationElement tokenSetting =
                        webConfig.AppSettings.Settings["Token"];
                    if (tokenSetting != null)
                    {
                        token = tokenSetting.Value;
                    }

                    KeyValueConfigurationElement vprogramSetting =
                        webConfig.AppSettings.Settings["VProgramPath"];
                    if (vprogramSetting != null)
                    {
                        vprogram_path = vprogramSetting.Value;
                    }

                }

                methodsFolder = CSTFolder + @"\" + methodsFolderName;
                dllsFolder = CSTFolder + @"\" + dllFolderName;
            }
        }

        public void ReadWebConfig(string configFile)
        {
            if (!File.Exists(configFile)) return;

            XDocument projDefinition = XDocument.Load(configFile);
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
                else if (key == "DLLServerAddress")
                {
                    server_url = value;
                }
                else if (key == "Token")
                {
                    token = value;
                }
                else if (key == "VProgramPath")
                {
                    vprogram_path = value;
                }

            }
        }

        public bool verify(string SymT)
        {
            string assertionFileName = "Assertion.cs";
            string assertionFilePath = Path.Combine(vprogram_path, assertionFileName);
//            FileStream fs = new FileStream(assertionFilePath, FileMode.Open, FileAccess.Read);
//            byte[] assertionData = new byte[fs.Length];
            byte[] assertionData = Encoding.UTF8.GetBytes(VProgramGenerator.Assertion_cs);
            //VProgramGenerator.Assertion_cs.
            
//            fs.Read(assertionData, 0, assertionData.Length);
//            fs.Close();

            string programFileName = "Program.cs";
            string programFilePath = Path.Combine(vprogram_path, programFileName);
//            fs = new FileStream(programFilePath, FileMode.Open, FileAccess.Read);
//            byte[] programFileData = new byte[fs.Length];
            byte[] programFileData = Encoding.UTF8.GetBytes(VProgramGenerator.Program_cs);
//            fs.Read(programFileData, 0, programFileData.Length);
//            fs.Close();

            // Generate post objects
            Dictionary<string, object> postParameters = new Dictionary<string, object>();
            postParameters.Add("file", new FileParameter(assertionData, assertionFileName, "application/octet-stream"));
            postParameters.Add("file2", new FileParameter(programFileData, programFileName, "application/octet-stream"));

            string url = server_url + verify_page + "?" + "SymT=" + SymT + "&token=" + System.Uri.EscapeDataString(token);

            HttpWebResponse webResponse = MultipartFormDataPost(url, "Uploader", postParameters);

            var content = webResponse.Headers.GetValues("Content-Disposition");

            if (content != null)
            {
                var header_list = content.ToList();

                string filename = "";

                if (header_list.Count > 0)
                    filename = new ContentDisposition(header_list[0]).FileName;

                if (filename.Equals("verified.txt"))
                    return true;
                else if (filename.Equals("not_verified.txt"))
                    return false;
            }

            return false;
        }

        public void uploadMethodRecord(string filePath, string sha)
        {
            FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);
            byte[] data = new byte[fs.Length];
            fs.Read(data, 0, data.Length);
            fs.Close();

            string fileName = Path.GetFileName(filePath);
            // Generate post objects
            Dictionary<string, object> postParameters = new Dictionary<string, object>();
            postParameters.Add("file", new FileParameter(data, fileName, "application/octet-stream"));

            string url = server_url + methodup_page + "?" + sha_parameter_name + "=" + sha + "&token=" + System.Uri.EscapeDataString(token);

            uploadFile(postParameters, url);
        }

        public void uploadDllDep(string dllFilePath, string depFilePath, string sha)
        {
            FileStream fs = new FileStream(dllFilePath, FileMode.Open, FileAccess.Read);
            byte[] dllData = new byte[fs.Length];
            fs.Read(dllData, 0, dllData.Length);
            fs.Close();

            fs = new FileStream(depFilePath, FileMode.Open, FileAccess.Read);
            byte[] depData = new byte[fs.Length];
            fs.Read(depData, 0, depData.Length);
            fs.Close();

            string dllFileName = Path.GetFileName(dllFilePath);
            string depFileName = Path.GetFileName(depFilePath);

            // Generate post objects
            Dictionary<string, object> postParameters = new Dictionary<string, object>();
            postParameters.Add("file", new FileParameter(dllData, dllFileName, "application/octet-stream"));
            postParameters.Add("file2", new FileParameter(depData, depFileName, "application/octet-stream"));

            string url = server_url + dllanddepUp_page + "?" + sha_parameter_name + "=" + sha + "&token=" + System.Uri.EscapeDataString(token);

            uploadFile(postParameters, url);
        }

        private void uploadFile(Dictionary<string, object> postParameters, string url)
        {
            HttpWebResponse webResponse = MultipartFormDataPost(url, "Uploader", postParameters);

            webResponse.Close();
        }

        private static readonly Encoding encoding = Encoding.UTF8;
        public HttpWebResponse MultipartFormDataPost(string postUrl, string userAgent, Dictionary<string, object> postParameters)
        {
            string formDataBoundary = String.Format("----------{0:N}", Guid.NewGuid());
            string contentType = "multipart/form-data; boundary=" + formDataBoundary;

            byte[] formData = GetMultipartFormData(postParameters, formDataBoundary);

            return PostForm(postUrl, userAgent, contentType, formData);
        }

        private HttpWebResponse PostForm(string postUrl, string userAgent, string contentType, byte[] formData)
        {
            HttpWebRequest request = WebRequest.Create(postUrl) as HttpWebRequest;

            if (request != null)
            {

                // Set up the request properties.
                request.Method = "POST";
                request.ContentType = contentType;
                request.UserAgent = userAgent;
                request.CookieContainer = new CookieContainer();
                request.ContentLength = formData.Length;

                // You could add authentication here as well if needed:
                // request.PreAuthenticate = true;
                // request.AuthenticationLevel = System.Net.Security.AuthenticationLevel.MutualAuthRequested;
                // request.Headers.Add("Authorization", "Basic " + Convert.ToBase64String(System.Text.Encoding.Default.GetBytes("username" + ":" + "password")));

                // Send the form data to the request.
                using (Stream requestStream = request.GetRequestStream())
                {
                    requestStream.Write(formData, 0, formData.Length);
                    requestStream.Close();
                }

                return request.GetResponse() as HttpWebResponse;
            }
            return null;
        }

        private byte[] GetMultipartFormData(Dictionary<string, object> postParameters, string boundary)
        {
            Stream formDataStream = new System.IO.MemoryStream();
            bool needsCLRF = false;

            foreach (var param in postParameters)
            {
                // Thanks to feedback from commenters, add a CRLF to allow multiple parameters to be added.
                // Skip it on the first parameter, add it to subsequent parameters.
                if (needsCLRF)
                    formDataStream.Write(encoding.GetBytes("\r\n"), 0, encoding.GetByteCount("\r\n"));

                needsCLRF = true;

                if (param.Value is FileParameter)
                {
                    FileParameter fileToUpload = (FileParameter)param.Value;

                    // Add just the first part of this param, since we will write the file data directly to the Stream
                    string header = string.Format("--{0}\r\nContent-Disposition: form-data; name=\"{1}\"; filename=\"{2}\";\r\nContent-Type: {3}\r\n\r\n",
                        boundary,
                        param.Key,
                        fileToUpload.FileName ?? param.Key,
                        fileToUpload.ContentType ?? "application/octet-stream");

                    formDataStream.Write(encoding.GetBytes(header), 0, encoding.GetByteCount(header));

                    // Write the file data directly to the Stream, rather than serializing it to a string.
                    formDataStream.Write(fileToUpload.File, 0, fileToUpload.File.Length);
                }
                else
                {
                    string postData = string.Format("--{0}\r\nContent-Disposition: form-data; name=\"{1}\"\r\n\r\n{2}",
                        boundary,
                        param.Key,
                        param.Value);
                    formDataStream.Write(encoding.GetBytes(postData), 0, encoding.GetByteCount(postData));
                }
            }

            // Add the end of the request.  Start with a newline
            string footer = "\r\n--" + boundary + "--\r\n";
            formDataStream.Write(encoding.GetBytes(footer), 0, encoding.GetByteCount(footer));

            // Dump the Stream into a byte[]
            formDataStream.Position = 0;
            byte[] formData = new byte[formDataStream.Length];
            formDataStream.Read(formData, 0, formData.Length);
            formDataStream.Close();

            return formData;
        }
    }

    public class DLLServerDownloader
    {
        public static string CSTFolder = @"C:\CST";
        public static string methodsFolderName = "methods";
        public static string dllFolderName = "dlls";
        public static string methodsFolder = CSTFolder + @"\" + methodsFolderName + @"\";
        public static string dllsFolder = CSTFolder + @"\" + dllFolderName + @"\";
        public static string server_url = "http://protoagnostic.cloudapp.net:8700/";
        public static string depdown_page = "Account/DepHandle";
        public static string dlldown_page = "Account/DllHandle";
        public static string methoddown_page = "Account/DownloadMethodRecord";
        public static string dllanddepUp_page = "Account/UploadDll";
        public static string methodup_page = "Account/UploadMethodRecord";
        public static string sha_parameter_name = "USER_SHA";
        public static string symt_parameter_name = "SymT";
        public static string verify_page = "Account/Verify";
        public static string token = "";



        private static void downloadFile(string path, string url)
        {
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            var httpWebRequest = (HttpWebRequest)WebRequest.Create(url);
            httpWebRequest.ReadWriteTimeout = 500;
            httpWebRequest.ContentType = "application/octet-stream";
            httpWebRequest.Accept = "*/*";
            httpWebRequest.Method = "GET";

            using (WebResponse response = httpWebRequest.GetResponse())
            {
                var content = response.Headers.GetValues("Content-Disposition");
                
                if (content != null)
                {
                    var header_list = content.ToList();

                    string filename = "";

                    if (header_list.Count > 0)
                        filename = new ContentDisposition(header_list[0]).FileName;
                    else
                        filename = "temp.txt";

                    using (Stream stream = response.GetResponseStream())
                    {
                        using (MemoryStream ms = new MemoryStream())
                        {
                            stream.CopyTo(ms);

                            try
                            {
                                File.WriteAllBytes(path + filename, ms.ToArray());
                            }
                            catch (IOException)
                            {
                            }
                        }
                    }
                }
            }
        }

        public DLLServerDownloader()
        {
            if (HttpContext.Current != null)
            {
                Configuration webConfig = WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);

                if (webConfig.AppSettings.Settings.Count > 0)
                {
                    KeyValueConfigurationElement customSetting =
                        webConfig.AppSettings.Settings["CSTFolderPath"];
                    if (customSetting != null)
                    {
                        CSTFolder = customSetting.Value;
                    }

                    KeyValueConfigurationElement dllSetting =
                        webConfig.AppSettings.Settings["DLLServerAddress"];
                    if (dllSetting != null)
                    {
                        server_url = dllSetting.Value;
                    }
                    KeyValueConfigurationElement tokenSetting =
                        webConfig.AppSettings.Settings["Token"];
                    if (tokenSetting != null)
                    {
                        token = tokenSetting.Value;
                    }
                }

                methodsFolder = CSTFolder + @"\" + methodsFolderName;
                dllsFolder = CSTFolder + @"\" + dllFolderName;
            }
        }


        public static void downloadDLLandDep(string sha)
        {
            downloadFile(dllsFolder + sha + "\\", server_url + depdown_page + "?" + sha_parameter_name + "=" + sha + "&token=" + System.Uri.EscapeDataString(token));
            downloadFile(dllsFolder + sha + "\\", server_url + dlldown_page + "?" + sha_parameter_name + "=" + sha + "&token=" + System.Uri.EscapeDataString(token));

            string path = dllsFolder + sha;

            if (Directory.Exists(path)) {
                string[] depfiles = Directory.GetFiles(path, "*.dep");

                if (depfiles.Length > 0)
                {
                    string dependentDLLs = File.ReadAllText(depfiles[0]);

                    string pattern = @"\\[A-Za-z0-9.]+\\[A-Za-z0-9.]*dll\n";
                    Regex rgx = new Regex(pattern);
                    foreach (Match match in rgx.Matches(dependentDLLs))
                    {
                        string matched_sha = match.Value.Substring(1).Split('\\')[0];

                        if (!Directory.Exists(dllsFolder + matched_sha))
                            downloadDLLandDep(matched_sha);
                    }
                }
            }
        }

        public static void downloadMethodRecord(string sha)
        {
            downloadFile(methodsFolder, server_url + methoddown_page + "?" + sha_parameter_name + "=" + sha);
        }


        public static bool verify(string SymT)
        {
            string vfolder = Path.Combine(CSTFolder, "vprogram");
            downloadFile(vfolder, server_url + verify_page + "?" + symt_parameter_name + "=" + SymT + "&token=" + System.Uri.EscapeDataString(token));

            return true;
        }
    }}
