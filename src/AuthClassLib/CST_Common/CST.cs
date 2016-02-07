using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Diagnostics;
using System.Diagnostics.Contracts;
using System.Net;
using System.IO;

namespace CST
{
    public class CST_MSG
    {
        public string SymT = "";
        public string SignedBy = "";
    }
    public class Debug
    {
        static public void reached()
        {
            Contract.Assert(false);
        }
    }

    public interface Nondet_Base
    {
        int Int();
        string String();
        bool Bool();
    }
}
