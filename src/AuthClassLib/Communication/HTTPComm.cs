using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Text;
using System.IO;
using System.Xml;

namespace HTTP
{
    /// <summary>
    /// Summary description for HTTPComm
    /// </summary>
    public class HTTPComm
    {
        public HTTPComm()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public static string HttpPost(string url, string post)
        {
            HttpWebResponse response=HttpReq(url, post, "POST");
            StreamReader sr = new StreamReader(response.GetResponseStream());
            return sr.ReadToEnd();
        }
        public static string HttpGet(string url)
        {
            HttpWebResponse response = HttpReq(url, "", "GET");
            StreamReader sr = new StreamReader(response.GetResponseStream());
            return sr.ReadToEnd();
        }
        public static HttpWebResponse HttpReq(string url, string post, string method)
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.KeepAlive = false;
            request.Method = method;

            if (method == "POST")
            {
                byte[] postBytes = Encoding.ASCII.GetBytes(post);
                request.ContentType = "application/x-www-form-urlencoded";
                request.ContentLength = postBytes.Length;

                Stream requestStream = request.GetRequestStream();
                requestStream.Write(postBytes, 0, postBytes.Length);
                requestStream.Close();
            }

            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            return response;
        }

        public static XmlDocument GenerateXML(Dictionary<string, string> msgDict)
        {
            XmlDocument doc = new XmlDocument();
            XmlNode docNode = doc.CreateXmlDeclaration("1.0", "UTF-8", null);

            XmlNode msgNode = doc.CreateElement("Message");
            doc.AppendChild(msgNode);

            foreach (KeyValuePair<string, string> kvp in msgDict)
            {
                XmlNode newNode = doc.CreateElement(kvp.Key);

                newNode.InnerText = kvp.Value;

                msgNode.AppendChild(newNode);
            }

            return doc;
        }
    }
}