using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OAuth20NameSpace;
using GenericAuthNameSpace;
using System.Diagnostics.Contracts;

namespace OAuth20NameSpace
{
    public class AuthorizationServerImpl : AuthorizationServer
    {
        static NondetOAuth20 Nondet;

        public void init()
        {
            base.init(AccessTokenDictionary);
        }

        public override SignInIdP_Resp_SignInRP_Req Redir(string dest, ID_Claim _ID_Claim)
        {
            var AuthCode = _ID_Claim as AuthorizationCodeEntry;
            if (AuthCode == null)
                return null;
            AuthorizationResponse resp = new AuthorizationResponse();
            resp.code = AuthCode.code;
            return resp;
        }

        public override AccessTokenEntry createAccessTokenEntry(string redirect_uri, Permissions scope, string state)
        {
            AccessTokenEntry entry = new AccessTokenEntry();
            entry.redirect_uri = redirect_uri;
            entry.scope = scope;
            entry.state = state;

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

        AccessTokenDictionary_def AccessTokenDictionary = new AccessTokenDictionary_def();

        class AccessTokenDictionary_def : AccessTokenRecs
        {
            Dictionary<AccessToken, Dictionary<string, Dictionary<string, AccessTokenEntry>>> dict = new Dictionary<AccessToken, Dictionary<string, Dictionary<string, AccessTokenEntry>>>();

            public Permission_Claim getEntry(Ticket ticket, string Realm, string UserID)
            {
                AccessToken at = (AccessToken)ticket;

                AccessTokenEntry tokenEntry = dict[at][Realm][UserID];

                Contract.Assume(tokenEntry.GetType() == typeof(AccessTokenEntry));
                return tokenEntry;
            }

            public bool setEntry(Ticket ticket, string Realm, string UserID, Permission_Claim claim)
            {
                AccessToken at = (AccessToken)ticket;
                AccessTokenEntry ate = (AccessTokenEntry)claim;

                if (at == null && claim == null)
                    return false;

                dict[at] = new Dictionary<string, Dictionary<string, AccessTokenEntry>>();
                dict[at][Realm] = new Dictionary<string, AccessTokenEntry>();
                dict[at][Realm][UserID] = ate;

                return true;
            }

            Dictionary<string, Dictionary<string, Dictionary<string, string>>> issDict = new Dictionary<string, Dictionary<string, Dictionary<string, string>>>();

            public string findISSByClientIDAndAccessToken(string client_id, string UserID, string access_token)
            {
                return issDict[client_id][UserID][access_token];
            }

            public string findISSByClientIDAndRefreshToken(string client_id, string UserID, string refresh_token)
            {
                return issDict[client_id][UserID][refresh_token];
            }
        }

        public override ValidateTokenResponse Process_ValidateTicket(ValidateTokenRequest req, AccessTokenEntry tokenEntry)
        {
            ValidateTokenResponse resp = new ValidateTokenResponse();
            resp.access_token = req.access_token;
            resp.client_id = tokenEntry.Realm;
            resp.claimed_scope = tokenEntry.permissions;
            resp.scope = req.scope;
            resp.UserID = tokenEntry.UserID;
            resp.Realm = tokenEntry.Realm;
            return resp;
        }
    }
}
