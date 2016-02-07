using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CST;
using ABC;
using System.Diagnostics;
using System.IO;
using CST_Message;

namespace ABC
{
    public class B
    {
        public B()
        {
        }
        public B(int i1)
        {
            data = i1;
        }
        public int data;
        public Message invoke(Message in_msg)
        {
            Message out_msg = new Message();
            CST_Ops.recordme(this, in_msg, out_msg);
            out_msg.value = in_msg.value;
            out_msg.largestParty = in_msg.largestParty;

            if (out_msg.value < data)
            {
                out_msg.value = data;
                out_msg.largestParty = "Bob";
            }
            out_msg.SignedBy = "Bob";
            return out_msg;
        }
    }
}
