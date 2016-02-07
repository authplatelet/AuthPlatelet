using System.Diagnostics.Contracts;
using System.Text;
using CST;
using ABC;
using CST_Message;

public interface NondetVProgram : CST.Nondet_Base
{
    CST_Message.Message Message();
}


public class GlobalObjectsForCST
{
    public static A A = new A(PoirotMain.Nondet.Int());
    public static B B = new B(PoirotMain.Nondet.Int());
    public static C C = new C(PoirotMain.Nondet.Int());
}

partial class PoirotMain
{
    public static NondetVProgram Nondet;

      static void Main()
      {
          SynthesizedPortion.SynthesizedSequence();
          check_Assertion();        
      }
}
