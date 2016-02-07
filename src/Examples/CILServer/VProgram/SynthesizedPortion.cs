public class SynthesizedPortion
{
    public static void SynthesizedSequence()
    {
          OpenIDConnectNameSpace.AuthenticationResponse O1 = PoirotMain.Nondet.AuthenticationResponse();
          OpenIDConnectNameSpace.TokenRequest O2 = ((LiveIDNameSpace.LiveID_RP)GlobalObjectsForCST.RP).constructTokenRequest(O1);
          OpenIDConnectNameSpace.TokenResponse O3 = ((LiveIDNameSpace.LiveID_IdP)GlobalObjectsForCST.AS).TokenEndpoint(O2);
          GenericAuthNameSpace.RP.AuthenticationConclusion G4 = ((LiveIDNameSpace.LiveID_RP)GlobalObjectsForCST.RP).conclude(O3);
    }
}