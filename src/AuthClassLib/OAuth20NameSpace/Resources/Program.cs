using System.Diagnostics.Contracts;
using GenericAuthNameSpace;
using OAuth20NameSpace;
using CST;

class GlobalObjectsForCST : GlobalObjects_base
{
    static public void init()
    {
        AuthTicket_Req = PoirotMain.Nondet.AuthTicket_Req();
        AuthTicket_Req.permissions = PoirotMain.Nondet.Permissions();
        AuthTicket_Req.permissions.permissionSet = PoirotMain.Nondet.HashSet();
        AS = new AuthorizationServerImpl(); ((AuthorizationServerImpl)AS).init();
        RS = new For_vProgram();
    }
}
class PoirotMain
{
    public static NondetOAuth20 Nondet;

    static void Main() 
    {
        GlobalObjectsForCST.init();
        SynthesizedPortion.SynthesizedSequence();
    }
}