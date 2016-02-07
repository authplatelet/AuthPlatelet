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
    public class A
    {
        public A()
        {
        }
        public A(int i1)
        {
            data = i1;
        }
        public int data;

        public Message invoke(Message in_msg)
        {
            Message out_msg = new Message();

            CST_Ops.recordme(this, in_msg, out_msg);

            out_msg.value = data;
            out_msg.largestParty = "Alice";
            out_msg.SignedBy = "Alice";

            return out_msg;
        }
    }
}