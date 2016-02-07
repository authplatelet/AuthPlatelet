public class SynthesizedPortion
{
    public static void SynthesizedSequence()
    {
          OAuth20NameSpace.ResourceRequest O1 = PoirotMain.Nondet.ResourceRequest();
          OAuth20NameSpace.ValidateTokenRequest O2 = ((OAuth20NameSpace.ResourceServerImpl)GlobalObjectsForCST.RS).createValidateTokenRequest(O1);
          OAuth20NameSpace.ValidateTokenResponse O3 = ((OAuth20NameSpace.AuthorizationServerImpl)GlobalObjectsForCST.AS).ValidateTicket(O2);
          System.Boolean S4 = ((OAuth20NameSpace.ResourceServerImpl)GlobalObjectsForCST.RS).conclude(O3);
    }
}