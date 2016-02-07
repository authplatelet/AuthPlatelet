using OpenID20NameSpace;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CST;
using GenericAuthNameSpace;
using System.Net;
using System.Text;
using HTTP;
using System.Diagnostics;
using System.IO;

namespace OpenIDExample
{
    public partial class LogIn : System.Web.UI.Page
    {
        static string yahoo_str = "https://open.login.yahooapis.com/openid/op/auth";
        RelyingPartyImpl RP = new RelyingPartyImpl("http://localhost:32928/LogIn.aspx", yahoo_str);
        static bool expecting_redir = false;

        protected void Page_Load(object sender, EventArgs e)
        {            
            string mode = Request.Params["openid.mode"];

            if (!String.IsNullOrEmpty(mode))
            {
                if (!expecting_redir)
                    return;

                expecting_redir = false;

                HttpSessionStateBase sessionBase = new HttpSessionStateWrapper(Session);

                RP.CurrentSession = sessionBase;

                YahooAuthenticationResponse resp = RP.ParseAuthenticationResponse(Request);

                if (resp == null) return;
                                
                notLoggedIn.Visible = false;
                LoggedIn.Visible = true;

                if (RP.SignInRP(resp) != null)
                    logged_id.InnerHtml = String.Format("Your ID is {0}", Request.Params["openid.identity"]);
                else
                    logged_id.InnerHtml = String.Format("Verification Failed");
            }
            else
            {
                notLoggedIn.Visible = true;
                LoggedIn.Visible = false;

            }
        }


        protected void LoginBtn_Click(Object sender, EventArgs e)
        {
            expecting_redir = true;
            YahooAuthenticationResponse req = new YahooAuthenticationResponse();

            var resp = RP.RequestAuthentication(req);

            /* HACK for Yahoo IdP */
            YahooAuthenticationRequest new_resq = new YahooAuthenticationRequest();
            new_resq.claimed_id = resp.claimed_id;
            new_resq.identity = resp.identity;
            new_resq.return_to = resp.return_to;
            new_resq.realm = resp.realm;
            new_resq.ns = resp.ns;
            new_resq.mode = resp.mode;


            CST_Ops.recordme(new OpenID20NameSpace.AuthorizationServerImpl(), resp, new_resq, typeof(AuthorizationServerImpl).GetMethod("SignInIdP"), "yahoo.com", true, false);

            string final_url = RP.GenerateURL(new_resq);

            Response.Redirect(final_url);
        }

        protected void LogoutBtn_Click(Object sender, EventArgs e)
        {
            notLoggedIn.Visible = true;
            LoggedIn.Visible = false;
        }
    }

}