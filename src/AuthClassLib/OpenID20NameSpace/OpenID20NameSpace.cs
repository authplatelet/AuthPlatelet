using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GenericAuthNameSpace;
using System.Net;
using CST;
using System.Web;
using System.Diagnostics.Contracts;
using HTTP;
using System.Diagnostics;
using System.IO;

namespace OpenID20NameSpace
{
    public class AuthenticationRequest : SignInIdP_Req
    {
        public string ns = "http://specs.openid.net/auth/2.0";
        public string mode;
        public string claimed_id;
        public string identity;
        public string assoc_handle;
        public string return_to;
        public string realm;

        public override string Realm
        {
            get { return realm;  }
            set { realm = value; }
        }

        public string endpointURL;
    }

    public class AuthenticationResponse : SignInIdP_Resp_SignInRP_Req
    {
        public string ns = "http://specs.openid.net/auth/2.0";
        public string mode;
        public string claimed_id;
        public string identity;
        public string assoc_handle;
        public string return_to;
        public string realm;


        public string endpointURL;
    }
    
    //data structures
    public class IDAssertionEntry : ID_Claim
    {
        public string openid_return_to;
        public string openid_identity;
        public string openid_claimed_id;
        public string openid_assoc_handle;
        public string openid_op_endpoint;
        public string openid_op_email;

        public override string Redir_dest
        {
            get { return openid_return_to; }
        }
        public override string UserID
        {
            get { return openid_claimed_id; }
        }

        static public IDAssertionEntry AssumeType(IDAssertionEntry in_obj)
        {
            IDAssertionEntry out_obj = new IDAssertionEntry();
            out_obj.openid_return_to = in_obj.openid_return_to;
            out_obj.openid_claimed_id = in_obj.openid_claimed_id;

            return out_obj;
        }
    }
    //=====================================================
    public abstract class RelyingParty : RP
    {
        public string return_uri
        {
            get { return Domain; }
            set { Domain = value; }
        }
        public string assoc_handle;
 
        public string endpointUrl;

        public void init()
        {
            VProgramGenerator.Assertion_cs = Properties.Resources.Assertion;
            VProgramGenerator.Program_cs = Properties.Resources.Program;
        }

        public AuthenticationRequest RequestAuthentication(AuthenticationResponse resp)
        {
            var req = new AuthenticationRequest();

            req.realm = this.Domain;
            req.identity = "http://specs.openid.net/auth/2.0/identifier_select";
            req.ns = "http://specs.openid.net/auth/2.0";
            req.claimed_id = "http://specs.openid.net/auth/2.0/identifier_select";
            req.mode = "checkid_setup";
            req.return_to = this.Domain;
            CST_Ops.recordme(this, resp, req);

            return req;
        }

        public override SignInRP_Resp SignInRP(SignInIdP_Resp_SignInRP_Req req1)
        {
            AuthenticationResponse req = (AuthenticationResponse)req1;
            if (req == null) return null;

            AuthenticationConclusion conclusion = Process_SignInRP_req(req);
            if (conclusion == null)
                return null;
            CST_Ops.recordme(this, req, conclusion, true);

            if (AuthenticationDone(conclusion))
                return new SignInRP_Resp();
            else
                return null;
        }

        public virtual AuthenticationConclusion Process_SignInRP_req(AuthenticationResponse req)
        {
            if (this.Domain != req.return_to) return null;
            AuthenticationConclusion conclusion = new AuthenticationConclusion();

            conclusion.SessionUID = req.claimed_id;

            return conclusion;
        }

    }

    public interface IDAssertionRecs : IdPAuthRecords_Base
    {
    }

    public abstract class OpenIDProvider : AS
    {
        public void init(IDAssertionRecs recs)
        {
            IDAssertionRecs = recs;
        }

        protected IDAssertionRecs IDAssertionRecs
        {
            get { return (IDAssertionRecs)IdentityRecords; }
            set { IdentityRecords = value; }
        }

        public override SignInIdP_Resp_SignInRP_Req SignInIdP(SignInIdP_Req req1)
        {
            AuthenticationRequest req = (AuthenticationRequest)req1;
            Contract.Assume(GlobalObjects_base.SignInIdP_Req.IdPSessionSecret == req.IdPSessionSecret);

            if (req == null) return null;
            ID_Claim _ID_Claim = Process_SignInIdP_req(req);
            if (_ID_Claim == null) return null;

            AuthenticationResponse resp = (AuthenticationResponse)Redir(_ID_Claim.Redir_dest, _ID_Claim);

            resp.realm = req.realm;
            resp.identity = req.identity;
            resp.ns = req.ns;
            resp.mode = req.mode;

            CST_Ops.recordme(this, req, resp, true, false);

            return resp;
        }

        public override ID_Claim Process_SignInIdP_req(SignInIdP_Req req1)
        {
            AuthenticationRequest req = (AuthenticationRequest)req1;

            switch (req.mode)
            {
                case "checkid_setup":
                    IDAssertionEntry entry = (IDAssertionEntry)IDAssertionRecs.getEntry(req.IdPSessionSecret, req.realm);
                    if (req.realm != entry.Redir_dest)
                        return null;
                    return entry;
            }

            return null;
        }

        public override SignInIdP_Resp_SignInRP_Req Redir(string dest, ID_Claim _ID_Claim)
        {
            AuthenticationResponse req = new AuthenticationResponse();

            req.claimed_id = _ID_Claim.UserID;
            req.return_to = _ID_Claim.Redir_dest;

            /*
             * Redir should happen here.
             */

            return req;
        }

        public override AuthTicket_Resp ValidateTicket(AuthTicket_Req req)
        {
            throw new NotImplementedException();
        }
    }

    public interface NondetOpenID20 : Nondet_Base
    {
        SignInIdP_Req SignInIdP_Req();
        SignInIdP_Resp_SignInRP_Req SignInIdP_Resp_SignInRP_Req();
        AuthenticationRequest AuthenticationRequest();
        AuthenticationResponse AuthenticationResponse();
        IDAssertionEntry IDAssertionEntry();
        Dictionary<string, Dictionary<string, IDAssertionEntry>> IDAssertionRecsDictionary();
    }
}