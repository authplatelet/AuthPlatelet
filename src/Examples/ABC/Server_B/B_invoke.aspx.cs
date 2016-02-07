using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ABC;
using CST;
using CST_Message;

namespace Server_B
{
    public partial class B_invoke : System.Web.UI.Page
    {
        B server_b = new B(45);
        protected void Page_Load(object sender, EventArgs e)
        {
            Message m = new Message();
            if (Message.parse(m, Request))
            {
                Message m2 = server_b.invoke(m);

                Message.respond(m2, Response);
            }
        }
    }
}