using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(CILRepository.Startup))]
namespace CILRepository
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
