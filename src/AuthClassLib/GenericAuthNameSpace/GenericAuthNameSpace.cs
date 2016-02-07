﻿namespace GenericAuthNameSpace
{
    using System.Diagnostics.Contracts;
    using System.Web.SessionState;
    using CST;
    using System.Web;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.IO;

    /***********************************************************/
    /*               Messages between parties                  */
    /***********************************************************/
    public abstract class SignInIdP_Req : CST_MSG
    {
        public string IdPSessionSecret;
        public abstract string Realm
        {
            get;
            set;
        }
    }

    public class SignInIdP_Resp_SignInRP_Req : CST_MSG
    {
    }

    public class SignInRP_Resp : CST_MSG
    {
    }

    public abstract class Ticket : CST_MSG 
    {
        public abstract string ticket
        {
            get;
            set;
        }
    }

    public class Permission : CST_MSG 
    {
        public string name;
    }

    public class Permissions
    {
        public HashSet<Permission> permissionSet;
    }

    public abstract class Resource : CST_MSG
    {
        public string name;
        public abstract object value
        {
            get;
            set;
        }
    }

    public class Resources
    {
        public HashSet<Resource> resourceSet;
    }

    public abstract class AuthTicketAS_Req : CST_MSG  
    {
        public abstract Ticket ticket
        {
            get;
            set;
        }
        public abstract string Realm
        {
            get;
            set;
        }
    }

    public abstract class AuthTicketAS_Resp : CST_MSG
    {
        public abstract Ticket ticket
        {
            get;
            set;
        }
        public abstract string Realm
        {
            get;
            set;
        }
    }

    public abstract class ReqResourceRS_Req : CST_MSG
    {
        public abstract Ticket ticket
        {
            get;
            set;
        }
        public abstract string Realm
        {
            get;
            set;
        }

        public Resource resource;
        public string UserID;
    }

    public abstract class ReqResourceRS_Resp : CST_MSG
    {
        public abstract Ticket ticket
        {
            get;
            set;
        }
        public abstract string Realm
        {
            get;
            set;
        }

        public Resources resources;
        public string UserID;
    }

    public abstract class AuthTicket_Req : CST_MSG
    {
        public abstract Ticket ticket
        {
            get;
            set;
        }
        public abstract string Realm
        {
            get;
            set;
        }
        public abstract string UserID
        {
            get;
            set;
        }
        public abstract Permissions permissions
        {
            get;
            set;
        }
    }

    public abstract class AuthTicket_Resp : CST_MSG
    {
        public abstract string Realm
        {
            get;
            set;
        }
        public abstract string UserID
        {
            get;
            set;
        }

        public abstract Permissions permissions
        {
            get;
            set;
        }
    }

    
    /***********************************************************/
    /*               Data structures on parties                */
    /***********************************************************/

    public abstract class ID_Claim
    {
        public abstract string UserID
        {
            get;
        }
        public abstract string Redir_dest
        {
            get;
        }
    }

    
    public interface IdPAuthRecords_Base
    {
        ID_Claim getEntry(string IdPSessionSecret, string Realm);
        bool setEntry(string IdPSessionSecret, string Realm, ID_Claim _ID_Claim);
    }

    public abstract class Permission_Claim : ID_Claim
    {
        public abstract Permissions permissions
        {
            get;
        }
        public abstract string Realm
        {
            get;
        }
    }

    public interface ASAuthTicketRecords_Base
    {
        bool setEntry(Ticket ticket, string Realm, string UserID, Permission_Claim claim);
        Permission_Claim getEntry(Ticket ticket, string Realm, string UserID);    
    }

     public interface RSResourceRecords_Base
     {
         bool setEntry(string UserID, Permission permission, Resource resource);
         Resource getEntry(string UserID, Permission permission);

     }


    /***********************************************************/
    /*                          Parties                        */
    /***********************************************************/

    /***********************************************************/
    /*         AS stands for Authority Server                  */
    /*         AS is both IdP and Authorization Server        */
    /***********************************************************/

    public abstract class AS                   
    {
        public IdPAuthRecords_Base IdentityRecords;
        public ASAuthTicketRecords_Base TicketRecords;

        public virtual SignInIdP_Resp_SignInRP_Req SignInIdP(SignInIdP_Req req)
        {
            GlobalObjects_base.SignInIdP_Req = req;

            if (req == null) return null;
            ID_Claim _ID_Claim = Process_SignInIdP_req(req);
            if (IdentityRecords.setEntry(req.IdPSessionSecret, req.Realm, _ID_Claim) == false)
                return null;
            return Redir(_ID_Claim.Redir_dest, _ID_Claim);
        }
            
        public abstract ID_Claim Process_SignInIdP_req(SignInIdP_Req req);
        public abstract SignInIdP_Resp_SignInRP_Req Redir(string dest, ID_Claim _ID_Claim);
        public abstract AuthTicket_Resp ValidateTicket(AuthTicket_Req req);

    }

    public abstract class RP
    {
        public HttpSessionStateBase CurrentSession;
        public string Domain, Realm;
        public abstract SignInRP_Resp SignInRP(SignInIdP_Resp_SignInRP_Req req);
        public class AuthenticationConclusion: CST_MSG
        {
            public string SessionUID;
        }
        public virtual bool AuthenticationDone(AuthenticationConclusion conclusion)
        {
            bool CST_verified = CST_Ops.Certify(conclusion);

            if (CurrentSession["UserID"] != null)
                CurrentSession["UserID"] = CST_verified?conclusion.SessionUID:"";
            else
                CurrentSession.Add("UserID", CST_verified ? conclusion.SessionUID : "");
            return CST_verified;
        }

    }

    /***********************************************************/
    /*               Resource Server                           */
    /***********************************************************/

    public abstract class RS
    {
        public RSResourceRecords_Base RSResourceRecs;
        public string Domain, Realm;

        public class AuthorizationConclusion : CST_MSG
        {
            public Ticket ticket;
            public Permissions permissions;
            public string Realm;
            public string UserID;
        }

        public virtual bool ResourceRequestDone(AuthorizationConclusion conclusion)
        {
            bool CST_verified = CST_Ops.Certify(conclusion);

            return CST_verified;
        }
    }

    /****************************************************************/
    /* The definition of the "Authentication/Authorization" problem */
    /****************************************************************/
    public class GlobalObjects_base
    {
        static public SignInIdP_Req SignInIdP_Req;
        static public AuthTicket_Req AuthTicket_Req;
        static public AS AS;
        static public RP RP;
        static public RS RS;

        static public void BadPersonCannotSignInAsGoodPerson(RP.AuthenticationConclusion conclusion)
        {
            ID_Claim ID_claim;
            ID_claim = AS.IdentityRecords.getEntry(
                                 SignInIdP_Req.IdPSessionSecret,
                                 RP.Realm);
            Contract.Assert(ID_claim.Redir_dest == RP.Domain && ID_claim.UserID == conclusion.SessionUID);
        }

        static public void PermissionsHaveBeenGrantedByOwner(RS.AuthorizationConclusion conclusion)
        {
            Permission_Claim _Permission_Claim;

            _Permission_Claim = AS.TicketRecords.getEntry(AuthTicket_Req.ticket, RS.Realm, AuthTicket_Req.UserID);
            Contract.Assert(_Permission_Claim.permissions == conclusion.permissions &&
                            _Permission_Claim.Realm == RS.Realm &&
                            _Permission_Claim.UserID == conclusion.UserID);
        }




        //people can define other safety properties here ...
        //...
        //...
    }
}