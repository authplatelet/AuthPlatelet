using System.Diagnostics.Contracts;
using GenericAuthNameSpace;
using OpenIDConnectNameSpace;
using CST;
class GlobalObjectsForCST : GlobalObjects_base
{
    static public void init()
    {
        SignInIdP_Req = PoirotMain.Nondet.AuthenticationRequest();
        AS = new AuthorizationServerImpl(); ((AuthorizationServerImpl)AS).init();
        RP = new For_vProgram();
    }
}
class PoirotMain
{
    public static NondetOpenIDConnect Nondet;
    static void Main() 
    {
        GlobalObjectsForCST.init();
        SynthesizedPortion.SynthesizedSequence();       
    }
}