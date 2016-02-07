using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using OpenIDConnectNameSpace;

partial class login : System.Web.UI.Page 
{
    RelyingPartyImpl RP = new RelyingPartyImpl("000000004C108D95", "http://a.local.host:14022/login.aspx", "zMVS1BpoNHwtdTnSzazSt2JgLd1hxRA1", "https://login.live.com/oauth20_token.srf");

    protected void Page_Load(object sender, EventArgs e)
    {
        HttpSessionStateBase sessionBase = new HttpSessionStateWrapper(Session);

        RP.CurrentSession = sessionBase;
        LiveIDAuthenticationResponse codeResp = (LiveIDAuthenticationResponse)RP.parseAuthenticationResponse(HttpContext.Current.Request);
        if (codeResp == null) return;
        RP.SignInRP(codeResp);
    }
}
