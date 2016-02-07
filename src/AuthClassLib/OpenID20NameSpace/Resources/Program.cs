using System.Diagnostics.Contracts;
using GenericAuthNameSpace;
using CST;
using OpenID20NameSpace;
class GlobalObjectsForCST : GlobalObjects_base
{
    static public void init()
    {
        SignInIdP_Req = new AuthenticationRequest(); // PoirotMain.Nondet.AuthenticationRequest();
        ((AuthenticationRequest)SignInIdP_Req).Realm = PoirotMain.Nondet.String();
        ((AuthenticationRequest)SignInIdP_Req).IdPSessionSecret = PoirotMain.Nondet.String();
        ((AuthenticationRequest)SignInIdP_Req).return_to = PoirotMain.Nondet.String();
        ((AuthenticationRequest)SignInIdP_Req).SymT = PoirotMain.Nondet.String();
        ((AuthenticationRequest)SignInIdP_Req).identity = PoirotMain.Nondet.String();
        ((AuthenticationRequest)SignInIdP_Req).realm = PoirotMain.Nondet.String();
        AS = new AuthorizationServerImpl(); ((AuthorizationServerImpl)AS).init();
        RP = new For_vProgram();
    }
}
class PoirotMain
{
    public static NondetOpenID20 Nondet;

    static void Main() 
    {
        GlobalObjectsForCST.init();
        SynthesizedPortion.SynthesizedSequence();       
    }
}