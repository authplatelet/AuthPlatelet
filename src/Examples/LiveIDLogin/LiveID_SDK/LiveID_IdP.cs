namespace OpenIDConnectNameSpace
{
    using System.Collections.Generic;
    using GenericAuthNameSpace;
    using OAuth20NameSpace;
    using CST;
    using System.Diagnostics.Contracts;

    /***********************************************************/
    /*                          Parties                        */
    /***********************************************************/

    public class AuthorizationServerImpl : OpenIDProvider
    {
        public void init()
        {
            base.init(AuthorizationCodeDictionary, IDTokenAndAccessTokenDictionary);
        }
        
        static NondetOpenIDConnect Nondet;

        class AuthorizationCodeDictionary_def : AuthorizationCodeRecs
        {
            Dictionary<string, Dictionary<string, AuthorizationCodeEntry>> Dictionary = new Dictionary<string, Dictionary<string, AuthorizationCodeEntry>>();

            public ID_Claim getEntry(string IdPSessionSecret, string client_id)
            {
                AuthorizationCodeEntry entry = Dictionary[IdPSessionSecret][client_id];

                Contract.Assume(entry.GetType() == typeof(AuthorizationCodeEntry));

                return entry;
            }

            public bool setEntry(string IdPSessionSecret, string client_id, ID_Claim Entry)
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
                string IdPSessionSecret = Nondet.String();
                AuthorizationCodeEntry entry = (AuthorizationCodeEntry)getEntry(IdPSessionSecret, client_id);
                Contract.Assume(entry.code == authorization_code);

                /*This is an assumption implicitly in the definition of the notion of "code lookup" and "AuthReq redirection"*/
                Contract.Assume(IdPSessionSecret == GlobalObjects_base.SignInIdP_Req.IdPSessionSecret &&
                                client_id == GlobalObjects_base.SignInIdP_Req.Realm &&
                                client_id == GlobalObjects_base.RP.Realm);
                /*********************************************************************************/

                return IdPSessionSecret;
            }

        }
        class IDTokenAndAccessTokenDictionary_def : IDTokenAndAccessTokenRecs
        {
            Dictionary<AccessToken, Dictionary<string, Dictionary<string, AccessTokenEntry>>> Dictionary = new Dictionary<AccessToken, Dictionary<string, Dictionary<string, AccessTokenEntry>>>();

            public Permission_Claim getEntry(Ticket ticket, string Realm, string UserID)
            {
                AccessToken at = (AccessToken)ticket;

                return Dictionary[at][Realm][UserID];
            }

            public bool setEntry(Ticket ticket, string Realm, string UserID, Permission_Claim claim)
            {
                AccessToken at = (AccessToken)ticket;
                AccessTokenEntry ate = (AccessTokenEntry)claim;

                
                if (at == null && claim == null)
                    return false;
                
                Dictionary[at] = new Dictionary<string, Dictionary<string, AccessTokenEntry>>();
                Dictionary[at][Realm] = new Dictionary<string, AccessTokenEntry>();
                Dictionary[at][Realm][UserID] = ate;

                return true;
            }            
            
            public string findISSByClientIDAndAccessToken(string client_id, string UserID, string access_token)
            {
                string IdPSessionSecret = Nondet.String();
                AccessToken token = new AccessToken();
                token.token = access_token;
                IDTokenAndAccessTokenEntry entry = (IDTokenAndAccessTokenEntry)getEntry(token, client_id, UserID);
                Contract.Assume(entry.access_token == token);
                return IdPSessionSecret;
            }

            public string findISSByClientIDAndRefreshToken(string client_id, string UserID, string refresh_token)
            {
                string IdPSessionSecret = Nondet.String();
                AccessToken token = new AccessToken();
                token.token = refresh_token;
                IDTokenAndAccessTokenEntry entry = (IDTokenAndAccessTokenEntry)getEntry(token, client_id, UserID);
                Contract.Assume(entry.refresh_token == refresh_token);
                return IdPSessionSecret;
            }

        }
        AuthorizationCodeDictionary_def AuthorizationCodeDictionary=new AuthorizationCodeDictionary_def();
        IDTokenAndAccessTokenDictionary_def IDTokenAndAccessTokenDictionary=new IDTokenAndAccessTokenDictionary_def();

        public override AccessTokenEntry createAccessTokenEntry(string redirect_uri, Permissions scope, string state)
        {
            IDTokenAndAccessTokenEntry entry = new IDTokenAndAccessTokenEntry();
            entry.redirect_uri = redirect_uri;
            entry.scope = scope;
            entry.state = state;
            entry.id_token = Nondet.JsonWebToken();
 
            return entry;
        }

        public override AuthorizationCodeEntry createAuthorizationCodeEntry(AuthorizationRequest req)
        {
            AuthorizationCodeEntry entry = Nondet.AuthorizationCodeEntry();
            entry.redirect_uri = req.redirect_uri;
            entry.scope = req.scope;
            entry.state = req.state;
            return entry;
        }
    }
 
}