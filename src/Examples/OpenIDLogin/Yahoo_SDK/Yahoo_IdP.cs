using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OpenID20NameSpace;
using GenericAuthNameSpace;
using System.Diagnostics.Contracts;

namespace OpenID20NameSpace
{
    public class AuthorizationServerImpl : OpenIDProvider
    {
        public void init()
        {
            base.init(IDAssertionRecsDictionary);
            IDAssertionRecsDictionary.Dictionary[GlobalObjects_base.SignInIdP_Req.IdPSessionSecret] = new Dictionary<string, IDAssertionEntry>();
        }

        IDAssertionRecsDictionary_def IDAssertionRecsDictionary = new IDAssertionRecsDictionary_def();

        public class IDAssertionRecsDictionary_def : IDAssertionRecs
        {
            public Dictionary<string, Dictionary<string, IDAssertionEntry>> Dictionary = new Dictionary<string, Dictionary<string, IDAssertionEntry>>();

            public ID_Claim getEntry(string IdPSessionSecret, string client_id)
            {           
                IDAssertionEntry entry = Dictionary[IdPSessionSecret][client_id];

                Contract.Assume(entry.GetType() == typeof(IDAssertionEntry));

                return entry;
            }

            public bool setEntry(string IdPSessionSecret, string client_id, ID_Claim Entry)
            {
                IDAssertionEntry IDAssertionEntry = new IDAssertionEntry();

                IDAssertionEntry.openid_claimed_id = ((IDAssertionEntry)Entry).openid_claimed_id;
                IDAssertionEntry.openid_return_to = ((IDAssertionEntry)Entry).openid_return_to;
                Dictionary[IdPSessionSecret][client_id] = IDAssertionEntry;
  
                return true;
            }
        }

        public override ID_Claim Process_SignInIdP_req(SignInIdP_Req req1)
        {
            AuthenticationRequest req = (AuthenticationRequest)req1;

            switch (req.mode)
            {
                case "checkid_setup":
                    IDAssertionEntry entry = (IDAssertionEntry)IDAssertionRecs.getEntry(req.IdPSessionSecret, req.realm);
                    if (req.realm == entry.Redir_dest)
                        return entry;
                    return null;
            }

            return null;
        }
    }
}