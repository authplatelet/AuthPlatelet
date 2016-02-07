namespace OAuth20NameSpace
{
    using GenericAuthNameSpace;
    using OAuth20NameSpace;
    using System.Diagnostics.Contracts;

    public class For_vProgram : ResourceServerImpl
    {
        public override bool ResourceRequestDone(AuthorizationConclusion conclusion)
        {
            GlobalObjects_base.Assert_BadPersonCannotAccessGoodPersonsResource(conclusion);
            
            return true;
        }
    }
}
