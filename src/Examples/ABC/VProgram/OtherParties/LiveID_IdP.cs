namespace LiveIDNameSpace
{
    using System.Collections.Generic;
    using OpenIDConnectNameSpace;
    using GenericAuthNameSpace;
    using OAuth20NameSpace;
    using CST;
    using System.Diagnostics.Contracts;
    /***********************************************************/
    /*               Messages between parties                  */
    /***********************************************************/
    
    //Nothing to define

    /***********************************************************/
    /*               Data structures on parties                */
    /***********************************************************/

    //Nothing to define

    /***********************************************************/
    /*                          Parties                        */
    /***********************************************************/

    class LiveID_IdP : OpenIDProvider
    {
        internal void init()
        {
            base.init(AuthorizationCodeDictionary, IDTokenAndAccessTokenDictionary);
        }
        
        static NondetOpenIDConnect Nondet;

        class AuthorizationCodeDictionary_def : AuthorizationCodeRecs
        {
            Dictionary<string, Dictionary<string, AuthorizationCodeEntry>> Dictionary = new Dictionary<string,Dictionary<string,AuthorizationCodeEntry>>();
            public _ID_Claim getEntry(string IdPSessionSecret, string client_id)
            {

                return Dictionary[IdPSessionSecret][client_id];
            }
            public bool setEntry(string IdPSessionSecret, string client_id, _ID_Claim Entry)
            {
                AuthorizationCodeEntry AuthorizationCodeEntry= (AuthorizationCodeEntry)Entry;
                if (AuthorizationCodeEntry==null)
                    return false;
                Dictionary[IdPSessionSecret] = new Dictionary<string, AuthorizationCodeEntry>();
                Dictionary[IdPSessionSecret][client_id] = AuthorizationCodeEntry;
                return true;
            }
            public string findISSByClientIDAndCode(string client_id, string authorization_code)
            {
                string IdPSessinSecret = Nondet.String();
                AuthorizationCodeEntry entry=(AuthorizationCodeEntry)getEntry(IdPSessinSecret,client_id);
                Contract.Assume(entry.code == authorization_code);

                /*This is an assumption implicitly in the definition of the notion of "code lookup" and "AuthReq redirection"*/
                Contract.Assume(IdPSessinSecret == GlobalObjects_base.SignInIdP_Req.IdPSessionSecret &&
                                client_id == GlobalObjects_base.SignInIdP_Req.Realm &&
                                client_id == GlobalObjects_base.RP.Realm);
                /*********************************************************************************/

                return IdPSessinSecret;
            }

        }
        class IDTokenAndAccessTokenDictionary_def : IDTokenAndAccessTokenRecs
        {
            Dictionary<string, Dictionary<string, IDTokenAndAccessTokenEntry>> Dictionary = new Dictionary<string,Dictionary<string,IDTokenAndAccessTokenEntry>>();
            public _ID_Claim getEntry(string IdPSessionSecret, string client_id)
            {
                return Dictionary[IdPSessionSecret][client_id];
            }
            public bool setEntry(string IdPSessionSecret, string client_id, _ID_Claim Entry)
            {
                IDTokenAndAccessTokenEntry IDTokenAndAccessTokenEntry = (IDTokenAndAccessTokenEntry)Entry;
                if (IDTokenAndAccessTokenEntry == null)
                    return false;
                Dictionary[IdPSessionSecret] = new Dictionary<string, IDTokenAndAccessTokenEntry>();
                Dictionary[IdPSessionSecret][client_id] = IDTokenAndAccessTokenEntry;
                return true;
            }
            public string findISSByClientIDAndAccessToken(string client_id, string access_token)
            {
                string IdPSessinSecret = Nondet.String();
                IDTokenAndAccessTokenEntry entry = (IDTokenAndAccessTokenEntry)getEntry(IdPSessinSecret, client_id);
                Contract.Assume(entry.access_token == access_token);
                return IdPSessinSecret;
            }
            public string findISSByClientIDAndRefreshToken(string client_id, string refresh_token)
            {
                string IdPSessinSecret = Nondet.String();
                IDTokenAndAccessTokenEntry entry = (IDTokenAndAccessTokenEntry)getEntry(IdPSessinSecret, client_id);
                Contract.Assume(entry.refresh_token == refresh_token);
                return IdPSessinSecret;
            }

        }
        AuthorizationCodeDictionary_def AuthorizationCodeDictionary=new AuthorizationCodeDictionary_def();
        IDTokenAndAccessTokenDictionary_def IDTokenAndAccessTokenDictionary=new IDTokenAndAccessTokenDictionary_def();

        internal override AccessTokenEntry createAccessTokenEntry(string redirect_uri, HashSet<string> scope, string state)
        {
            IDTokenAndAccessTokenEntry entry = new IDTokenAndAccessTokenEntry();
            entry.redirect_uri = redirect_uri;
            entry.scope = scope;
            entry.state = state;
            entry.id_token = Nondet.JsonWebToken();
 
            return entry;
        }
        internal override AuthorizationCodeEntry createAuthorizationCodeEntry(AuthorizationRequest req)
        {
            AuthorizationCodeEntry entry = Nondet.AuthorizationCodeEntry();
            entry.redirect_uri = req.redirect_uri;
            entry.scope = req.scope;
            entry.state = req.state;
            return entry;
        }
    }
 
}
