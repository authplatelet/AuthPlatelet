using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OpenID20NameSpace;
using GenericAuthNameSpace;
using System.Text;
using CST;
using HTTP;
using System.Net;

namespace OpenID20NameSpace
{
    public class RelyingPartyImpl : RelyingParty
    {
        public RelyingPartyImpl()
        {

        }

        public RelyingPartyImpl(string return_uri, string endpointUrl)
        {
            this.return_uri = return_uri;
            this.endpointUrl = endpointUrl;
            init();
        }

        public bool ValidateSignature(HttpRequest request)
        {
            StringBuilder sb = new StringBuilder();

            string[] keys = request.Params.AllKeys;
            bool not_first = false;
            string signed_fields = request.Params["openid.signed"];

            if (signed_fields.IndexOf("claimed_id") < 0 || signed_fields.IndexOf("return_to") < 0)
                return false;

            if (!request.Params["openid.return_to"].StartsWith(Domain))
                return false;

            for (int i = 0; i < keys.Length; i++)
            {
                if (not_first) sb.Append("&");
                if (keys[i].StartsWith("openid."))
                {
                    if (keys[i] == "openid.mode")
                        sb.Append(keys[i] + "=check_authentication");
                    else
                        sb.Append(keys[i] + "=" + request.Params[keys[i]]);
                    not_first = true;
                }
            }

            HttpWebResponse response = HTTPComm.HttpReq(endpointUrl, sb.ToString(), "POST");
            string result = HTTPComm.HttpPost(endpointUrl, sb.ToString());

            if (result.Contains("is_valid:true\n")) return true;

            return false;
        }

        public YahooAuthenticationResponse ParseAuthenticationResponse(HttpRequest rawRequest)
        {
            YahooAuthenticationResponse r = new YahooAuthenticationResponse();
            HttpContext context = HttpContext.Current;

            string return_url = rawRequest.QueryString["openid.return_to"];

            /* Since we have added SymT in the return_uri, we need to strip them */
            if (return_url.StartsWith(this.Domain))
            {
                string[] urls = return_url.Split('?');
                return_url = urls[0];
            }

            if (ValidateSignature(rawRequest))
            {
                r.SymT = rawRequest.QueryString["SymT"];
                r.claimed_id = rawRequest.QueryString["openid.claimed_id"];
                r.return_to = return_url;
            }

            if (string.IsNullOrEmpty(r.claimed_id))
                return null;
            else
                return r;
        }
        
        public string GenerateURL(AuthenticationRequest req)
        {
            StringBuilder sb = new StringBuilder(endpointUrl);

            sb.AppendFormat("?openid.claimed_id={0}&openid.identity={1}&openid.return_to={2}?SymT={6}&openid.realm={5}&openid.mode={3}&openid.ns={4}", HttpUtility.UrlEncode(req.claimed_id), HttpUtility.UrlEncode(req.identity), HttpUtility.UrlEncode(req.return_to), req.mode, HttpUtility.UrlEncode(req.ns), HttpUtility.UrlEncode(req.realm), HttpUtility.UrlEncode(req.SymT));

            return sb.ToString();
        }

        public string GenerateURL(AuthenticationResponse req)
        {
            StringBuilder sb = new StringBuilder(endpointUrl);

            sb.AppendFormat("?openid.claimed_id={0}&openid.identity={1}&openid.return_to={2}?SymT={6}&openid.realm={5}&openid.mode={3}&openid.ns={4}", HttpUtility.UrlEncode(req.claimed_id), HttpUtility.UrlEncode(req.identity), HttpUtility.UrlEncode(req.return_to), req.mode, HttpUtility.UrlEncode(req.ns), HttpUtility.UrlEncode(req.realm), HttpUtility.UrlEncode(req.SymT));

            return sb.ToString();
        }

        public override AuthenticationConclusion Process_SignInRP_req(AuthenticationResponse req)
        {
            if (this.Domain != req.return_to) return null;
            AuthenticationConclusion conclusion = new AuthenticationConclusion();

            conclusion.SessionUID = req.claimed_id;

            return conclusion;
        }

    }
}