using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CST;
using ABC;
using System.Diagnostics.Contracts;
using System.Diagnostics;
using System.IO;
using CST_Message;

namespace ABC
{
    public class C
    {
        public C()
        {
        }

        public C(int i1)
        {
            data = i1;
        }

        public int data;
        public Message conclusion = new Message();

        public Message invoke(Message in_msg)
        {
            CST_Ops.recordme(this, in_msg, conclusion);

            conclusion.value = in_msg.value;
            conclusion.largestParty = in_msg.largestParty;
            conclusion.SignedBy = in_msg.SignedBy;

            if (conclusion.value < data)
            {
                conclusion.largestParty = "Charles";
                conclusion.value = data;
            }
            conclusion.SignedBy = "Charles";

            if (conclude(conclusion))
            {
                conclusion.certified = true;
                Console.WriteLine("The largest party is " + conclusion.largestParty + ".");
            }
            else
            {
                conclusion.certified = false;
                Console.WriteLine("Not verified.");
            }

            return conclusion;
        }

        public bool conclude(Message msg)
        {
            bool result = CST_Ops.CertifyLocally(msg);
            return result;
        }

    }
}
