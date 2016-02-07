namespace OAuth20NameSpace
{
    using System.Collections.Generic;
    using CST;
    using GenericAuthNameSpace;
    using System.Web;
    using System;
    using System.Net;
    using System.Runtime.Serialization.Json;
    using System.Runtime.Serialization;
    using System.Diagnostics.Contracts;
    using System.Diagnostics;
    using System.IO;

    /***********************************************************/
    /*               Messages between parties                  */
    /***********************************************************/

    public class AuthorizationRequest : SignInIdP_Req
    {
        public string response_type;
        public string client_id;

        public override string Realm
        {
            get { return client_id; }
            set { client_id = value; }
        }
        public string redirect_uri = null;
        public Permissions scope;
        public string state = null;
    }

    public class AuthorizationResponse : SignInIdP_Resp_SignInRP_Req
    {
        public string code;
        public string state = null;
    }

    public class AuthorizationErrorResponse : SignInIdP_Resp_SignInRP_Req
    {
        protected string error;
        protected string error_description = null, error_uri = null;
        protected string state = null;
    }

    public class AccessToken : Ticket
    {
        public string token;
        public override string ticket
        {
            get { return token; }
            set { token = value; }
        }

        public override int GetHashCode()
        {
            return token.GetHashCode();
        }
    }


    public class AccessTokenRequest : AuthTicketAS_Req
    {
        public AccessToken access_token;

        public override Ticket ticket
        {
            get { return (AccessToken)access_token; }
            set { access_token = (AccessToken)value; }
        }
        public string UserID;
        public string grant_type;
        public string code;
        public string redirect_uri;
        public string client_id;
        public override string Realm
        {
            get { return client_id; }
            set { client_id = value; }
        }
        public string refresh_token = null;
    }

    public class AccessTokenResponse : AuthTicketAS_Resp
    {
        public AccessToken access_token;

        public override Ticket ticket
        {
            get { return (AccessToken)access_token; }
            set { access_token = (AccessToken)value; }
        }
        public string token_type;
        public string expires_in;
        public string client_id;
        public override string Realm
        {
            get { return client_id; }
            set { client_id = value; }
        }
        public string refresh_token = null;
        public Permissions scope;


    }

    public class ResourceRequest : ReqResourceRS_Req
    {
        public AccessToken access_token;

        public override Ticket ticket
        {
            get { return (AccessToken)access_token; }
            set { access_token = (AccessToken)value; }
        }

        public string client_id;
        public override string Realm
        {
            get { return client_id; }
            set { client_id = value; }
        }
        public Permissions scope;
    }

    public class ResourceResponse : ReqResourceRS_Resp
    {
        public AccessToken access_token;

        public override Ticket ticket
        {
            get { return (AccessToken)access_token; }
            set { access_token = (AccessToken)value; }
        }
        public string client_id;
        public override string Realm
        {
            get { return client_id; }
            set { client_id = value; }
        }
    }

    public class ValidateTokenRequest : AuthTicket_Req
    {
        public AccessToken access_token;

        public override Ticket ticket
        {
            get { return (AccessToken)access_token; }
            set { access_token = (AccessToken)value; }
        }
        public override Permissions permissions
        {
            get { return scope; }
            set { scope = value; }
        }
        public Permissions scope;
        public string client_id;
        public override string Realm
        {
            get { return client_id; }
            set { client_id = value; }
        }
        public string user;
        public override string UserID
        {
            get { return user; }
            set { user = value; }
        }

    }

    public class ValidateTokenResponse : AuthTicket_Resp
    {
        public AccessToken access_token;

        public override Permissions permissions
        {
            get { return scope; }
            set { scope = value; }
        }
        public Permissions scope;

        public Permissions claimed_scope;
        public string client_id;
        public override string Realm
        {
            get { return client_id; }
            set { client_id = value; }
        }
        public string user;
        public override string UserID
        {
            get { return user; }
            set { user = value; }
        }

    }


    /***********************************************************/
    /*               Data structures on parties                */
    /***********************************************************/

    public class AuthorizationCodeEntry : ID_Claim
    {
        public string code;
        public string user;
        public override string UserID
        {
            get { return user; }
        }
        public string redirect_uri;
        public override string Redir_dest
        {
            get { return redirect_uri; }
        }
        public Permissions scope;
        public string state;
    }

    public class AccessTokenEntry : Permission_Claim
    {
        public AccessToken access_token;
        public string user;
        public override string UserID
        {
            get { return user; }
        }
        public string redirect_uri;
        public override string Redir_dest
        {
            get { return redirect_uri; }
        }
        public Permissions scope;
        public override Permissions permissions
        {
            get { return scope; }
        }
        public string refresh_token;
        public string state;
        public string client_id;
        public override string Realm
        {
            get { return client_id; }
        }
    }

    public interface AuthorizationCodeRecs : IdPAuthRecords_Base
    {
        string findISSByClientIDAndCode(string client_id, string authorization_code);
    }

    public interface AccessTokenRecs : ASAuthTicketRecords_Base
    {
        string findISSByClientIDAndAccessToken(string client_id, string UserID, string access_token);
        string findISSByClientIDAndRefreshToken(string client_id, string UserID, string refresh_token);
    }

    public interface ResourceRecs : RSResourceRecords_Base
    {

    }

    /***********************************************************/
    /*                          Parties                        */
    /***********************************************************/
    public abstract class Client: RP
    {
        public Client()
        {
        }

        public string client_id
        {
            get { return Realm; }
            set { Realm = value; }
        }
        public string return_uri
        {
            get { return Domain; }
            set { Domain = value; }
        }
        public string client_secret;
        public string TokenEndpointUrl;
        public Client(string client_id1, string return_uri1, string client_secret1, string TokenEndpointUrl1)
        {
            client_id = client_id1;
            return_uri = return_uri1;
            client_secret = client_secret1;
            TokenEndpointUrl = TokenEndpointUrl1;
        }

    }

    public abstract class ResourceServer: RS
    {
        public string TokenEndpointUrl;

        ResourceRecs ResourceRecs
        {
            get { return (ResourceRecs)RSResourceRecs; }
            set { RSResourceRecs = value;  }
        }

        public void init(ResourceRecs recs)
        {
            ResourceRecs = recs;
            VProgramGenerator.Assertion_cs = Properties.Resources.Assertion;
            VProgramGenerator.Program_cs = Properties.Resources.Program;
        }

        public ValidateTokenRequest createValidateTokenRequest(ResourceRequest res_req)
        {
            ValidateTokenRequest vtreq = new ValidateTokenRequest();

            vtreq.access_token = res_req.access_token;
            vtreq.scope = res_req.scope;
            vtreq.UserID = res_req.UserID;
            vtreq.client_id = this.Realm;

            vtreq = pre_ValidateTokenRequest(vtreq);

            CST_Ops.recordme(this, res_req, vtreq);

            return vtreq;
        }

        public virtual ValidateTokenRequest pre_ValidateTokenRequest(ValidateTokenRequest req)
        {
            return req;
        }

        public bool HasPermissionForResource(ResourceRequest req)
        {
            ValidateTokenRequest treq = createValidateTokenRequest(req);
            ValidateTokenResponse tresq = callValidateTokenEndpoint(treq);

            return conclude(tresq);
        }

        public abstract ValidateTokenResponse callValidateTokenEndpoint(ValidateTokenRequest treq);

        public bool conclude(ValidateTokenResponse tresq)
        {
            AuthorizationConclusion conclusion = new AuthorizationConclusion();
            
            conclusion.UserID = tresq.UserID;
            conclusion.Realm = tresq.Realm;
            conclusion.permissions = tresq.claimed_scope;

            CST_Ops.recordme(this, tresq, conclusion, false, true);
            conclusion = pre_AuthDone(conclusion);

            return ResourceRequestDone(conclusion);
        }

        public virtual AuthorizationConclusion pre_AuthDone(AuthorizationConclusion req)
        {
            return req;
        }
    }

    public abstract class AuthorizationServer: AS
    {
        public AuthorizationCodeRecs AuthorizationCodeRecs
        {
            get { return (AuthorizationCodeRecs)IdentityRecords;  }
            set { IdentityRecords = value; }
        }

        protected AccessTokenRecs AccessTokenRecs
        {
            get { return (AccessTokenRecs)TicketRecords; }
            set { TicketRecords = value; }
        }

        public void init(AuthorizationCodeRecs AuthorizationCodeRecs1, AccessTokenRecs AccessTokenRecs1)
        {
            AuthorizationCodeRecs = AuthorizationCodeRecs1;
            AccessTokenRecs = AccessTokenRecs1;
        }

        public void init(AccessTokenRecs AccessTokenRecs1)
        {
            AccessTokenRecs = AccessTokenRecs1;
        }

        public override AuthTicket_Resp ValidateTicket(AuthTicket_Req vtr)
        {
            Contract.Assume(vtr == GlobalObjects_base.AuthTicket_Req);

            ValidateTokenRequest req = (ValidateTokenRequest)vtr;

            AccessTokenEntry tokenEntry = (AccessTokenEntry)AccessTokenRecs.getEntry(req.access_token, req.client_id, req.UserID);

            if (req.client_id != tokenEntry.Realm || req.UserID != tokenEntry.UserID || tokenEntry.permissions.permissionSet.IsSupersetOf(req.scope.permissionSet) == false)
                return null;

            ValidateTokenResponse resp = (ValidateTokenResponse) Process_ValidateTicket(req, tokenEntry);
            CST_Ops.recordme(this, req, resp, false, false);

            return resp;
        }

        public virtual ValidateTokenResponse Process_ValidateTicket(ValidateTokenRequest req, AccessTokenEntry tokenEntry)
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

        public override SignInIdP_Resp_SignInRP_Req SignInIdP(SignInIdP_Req req)
        {
            GlobalObjects_base.SignInIdP_Req = req;

            if (req == null) return null;
            AuthorizationRequest req1 = (AuthorizationRequest)req;
            ID_Claim _ID_Claim;
            Permission_Claim _Permission_Claim;

            switch (req1.response_type)
            {
                case "code":
                    _ID_Claim = createAuthorizationCodeEntry(req1);
                    if (IdentityRecords.setEntry(req1.IdPSessionSecret, req1.Realm, _ID_Claim) == false)
                        return null;
                    break;
                case "token":
                    _Permission_Claim = createAccessTokenEntry(req1.redirect_uri, req1.scope, req1.state);
                    _ID_Claim = IdentityRecords.getEntry(req1.IdPSessionSecret, req1.Realm);
                    break;
                default:
                    return null;
            }

            return Redir(_ID_Claim.Redir_dest, _ID_Claim);
        }

        public override ID_Claim Process_SignInIdP_req(SignInIdP_Req req1)
        {
            AuthorizationRequest req = (AuthorizationRequest)req1;
            switch (req.response_type)
            {
                case "code":
                    return createAuthorizationCodeEntry(req);                   
                default:
                    return null;
            }
        }

        protected AuthorizationResponse AuthorizationEndpoint(AuthorizationRequest req)
        {
            AuthorizationResponse resp = (AuthorizationResponse)SignInIdP(req);

            return resp;
        }

        protected void AuthorizationGrant(AuthorizationResponse resp)
        {

        }

        protected AccessTokenResponse TokenEndpoint(AccessTokenRequest req)
        {
            AccessTokenEntry AccessTokenEntry;
            string IdPSessionSecret;
            if (req == null) return null;
            AccessTokenResponse resp = new AccessTokenResponse();
            CST_Ops.recordme(this, req, resp);
            switch (req.grant_type)
            {
                case "authorization_code":
                    IdPSessionSecret = AuthorizationCodeRecs.findISSByClientIDAndCode(req.client_id/*, req.UserID*/, req.code);
                    if (IdPSessionSecret == null)
                        return null;
                    AuthorizationCodeEntry AuthCodeEntry =(AuthorizationCodeEntry)AuthorizationCodeRecs.getEntry(IdPSessionSecret, req.client_id);
                    if (AuthCodeEntry.redirect_uri != req.redirect_uri)
                        return null;
                    AccessTokenEntry = createAccessTokenEntry(AuthCodeEntry.redirect_uri, AuthCodeEntry.scope, AuthCodeEntry.state);
                    if (AccessTokenRecs.setEntry(AccessTokenEntry.access_token, req.client_id, req.UserID, AccessTokenEntry) == false)
                        return null;
                    
                    resp.access_token = AccessTokenEntry.access_token;
                    resp.refresh_token = AccessTokenEntry.refresh_token;
                    resp.scope = AccessTokenEntry.scope;
                    return resp;
                case "refresh_token":
                    IdPSessionSecret = AccessTokenRecs.findISSByClientIDAndRefreshToken(req.client_id, req.UserID, req.code);
                    if (IdPSessionSecret == null)
                        return null;
                    AccessTokenEntry = (AccessTokenEntry)AccessTokenRecs.getEntry(req.access_token, req.client_id, req.UserID);
                    AccessTokenEntry newAccessTokenEntry = createAccessTokenEntry(AccessTokenEntry.redirect_uri, AccessTokenEntry.scope, AccessTokenEntry.state);
                    if (AccessTokenRecs.setEntry(newAccessTokenEntry.access_token, req.client_id, req.UserID, newAccessTokenEntry) == false)
                        return null;
                    resp.access_token = AccessTokenEntry.access_token;
                    resp.refresh_token = AccessTokenEntry.refresh_token;
                    resp.scope = AccessTokenEntry.scope;
                    return resp;
                default:
                    return null;
            }
        }

        public abstract AuthorizationCodeEntry createAuthorizationCodeEntry(AuthorizationRequest req);
        public abstract AccessTokenEntry createAccessTokenEntry(string redirect_uri, Permissions scope, string state);
    }

    public interface NondetOAuth20 : Nondet_Base
    {
        AuthTicket_Req AuthTicket_Req();
        ValidateTokenRequest ValidateTokenRequest();
        ResourceRequest ResourceRequest();
        ResourceResponse ResourceResponse();
        Dictionary<string, Dictionary<string, Dictionary<string, AccessTokenEntry>>> AccessTokenDictionary();
        AccessTokenEntry AccessTokenEntry();
        Permissions Permissions();
        HashSet<Permission> HashSet();
        AuthorizationCodeEntry AuthorizationCodeEntry();
    }
}