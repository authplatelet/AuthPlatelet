using HTTP;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Xml;
using CST;

namespace CST_Message
{
    public class Message : CST_MSG
    {
        public int value;
        public string largestParty;
        public bool certified;

        public Message()
        {
        }

        public void init()
        {
            VProgramGenerator.Assertion_cs = Properties.Resources.Assertion;
            VProgramGenerator.Program_cs = Properties.Resources.Program;
        }

        public static bool parse(Message msg, HttpRequest request)
        {
            msg.SymT = request.QueryString["SymT"];
            msg.SignedBy = request.QueryString["SignedBy"];
            if (request.QueryString["value"] != null)
                msg.value = Int32.Parse(request.QueryString["Value"]);
            msg.largestParty = request.QueryString["LargestParty"];

            if ((msg.SignedBy == null || msg.SignedBy.Length == 0) && !SignatureValid(request))
            {
                generateErrorResponse();
                return false;
            }
            return true;
        }

        public static void respond(Message msg, HttpResponse response)
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();

            dict.Add("SymT", msg.SymT);
            dict.Add("SignedBy", msg.SignedBy);
            dict.Add("LargestParty", msg.largestParty);
            dict.Add("Value", msg.value.ToString());
            dict.Add("Certified", msg.certified.ToString());

            XmlDocument doc = HTTPComm.GenerateXML(dict);

            response.StatusCode = 200;
            response.ContentType = "text/xml"; //must be 'text/xml'
            response.ContentEncoding = System.Text.Encoding.UTF8; //we'd like UTF-8
            doc.Save(response.Output);
        }


        public static void generateErrorResponse()
        {
        }

        public static bool SignatureValid(HttpRequest request)
        {
            return true;
        }
    }
}
