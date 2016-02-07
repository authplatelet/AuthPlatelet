using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OAuth20NameSpace;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Runtime.Serialization;
using GenericAuthNameSpace;

namespace FacebookGraphApiExample
{
    public partial class Facebook_GraphAuth : System.Web.UI.Page
    {
        static string client_id = "503819873126032";
        static string user_id = "1665122330392017";
        static string client_secret = "4e6b2f4926d0ed9fc199d30fd6efc95c";
        static string realm = "localhost";
        static string redirect_uri = "http://localhost:57999/Facebook_GraphAuth.aspx";
        ResourceServerImpl RS = new ResourceServerImpl(realm, client_id, client_secret, redirect_uri);

        [DataContract]
        public class JsonDataStrcuture
        {
            [DataMember(Name = "access_token")]
            public string AccessToken { get; set; }

            [DataMember(Name = "token_type")]
            public string TokenType { get; set; }

            [DataMember(Name = "expires_in")]
            public string ExpiresIn { get; set; }

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string access_token = Request.Params["access_token"];
            string code = Request.Params["code"];

            if (!String.IsNullOrEmpty(code))
            {

                RS.setCode(code);
                //Response.Redirect(RS.get_token_url);
                
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(RS.get_token_url);
                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(JsonDataStrcuture));
                JsonDataStrcuture JsonDataStrcuture = new JsonDataStrcuture();
                JsonDataStrcuture = serializer.ReadObject(response.GetResponseStream()) as JsonDataStrcuture;

                FBResourceRequest req = new FBResourceRequest();
                req.access_token = new AccessToken();
                req.access_token.token = JsonDataStrcuture.AccessToken;
                req.UserID = user_id;
                req.scope = new GenericAuthNameSpace.Permissions();
                req.scope.permissionSet = new HashSet<GenericAuthNameSpace.Permission>();
                req.scope.permissionSet.Add(new ResourceServerImpl.FBEmailPermission());

                FBResourceResponse resp = RS.RequestResource(req);
                if (resp == null)
                {
                    email.InnerHtml = "verification failed";
                }
                else
                {
                    Resource r = resp.resources.resourceSet.First();
                    email.InnerHtml = "John's email is " + r.value;
                }
            }
            else if (!String.IsNullOrEmpty(access_token))
            {
                notLoggedIn.Visible = false;
                LoggedIn.Visible = true;
            }
            else
            { 
                notLoggedIn.Visible = true;
                LoggedIn.Visible = false;
            }
        }

        protected void LoginBtn_Click(Object sender, EventArgs e)
        {
            Response.Redirect(RS.get_code_url);
        }

        protected void LogoutBtn_Click(Object sender, EventArgs e)
        {
            Response.Redirect(RS.get_token_url);
        }
    }
}