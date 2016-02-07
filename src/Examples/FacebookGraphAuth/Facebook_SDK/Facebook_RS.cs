using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CST;
using OAuth20NameSpace;
using GenericAuthNameSpace;
using System.Runtime.Serialization;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Diagnostics;
using System.IO;

namespace OAuth20NameSpace
{

    public class ResourceServerImpl : ResourceServer
    {
        public string _client_id, _client_secret;
        public string get_token_url = "https://graph.facebook.com/v2.3/oauth/access_token?";
        public string get_code_url = "https://graph.facebook.com/v2.3/oauth/access_token?";
        public string access_token;
        public string redirect_uri;
        ResourceRecs ResourceRecs = new ResourceRecs_def();

        string fbid = "1665122330392017";
        string fbemail = "johndoe.test.789@gmail.com";

        public FBResourceResponse RequestResource(FBResourceRequest req)
        {
            if (HasPermissionForResource(req))
            {
                Resources recources = new Resources();
                recources.resourceSet = new HashSet<Resource>();

                foreach (Permission perm in req.scope.permissionSet)
                {
                    recources.resourceSet.Add(ResourceRecs.getEntry(req.UserID, perm));
                }

                FBResourceResponse rr = new FBResourceResponse();
                rr.client_id = req.client_id;
                rr.access_token = req.access_token;
                rr.resources = recources;

                return rr;
            }
            return null;
        }

        class ResourceRecs_def : ResourceRecs
        {
            Dictionary<string, Dictionary<Permission, Resource>> resourceDB = new Dictionary<string, Dictionary<Permission, Resource>>();

            public ResourceRecs_def()
            {
            }

            public Resource getEntry(string UserID, Permission permission)
            {
                return resourceDB[UserID][permission];
            }

            public bool setEntry(string UserID, Permission permission, Resource resource)
            {
                if (!resourceDB.ContainsKey(UserID))
                    resourceDB[UserID] = new Dictionary<Permission,Resource>();
                resourceDB[UserID][permission] = resource;

                return true;
            }

        }

        public class FBEmailResource : Resource
        {
            public string email;
            public override object value
            {
                get
                {
                    return email;
                }
                set
                {
                    email = (string)value;
                }
            }
            public FBEmailResource()
            {
                this.name = "email";
            }

        }

        public class FBEmailPermission : Permission
        {
            public string email;

            public FBEmailPermission()
            {
                this.name = "email";
            }

            public override bool Equals(object obj)
            {
                FBEmailPermission emailP = obj as FBEmailPermission;

                if (emailP == null)
                    return false;
                return name.Equals(emailP.name);
            }

            public override int GetHashCode()
            {
                return name.GetHashCode();
            }
        }
        static string client_id_ = "503819873126032";
        static string user_id = "1665122330392017";
        static string client_secret_ = "4e6b2f4926d0ed9fc199d30fd6efc95c";
        static string redirect_uri_ = "http://localhost:57999/Facebook_GraphAuth.aspx";
        static string rl = "localhost";

        public ResourceServerImpl()
            : this(rl, client_id_, client_secret_, redirect_uri_)
        {
        }

        public ResourceServerImpl(string rl, string client_id, string client_secret, string redirect_uri)
        {
            this.Realm = rl;
            this._client_id = client_id;
            this._client_secret = client_secret;
            this.redirect_uri = redirect_uri;
            get_code_url = "https://www.facebook.com/dialog/oauth?client_id=" + _client_id + "&redirect_uri=" + redirect_uri + "&scope=email";
            TokenEndpointUrl = "https://graph.facebook.com";
            init(ResourceRecs);
            FBEmailPermission perm = new FBEmailPermission();
            FBEmailResource res = new FBEmailResource();
            res.email = fbemail;
            ResourceRecs.setEntry(fbid, perm, res);
        }

        public void setToken(string access_token)
        {
            this.access_token = access_token;
        }

        public void setCode(string code)
        {
            get_token_url = "https://graph.facebook.com/v2.3/oauth/access_token?client_id=" + _client_id + "&redirect_uri=" + redirect_uri + "&client_secret=" + _client_secret + "&code=" + code;
        }

        [DataContract]
        public class FBPermssionJSon
        {
            [DataMember(Name = "permission")]
            public string permission { get; set; }

            [DataMember(Name = "status")]
            public string status { get; set; }
        }

        [DataContract]
        public class FBPermssionData
        {
            [DataMember(Name = "data")]
            public FBPermssionJSon[] data { get; set; }
        }

        public override ValidateTokenResponse callValidateTokenEndpoint(ValidateTokenRequest treq)
        {
            ValidateTokenResponse vtr = new ValidateTokenResponse();
            FBPermssionData fbPermssionData = new FBPermssionData();

            string url = TokenEndpointUrl + "/" + treq.UserID + "/permissions?access_token=" + treq.access_token.token;

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(FBPermssionData));
            fbPermssionData = serializer.ReadObject(response.GetResponseStream()) as FBPermssionData;

            CST_Ops.recordme(new OAuth20NameSpace.AuthorizationServerImpl(), treq, vtr, typeof(AuthorizationServer).GetMethod("ValidateTicket"), "facebook.com", false, false);
            vtr.UserID = treq.UserID;
            vtr.scope = treq.scope;
            vtr.access_token = treq.access_token;

            return vtr;
        }

        public override AuthorizationConclusion pre_AuthDone(AuthorizationConclusion req)
        {
            return req;
        }

    }
}