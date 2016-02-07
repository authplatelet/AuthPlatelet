namespace OpenID20NameSpace
{
    using GenericAuthNameSpace;
    using System.Diagnostics.Contracts;

    public class For_vProgram : RelyingPartyImpl
    {
        public override bool AuthenticationDone(AuthenticationConclusion conclusion)
        {
            GlobalObjects_base.BadPersonCannotSignInAsGoodPerson(conclusion);

            return true;
        }
    }
}
