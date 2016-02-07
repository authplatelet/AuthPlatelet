using GenericAuthNameSpace;
using LiveIDNameSpace;
using OpenIDConnectNameSpace;
using CST;

class SynthesizedPortion
{
    static public void SynthesizedSequence()
    {
        //SymT
        /*   a.local.host:#conclusion((
                   login.live.com:#TokenEndpoint((
                       a.local.host:#constructTokenRequest(
             )))))
        */

        AuthenticationResponse constructTokenRequest_in = PoirotMain.Nondet.AuthenticationResponse();
        TokenRequest constructTokenRequest_out = ((LiveID_RP_For_vProgram)GlobalObjectsForCST.RP).constructTokenRequest(constructTokenRequest_in);
        if (constructTokenRequest_out == null)
            return;

        TokenRequest TokenEndpoint_in = constructTokenRequest_out;
        TokenResponse TokenEndpoint_out = ((LiveID_IdP)GlobalObjectsForCST.IdP).TokenEndpoint(TokenEndpoint_in);
        if (TokenEndpoint_out == null)
            return;

        TokenResponse conclude_in = TokenEndpoint_out;
        _RP.AuthenticationConclusion conclude_out = ((LiveID_RP_For_vProgram)GlobalObjectsForCST.RP).conclude(conclude_in);
    }
}

