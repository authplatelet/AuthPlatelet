namespace OpenID20NameSpace
{
    using GenericAuthNameSpace;
    using OpenID20NameSpace;
    using System.Diagnostics.Contracts;

    public class For_vProgram : RelyingPartyImpl
    {
        public override bool AuthenticationDone(AuthenticationConclusion conclusion)
        {
            GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson(conclusion);

            return true;
        }
    }
}
