namespace OpenIDConnectNameSpace
{
    using System;
    using System.Web;
    using CST;
    using GenericAuthNameSpace;
    using System.Diagnostics;
    using System.IO;

    public class RelyingPartyImpl: RelyingParty 
    {
        public Boolean isVerified;

        public RelyingPartyImpl(string client_id, string return_uri, string client_secret, string TokenEndpointUrl)
            :base(client_id, return_uri, client_secret, TokenEndpointUrl) 
        {
            init();
        }

        public RelyingPartyImpl()
            : this(
                "000000004C108D95",
                "http://a.local.host:14022/login.aspx",
                "zMVS1BpoNHwtdTnSzazSt2JgLd1hxRA1",
                "https://login.live.com/oauth20_token.srf"
                )
        {
        }

        public override SignInRP_Resp SignInRP(SignInIdP_Resp_SignInRP_Req req)
        {
            LiveIDAuthenticationResponse codeResp = (LiveIDAuthenticationResponse)req;
            AuthenticationConclusion conclusion = AuthenticationUsingAuthorizationCodeFlow(codeResp);
            if (conclusion != null)
                isVerified = true;
            return null;
        }

        public LiveIDAuthenticationResponse parseAuthenticationResponse(HttpRequest rawRequest)
        {
            LiveIDAuthenticationResponse r = new LiveIDAuthenticationResponse();
            HttpContext context = HttpContext.Current;
            r.code = rawRequest.QueryString["code"];
            r.state = rawRequest.QueryString["state"];
            if (string.IsNullOrEmpty(r.code))
                return null;
            else
                return r;
        }

        public override TokenResponse callTokenEndpoint(TokenRequest req)
        {
            TokenResponse tr = base.callTokenEndpoint(req);

            CST_Ops.recordme(new OpenIDConnectNameSpace.AuthorizationServerImpl(), req, tr, typeof(OpenIDProvider).GetMethod("TokenEndpoint"), "live.com", false, false);

            return tr;
        }

        public override RP.AuthenticationConclusion pre_AuthDone(RP.AuthenticationConclusion req)
        {
            return req;
        }

        public string GetUserID()
        {
            return (string)CurrentSession["UserID"];
        }

        public bool IsVerified()
        {
            return isVerified;
        }
    }
}