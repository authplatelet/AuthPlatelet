using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ABC;
using CST;
using CST_Message;

namespace Server_A
{
    public partial class A_invoke : System.Web.UI.Page
    {
        A server_a = new A(40);
        protected void Page_Load(object sender, EventArgs e)
        {
            Message m = new Message();
            if (Message.parse(m, Request))
            {
                Message m2 = server_a.invoke(m);

                Message.respond(m2, Response);
            }
        }
    }
}