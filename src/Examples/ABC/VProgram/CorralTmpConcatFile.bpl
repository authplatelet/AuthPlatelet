const hashsetEmpty : [Union]bool;
axiom (forall x: Union :: {hashsetEmpty[x]} !hashsetEmpty[x]);

var hashsets: [Ref][Union]bool;
var hashsetSize: [Ref]int;

procedure {:extern} System.Collections.Generic.HashSet`1.#ctor($this: Ref) 
{
  hashsets[$this] := hashsetEmpty;
  hashsetSize[$this] := 0;
}

procedure {:extern} System.Collections.Generic.HashSet`1.Add$`0($this: Ref, item$in: Union) returns ($result: bool)
{
  $result := !hashsets[$this][item$in];
  hashsets[$this][item$in] := true;
  if ($result) {
    hashsetSize[$this] := hashsetSize[$this] + 1;
  }
}

procedure {:extern} System.Collections.Generic.HashSet`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool)
{
  $result := hashsets[$this][item$in];
}

procedure {:extern} System.Collections.Generic.HashSet`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool)
{
  $result := hashsets[$this][item$in];
  hashsets[$this][item$in] := false;
  if ($result) {
    hashsetSize[$this] := hashsetSize[$this] - 1;
  }
}

procedure {:extern} System.Collections.Generic.HashSet`1.get_Count($this: Ref) returns ($result: int)
{
    $result := hashsetSize[$this];
}

procedure {:extern} System.Collections.Generic.HashSet`1.New($this: Ref) returns ($result: Ref)
{
    call $result := Alloc();
    call System.Collections.Generic.HashSet`1.#ctor($result);
    assume $DynamicType($result) == $DynamicType($this);
}

var stacks: [Ref][int]Union;
var stackPtr: [Ref]int;

procedure {:extern} System.Collections.Generic.Stack`1.#ctor($this: Ref)
{
  stackPtr[$this] := 0;
}

procedure {:extern} System.Collections.Generic.Stack`1.Push$`0($this: Ref, item$in: Union)
{
  stacks[$this][stackPtr[$this]] := item$in;
  stackPtr[$this] := stackPtr[$this] + 1;
}

procedure {:extern} System.Collections.Generic.Stack`1.Pop($this: Ref) returns ($result: Union)
{
  stackPtr[$this] := stackPtr[$this] - 1;
  $result := stacks[$this][stackPtr[$this]];
}

procedure {:extern} System.Collections.Generic.Stack`1.get_Count($this: Ref) returns ($result: int)
{
  $result := stackPtr[$this];
}

procedure {:extern} System.Collections.Generic.Stack`1.Peek($this: Ref) returns ($result: Union)
{
  $result := stacks[$this][stackPtr[$this] - 1];
}

var listContents: [Ref][int]Union;
var listSize: [Ref]int;

procedure {:extern} System.Collections.Generic.List`1.#ctor($this: Ref)
{
    listSize[$this] := 0;
}

procedure {:extern} System.Collections.Generic.List`1.Add$`0($this: Ref, item$in: Union)
{
    var size: int;

    size := listSize[$this];
    listContents[$this][size] := item$in;
    listSize[$this] := size + 1;
}

procedure {:extern} System.Collections.Generic.List`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool)
{
    var iter: int;

    $result := false;
    iter := 0;
    while (iter < listSize[$this] && !$result) {
        $result := (item$in == listContents[$this][iter]);
	iter := iter + 1;
    }

    while (iter < listSize[$this]) {
        listContents[$this][iter-1] := listContents[$this][iter];
	iter := iter + 1;
    }

    if ($result) {
        listSize[$this] := listSize[$this] - 1;
    }
}

procedure {:extern} System.Collections.Generic.List`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool)
{
    var iter: int;

    $result := false;
    iter := 0;
    while (iter < listSize[$this] && !$result) {
        $result := (item$in == listContents[$this][iter]);
	iter := iter + 1;
    }
}

procedure {:extern} System.Collections.Generic.List`1.get_Count($this: Ref) returns ($result: int)
{
    $result := listSize[$this];
}

procedure {:extern} System.Collections.Generic.List`1.Clear($this: Ref)
{
    listSize[$this] := 0;
}

procedure {:extern} System.Collections.Generic.List`1.get_Item$System.Int32($this: Ref, index$in: int) returns ($result: Union)
{
    $result := listContents[$this][index$in];
}

procedure {:extern} System.Collections.Generic.List`1.set_Item$System.Int32$`0($this: Ref, index$in: int, value$in: Union)
{
    listContents[$this][index$in] := value$in;
}

var AllMaps: [Ref][Union]Union;

procedure {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0(this: Ref, key$in: Union) returns ($result: Union)
{
    $result := AllMaps[this][key$in];
    return;
}


procedure {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1(this: Ref, key$in: Union, value$in: Union)
{
    AllMaps[this][key$in] := value$in;
    return;
}

// Copyright (c) 2010, Microsoft Corp.
// Bytecode Translator prelude

procedure {:inline 1} Alloc() returns (x: Ref);
  modifies $Alloc;



implementation {:inline 1} Alloc() returns (x: Ref)
{
    assume $Alloc[x] == false && x != null;
    $Alloc[x] := true;
}



procedure {:inline 1} System.Object.GetType(this: Ref) returns ($result: Ref);



implementation {:inline 1} System.Object.GetType(this: Ref) returns ($result: Ref)
{
    $result := $DynamicType(this);
}



axiom Union2Int(null) == 0;

axiom Union2Bool(null) == false;

function $ThreadDelegate(Ref) : Ref;

procedure {:inline 1} System.Threading.Thread.#ctor$System.Threading.ParameterizedThreadStart(this: Ref, start$in: Ref);



implementation {:inline 1} System.Threading.Thread.#ctor$System.Threading.ParameterizedThreadStart(this: Ref, start$in: Ref)
{
    assume $ThreadDelegate(this) == start$in;
}



procedure {:inline 1} System.Threading.Thread.Start$System.Object(this: Ref, parameter$in: Ref);



implementation {:inline 1} System.Threading.Thread.Start$System.Object(this: Ref, parameter$in: Ref)
{
    async call Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object($ThreadDelegate(this), parameter$in);
}



procedure Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref);



implementation Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref)
{
    $Exception := null;
    call System.Threading.ParameterizedThreadStart.Invoke$System.Object(this, obj$in);
}



procedure {:extern} System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref);



procedure {:inline 1} System.Threading.Thread.#ctor$System.Threading.ThreadStart(this: Ref, start$in: Ref);



implementation {:inline 1} System.Threading.Thread.#ctor$System.Threading.ThreadStart(this: Ref, start$in: Ref)
{
    assume $ThreadDelegate(this) == start$in;
}



procedure {:inline 1} System.Threading.Thread.Start(this: Ref);



implementation {:inline 1} System.Threading.Thread.Start(this: Ref)
{
    async call Wrapper_System.Threading.ThreadStart.Invoke($ThreadDelegate(this));
}



procedure Wrapper_System.Threading.ThreadStart.Invoke(this: Ref);



implementation Wrapper_System.Threading.ThreadStart.Invoke(this: Ref)
{
    $Exception := null;
    call System.Threading.ThreadStart.Invoke(this);
}



procedure {:extern} System.Threading.ThreadStart.Invoke(this: Ref);



procedure {:inline 1} System.String.op_Equality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool);



procedure {:inline 1} System.String.op_Inequality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool);



implementation System.String.op_Equality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool)
{
    $result := a$in == b$in;
}



implementation System.String.op_Inequality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool)
{
    $result := a$in != b$in;
}



var $ArrayContents: [Ref][int]Union;

function $ArrayLength(Ref) : int;

type Field;

type Union = Ref;

type Ref;

const unique null: Ref;

type Type = Ref;

function $TypeConstructor(Ref) : int;

type Real;

const unique $DefaultReal: Real;

procedure {:inline 1} $BoxFromBool(b: bool) returns (r: Ref);



implementation {:inline 1} $BoxFromBool(b: bool) returns (r: Ref)
{
    call r := Alloc();
    assume $TypeConstructor($DynamicType(r)) == $BoolValueType;
    assume Union2Bool(r) == b;
}



procedure {:inline 1} $BoxFromInt(i: int) returns (r: Ref);



implementation {:inline 1} $BoxFromInt(i: int) returns (r: Ref)
{
    call r := Alloc();
    assume $TypeConstructor($DynamicType(r)) == $IntValueType;
    assume Union2Int(r) == i;
}



procedure {:inline 1} $BoxFromReal(r: Real) returns (rf: Ref);



implementation {:inline 1} $BoxFromReal(r: Real) returns (rf: Ref)
{
    call rf := Alloc();
    assume $TypeConstructor($DynamicType(rf)) == $RealValueType;
    assume Union2Real(rf) == r;
}



procedure {:inline 1} $BoxFromUnion(u: Union) returns (r: Ref);



implementation {:inline 1} $BoxFromUnion(u: Union) returns (r: Ref)
{
    r := u;
}



const unique $BoolValueType: int;

const unique $IntValueType: int;

const unique $RealValueType: int;

function {:inline true} $Unbox2Bool(r: Ref) : bool
{
  Union2Bool(r)
}

function {:inline true} $Unbox2Int(r: Ref) : int
{
  Union2Int(r)
}

function {:inline true} $Unbox2Real(r: Ref) : Real
{
  Union2Real(r)
}

function {:inline true} $Unbox2Union(r: Ref) : Union
{
  r
}

function Union2Bool(u: Union) : bool;

function Union2Int(u: Union) : int;

function Union2Real(u: Union) : Real;

function Bool2Union(boolValue: bool) : Union;

function Int2Union(intValue: int) : Union;

function Real2Union(realValue: Real) : Union;

function Int2Real(int) : Real;

function Real2Int(Real) : int;

function RealPlus(Real, Real) : Real;

function RealMinus(Real, Real) : Real;

function RealTimes(Real, Real) : Real;

function RealDivide(Real, Real) : Real;

function RealModulus(Real, Real) : Real;

function RealLessThan(Real, Real) : bool;

function RealLessThanOrEqual(Real, Real) : bool;

function RealGreaterThan(Real, Real) : bool;

function RealGreaterThanOrEqual(Real, Real) : bool;

function BitwiseAnd(int, int) : int;

function BitwiseOr(int, int) : int;

function BitwiseExclusiveOr(int, int) : int;

function BitwiseNegation(int) : int;

function RightShift(int, int) : int;

function LeftShift(int, int) : int;

function $DynamicType(Ref) : Type;

function $As(a: Ref, b: Type) : Ref;

axiom (forall a: Ref, b: Type :: { $As(a, b): Ref } $As(a, b): Ref == (if $Subtype($DynamicType(a), b) then a else null));

function $Subtype(Type, Type) : bool;

function $DisjointSubtree(Type, Type) : bool;

var $Alloc: [Ref]bool;

function {:builtin "MapImp"} $allocImp([Ref]bool, [Ref]bool) : [Ref]bool;

function {:builtin "MapConst"} $allocConstBool(bool) : [Ref]bool;

function $RefToDelegateMethod(int, Ref) : bool;

function $RefToDelegateReceiver(int, Ref) : Ref;

function $RefToDelegateTypeParameters(int, Ref) : Type;

var {:thread_local} $Exception: Ref;

function T$GlobalObjectsForCST() : Ref;

const unique T$GlobalObjectsForCST: int;

var F$GlobalObjectsForCST.A: Ref;

var F$GlobalObjectsForCST.B: Ref;

var F$GlobalObjectsForCST.C: Ref;

procedure GlobalObjectsForCST.#ctor($this: Ref);



procedure {:extern} System.Object.#ctor($this: Ref);



implementation GlobalObjectsForCST.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 0} true;
    call System.Object.#ctor($this);
}



procedure GlobalObjectsForCST.#cctor();



var F$PoirotMain.Nondet: Ref;

procedure {:extern} CST.Nondet_Base.Int($this: Ref) returns ($result: int);



procedure {:extern} ABC.A.#ctor$System.Int32($this: Ref, i1$in: int);



function {:extern} T$ABC.A() : Ref;

const {:extern} unique T$ABC.A: int;

axiom $TypeConstructor(T$ABC.A()) == T$ABC.A;

procedure {:extern} ABC.B.#ctor$System.Int32($this: Ref, i1$in: int);



function {:extern} T$ABC.B() : Ref;

const {:extern} unique T$ABC.B: int;

axiom $TypeConstructor(T$ABC.B()) == T$ABC.B;

procedure {:extern} ABC.C.#ctor$System.Int32($this: Ref, i1$in: int);



function {:extern} T$ABC.C() : Ref;

const {:extern} unique T$ABC.C: int;

axiom $TypeConstructor(T$ABC.C()) == T$ABC.C;

implementation GlobalObjectsForCST.#cctor()
{
  var $tmp0: Ref;
  var $tmp1: int;
  var $tmp2: Ref;
  var $tmp3: int;
  var $tmp4: Ref;
  var $tmp5: int;
  var $localExc: Ref;
  var $label: int;

    F$GlobalObjectsForCST.A := null;
    F$GlobalObjectsForCST.B := null;
    F$GlobalObjectsForCST.C := null;
    assume {:breadcrumb 1} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 14} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 14} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 14} true;
    call $tmp1 := CST.Nondet_Base.Int(F$PoirotMain.Nondet);
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 14} true;
    call ABC.A.#ctor$System.Int32($tmp0, $tmp1);
    assume $DynamicType($tmp0) == T$ABC.A();
    assume $TypeConstructor($DynamicType($tmp0)) == T$ABC.A;
    F$GlobalObjectsForCST.A := $tmp0;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 15} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 15} true;
    call $tmp2 := Alloc();
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 15} true;
    call $tmp3 := CST.Nondet_Base.Int(F$PoirotMain.Nondet);
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 15} true;
    call ABC.B.#ctor$System.Int32($tmp2, $tmp3);
    assume $DynamicType($tmp2) == T$ABC.B();
    assume $TypeConstructor($DynamicType($tmp2)) == T$ABC.B;
    F$GlobalObjectsForCST.B := $tmp2;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 16} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 16} true;
    call $tmp4 := Alloc();
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 16} true;
    call $tmp5 := CST.Nondet_Base.Int(F$PoirotMain.Nondet);
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 16} true;
    call ABC.C.#ctor$System.Int32($tmp4, $tmp5);
    assume $DynamicType($tmp4) == T$ABC.C();
    assume $TypeConstructor($DynamicType($tmp4)) == T$ABC.C;
    F$GlobalObjectsForCST.C := $tmp4;
}



function T$SynthesizedPortion() : Ref;

const unique T$SynthesizedPortion: int;

procedure SynthesizedPortion.SynthesizedSequence();



procedure NondetVProgram.Message($this: Ref) returns ($result: Ref);



procedure {:extern} ABC.A.invoke$CST.Message($this: Ref, in_msg$in: Ref) returns ($result: Ref);



procedure {:extern} ABC.B.invoke$CST.Message($this: Ref, in_msg$in: Ref) returns ($result: Ref);



procedure {:extern} ABC.C.invoke$CST.Message($this: Ref, in_msg$in: Ref) returns ($result: Ref);



implementation SynthesizedPortion.SynthesizedSequence()
{
  var C1_Ref: Ref;
  var $tmp0: Ref;
  var C2_Ref: Ref;
  var $tmp1: Ref;
  var C3_Ref: Ref;
  var $tmp2: Ref;
  var C4_Ref: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 2} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedPortion.cs"} {:sourceLine 5} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedPortion.cs"} {:sourceLine 5} true;
    call $tmp0 := NondetVProgram.Message(F$PoirotMain.Nondet);
    C1_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedPortion.cs"} {:sourceLine 6} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedPortion.cs"} {:sourceLine 6} true;
    call $tmp1 := ABC.A.invoke$CST.Message(F$GlobalObjectsForCST.A, C1_Ref);
    C2_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedPortion.cs"} {:sourceLine 7} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedPortion.cs"} {:sourceLine 7} true;
    call $tmp2 := ABC.B.invoke$CST.Message(F$GlobalObjectsForCST.B, C2_Ref);
    C3_Ref := $tmp2;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedPortion.cs"} {:sourceLine 8} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedPortion.cs"} {:sourceLine 8} true;
    call $tmp3 := ABC.C.invoke$CST.Message(F$GlobalObjectsForCST.C, C3_Ref);
    C4_Ref := $tmp3;
}



procedure SynthesizedPortion.#ctor($this: Ref);



implementation SynthesizedPortion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 3} true;
    call System.Object.#ctor($this);
}



procedure T$SynthesizedPortion.#cctor();



implementation T$SynthesizedPortion.#cctor()
{
}



function T$NondetVProgram() : Ref;

const unique T$NondetVProgram: int;

function T$PoirotMain() : Ref;

const unique T$PoirotMain: int;

procedure PoirotMain.check_Assertion();



var {:extern} F$ABC.A.data: [Ref]int;

var {:extern} F$ABC.C.data: [Ref]int;

var {:extern} F$ABC.B.data: [Ref]int;

var {:extern} F$ABC.C.conclusion: [Ref]Ref;

var {:extern} F$CST.Message.largestParty: [Ref]Ref;

const {:value "Alice"} unique $string_literal_Alice_0: Ref;

implementation PoirotMain.check_Assertion()
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: bool;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 4} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Assertion.cs"} {:sourceLine 7} true;
    $tmp4 := F$GlobalObjectsForCST.C;
    assume $tmp4 != null;
    $tmp5 := F$ABC.C.conclusion[$tmp4];
    assume $tmp5 != null;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Assertion.cs"} {:sourceLine 7} true;
    call $tmp6 := System.String.op_Equality$System.String$System.String(F$CST.Message.largestParty[$tmp5], $string_literal_Alice_0);
    if (!$tmp6)
    {
    }
    else
    {
        $tmp2 := F$GlobalObjectsForCST.A;
        assume $tmp2 != null;
        $tmp3 := F$GlobalObjectsForCST.B;
        assume $tmp3 != null;
        if (F$ABC.A.data[$tmp2] < F$ABC.B.data[$tmp3])
        {
        }
        else
        {
            $tmp0 := F$GlobalObjectsForCST.A;
            assume $tmp0 != null;
            $tmp1 := F$GlobalObjectsForCST.C;
            assume $tmp1 != null;
        }
    }

    assert (if !$tmp6 then true else (if F$ABC.A.data[$tmp2] < F$ABC.B.data[$tmp3] then false else !(F$ABC.A.data[$tmp0] < F$ABC.C.data[$tmp1])));
}



procedure {:entrypoint} PoirotMain.Main();



implementation PoirotMain.Main()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 5} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 25} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 25} true;
    call SynthesizedPortion.SynthesizedSequence();
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 26} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\ABC\VProgram\Program.cs"} {:sourceLine 26} true;
    call PoirotMain.check_Assertion();
}



procedure PoirotMain.#ctor($this: Ref);



implementation PoirotMain.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 6} true;
    call System.Object.#ctor($this);
}



procedure T$PoirotMain.#cctor();



implementation T$PoirotMain.#cctor()
{
    F$PoirotMain.Nondet := null;
}



procedure ABC.A.#ctor($this: Ref);



implementation ABC.A.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$ABC.A.data[$this] := 0;
    assume {:breadcrumb 7} true;
    call System.Object.#ctor($this);
}



implementation ABC.A.#ctor$System.Int32($this: Ref, i1$in: int)
{
  var i1: int;
  var $localExc: Ref;
  var $label: int;

    i1 := i1$in;
    F$ABC.A.data[$this] := 0;
    assume {:breadcrumb 8} true;
    call System.Object.#ctor($this);
    F$ABC.A.data[$this] := i1;
}



procedure {:extern} CST.Message.#ctor($this: Ref);



function {:extern} T$CST.Message() : Ref;

const {:extern} unique T$CST.Message: int;

axiom $TypeConstructor(T$CST.Message()) == T$CST.Message;

procedure {:extern} System.Diagnostics.Stopwatch.#ctor($this: Ref);



function {:extern} T$System.Diagnostics.Stopwatch() : Ref;

const {:extern} unique T$System.Diagnostics.Stopwatch: int;

axiom $TypeConstructor(T$System.Diagnostics.Stopwatch()) == T$System.Diagnostics.Stopwatch;

procedure {:extern} System.Diagnostics.Stopwatch.Start($this: Ref);



procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct(o$in: Ref, in_msg$in: Ref, out_msg$in: Ref);



procedure {:extern} System.Diagnostics.Stopwatch.Stop($this: Ref);



const {:value "C:\Users\Daniel Song\Desktop\Alice.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$Alice.txt_1: Ref;

procedure {:extern} System.IO.File.Exists$System.String(path$in: Ref) returns ($result: bool);



procedure {:extern} System.IO.File.CreateText$System.String(path$in: Ref) returns ($result: Ref);



procedure {:extern} System.Diagnostics.Stopwatch.get_ElapsedMilliseconds($this: Ref) returns ($result: int);



procedure {:extern} System.IO.TextWriter.WriteLine$System.Int64($this: Ref, value$in: int);



procedure {:extern} System.IO.File.AppendText$System.String(path$in: Ref) returns ($result: Ref);



var {:extern} F$CST.Message.value: [Ref]int;

var {:extern} F$CST.CST_Struct.SignedBy: [Ref]Ref;

implementation ABC.A.invoke$CST.Message($this: Ref, in_msg$in: Ref) returns ($result: Ref)
{
  var in_msg: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $tmp1: Ref;
  var local_2_Ref: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var local_3_Ref: Ref;
  var $tmp4: int;
  var $tmp5: Ref;
  var $tmp6: int;
  var local_4_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    in_msg := in_msg$in;
    assume {:breadcrumb 9} true;
    call $tmp0 := Alloc();
    call CST.Message.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$CST.Message();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CST.Message;
    local_0_Ref := $tmp0;
    call $tmp1 := Alloc();
    call System.Diagnostics.Stopwatch.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Diagnostics.Stopwatch();
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Diagnostics.Stopwatch;
    local_1_Ref := $tmp1;
    call System.Diagnostics.Stopwatch.Start(local_1_Ref);
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct($this, in_msg, local_0_Ref);
    call System.Diagnostics.Stopwatch.Stop(local_1_Ref);
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$Alice.txt_1;
    call $tmp2 := System.IO.File.Exists$System.String(local_2_Ref);
    if (!$tmp2)
    {
        assume {:breadcrumb 10} true;
        call $tmp3 := System.IO.File.CreateText$System.String(local_2_Ref);
        local_3_Ref := $tmp3;
        call $tmp4 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp4);
    }
    else
    {
        assume {:breadcrumb 11} true;
        call $tmp5 := System.IO.File.AppendText$System.String(local_2_Ref);
        local_3_Ref := $tmp5;
        call $tmp6 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp6);
    }

    assume $this != null;
    F$CST.Message.value[local_0_Ref] := F$ABC.A.data[$this];
    F$CST.Message.largestParty[local_0_Ref] := $string_literal_Alice_0;
    F$CST.CST_Struct.SignedBy[local_0_Ref] := $string_literal_Alice_0;
    local_4_Ref := local_0_Ref;
    goto IL_00b9;

  IL_00b9:
    $result := local_4_Ref;
    return;
}



procedure T$ABC.A.#cctor();



implementation T$ABC.A.#cctor()
{
}



function T$Server_A.A_invoke() : Ref;

const unique T$Server_A.A_invoke: int;

var F$Server_A.A_invoke.server_a: [Ref]Ref;

procedure Server_A.A_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



procedure {:extern} System.Web.UI.Page.get_Request($this: Ref) returns ($result: Ref);



procedure {:extern} CST.Message.parse$CST.Message$System.Web.HttpRequest(msg$in: Ref, request$in: Ref) returns ($result: bool);



procedure {:extern} System.Web.UI.Page.get_Response($this: Ref) returns ($result: Ref);



procedure {:extern} CST.Message.respond$CST.Message$System.Web.HttpResponse(msg$in: Ref, response$in: Ref);



implementation Server_A.A_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 12} true;
    call $tmp0 := Alloc();
    call CST.Message.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$CST.Message();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CST.Message;
    local_0_Ref := $tmp0;
    call $tmp1 := System.Web.UI.Page.get_Request($this);
    call $tmp2 := CST.Message.parse$CST.Message$System.Web.HttpRequest(local_0_Ref, $tmp1);
    if ($tmp2)
    {
        assume {:breadcrumb 13} true;
        assume $this != null;
        $tmp3 := F$Server_A.A_invoke.server_a[$this];
        call $tmp4 := ABC.A.invoke$CST.Message($tmp3, local_0_Ref);
        call $tmp5 := System.Web.UI.Page.get_Response($this);
        call CST.Message.respond$CST.Message$System.Web.HttpResponse($tmp4, $tmp5);
    }
    else
    {
        assume {:breadcrumb 14} true;
    }
}



procedure Server_A.A_invoke.#ctor($this: Ref);



procedure {:extern} System.Web.UI.Page.#ctor($this: Ref);



implementation Server_A.A_invoke.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$Server_A.A_invoke.server_a[$this] := null;
    assume {:breadcrumb 15} true;
    call $tmp0 := Alloc();
    call ABC.A.#ctor$System.Int32($tmp0, 40);
    assume $DynamicType($tmp0) == T$ABC.A();
    assume $TypeConstructor($DynamicType($tmp0)) == T$ABC.A;
    F$Server_A.A_invoke.server_a[$this] := $tmp0;
    call System.Web.UI.Page.#ctor($this);
}



procedure T$Server_A.A_invoke.#cctor();



implementation T$Server_A.A_invoke.#cctor()
{
}



procedure ABC.B.#ctor($this: Ref);



implementation ABC.B.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$ABC.B.data[$this] := 0;
    assume {:breadcrumb 16} true;
    call System.Object.#ctor($this);
}



implementation ABC.B.#ctor$System.Int32($this: Ref, i1$in: int)
{
  var i1: int;
  var $localExc: Ref;
  var $label: int;

    i1 := i1$in;
    F$ABC.B.data[$this] := 0;
    assume {:breadcrumb 17} true;
    call System.Object.#ctor($this);
    F$ABC.B.data[$this] := i1;
}



const {:value "C:\Users\Daniel Song\Desktop\Bob.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$Bob.txt_2: Ref;

const {:value "Bob"} unique $string_literal_Bob_3: Ref;

implementation ABC.B.invoke$CST.Message($this: Ref, in_msg$in: Ref) returns ($result: Ref)
{
  var in_msg: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $tmp1: Ref;
  var local_2_Ref: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var local_3_Ref: Ref;
  var $tmp4: int;
  var $tmp5: Ref;
  var $tmp6: int;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var local_4_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    in_msg := in_msg$in;
    assume {:breadcrumb 18} true;
    call $tmp0 := Alloc();
    call CST.Message.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$CST.Message();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CST.Message;
    local_0_Ref := $tmp0;
    call $tmp1 := Alloc();
    call System.Diagnostics.Stopwatch.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Diagnostics.Stopwatch();
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Diagnostics.Stopwatch;
    local_1_Ref := $tmp1;
    call System.Diagnostics.Stopwatch.Start(local_1_Ref);
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct($this, in_msg, local_0_Ref);
    call System.Diagnostics.Stopwatch.Stop(local_1_Ref);
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$Bob.txt_2;
    call $tmp2 := System.IO.File.Exists$System.String(local_2_Ref);
    if (!$tmp2)
    {
        assume {:breadcrumb 19} true;
        call $tmp3 := System.IO.File.CreateText$System.String(local_2_Ref);
        local_3_Ref := $tmp3;
        call $tmp4 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp4);
    }
    else
    {
        assume {:breadcrumb 20} true;
        call $tmp5 := System.IO.File.AppendText$System.String(local_2_Ref);
        local_3_Ref := $tmp5;
        call $tmp6 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp6);
    }

    $tmp7 := in_msg;
    assume $tmp7 != null;
    F$CST.Message.value[local_0_Ref] := F$CST.Message.value[$tmp7];
    $tmp8 := in_msg;
    assume $tmp8 != null;
    F$CST.Message.largestParty[local_0_Ref] := F$CST.Message.largestParty[$tmp8];
    $tmp9 := local_0_Ref;
    assume $tmp9 != null;
    assume $this != null;
    if (F$CST.Message.value[$tmp9] < F$ABC.B.data[$this])
    {
        assume {:breadcrumb 21} true;
        assume $this != null;
        F$CST.Message.value[local_0_Ref] := F$ABC.B.data[$this];
        F$CST.Message.largestParty[local_0_Ref] := $string_literal_Bob_3;
    }
    else
    {
        assume {:breadcrumb 22} true;
    }

    F$CST.CST_Struct.SignedBy[local_0_Ref] := $string_literal_Bob_3;
    local_4_Ref := local_0_Ref;
    goto IL_00ea;

  IL_00ea:
    $result := local_4_Ref;
    return;
}



procedure T$ABC.B.#cctor();



implementation T$ABC.B.#cctor()
{
}



function T$Server_B.B_invoke() : Ref;

const unique T$Server_B.B_invoke: int;

var F$Server_B.B_invoke.server_b: [Ref]Ref;

procedure Server_B.B_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



implementation Server_B.B_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 23} true;
    call $tmp0 := Alloc();
    call CST.Message.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$CST.Message();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CST.Message;
    local_0_Ref := $tmp0;
    call $tmp1 := System.Web.UI.Page.get_Request($this);
    call $tmp2 := CST.Message.parse$CST.Message$System.Web.HttpRequest(local_0_Ref, $tmp1);
    if ($tmp2)
    {
        assume {:breadcrumb 24} true;
        assume $this != null;
        $tmp3 := F$Server_B.B_invoke.server_b[$this];
        call $tmp4 := ABC.B.invoke$CST.Message($tmp3, local_0_Ref);
        call $tmp5 := System.Web.UI.Page.get_Response($this);
        call CST.Message.respond$CST.Message$System.Web.HttpResponse($tmp4, $tmp5);
    }
    else
    {
        assume {:breadcrumb 25} true;
    }
}



procedure Server_B.B_invoke.#ctor($this: Ref);



implementation Server_B.B_invoke.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$Server_B.B_invoke.server_b[$this] := null;
    assume {:breadcrumb 26} true;
    call $tmp0 := Alloc();
    call ABC.B.#ctor$System.Int32($tmp0, 45);
    assume $DynamicType($tmp0) == T$ABC.B();
    assume $TypeConstructor($DynamicType($tmp0)) == T$ABC.B;
    F$Server_B.B_invoke.server_b[$this] := $tmp0;
    call System.Web.UI.Page.#ctor($this);
}



procedure T$Server_B.B_invoke.#cctor();



implementation T$Server_B.B_invoke.#cctor()
{
}



function T$Server_C.C_invoke() : Ref;

const unique T$Server_C.C_invoke: int;

var F$Server_C.C_invoke.server_c: [Ref]Ref;

procedure Server_C.C_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



implementation Server_C.C_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 27} true;
    call $tmp0 := Alloc();
    call CST.Message.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$CST.Message();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CST.Message;
    local_0_Ref := $tmp0;
    call $tmp1 := System.Web.UI.Page.get_Request($this);
    call $tmp2 := CST.Message.parse$CST.Message$System.Web.HttpRequest(local_0_Ref, $tmp1);
    if ($tmp2)
    {
        assume {:breadcrumb 28} true;
        assume $this != null;
        $tmp3 := F$Server_C.C_invoke.server_c[$this];
        call $tmp4 := ABC.C.invoke$CST.Message($tmp3, local_0_Ref);
        call $tmp5 := System.Web.UI.Page.get_Response($this);
        call CST.Message.respond$CST.Message$System.Web.HttpResponse($tmp4, $tmp5);
    }
    else
    {
        assume {:breadcrumb 29} true;
    }
}



procedure Server_C.C_invoke.#ctor($this: Ref);



implementation Server_C.C_invoke.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$Server_C.C_invoke.server_c[$this] := null;
    assume {:breadcrumb 30} true;
    call $tmp0 := Alloc();
    call ABC.C.#ctor$System.Int32($tmp0, 50);
    assume $DynamicType($tmp0) == T$ABC.C();
    assume $TypeConstructor($DynamicType($tmp0)) == T$ABC.C;
    F$Server_C.C_invoke.server_c[$this] := $tmp0;
    call System.Web.UI.Page.#ctor($this);
}



procedure T$Server_C.C_invoke.#cctor();



implementation T$Server_C.C_invoke.#cctor()
{
}



procedure ABC.C.#ctor($this: Ref);



implementation ABC.C.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$ABC.C.data[$this] := 0;
    F$ABC.C.conclusion[$this] := null;
    assume {:breadcrumb 31} true;
    call $tmp0 := Alloc();
    call CST.Message.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$CST.Message();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CST.Message;
    F$ABC.C.conclusion[$this] := $tmp0;
    call System.Object.#ctor($this);
}



implementation ABC.C.#ctor$System.Int32($this: Ref, i1$in: int)
{
  var i1: int;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    i1 := i1$in;
    F$ABC.C.data[$this] := 0;
    F$ABC.C.conclusion[$this] := null;
    assume {:breadcrumb 32} true;
    call $tmp0 := Alloc();
    call CST.Message.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$CST.Message();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CST.Message;
    F$ABC.C.conclusion[$this] := $tmp0;
    call System.Object.#ctor($this);
    F$ABC.C.data[$this] := i1;
}



const {:value "C:\Users\Daniel Song\Desktop\Charlie.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$Charlie.txt_4: Ref;

const {:value "Charles"} unique $string_literal_Charles_5: Ref;

procedure ABC.C.conclude$CST.Message($this: Ref, msg$in: Ref) returns ($result: bool);



var {:extern} F$CST.Message.certified: [Ref]bool;

const {:value "The largest party is "} unique $string_literal_The$largest$party$is$_6: Ref;

const {:value "."} unique $string_literal_._7: Ref;

procedure {:extern} System.String.Concat$System.String$System.String$System.String(str0$in: Ref, str1$in: Ref, str2$in: Ref) returns ($result: Ref);



procedure {:extern} System.Console.WriteLine$System.String(value$in: Ref);



const {:value "Not verified."} unique $string_literal_Not$verified._8: Ref;

implementation ABC.C.invoke$CST.Message($this: Ref, in_msg$in: Ref) returns ($result: Ref)
{
  var in_msg: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $tmp1: bool;
  var $tmp2: Ref;
  var local_2_Ref: Ref;
  var $tmp3: int;
  var $tmp4: Ref;
  var $tmp5: int;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: bool;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var local_3_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    in_msg := in_msg$in;
    assume {:breadcrumb 33} true;
    call $tmp0 := Alloc();
    call System.Diagnostics.Stopwatch.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Diagnostics.Stopwatch();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Diagnostics.Stopwatch;
    local_0_Ref := $tmp0;
    call System.Diagnostics.Stopwatch.Start(local_0_Ref);
    assume $this != null;
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct($this, in_msg, F$ABC.C.conclusion[$this]);
    call System.Diagnostics.Stopwatch.Stop(local_0_Ref);
    local_1_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$Charlie.txt_4;
    call $tmp1 := System.IO.File.Exists$System.String(local_1_Ref);
    if (!$tmp1)
    {
        assume {:breadcrumb 34} true;
        call $tmp2 := System.IO.File.CreateText$System.String(local_1_Ref);
        local_2_Ref := $tmp2;
        call $tmp3 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_2_Ref, $tmp3);
    }
    else
    {
        assume {:breadcrumb 35} true;
        call $tmp4 := System.IO.File.AppendText$System.String(local_1_Ref);
        local_2_Ref := $tmp4;
        call $tmp5 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_2_Ref, $tmp5);
    }

    $tmp6 := in_msg;
    assume $tmp6 != null;
    assume $this != null;
    F$CST.Message.value[F$ABC.C.conclusion[$this]] := F$CST.Message.value[$tmp6];
    $tmp7 := in_msg;
    assume $tmp7 != null;
    assume $this != null;
    F$CST.Message.largestParty[F$ABC.C.conclusion[$this]] := F$CST.Message.largestParty[$tmp7];
    $tmp8 := in_msg;
    assume $tmp8 != null;
    assume $this != null;
    F$CST.CST_Struct.SignedBy[F$ABC.C.conclusion[$this]] := F$CST.CST_Struct.SignedBy[$tmp8];
    assume $this != null;
    $tmp9 := F$ABC.C.conclusion[$this];
    assume $tmp9 != null;
    assume $this != null;
    if (F$CST.Message.value[$tmp9] < F$ABC.C.data[$this])
    {
        assume {:breadcrumb 36} true;
        assume $this != null;
        F$CST.Message.largestParty[F$ABC.C.conclusion[$this]] := $string_literal_Charles_5;
        assume $this != null;
        assume $this != null;
        F$CST.Message.value[F$ABC.C.conclusion[$this]] := F$ABC.C.data[$this];
    }
    else
    {
        assume {:breadcrumb 37} true;
    }

    assume $this != null;
    F$CST.CST_Struct.SignedBy[F$ABC.C.conclusion[$this]] := $string_literal_Charles_5;
    assume $this != null;
    call $tmp10 := ABC.C.conclude$CST.Message($this, F$ABC.C.conclusion[$this]);
    if ($tmp10)
    {
        assume {:breadcrumb 38} true;
        assume $this != null;
        F$CST.Message.certified[F$ABC.C.conclusion[$this]] := true;
        assume $this != null;
        $tmp11 := F$ABC.C.conclusion[$this];
        assume $tmp11 != null;
        call $tmp12 := System.String.Concat$System.String$System.String$System.String($string_literal_The$largest$party$is$_6, F$CST.Message.largestParty[$tmp11], $string_literal_._7);
        call System.Console.WriteLine$System.String($tmp12);
    }
    else
    {
        assume {:breadcrumb 39} true;
        assume $this != null;
        F$CST.Message.certified[F$ABC.C.conclusion[$this]] := false;
        call System.Console.WriteLine$System.String($string_literal_Not$verified._8);
    }

    assume $this != null;
    local_3_Ref := F$ABC.C.conclusion[$this];
    goto IL_017a;

  IL_017a:
    $result := local_3_Ref;
    return;
}



procedure {:extern} CST.CST_Ops.CertifyLocally$CST.CST_Struct(msg$in: Ref) returns ($result: bool);



const {:value "C:\Users\Daniel Song\Desktop\ABC_Certify.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$ABC_Certify.txt_9: Ref;

implementation ABC.C.conclude$CST.Message($this: Ref, msg$in: Ref) returns ($result: bool)
{
  var msg: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_1_bool: bool;
  var $tmp1: bool;
  var local_2_Ref: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var local_3_Ref: Ref;
  var $tmp4: int;
  var $tmp5: Ref;
  var $tmp6: int;
  var local_4_bool: bool;
  var $localExc: Ref;
  var $label: int;

    msg := msg$in;
    assume {:breadcrumb 40} true;
    call $tmp0 := Alloc();
    call System.Diagnostics.Stopwatch.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Diagnostics.Stopwatch();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Diagnostics.Stopwatch;
    local_0_Ref := $tmp0;
    call System.Diagnostics.Stopwatch.Start(local_0_Ref);
    call $tmp1 := CST.CST_Ops.CertifyLocally$CST.CST_Struct(msg);
    local_1_bool := $tmp1;
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$ABC_Certify.txt_9;
    call $tmp2 := System.IO.File.Exists$System.String(local_2_Ref);
    if (!$tmp2)
    {
        assume {:breadcrumb 41} true;
        call $tmp3 := System.IO.File.CreateText$System.String(local_2_Ref);
        local_3_Ref := $tmp3;
        call $tmp4 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp4);
    }
    else
    {
        assume {:breadcrumb 42} true;
        call $tmp5 := System.IO.File.AppendText$System.String(local_2_Ref);
        local_3_Ref := $tmp5;
        call $tmp6 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp6);
    }

    local_4_bool := local_1_bool;
    goto IL_0088;

  IL_0088:
    $result := local_4_bool;
    return;
}



procedure T$ABC.C.#cctor();



implementation T$ABC.C.#cctor()
{
}



procedure {:extern} System.Web.HttpRequest.get_QueryString($this: Ref) returns ($result: Ref);



const {:value "SymT"} unique $string_literal_SymT_10: Ref;

procedure {:extern} System.Collections.Specialized.NameValueCollection.get_Item$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



var {:extern} F$CST.CST_Struct.SymT: [Ref]Ref;

const {:value "SignedBy"} unique $string_literal_SignedBy_11: Ref;

const {:value "value"} unique $string_literal_value_12: Ref;

const {:value "Value"} unique $string_literal_Value_13: Ref;

procedure {:extern} System.Int32.Parse$System.String(s$in: Ref) returns ($result: int);



const {:value "LargestParty"} unique $string_literal_LargestParty_14: Ref;

procedure CST.Message.SignatureValid$System.Web.HttpRequest(request$in: Ref) returns ($result: bool);



procedure {:extern} System.String.get_Length($this: Ref) returns ($result: int);



procedure CST.Message.generateErrorResponse();



implementation CST.Message.parse$CST.Message$System.Web.HttpRequest(msg$in: Ref, request$in: Ref) returns ($result: bool)
{
  var msg: Ref;
  var request: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: int;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: bool;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: int;
  var $tmp15: Ref;
  var local_0_bool: bool;
  var $localExc: Ref;
  var $label: int;

    msg := msg$in;
    request := request$in;
    assume {:breadcrumb 43} true;
    call $tmp0 := System.Web.HttpRequest.get_QueryString(request);
    call $tmp1 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp0, $string_literal_SymT_10);
    F$CST.CST_Struct.SymT[msg] := $tmp1;
    call $tmp2 := System.Web.HttpRequest.get_QueryString(request);
    call $tmp3 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp2, $string_literal_SignedBy_11);
    F$CST.CST_Struct.SignedBy[msg] := $tmp3;
    call $tmp4 := System.Web.HttpRequest.get_QueryString(request);
    call $tmp5 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp4, $string_literal_value_12);
    if ($tmp5 != null)
    {
        assume {:breadcrumb 44} true;
        call $tmp6 := System.Web.HttpRequest.get_QueryString(request);
        call $tmp7 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp6, $string_literal_Value_13);
        call $tmp8 := System.Int32.Parse$System.String($tmp7);
        F$CST.Message.value[msg] := $tmp8;
    }
    else
    {
        assume {:breadcrumb 45} true;
    }

    call $tmp9 := System.Web.HttpRequest.get_QueryString(request);
    call $tmp10 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp9, $string_literal_LargestParty_14);
    F$CST.Message.largestParty[msg] := $tmp10;
    $tmp15 := msg;
    assume $tmp15 != null;
    if (F$CST.CST_Struct.SignedBy[$tmp15] == null)
    {
    }
    else
    {
        $tmp12 := msg;
        assume $tmp12 != null;
        $tmp13 := F$CST.CST_Struct.SignedBy[$tmp12];
        call $tmp14 := System.String.get_Length($tmp13);
    }

    if ((if F$CST.CST_Struct.SignedBy[$tmp15] == null then true else $tmp14 == 0))
    {
        call $tmp11 := CST.Message.SignatureValid$System.Web.HttpRequest(request);
    }
    else
    {
    }

    if ((if (if F$CST.CST_Struct.SignedBy[$tmp15] == null then true else $tmp14 == 0) then !$tmp11 else false))
    {
        assume {:breadcrumb 46} true;
        call CST.Message.generateErrorResponse();
        local_0_bool := false;
    }
    else
    {
        assume {:breadcrumb 47} true;
        local_0_bool := true;
        goto IL_00a7;
    }

  IL_00a7:
    $result := local_0_bool;
    return;
}



procedure {:extern} System.Collections.Generic.Dictionary`2.#ctor($this: Ref);



function {:extern} TKey$T$System.Collections.Generic.Dictionary`2(parent: Ref) : Ref;

function {:extern} TValue$T$System.Collections.Generic.Dictionary`2(parent: Ref) : Ref;

function {:extern} T$System.Collections.Generic.Dictionary`2(TKey: Ref, TValue: Ref) : Ref;

const {:extern} unique T$System.Collections.Generic.Dictionary`2: int;

function {:extern} T$System.String() : Ref;

const {:extern} unique T$System.String: int;

axiom $TypeConstructor(T$System.String()) == T$System.String;

procedure {:extern} System.Collections.Generic.Dictionary`2.Add$`0$`1($this: Ref, key$in: Ref, value$in: Ref);



procedure {:extern} System.Int32.ToString($this: int) returns ($result: Ref);



const {:value "Certified"} unique $string_literal_Certified_15: Ref;

procedure {:extern} System.Boolean.ToString($this: bool) returns ($result: Ref);



procedure {:extern} HTTP.HTTPComm.GenerateXML$System.Collections.Generic.Dictionary$System.String$System.String$(msgDict$in: Ref) returns ($result: Ref);



procedure {:extern} System.Web.HttpResponse.set_StatusCode$System.Int32($this: Ref, value$in: int);



const {:value "text/xml"} unique $string_literal_text$xml_16: Ref;

procedure {:extern} System.Web.HttpResponse.set_ContentType$System.String($this: Ref, value$in: Ref);



procedure {:extern} System.Text.Encoding.get_UTF8() returns ($result: Ref);



procedure {:extern} System.Web.HttpResponse.set_ContentEncoding$System.Text.Encoding($this: Ref, value$in: Ref);



procedure {:extern} System.Web.HttpResponse.get_Output($this: Ref) returns ($result: Ref);



procedure {:extern} System.Xml.XmlDocument.Save$System.IO.TextWriter($this: Ref, writer$in: Ref);



implementation CST.Message.respond$CST.Message$System.Web.HttpResponse(msg$in: Ref, response$in: Ref)
{
  var msg: Ref;
  var response: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: int;
  var $tmp5: Ref;
  var $tmp6: bool;
  var $tmp7: Ref;
  var local_1_Ref: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $localExc: Ref;
  var $label: int;

    msg := msg$in;
    response := response$in;
    assume {:breadcrumb 48} true;
    call $tmp0 := Alloc();
    call System.Collections.Generic.Dictionary`2.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.String());
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.String();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.String();
    local_0_Ref := $tmp0;
    $tmp1 := msg;
    assume $tmp1 != null;
    call System.Collections.Generic.Dictionary`2.Add$`0$`1(local_0_Ref, $string_literal_SymT_10, F$CST.CST_Struct.SymT[$tmp1]);
    $tmp2 := msg;
    assume $tmp2 != null;
    call System.Collections.Generic.Dictionary`2.Add$`0$`1(local_0_Ref, $string_literal_SignedBy_11, F$CST.CST_Struct.SignedBy[$tmp2]);
    $tmp3 := msg;
    assume $tmp3 != null;
    call System.Collections.Generic.Dictionary`2.Add$`0$`1(local_0_Ref, $string_literal_LargestParty_14, F$CST.Message.largestParty[$tmp3]);
    assume msg != null;
    $tmp4 := F$CST.Message.value[msg];
    call $tmp5 := System.Int32.ToString($tmp4);
    call System.Collections.Generic.Dictionary`2.Add$`0$`1(local_0_Ref, $string_literal_Value_13, $tmp5);
    assume msg != null;
    $tmp6 := F$CST.Message.certified[msg];
    call $tmp7 := System.Boolean.ToString($tmp6);
    call System.Collections.Generic.Dictionary`2.Add$`0$`1(local_0_Ref, $string_literal_Certified_15, $tmp7);
    call $tmp8 := HTTP.HTTPComm.GenerateXML$System.Collections.Generic.Dictionary$System.String$System.String$(local_0_Ref);
    local_1_Ref := $tmp8;
    call System.Web.HttpResponse.set_StatusCode$System.Int32(response, 200);
    call System.Web.HttpResponse.set_ContentType$System.String(response, $string_literal_text$xml_16);
    call $tmp9 := System.Text.Encoding.get_UTF8();
    call System.Web.HttpResponse.set_ContentEncoding$System.Text.Encoding(response, $tmp9);
    call $tmp10 := System.Web.HttpResponse.get_Output(response);
    call System.Xml.XmlDocument.Save$System.IO.TextWriter(local_1_Ref, $tmp10);
}



implementation CST.Message.generateErrorResponse()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 49} true;
}



implementation CST.Message.SignatureValid$System.Web.HttpRequest(request$in: Ref) returns ($result: bool)
{
  var request: Ref;
  var local_0_bool: bool;
  var $localExc: Ref;
  var $label: int;

    request := request$in;
    assume {:breadcrumb 50} true;
    local_0_bool := true;
    goto IL_0005;

  IL_0005:
    $result := local_0_bool;
    return;
}



procedure {:extern} CST.CST_Struct.#ctor($this: Ref);



implementation CST.Message.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$CST.Message.value[$this] := 0;
    F$CST.Message.largestParty[$this] := null;
    F$CST.Message.certified[$this] := false;
    assume {:breadcrumb 51} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$CST.Message.#cctor();



implementation T$CST.Message.#cctor()
{
}



function T$CST.Nondet_Base() : Ref;

const unique T$CST.Nondet_Base: int;

procedure CST.Nondet_Base.String($this: Ref) returns ($result: Ref);



procedure CST.Nondet_Base.Bool($this: Ref) returns ($result: bool);



function T$CST.CST_Struct() : Ref;

const unique T$CST.CST_Struct: int;

const {:value ""} unique $string_literal__17: Ref;

implementation CST.CST_Struct.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$CST.CST_Struct.SymT[$this] := null;
    F$CST.CST_Struct.SignedBy[$this] := null;
    assume {:breadcrumb 52} true;
    F$CST.CST_Struct.SymT[$this] := $string_literal__17;
    F$CST.CST_Struct.SignedBy[$this] := $string_literal__17;
    call System.Object.#ctor($this);
}



procedure T$CST.CST_Struct.#cctor();



implementation T$CST.CST_Struct.#cctor()
{
}



function T$CST.Debug() : Ref;

const unique T$CST.Debug: int;

procedure CST.Debug.reached();



implementation CST.Debug.reached()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 53} true;
    assert false;
}



procedure CST.Debug.#ctor($this: Ref);



implementation CST.Debug.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 54} true;
    call System.Object.#ctor($this);
}



procedure T$CST.Debug.#cctor();



implementation T$CST.Debug.#cctor()
{
}



