using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ABC;
using CST;
using CST_Message;

namespace Server_C
{
    public partial class C_invoke : System.Web.UI.Page
    {        
        C server_c = new C(50);
        protected void Page_Load(object sender, EventArgs e)
        {
            Message m = new Message();
            if (Message.parse(m, Request))
            {
                Message m2 = server_c.invoke(m);

                Message.respond(m2, Response);
            }
        }
    }
}