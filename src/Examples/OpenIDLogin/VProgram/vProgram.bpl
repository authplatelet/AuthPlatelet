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

procedure GlobalObjectsForCST.init();



procedure {:extern} OpenID20NameSpace.AuthenticationRequest.#ctor($this: Ref);



function {:extern} T$OpenID20NameSpace.AuthenticationRequest() : Ref;

const {:extern} unique T$OpenID20NameSpace.AuthenticationRequest: int;

axiom $TypeConstructor(T$OpenID20NameSpace.AuthenticationRequest()) == T$OpenID20NameSpace.AuthenticationRequest;

var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req: Ref;

var F$PoirotMain.Nondet: Ref;

procedure {:extern} CST.Nondet_Base.String($this: Ref) returns ($result: Ref);



procedure {:extern} OpenID20NameSpace.AuthenticationRequest.set_Realm$System.String($this: Ref, value$in: Ref);



procedure {:extern} GenericAuthNameSpace.SignInIdP_Req.set_Realm$System.String($this: Ref, value$in: Ref);



var {:extern} F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret: [Ref]Ref;

var {:extern} F$OpenID20NameSpace.AuthenticationRequest.return_to: [Ref]Ref;

var {:extern} F$CST.CST_Struct.SymT: [Ref]Ref;

var {:extern} F$OpenID20NameSpace.AuthenticationRequest.identity: [Ref]Ref;

var {:extern} F$OpenID20NameSpace.AuthenticationRequest.realm: [Ref]Ref;

procedure {:extern} OpenID20NameSpace.Yahoo_IdP.#ctor($this: Ref);



function {:extern} T$OpenID20NameSpace.Yahoo_IdP() : Ref;

const {:extern} unique T$OpenID20NameSpace.Yahoo_IdP: int;

axiom $TypeConstructor(T$OpenID20NameSpace.Yahoo_IdP()) == T$OpenID20NameSpace.Yahoo_IdP;

var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.AS: Ref;

procedure {:extern} OpenID20NameSpace.Yahoo_IdP.init($this: Ref);



procedure LiveIDNameSpace.Yahoo_RP_For_vProgram.#ctor($this: Ref);



function T$LiveIDNameSpace.Yahoo_RP_For_vProgram() : Ref;

const unique T$LiveIDNameSpace.Yahoo_RP_For_vProgram: int;

var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.RP: Ref;

implementation GlobalObjectsForCST.init()
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 0} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 10} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 10} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 10} true;
    call OpenID20NameSpace.AuthenticationRequest.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationRequest();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationRequest;
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := $tmp0;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 11} true;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenID20NameSpace.AuthenticationRequest)
    {
        assume {:breadcrumb 1} true;
        call $tmp1 := CST.Nondet_Base.String(F$PoirotMain.Nondet);
        call OpenID20NameSpace.AuthenticationRequest.set_Realm$System.String(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req, $tmp1);
    }
    else
    {
        assume {:breadcrumb 2} true;
        call $tmp2 := CST.Nondet_Base.String(F$PoirotMain.Nondet);
        call GenericAuthNameSpace.SignInIdP_Req.set_Realm$System.String(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req, $tmp2);
    }

    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 12} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 12} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 12} true;
    call $tmp3 := CST.Nondet_Base.String(F$PoirotMain.Nondet);
    F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req] := $tmp3;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 13} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 13} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 13} true;
    call $tmp4 := CST.Nondet_Base.String(F$PoirotMain.Nondet);
    F$OpenID20NameSpace.AuthenticationRequest.return_to[F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req] := $tmp4;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 14} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 14} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 14} true;
    call $tmp5 := CST.Nondet_Base.String(F$PoirotMain.Nondet);
    F$CST.CST_Struct.SymT[F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req] := $tmp5;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 15} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 15} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 15} true;
    call $tmp6 := CST.Nondet_Base.String(F$PoirotMain.Nondet);
    F$OpenID20NameSpace.AuthenticationRequest.identity[F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req] := $tmp6;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 16} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 16} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 16} true;
    call $tmp7 := CST.Nondet_Base.String(F$PoirotMain.Nondet);
    F$OpenID20NameSpace.AuthenticationRequest.realm[F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req] := $tmp7;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 17} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 17} true;
    call $tmp8 := Alloc();
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 17} true;
    call OpenID20NameSpace.Yahoo_IdP.#ctor($tmp8);
    assume $DynamicType($tmp8) == T$OpenID20NameSpace.Yahoo_IdP();
    assume $TypeConstructor($DynamicType($tmp8)) == T$OpenID20NameSpace.Yahoo_IdP;
    F$GenericAuthNameSpace.GlobalObjects_base.AS := $tmp8;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 17} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 17} true;
    call OpenID20NameSpace.Yahoo_IdP.init(F$GenericAuthNameSpace.GlobalObjects_base.AS);
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 18} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 18} true;
    call $tmp9 := Alloc();
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 18} true;
    call LiveIDNameSpace.Yahoo_RP_For_vProgram.#ctor($tmp9);
    assume $DynamicType($tmp9) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram();
    assume $TypeConstructor($DynamicType($tmp9)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram;
    F$GenericAuthNameSpace.GlobalObjects_base.RP := $tmp9;
}



procedure GlobalObjectsForCST.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref);



implementation GlobalObjectsForCST.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 3} true;
    call GenericAuthNameSpace.GlobalObjects_base.#ctor($this);
}



procedure T$GlobalObjectsForCST.#cctor();



implementation T$GlobalObjectsForCST.#cctor()
{
}



function T$PoirotMain() : Ref;

const unique T$PoirotMain: int;

procedure {:entrypoint} PoirotMain.Main();



procedure SynthesizedPortion.SynthesizedSequence();



implementation PoirotMain.Main()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 4} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 27} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 27} true;
    call GlobalObjectsForCST.init();
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 28} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 28} true;
    call SynthesizedPortion.SynthesizedSequence();
}



procedure PoirotMain.#ctor($this: Ref);



procedure {:extern} System.Object.#ctor($this: Ref);



implementation PoirotMain.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 5} true;
    call System.Object.#ctor($this);
}



procedure T$PoirotMain.#cctor();



implementation T$PoirotMain.#cctor()
{
    F$PoirotMain.Nondet := null;
}



function T$SynthesizedPortion() : Ref;

const unique T$SynthesizedPortion: int;

procedure {:extern} OpenID20NameSpace.NondetOpenID20.SignInIdP_Req($this: Ref) returns ($result: Ref);



procedure {:extern} OpenID20NameSpace.OpenIDProvider.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.AS.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



function {:extern} T$OpenID20NameSpace.OpenIDProvider() : Ref;

const {:extern} unique T$OpenID20NameSpace.OpenIDProvider: int;

axiom $TypeConstructor(T$OpenID20NameSpace.OpenIDProvider()) == T$OpenID20NameSpace.OpenIDProvider;

procedure {:extern} OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req1$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



function {:extern} T$OpenID20NameSpace.RelyingParty() : Ref;

const {:extern} unique T$OpenID20NameSpace.RelyingParty: int;

axiom $TypeConstructor(T$OpenID20NameSpace.RelyingParty()) == T$OpenID20NameSpace.RelyingParty;

function {:extern} T$OpenID20NameSpace.Yahoo_RP() : Ref;

const {:extern} unique T$OpenID20NameSpace.Yahoo_RP: int;

axiom $TypeConstructor(T$OpenID20NameSpace.Yahoo_RP()) == T$OpenID20NameSpace.Yahoo_RP;

implementation SynthesizedPortion.SynthesizedSequence()
{
  var G1_Ref: Ref;
  var $tmp0: Ref;
  var G2_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var G3_Ref: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 6} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 5} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 5} true;
    call $tmp0 := OpenID20NameSpace.NondetOpenID20.SignInIdP_Req(F$PoirotMain.Nondet);
    G1_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 6} true;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.AS)) == T$OpenID20NameSpace.Yahoo_IdP)
    {
        call $tmp1 := OpenID20NameSpace.OpenIDProvider.SignInIdP$GenericAuthNameSpace.SignInIdP_Req(F$GenericAuthNameSpace.GlobalObjects_base.AS, G1_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.AS)) == T$OpenID20NameSpace.OpenIDProvider)
        {
            call $tmp2 := OpenID20NameSpace.OpenIDProvider.SignInIdP$GenericAuthNameSpace.SignInIdP_Req(F$GenericAuthNameSpace.GlobalObjects_base.AS, G1_Ref);
        }
        else
        {
            call $tmp3 := GenericAuthNameSpace.AS.SignInIdP$GenericAuthNameSpace.SignInIdP_Req(F$GenericAuthNameSpace.GlobalObjects_base.AS, G1_Ref);
        }
    }

    G2_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.AS)) == T$OpenID20NameSpace.Yahoo_IdP then $tmp1 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.AS)) == T$OpenID20NameSpace.OpenIDProvider then $tmp2 else $tmp3));
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 7} true;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.RP)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram)
    {
        call $tmp4 := OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req(F$GenericAuthNameSpace.GlobalObjects_base.RP, G2_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.RP)) == T$OpenID20NameSpace.Yahoo_RP)
        {
            call $tmp5 := OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req(F$GenericAuthNameSpace.GlobalObjects_base.RP, G2_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.RP)) == T$OpenID20NameSpace.RelyingParty)
            {
                call $tmp6 := OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req(F$GenericAuthNameSpace.GlobalObjects_base.RP, G2_Ref);
            }
            else
            {
                call $tmp7 := GenericAuthNameSpace.RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req(F$GenericAuthNameSpace.GlobalObjects_base.RP, G2_Ref);
            }
        }
    }

    G3_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.RP)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram then $tmp4 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.RP)) == T$OpenID20NameSpace.Yahoo_RP then $tmp5 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.RP)) == T$OpenID20NameSpace.RelyingParty then $tmp6 else $tmp7)));
}



procedure SynthesizedPortion.#ctor($this: Ref);



implementation SynthesizedPortion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 7} true;
    call System.Object.#ctor($this);
}



procedure T$SynthesizedPortion.#cctor();



implementation T$SynthesizedPortion.#cctor()
{
}



procedure LiveIDNameSpace.Yahoo_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool);



procedure {:extern} GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion$in: Ref);



implementation LiveIDNameSpace.Yahoo_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool)
{
  var conclusion: Ref;
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 8} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Assertion.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Assertion.cs"} {:sourceLine 11} true;
    call GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion);
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Assertion.cs"} {:sourceLine 13} true;
    $result := true;
    return;
}



procedure {:extern} OpenID20NameSpace.Yahoo_RP.#ctor($this: Ref);



implementation LiveIDNameSpace.Yahoo_RP_For_vProgram.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 9} true;
    call OpenID20NameSpace.Yahoo_RP.#ctor($this);
}



procedure T$LiveIDNameSpace.Yahoo_RP_For_vProgram.#cctor();



implementation T$LiveIDNameSpace.Yahoo_RP_For_vProgram.#cctor()
{
}



function T$OpenID20NameSpace.AuthenticationResponse() : Ref;

const unique T$OpenID20NameSpace.AuthenticationResponse: int;

var F$OpenID20NameSpace.AuthenticationResponse.ns: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.mode: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.claimed_id: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.identity: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.assoc_handle: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.return_to: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.realm: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.endpointURL: [Ref]Ref;

procedure OpenID20NameSpace.AuthenticationResponse.#ctor($this: Ref);



const {:value "http://specs.openid.net/auth/2.0"} unique $string_literal_http$$$specs.openid.net$auth$2.0_0: Ref;

procedure {:extern} GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref);



implementation OpenID20NameSpace.AuthenticationResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenID20NameSpace.AuthenticationResponse.ns[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.mode[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.claimed_id[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.identity[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.assoc_handle[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.return_to[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.realm[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.endpointURL[$this] := null;
    assume {:breadcrumb 10} true;
    F$OpenID20NameSpace.AuthenticationResponse.ns[$this] := $string_literal_http$$$specs.openid.net$auth$2.0_0;
    call GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this);
}



procedure T$OpenID20NameSpace.AuthenticationResponse.#cctor();



implementation T$OpenID20NameSpace.AuthenticationResponse.#cctor()
{
}



function T$OpenID20NameSpace.NondetOpenID20() : Ref;

const unique T$OpenID20NameSpace.NondetOpenID20: int;

procedure OpenID20NameSpace.NondetOpenID20.SignInIdP_Resp_SignInRP_Req($this: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.NondetOpenID20.AuthenticationRequest($this: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.NondetOpenID20.AuthenticationResponse($this: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.NondetOpenID20.IDAssertionEntry($this: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.NondetOpenID20.IDAssertionRecsDictionary($this: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.OpenIDProvider.init$OpenID20NameSpace.IDAssertionRecs($this: Ref, recs$in: Ref);



procedure OpenID20NameSpace.OpenIDProvider.set_IDAssertionRecs$OpenID20NameSpace.IDAssertionRecs($this: Ref, value$in: Ref);



implementation OpenID20NameSpace.OpenIDProvider.init$OpenID20NameSpace.IDAssertionRecs($this: Ref, recs$in: Ref)
{
  var recs: Ref;
  var $localExc: Ref;
  var $label: int;

    recs := recs$in;
    assume {:breadcrumb 11} true;
    call OpenID20NameSpace.OpenIDProvider.set_IDAssertionRecs$OpenID20NameSpace.IDAssertionRecs($this, recs);
}



procedure OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.AS.IdpAuthRecs: [Ref]Ref;

implementation OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 12} true;
    assume $this != null;
    local_0_Ref := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



implementation OpenID20NameSpace.OpenIDProvider.set_IDAssertionRecs$OpenID20NameSpace.IDAssertionRecs($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 13} true;
    F$GenericAuthNameSpace.AS.IdpAuthRecs[$this] := value;
}



procedure OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.AS.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.IDAssertionEntry.get_Redir_dest($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.ID_Claim.get_Redir_dest($this: Ref) returns ($result: Ref);



function T$OpenID20NameSpace.IDAssertionEntry() : Ref;

const unique T$OpenID20NameSpace.IDAssertionEntry: int;

procedure OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.OpenIDProvider.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref)
{
  var req1: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var local_2_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var local_1_Ref: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $localExc: Ref;
  var $label: int;

    req1 := req1$in;
    assume {:breadcrumb 14} true;
    local_0_Ref := req1;
    $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
    assume $tmp0 != null;
    $tmp1 := local_0_Ref;
    assume $tmp1 != null;
    call $tmp2 := System.String.op_Equality$System.String$System.String(F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp0], F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp1]);
    assume $tmp2;
    if (local_0_Ref == null)
    {
        assume {:breadcrumb 15} true;
        local_2_Ref := null;
    }
    else
    {
        assume {:breadcrumb 16} true;
        if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP)
        {
            call $tmp3 := OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, local_0_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider)
            {
                call $tmp4 := OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, local_0_Ref);
            }
            else
            {
                call $tmp5 := GenericAuthNameSpace.AS.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, local_0_Ref);
            }
        }

        local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP then $tmp3 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider then $tmp4 else $tmp5));
        if (local_1_Ref == null)
        {
            assume {:breadcrumb 17} true;
            local_2_Ref := null;
        }
        else
        {
            assume {:breadcrumb 18} true;
            if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP)
            {
                if ($TypeConstructor($DynamicType(local_1_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
                {
                    call $tmp6 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(local_1_Ref);
                }
                else
                {
                    call $tmp7 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
                }

                call $tmp8 := OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp6 else $tmp7), local_1_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider)
                {
                    if ($TypeConstructor($DynamicType(local_1_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
                    {
                        call $tmp9 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(local_1_Ref);
                    }
                    else
                    {
                        call $tmp10 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
                    }

                    call $tmp11 := OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp9 else $tmp10), local_1_Ref);
                }
                else
                {
                    if ($TypeConstructor($DynamicType(local_1_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
                    {
                        call $tmp12 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(local_1_Ref);
                    }
                    else
                    {
                        call $tmp13 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
                    }

                    call $tmp14 := GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp12 else $tmp13), local_1_Ref);
                }
            }

            local_2_Ref := (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP then $tmp8 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider then $tmp11 else $tmp14));
            goto IL_0059;
        }
    }

  IL_0059:
    $result := local_2_Ref;
    return;
}



var F$OpenID20NameSpace.AuthenticationRequest.mode: [Ref]Ref;

const {:value "checkid_setup"} unique $string_literal_checkid_setup_1: Ref;

procedure {:extern} OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, Realm$in: Ref) returns ($result: Ref);



function {:extern} T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def() : Ref;

const {:extern} unique T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def: int;

axiom $TypeConstructor(T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def()) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def;

implementation OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref)
{
  var req1: Ref;
  var local_0_Ref: Ref;
  var local_3_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: bool;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var local_1_Ref: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: bool;
  var local_2_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    req1 := req1$in;
    assume {:breadcrumb 19} true;
    local_0_Ref := req1;
    $tmp0 := local_0_Ref;
    assume $tmp0 != null;
    local_3_Ref := F$OpenID20NameSpace.AuthenticationRequest.mode[$tmp0];
    if (local_3_Ref != null)
    {
        assume {:breadcrumb 20} true;
        call $tmp1 := System.String.op_Equality$System.String$System.String(local_3_Ref, $string_literal_checkid_setup_1);
        if (!$tmp1)
        {
            assume {:breadcrumb 22} true;
            goto IL_0060;
        }
        else
        {
            assume {:breadcrumb 23} true;
        }

        call $tmp10 := OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this);
        if ($TypeConstructor($DynamicType($tmp10)) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def)
        {
            call $tmp2 := OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this);
            $tmp3 := local_0_Ref;
            assume $tmp3 != null;
            $tmp4 := local_0_Ref;
            assume $tmp4 != null;
            call $tmp5 := OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($tmp2, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp3], F$OpenID20NameSpace.AuthenticationRequest.realm[$tmp4]);
        }
        else
        {
            call $tmp6 := OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this);
            $tmp7 := local_0_Ref;
            assume $tmp7 != null;
            $tmp8 := local_0_Ref;
            assume $tmp8 != null;
            call $tmp9 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp6, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp7], F$OpenID20NameSpace.AuthenticationRequest.realm[$tmp8]);
        }

        local_1_Ref := (if $TypeConstructor($DynamicType($tmp10)) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def then $tmp5 else $tmp9);
        $tmp11 := local_0_Ref;
        assume $tmp11 != null;
        if ($TypeConstructor($DynamicType(local_1_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
        {
            call $tmp12 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(local_1_Ref);
        }
        else
        {
            call $tmp13 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
        }

        call $tmp14 := System.String.op_Equality$System.String$System.String(F$OpenID20NameSpace.AuthenticationRequest.realm[$tmp11], (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp12 else $tmp13));
        if ($tmp14)
        {
            assume {:breadcrumb 24} true;
            local_2_Ref := local_1_Ref;
        }
        else
        {
            assume {:breadcrumb 25} true;
            local_2_Ref := null;
        }
    }
    else
    {
        assume {:breadcrumb 21} true;

      IL_0060:
        local_2_Ref := null;
        goto IL_0064;
    }

  IL_0064:
    $result := local_2_Ref;
    return;
}



procedure OpenID20NameSpace.IDAssertionEntry.get_UserID($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.ID_Claim.get_UserID($this: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref)
{
  var dest: Ref;
  var _ID_Claim: Ref;
  var local_1_Ref: Ref;
  var local_0_prime_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

    dest := dest$in;
    _ID_Claim := _ID_Claim$in;
    assume {:breadcrumb 26} true;
    call $tmp0 := Alloc();
    call OpenID20NameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationResponse;
    local_0_prime_Ref := $tmp0;
    if ($TypeConstructor($DynamicType(_ID_Claim)) == T$OpenID20NameSpace.IDAssertionEntry)
    {
        call $tmp1 := OpenID20NameSpace.IDAssertionEntry.get_UserID(_ID_Claim);
    }
    else
    {
        call $tmp2 := GenericAuthNameSpace.ID_Claim.get_UserID(_ID_Claim);
    }

    F$OpenID20NameSpace.AuthenticationResponse.claimed_id[local_0_prime_Ref] := (if $TypeConstructor($DynamicType(_ID_Claim)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp1 else $tmp2);
    if ($TypeConstructor($DynamicType(_ID_Claim)) == T$OpenID20NameSpace.IDAssertionEntry)
    {
        call $tmp3 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(_ID_Claim);
    }
    else
    {
        call $tmp4 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(_ID_Claim);
    }

    F$OpenID20NameSpace.AuthenticationResponse.return_to[local_0_prime_Ref] := (if $TypeConstructor($DynamicType(_ID_Claim)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp3 else $tmp4);
    local_1_Ref := local_0_prime_Ref;
    goto IL_0023;

  IL_0023:
    $result := local_1_Ref;
    return;
}



procedure OpenID20NameSpace.OpenIDProvider.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.AS.#ctor($this: Ref);



implementation OpenID20NameSpace.OpenIDProvider.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 27} true;
    call GenericAuthNameSpace.AS.#ctor($this);
}



procedure T$OpenID20NameSpace.OpenIDProvider.#cctor();



implementation T$OpenID20NameSpace.OpenIDProvider.#cctor()
{
}



var F$OpenID20NameSpace.IDAssertionEntry.openid_return_to: [Ref]Ref;

var F$OpenID20NameSpace.IDAssertionEntry.openid_identity: [Ref]Ref;

var F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id: [Ref]Ref;

var F$OpenID20NameSpace.IDAssertionEntry.openid_assoc_handle: [Ref]Ref;

var F$OpenID20NameSpace.IDAssertionEntry.openid_op_endpoint: [Ref]Ref;

implementation OpenID20NameSpace.IDAssertionEntry.get_Redir_dest($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 28} true;
    assume $this != null;
    local_0_Ref := F$OpenID20NameSpace.IDAssertionEntry.openid_return_to[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



implementation OpenID20NameSpace.IDAssertionEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 29} true;
    assume $this != null;
    local_0_Ref := F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OpenID20NameSpace.IDAssertionEntry.AssumeType$OpenID20NameSpace.IDAssertionEntry(in_obj$in: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.IDAssertionEntry.#ctor($this: Ref);



implementation OpenID20NameSpace.IDAssertionEntry.AssumeType$OpenID20NameSpace.IDAssertionEntry(in_obj$in: Ref) returns ($result: Ref)
{
  var in_obj: Ref;
  var local_1_Ref: Ref;
  var local_0_prime_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

    in_obj := in_obj$in;
    assume {:breadcrumb 30} true;
    call $tmp0 := Alloc();
    call OpenID20NameSpace.IDAssertionEntry.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.IDAssertionEntry();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.IDAssertionEntry;
    local_0_prime_Ref := $tmp0;
    $tmp1 := in_obj;
    assume $tmp1 != null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_return_to[local_0_prime_Ref] := F$OpenID20NameSpace.IDAssertionEntry.openid_return_to[$tmp1];
    $tmp2 := in_obj;
    assume $tmp2 != null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id[local_0_prime_Ref] := F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id[$tmp2];
    local_1_Ref := local_0_prime_Ref;
    goto IL_0023;

  IL_0023:
    $result := local_1_Ref;
    return;
}



procedure {:extern} GenericAuthNameSpace.ID_Claim.#ctor($this: Ref);



implementation OpenID20NameSpace.IDAssertionEntry.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenID20NameSpace.IDAssertionEntry.openid_return_to[$this] := null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_identity[$this] := null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id[$this] := null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_assoc_handle[$this] := null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_op_endpoint[$this] := null;
    assume {:breadcrumb 31} true;
    call GenericAuthNameSpace.ID_Claim.#ctor($this);
}



procedure T$OpenID20NameSpace.IDAssertionEntry.#cctor();



implementation T$OpenID20NameSpace.IDAssertionEntry.#cctor()
{
}



var F$OpenID20NameSpace.AuthenticationRequest.ns: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationRequest.claimed_id: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationRequest.assoc_handle: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationRequest.endpointURL: [Ref]Ref;

procedure OpenID20NameSpace.AuthenticationRequest.get_Realm($this: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.AuthenticationRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 32} true;
    assume $this != null;
    local_0_Ref := F$OpenID20NameSpace.AuthenticationRequest.realm[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



implementation OpenID20NameSpace.AuthenticationRequest.set_Realm$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 33} true;
    F$OpenID20NameSpace.AuthenticationRequest.realm[$this] := value;
}



procedure {:extern} GenericAuthNameSpace.SignInIdP_Req.#ctor($this: Ref);



implementation OpenID20NameSpace.AuthenticationRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenID20NameSpace.AuthenticationRequest.ns[$this] := null;
    F$OpenID20NameSpace.AuthenticationRequest.mode[$this] := null;
    F$OpenID20NameSpace.AuthenticationRequest.claimed_id[$this] := null;
    F$OpenID20NameSpace.AuthenticationRequest.identity[$this] := null;
    F$OpenID20NameSpace.AuthenticationRequest.assoc_handle[$this] := null;
    F$OpenID20NameSpace.AuthenticationRequest.return_to[$this] := null;
    F$OpenID20NameSpace.AuthenticationRequest.realm[$this] := null;
    F$OpenID20NameSpace.AuthenticationRequest.endpointURL[$this] := null;
    assume {:breadcrumb 34} true;
    F$OpenID20NameSpace.AuthenticationRequest.ns[$this] := $string_literal_http$$$specs.openid.net$auth$2.0_0;
    call GenericAuthNameSpace.SignInIdP_Req.#ctor($this);
}



procedure T$OpenID20NameSpace.AuthenticationRequest.#cctor();



implementation T$OpenID20NameSpace.AuthenticationRequest.#cctor()
{
}



var F$OpenID20NameSpace.RelyingParty.assoc_handle: [Ref]Ref;

var F$OpenID20NameSpace.RelyingParty.endpointUrl: [Ref]Ref;

procedure OpenID20NameSpace.RelyingParty.get_return_uri($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.RP.Domain: [Ref]Ref;

implementation OpenID20NameSpace.RelyingParty.get_return_uri($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 35} true;
    assume $this != null;
    local_0_Ref := F$GenericAuthNameSpace.RP.Domain[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OpenID20NameSpace.RelyingParty.set_return_uri$System.String($this: Ref, value$in: Ref);



implementation OpenID20NameSpace.RelyingParty.set_return_uri$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 36} true;
    F$GenericAuthNameSpace.RP.Domain[$this] := value;
}



procedure OpenID20NameSpace.RelyingParty.RequestAuthentication$OpenID20NameSpace.AuthenticationResponse($this: Ref, resp$in: Ref) returns ($result: Ref);



const {:value "http://specs.openid.net/auth/2.0/identifier_select"} unique $string_literal_http$$$specs.openid.net$auth$2.0$identifier_select_2: Ref;

procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct(o$in: Ref, in_msg$in: Ref, out_msg$in: Ref);



implementation OpenID20NameSpace.RelyingParty.RequestAuthentication$OpenID20NameSpace.AuthenticationResponse($this: Ref, resp$in: Ref) returns ($result: Ref)
{
  var resp: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    resp := resp$in;
    assume {:breadcrumb 37} true;
    call $tmp0 := Alloc();
    call OpenID20NameSpace.AuthenticationRequest.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationRequest();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationRequest;
    local_0_Ref := $tmp0;
    assume $this != null;
    F$OpenID20NameSpace.AuthenticationRequest.realm[local_0_Ref] := F$GenericAuthNameSpace.RP.Domain[$this];
    F$OpenID20NameSpace.AuthenticationRequest.identity[local_0_Ref] := $string_literal_http$$$specs.openid.net$auth$2.0$identifier_select_2;
    F$OpenID20NameSpace.AuthenticationRequest.ns[local_0_Ref] := $string_literal_http$$$specs.openid.net$auth$2.0_0;
    F$OpenID20NameSpace.AuthenticationRequest.claimed_id[local_0_Ref] := $string_literal_http$$$specs.openid.net$auth$2.0$identifier_select_2;
    F$OpenID20NameSpace.AuthenticationRequest.mode[local_0_Ref] := $string_literal_checkid_setup_1;
    assume $this != null;
    F$OpenID20NameSpace.AuthenticationRequest.return_to[local_0_Ref] := F$GenericAuthNameSpace.RP.Domain[$this];
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct($this, resp, local_0_Ref);
    local_1_Ref := local_0_Ref;
    goto IL_0058;

  IL_0058:
    $result := local_1_Ref;
    return;
}



procedure OpenID20NameSpace.RelyingParty.ValidateSignature$System.Web.HttpRequest($this: Ref, request$in: Ref) returns ($result: bool);



procedure {:extern} System.Text.StringBuilder.#ctor($this: Ref);



function {:extern} T$System.Text.StringBuilder() : Ref;

const {:extern} unique T$System.Text.StringBuilder: int;

axiom $TypeConstructor(T$System.Text.StringBuilder()) == T$System.Text.StringBuilder;

procedure {:extern} System.Web.HttpRequest.get_Params($this: Ref) returns ($result: Ref);



procedure {:extern} System.Collections.Specialized.NameValueCollection.get_AllKeys($this: Ref) returns ($result: Ref);



const {:value "&"} unique $string_literal_$_3: Ref;

procedure {:extern} System.Text.StringBuilder.Append$System.String($this: Ref, value$in: Ref) returns ($result: Ref);



const {:value "openid."} unique $string_literal_openid._4: Ref;

procedure {:extern} System.String.StartsWith$System.String($this: Ref, value$in: Ref) returns ($result: bool);



const {:value "openid.mode"} unique $string_literal_openid.mode_5: Ref;

const {:value "=check_authentication"} unique $string_literal_$check_authentication_6: Ref;

procedure {:extern} System.String.Concat$System.String$System.String(str0$in: Ref, str1$in: Ref) returns ($result: Ref);



const {:value "="} unique $string_literal_$_7: Ref;

procedure {:extern} System.Collections.Specialized.NameValueCollection.get_Item$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



procedure {:extern} System.String.Concat$System.String$System.String$System.String(str0$in: Ref, str1$in: Ref, str2$in: Ref) returns ($result: Ref);



procedure {:extern} System.Object.ToString($this: Ref) returns ($result: Ref);



const {:value "POST"} unique $string_literal_POST_8: Ref;

procedure {:extern} HTTP.HTTPComm.HttpReq$System.String$System.String$System.String(url$in: Ref, post$in: Ref, method$in: Ref) returns ($result: Ref);



procedure {:extern} HTTP.HTTPComm.HttpPost$System.String$System.String(url$in: Ref, post$in: Ref) returns ($result: Ref);



const {:value "is_valid:true\n"} unique $string_literal_is_valid$true$n_9: Ref;

procedure {:extern} System.String.Contains$System.String($this: Ref, value$in: Ref) returns ($result: bool);



implementation OpenID20NameSpace.RelyingParty.ValidateSignature$System.Web.HttpRequest($this: Ref, request$in: Ref) returns ($result: bool)
{
  var request: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_2_bool: bool;
  var local_3_int: int;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $tmp6: bool;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var local_4_Ref: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: bool;
  var local_6_bool: bool;
  var $localExc: Ref;
  var $label: int;

    request := request$in;
    assume {:breadcrumb 38} true;
    call $tmp0 := Alloc();
    call System.Text.StringBuilder.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Text.StringBuilder();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Text.StringBuilder;
    local_0_Ref := $tmp0;
    call $tmp1 := System.Web.HttpRequest.get_Params(request);
    call $tmp2 := System.Collections.Specialized.NameValueCollection.get_AllKeys($tmp1);
    local_1_Ref := $tmp2;
    local_2_bool := false;
    local_3_int := 0;
    goto IL_00a0;

  IL_001c:
    if (local_2_bool)
    {
        assume {:breadcrumb 39} true;
        call $tmp3 := System.Text.StringBuilder.Append$System.String(local_0_Ref, $string_literal_$_3);
    }
    else
    {
        assume {:breadcrumb 40} true;
    }

    assume local_1_Ref != null;
    $tmp4 := $ArrayContents[local_1_Ref][local_3_int];
    call $tmp5 := System.String.StartsWith$System.String($tmp4, $string_literal_openid._4);
    if ($tmp5)
    {
        assume {:breadcrumb 41} true;
        assume local_1_Ref != null;
        call $tmp6 := System.String.op_Equality$System.String$System.String($ArrayContents[local_1_Ref][local_3_int], $string_literal_openid.mode_5);
        if ($tmp6)
        {
            assume {:breadcrumb 43} true;
            assume local_1_Ref != null;
            call $tmp7 := System.String.Concat$System.String$System.String($ArrayContents[local_1_Ref][local_3_int], $string_literal_$check_authentication_6);
            call $tmp8 := System.Text.StringBuilder.Append$System.String(local_0_Ref, $tmp7);
        }
        else
        {
            assume {:breadcrumb 44} true;
            assume local_1_Ref != null;
            call $tmp9 := System.Web.HttpRequest.get_Params(request);
            assume local_1_Ref != null;
            call $tmp10 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp9, $ArrayContents[local_1_Ref][local_3_int]);
            call $tmp11 := System.String.Concat$System.String$System.String$System.String($ArrayContents[local_1_Ref][local_3_int], $string_literal_$_7, $tmp10);
            call $tmp12 := System.Text.StringBuilder.Append$System.String(local_0_Ref, $tmp11);
        }

        local_2_bool := true;
    }
    else
    {
        assume {:breadcrumb 42} true;
    }

    local_3_int := local_3_int + 1;

  IL_00a0:
    if (local_3_int < $ArrayLength(local_1_Ref))
    {
        assume {:breadcrumb 45} true;
        goto IL_001c;
    }
    else
    {
        assume {:breadcrumb 46} true;
    }

    assume $this != null;
    call $tmp13 := System.Object.ToString(local_0_Ref);
    call $tmp14 := HTTP.HTTPComm.HttpReq$System.String$System.String$System.String(F$OpenID20NameSpace.RelyingParty.endpointUrl[$this], $tmp13, $string_literal_POST_8);
    local_4_Ref := $tmp14;
    assume $this != null;
    call $tmp15 := System.Object.ToString(local_0_Ref);
    call $tmp16 := HTTP.HTTPComm.HttpPost$System.String$System.String(F$OpenID20NameSpace.RelyingParty.endpointUrl[$this], $tmp15);
    call $tmp17 := System.String.Contains$System.String($tmp16, $string_literal_is_valid$true$n_9);
    if ($tmp17)
    {
        assume {:breadcrumb 47} true;
        local_6_bool := true;
    }
    else
    {
        assume {:breadcrumb 48} true;
        local_6_bool := false;
        goto IL_00f9;
    }

  IL_00f9:
    $result := local_6_bool;
    return;
}



procedure OpenID20NameSpace.RelyingParty.ParseAuthenticationResponse$System.Web.HttpRequest($this: Ref, rawRequest$in: Ref) returns ($result: Ref);



procedure {:extern} System.Web.HttpContext.get_Current() returns ($result: Ref);



procedure {:extern} System.Web.HttpRequest.get_QueryString($this: Ref) returns ($result: Ref);



const {:value "openid.claimed_id"} unique $string_literal_openid.claimed_id_10: Ref;

const {:value "SymT"} unique $string_literal_SymT_11: Ref;

const {:value "openid.return_to"} unique $string_literal_openid.return_to_12: Ref;

procedure {:extern} System.String.Split$System.Chararray($this: Ref, separator$in: Ref) returns ($result: Ref);



procedure {:extern} System.String.IsNullOrEmpty$System.String(value$in: Ref) returns ($result: bool);



implementation OpenID20NameSpace.RelyingParty.ParseAuthenticationResponse$System.Web.HttpRequest($this: Ref, rawRequest$in: Ref) returns ($result: Ref)
{
  var rawRequest: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var local_2_Ref: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: bool;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: bool;
  var local_4_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    rawRequest := rawRequest$in;
    assume {:breadcrumb 49} true;
    call $tmp0 := Alloc();
    call OpenID20NameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationResponse;
    local_0_Ref := $tmp0;
    call $tmp1 := System.Web.HttpContext.get_Current();
    local_1_Ref := $tmp1;
    call $tmp2 := System.Web.HttpRequest.get_QueryString(rawRequest);
    call $tmp3 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp2, $string_literal_openid.claimed_id_10);
    F$OpenID20NameSpace.AuthenticationResponse.claimed_id[local_0_Ref] := $tmp3;
    call $tmp4 := System.Web.HttpRequest.get_QueryString(rawRequest);
    call $tmp5 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp4, $string_literal_SymT_11);
    F$CST.CST_Struct.SymT[local_0_Ref] := $tmp5;
    call $tmp6 := System.Web.HttpRequest.get_QueryString(rawRequest);
    call $tmp7 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp6, $string_literal_openid.return_to_12);
    local_2_Ref := $tmp7;
    assume $this != null;
    call $tmp8 := System.String.StartsWith$System.String(local_2_Ref, F$GenericAuthNameSpace.RP.Domain[$this]);
    if ($tmp8)
    {
        assume {:breadcrumb 50} true;
        call $tmp9 := Alloc();
        assume $ArrayLength($tmp9) == 1 * 1;
        call $tmp10 := System.String.Split$System.Chararray(local_2_Ref, $tmp9);
        assume $tmp10 != null;
        F$OpenID20NameSpace.AuthenticationResponse.return_to[local_0_Ref] := $ArrayContents[$tmp10][0];
    }
    else
    {
        assume {:breadcrumb 51} true;
    }

    $tmp11 := local_0_Ref;
    assume $tmp11 != null;
    call $tmp12 := System.String.IsNullOrEmpty$System.String(F$OpenID20NameSpace.AuthenticationResponse.claimed_id[$tmp11]);
    if ($tmp12)
    {
        assume {:breadcrumb 52} true;
        local_4_Ref := null;
    }
    else
    {
        assume {:breadcrumb 53} true;
        local_4_Ref := local_0_Ref;
        goto IL_009f;
    }

  IL_009f:
    $result := local_4_Ref;
    return;
}



procedure {:extern} GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref);



function {:extern} T$GenericAuthNameSpace.RP.AuthenticationConclusion() : Ref;

const {:extern} unique T$GenericAuthNameSpace.RP.AuthenticationConclusion: int;

axiom $TypeConstructor(T$GenericAuthNameSpace.RP.AuthenticationConclusion()) == T$GenericAuthNameSpace.RP.AuthenticationConclusion;

var {:extern} F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID: [Ref]Ref;

procedure {:extern} System.Diagnostics.Stopwatch.#ctor($this: Ref);



function {:extern} T$System.Diagnostics.Stopwatch() : Ref;

const {:extern} unique T$System.Diagnostics.Stopwatch: int;

axiom $TypeConstructor(T$System.Diagnostics.Stopwatch()) == T$System.Diagnostics.Stopwatch;

procedure {:extern} System.Diagnostics.Stopwatch.Start($this: Ref);



procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct$System.Boolean(o$in: Ref, in_msg$in: Ref, out_msg$in: Ref, signed$in: bool);



procedure {:extern} System.Diagnostics.Stopwatch.Stop($this: Ref);



const {:value "C:\Users\Daniel Song\Desktop\YahooRP_SignInIdP.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$YahooRP_SignInIdP.txt_13: Ref;

procedure {:extern} System.IO.File.Exists$System.String(path$in: Ref) returns ($result: bool);



procedure {:extern} System.IO.File.CreateText$System.String(path$in: Ref) returns ($result: Ref);



procedure {:extern} System.Diagnostics.Stopwatch.get_ElapsedMilliseconds($this: Ref) returns ($result: int);



procedure {:extern} System.IO.TextWriter.WriteLine$System.Int64($this: Ref, value$in: int);



procedure {:extern} System.IO.File.AppendText$System.String(path$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool);



procedure {:extern} GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref);



function {:extern} T$GenericAuthNameSpace.SignInRP_Resp() : Ref;

const {:extern} unique T$GenericAuthNameSpace.SignInRP_Resp: int;

axiom $TypeConstructor(T$GenericAuthNameSpace.SignInRP_Resp()) == T$GenericAuthNameSpace.SignInRP_Resp;

implementation OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req1$in: Ref) returns ($result: Ref)
{
  var req1: Ref;
  var local_0_Ref: Ref;
  var local_5_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: bool;
  var $tmp2: Ref;
  var local_1_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_2_Ref: Ref;
  var local_3_Ref: Ref;
  var $tmp5: bool;
  var $tmp6: Ref;
  var local_4_Ref: Ref;
  var $tmp7: int;
  var $tmp8: Ref;
  var $tmp9: int;
  var $tmp10: bool;
  var $tmp11: bool;
  var $tmp12: bool;
  var $tmp13: bool;
  var $tmp14: Ref;
  var $localExc: Ref;
  var $label: int;

    req1 := req1$in;
    assume {:breadcrumb 54} true;
    local_0_Ref := req1;
    if (local_0_Ref == null)
    {
        assume {:breadcrumb 55} true;
        local_5_Ref := null;
    }
    else
    {
        assume {:breadcrumb 56} true;
        assume $this != null;
        $tmp0 := local_0_Ref;
        assume $tmp0 != null;
        call $tmp1 := System.String.op_Inequality$System.String$System.String(F$GenericAuthNameSpace.RP.Domain[$this], F$OpenID20NameSpace.AuthenticationResponse.return_to[$tmp0]);
        if ($tmp1)
        {
            assume {:breadcrumb 57} true;
            local_5_Ref := null;
        }
        else
        {
            assume {:breadcrumb 58} true;
            call $tmp2 := Alloc();
            call GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($tmp2);
            assume $DynamicType($tmp2) == T$GenericAuthNameSpace.RP.AuthenticationConclusion();
            assume $TypeConstructor($DynamicType($tmp2)) == T$GenericAuthNameSpace.RP.AuthenticationConclusion;
            local_1_Ref := $tmp2;
            $tmp3 := local_0_Ref;
            assume $tmp3 != null;
            F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[local_1_Ref] := F$OpenID20NameSpace.AuthenticationResponse.claimed_id[$tmp3];
            call $tmp4 := Alloc();
            call System.Diagnostics.Stopwatch.#ctor($tmp4);
            assume $DynamicType($tmp4) == T$System.Diagnostics.Stopwatch();
            assume $TypeConstructor($DynamicType($tmp4)) == T$System.Diagnostics.Stopwatch;
            local_2_Ref := $tmp4;
            call System.Diagnostics.Stopwatch.Start(local_2_Ref);
            call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct$System.Boolean($this, local_0_Ref, local_1_Ref, true);
            call System.Diagnostics.Stopwatch.Stop(local_2_Ref);
            local_3_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$YahooRP_SignInIdP.txt_13;
            call $tmp5 := System.IO.File.Exists$System.String(local_3_Ref);
            if (!$tmp5)
            {
                assume {:breadcrumb 59} true;
                call $tmp6 := System.IO.File.CreateText$System.String(local_3_Ref);
                local_4_Ref := $tmp6;
                call $tmp7 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_2_Ref);
                call System.IO.TextWriter.WriteLine$System.Int64(local_4_Ref, $tmp7);
            }
            else
            {
                assume {:breadcrumb 60} true;
                call $tmp8 := System.IO.File.AppendText$System.String(local_3_Ref);
                local_4_Ref := $tmp8;
                call $tmp9 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_2_Ref);
                call System.IO.TextWriter.WriteLine$System.Int64(local_4_Ref, $tmp9);
            }

            if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram)
            {
                call $tmp10 := LiveIDNameSpace.Yahoo_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_1_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_RP)
                {
                    call $tmp11 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_1_Ref);
                }
                else
                {
                    if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.RelyingParty)
                    {
                        call $tmp12 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_1_Ref);
                    }
                    else
                    {
                        call $tmp13 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_1_Ref);
                    }
                }
            }

            if ((if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram then $tmp10 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_RP then $tmp11 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.RelyingParty then $tmp12 else $tmp13))))
            {
                assume {:breadcrumb 61} true;
                call $tmp14 := Alloc();
                call GenericAuthNameSpace.SignInRP_Resp.#ctor($tmp14);
                assume $DynamicType($tmp14) == T$GenericAuthNameSpace.SignInRP_Resp();
                assume $TypeConstructor($DynamicType($tmp14)) == T$GenericAuthNameSpace.SignInRP_Resp;
                local_5_Ref := $tmp14;
            }
            else
            {
                assume {:breadcrumb 62} true;
                local_5_Ref := null;
                goto IL_0103;
            }
        }
    }

  IL_0103:
    $result := local_5_Ref;
    return;
}



procedure OpenID20NameSpace.RelyingParty.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.RP.#ctor($this: Ref);



implementation OpenID20NameSpace.RelyingParty.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenID20NameSpace.RelyingParty.assoc_handle[$this] := null;
    F$OpenID20NameSpace.RelyingParty.endpointUrl[$this] := null;
    assume {:breadcrumb 63} true;
    call GenericAuthNameSpace.RP.#ctor($this);
}



procedure T$OpenID20NameSpace.RelyingParty.#cctor();



implementation T$OpenID20NameSpace.RelyingParty.#cctor()
{
}



function T$OpenID20NameSpace.IDAssertionRecs() : Ref;

const unique T$OpenID20NameSpace.IDAssertionRecs: int;

function T$GenericAuthNameSpace.AuthTicketAS_Req() : Ref;

const unique T$GenericAuthNameSpace.AuthTicketAS_Req: int;

procedure GenericAuthNameSpace.AuthTicketAS_Req.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Req.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Req.set_Realm$System.String($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Req.#ctor($this: Ref);



procedure {:extern} CST.CST_Struct.#ctor($this: Ref);



implementation GenericAuthNameSpace.AuthTicketAS_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 64} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.AuthTicketAS_Req.#cctor();



implementation T$GenericAuthNameSpace.AuthTicketAS_Req.#cctor()
{
}



function T$GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req() : Ref;

const unique T$GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req: int;

procedure GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_Realm$System.String($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_UserID($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_UserID$System.String($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_permissions($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_permissions$GenericAuthNameSpace.Permissions($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#ctor($this: Ref);



implementation GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 65} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#cctor();



implementation T$GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#cctor()
{
}



function T$GenericAuthNameSpace.SignInIdP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Req: int;

procedure GenericAuthNameSpace.SignInIdP_Req.get_Realm($this: Ref) returns ($result: Ref);



implementation GenericAuthNameSpace.SignInIdP_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$this] := null;
    assume {:breadcrumb 66} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInIdP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Req.#cctor()
{
}



function T$GenericAuthNameSpace.RSResourceRecords_Base() : Ref;

const unique T$GenericAuthNameSpace.RSResourceRecords_Base: int;

procedure GenericAuthNameSpace.RSResourceRecords_Base.setEntry$System.String$GenericAuthNameSpace.Permission$GenericAuthNameSpace.Resource($this: Ref, UserID$in: Ref, permission$in: Ref, resource$in: Ref) returns ($result: bool);



procedure GenericAuthNameSpace.RSResourceRecords_Base.getEntry$System.String$GenericAuthNameSpace.Permission($this: Ref, UserID$in: Ref, permission$in: Ref) returns ($result: Ref);



function T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req: int;

implementation GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 67} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor()
{
}



function T$GenericAuthNameSpace.IdPAuthRecords_Base() : Ref;

const unique T$GenericAuthNameSpace.IdPAuthRecords_Base: int;

procedure GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, Realm$in: Ref, _ID_Claim$in: Ref) returns ($result: bool);



function T$GenericAuthNameSpace.ReqResourceRS_Req() : Ref;

const unique T$GenericAuthNameSpace.ReqResourceRS_Req: int;

var F$GenericAuthNameSpace.ReqResourceRS_Req.resource: [Ref]Ref;

var F$GenericAuthNameSpace.ReqResourceRS_Req.UserID: [Ref]Ref;

procedure GenericAuthNameSpace.ReqResourceRS_Req.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ReqResourceRS_Req.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ReqResourceRS_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ReqResourceRS_Req.set_Realm$System.String($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ReqResourceRS_Req.#ctor($this: Ref);



implementation GenericAuthNameSpace.ReqResourceRS_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.ReqResourceRS_Req.resource[$this] := null;
    F$GenericAuthNameSpace.ReqResourceRS_Req.UserID[$this] := null;
    assume {:breadcrumb 68} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.ReqResourceRS_Req.#cctor();



implementation T$GenericAuthNameSpace.ReqResourceRS_Req.#cctor()
{
}



function T$GenericAuthNameSpace.RP() : Ref;

const unique T$GenericAuthNameSpace.RP: int;

var F$GenericAuthNameSpace.RP.CurrentSession: [Ref]Ref;

var F$GenericAuthNameSpace.RP.Realm: [Ref]Ref;

procedure {:extern} CST.CST_Ops.CertifyLocally$CST.CST_Struct(msg$in: Ref) returns ($result: bool);



const {:value "C:\Users\Daniel Song\Desktop\Certify.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$Certify.txt_14: Ref;

const {:value "UserID"} unique $string_literal_UserID_15: Ref;

procedure {:extern} System.Web.HttpSessionStateBase.get_Item$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



const {:value ""} unique $string_literal__16: Ref;

procedure {:extern} System.Web.HttpSessionStateBase.set_Item$System.String$System.Object($this: Ref, name$in: Ref, value$in: Ref);



procedure {:extern} System.Web.HttpSessionStateBase.Add$System.String$System.Object($this: Ref, name$in: Ref, value$in: Ref);



implementation GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool)
{
  var conclusion: Ref;
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
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var local_4_bool: bool;
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 69} true;
    call $tmp0 := Alloc();
    call System.Diagnostics.Stopwatch.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Diagnostics.Stopwatch();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Diagnostics.Stopwatch;
    local_0_Ref := $tmp0;
    call System.Diagnostics.Stopwatch.Start(local_0_Ref);
    call $tmp1 := CST.CST_Ops.CertifyLocally$CST.CST_Struct(conclusion);
    local_1_bool := $tmp1;
    call System.Diagnostics.Stopwatch.Stop(local_0_Ref);
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$Certify.txt_14;
    call $tmp2 := System.IO.File.Exists$System.String(local_2_Ref);
    if (!$tmp2)
    {
        assume {:breadcrumb 70} true;
        call $tmp3 := System.IO.File.CreateText$System.String(local_2_Ref);
        local_3_Ref := $tmp3;
        call $tmp4 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp4);
    }
    else
    {
        assume {:breadcrumb 71} true;
        call $tmp5 := System.IO.File.AppendText$System.String(local_2_Ref);
        local_3_Ref := $tmp5;
        call $tmp6 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp6);
    }

    assume $this != null;
    $tmp7 := F$GenericAuthNameSpace.RP.CurrentSession[$this];
    call $tmp8 := System.Web.HttpSessionStateBase.get_Item$System.String($tmp7, $string_literal_UserID_15);
    if ($tmp8 != null)
    {
        assume {:breadcrumb 72} true;
        assume $this != null;
        $tmp9 := F$GenericAuthNameSpace.RP.CurrentSession[$this];
        if (local_1_bool)
        {
            $tmp10 := conclusion;
            assume $tmp10 != null;
        }
        else
        {
        }

        call System.Web.HttpSessionStateBase.set_Item$System.String$System.Object($tmp9, $string_literal_UserID_15, (if local_1_bool then F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp10] else $string_literal__16));
    }
    else
    {
        assume {:breadcrumb 73} true;
        assume $this != null;
        $tmp11 := F$GenericAuthNameSpace.RP.CurrentSession[$this];
        if (local_1_bool)
        {
            $tmp12 := conclusion;
            assume $tmp12 != null;
        }
        else
        {
        }

        call System.Web.HttpSessionStateBase.Add$System.String$System.Object($tmp11, $string_literal_UserID_15, (if local_1_bool then F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp12] else $string_literal__16));
    }

    local_4_bool := local_1_bool;
    goto IL_00ee;

  IL_00ee:
    $result := local_4_bool;
    return;
}



implementation GenericAuthNameSpace.RP.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RP.CurrentSession[$this] := null;
    F$GenericAuthNameSpace.RP.Domain[$this] := null;
    F$GenericAuthNameSpace.RP.Realm[$this] := null;
    assume {:breadcrumb 74} true;
    call System.Object.#ctor($this);
}



implementation GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$this] := null;
    assume {:breadcrumb 75} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.RP.AuthenticationConclusion.#cctor();



implementation T$GenericAuthNameSpace.RP.AuthenticationConclusion.#cctor()
{
}



procedure T$GenericAuthNameSpace.RP.#cctor();



implementation T$GenericAuthNameSpace.RP.#cctor()
{
}



implementation GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 76} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInRP_Resp.#cctor();



implementation T$GenericAuthNameSpace.SignInRP_Resp.#cctor()
{
}



function T$GenericAuthNameSpace.ValidateTicket_Req() : Ref;

const unique T$GenericAuthNameSpace.ValidateTicket_Req: int;

procedure GenericAuthNameSpace.ValidateTicket_Req.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.set_Realm$System.String($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.get_UserID($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.set_UserID$System.String($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.get_permissions($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.set_permissions$GenericAuthNameSpace.Permissions($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.#ctor($this: Ref);



implementation GenericAuthNameSpace.ValidateTicket_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 77} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.ValidateTicket_Req.#cctor();



implementation T$GenericAuthNameSpace.ValidateTicket_Req.#cctor()
{
}



function T$GenericAuthNameSpace.ASAuthTicketRecords_Base() : Ref;

const unique T$GenericAuthNameSpace.ASAuthTicketRecords_Base: int;

procedure GenericAuthNameSpace.ASAuthTicketRecords_Base.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($this: Ref, ticket$in: Ref, Realm$in: Ref, UserID$in: Ref, claim$in: Ref) returns ($result: bool);



procedure GenericAuthNameSpace.ASAuthTicketRecords_Base.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($this: Ref, ticket$in: Ref, Realm$in: Ref, UserID$in: Ref) returns ($result: Ref);



function T$GenericAuthNameSpace.ID_Claim() : Ref;

const unique T$GenericAuthNameSpace.ID_Claim: int;

implementation GenericAuthNameSpace.ID_Claim.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 78} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.ID_Claim.#cctor();



implementation T$GenericAuthNameSpace.ID_Claim.#cctor()
{
}



function T$GenericAuthNameSpace.RS() : Ref;

const unique T$GenericAuthNameSpace.RS: int;

var F$GenericAuthNameSpace.RS.RSResourceRecs: [Ref]Ref;

var F$GenericAuthNameSpace.RS.Domain: [Ref]Ref;

var F$GenericAuthNameSpace.RS.Realm: [Ref]Ref;

procedure GenericAuthNameSpace.RS.RequestResourceDone$GenericAuthNameSpace.RS.AuthorizationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool);



implementation GenericAuthNameSpace.RS.RequestResourceDone$GenericAuthNameSpace.RS.AuthorizationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool)
{
  var conclusion: Ref;
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

    conclusion := conclusion$in;
    assume {:breadcrumb 79} true;
    call $tmp0 := Alloc();
    call System.Diagnostics.Stopwatch.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Diagnostics.Stopwatch();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Diagnostics.Stopwatch;
    local_0_Ref := $tmp0;
    call System.Diagnostics.Stopwatch.Start(local_0_Ref);
    call $tmp1 := CST.CST_Ops.CertifyLocally$CST.CST_Struct(conclusion);
    local_1_bool := $tmp1;
    call System.Diagnostics.Stopwatch.Stop(local_0_Ref);
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$Certify.txt_14;
    call $tmp2 := System.IO.File.Exists$System.String(local_2_Ref);
    if (!$tmp2)
    {
        assume {:breadcrumb 80} true;
        call $tmp3 := System.IO.File.CreateText$System.String(local_2_Ref);
        local_3_Ref := $tmp3;
        call $tmp4 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp4);
    }
    else
    {
        assume {:breadcrumb 81} true;
        call $tmp5 := System.IO.File.AppendText$System.String(local_2_Ref);
        local_3_Ref := $tmp5;
        call $tmp6 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp6);
    }

    local_4_bool := local_1_bool;
    goto IL_008f;

  IL_008f:
    $result := local_4_bool;
    return;
}



procedure GenericAuthNameSpace.RS.#ctor($this: Ref);



implementation GenericAuthNameSpace.RS.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RS.RSResourceRecs[$this] := null;
    F$GenericAuthNameSpace.RS.Domain[$this] := null;
    F$GenericAuthNameSpace.RS.Realm[$this] := null;
    assume {:breadcrumb 82} true;
    call System.Object.#ctor($this);
}



function T$GenericAuthNameSpace.RS.AuthorizationConclusion() : Ref;

const unique T$GenericAuthNameSpace.RS.AuthorizationConclusion: int;

var F$GenericAuthNameSpace.RS.AuthorizationConclusion.ticket: [Ref]Ref;

var F$GenericAuthNameSpace.RS.AuthorizationConclusion.permissions: [Ref]Ref;

var F$GenericAuthNameSpace.RS.AuthorizationConclusion.Realm: [Ref]Ref;

var F$GenericAuthNameSpace.RS.AuthorizationConclusion.UserID: [Ref]Ref;

procedure GenericAuthNameSpace.RS.AuthorizationConclusion.#ctor($this: Ref);



implementation GenericAuthNameSpace.RS.AuthorizationConclusion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RS.AuthorizationConclusion.ticket[$this] := null;
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.permissions[$this] := null;
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.Realm[$this] := null;
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.UserID[$this] := null;
    assume {:breadcrumb 83} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.RS.AuthorizationConclusion.#cctor();



implementation T$GenericAuthNameSpace.RS.AuthorizationConclusion.#cctor()
{
}



procedure T$GenericAuthNameSpace.RS.#cctor();



implementation T$GenericAuthNameSpace.RS.#cctor()
{
}



function T$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req() : Ref;

const unique T$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req: int;

var F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.resources: [Ref]Ref;

var F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.UserID: [Ref]Ref;

procedure GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.set_Realm$System.String($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#ctor($this: Ref);



implementation GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.resources[$this] := null;
    F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.UserID[$this] := null;
    assume {:breadcrumb 84} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#cctor();



implementation T$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#cctor()
{
}



function T$GenericAuthNameSpace.Permissions() : Ref;

const unique T$GenericAuthNameSpace.Permissions: int;

var F$GenericAuthNameSpace.Permissions.permissionSet: [Ref]Ref;

procedure GenericAuthNameSpace.Permissions.#ctor($this: Ref);



implementation GenericAuthNameSpace.Permissions.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.Permissions.permissionSet[$this] := null;
    assume {:breadcrumb 85} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.Permissions.#cctor();



implementation T$GenericAuthNameSpace.Permissions.#cctor()
{
}



function T$GenericAuthNameSpace.GlobalObjects_base() : Ref;

const unique T$GenericAuthNameSpace.GlobalObjects_base: int;

var F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req: Ref;

var F$GenericAuthNameSpace.GlobalObjects_base.RS: Ref;

implementation GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion$in: Ref)
{
  var conclusion: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: bool;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: bool;
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 86} true;
    $tmp10 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
    assume $tmp10 != null;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$tmp10])) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def)
    {
        $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
        assume $tmp0 != null;
        $tmp1 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$tmp0];
        $tmp2 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
        assume $tmp2 != null;
        $tmp3 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
        assume $tmp3 != null;
        call $tmp4 := OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($tmp1, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp2], F$GenericAuthNameSpace.RP.Realm[$tmp3]);
    }
    else
    {
        $tmp5 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
        assume $tmp5 != null;
        $tmp6 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$tmp5];
        $tmp7 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
        assume $tmp7 != null;
        $tmp8 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
        assume $tmp8 != null;
        call $tmp9 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp6, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp7], F$GenericAuthNameSpace.RP.Realm[$tmp8]);
    }

    local_0_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$tmp10])) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def then $tmp4 else $tmp9);
    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
    {
        call $tmp15 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(local_0_Ref);
    }
    else
    {
        call $tmp16 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
    }

    $tmp17 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp17 != null;
    call $tmp18 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp15 else $tmp16), F$GenericAuthNameSpace.RP.Domain[$tmp17]);
    if ($tmp18)
    {
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
        {
            call $tmp11 := OpenID20NameSpace.IDAssertionEntry.get_UserID(local_0_Ref);
        }
        else
        {
            call $tmp12 := GenericAuthNameSpace.ID_Claim.get_UserID(local_0_Ref);
        }

        $tmp13 := conclusion;
        assume $tmp13 != null;
        call $tmp14 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp11 else $tmp12), F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp13]);
    }
    else
    {
    }

    assert (if $tmp18 then $tmp14 else false);
}



procedure GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotAccessGoodPersonsResource$GenericAuthNameSpace.RS.AuthorizationConclusion(conclusion$in: Ref);



var F$GenericAuthNameSpace.AS.ASAuthRecs: [Ref]Ref;

procedure GenericAuthNameSpace.Permission_Claim.get_UserID($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.Permission_Claim.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.Permission_Claim.get_permissions($this: Ref) returns ($result: Ref);



implementation GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotAccessGoodPersonsResource$GenericAuthNameSpace.RS.AuthorizationConclusion(conclusion$in: Ref)
{
  var conclusion: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: bool;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: bool;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 87} true;
    $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
    assume $tmp0 != null;
    $tmp1 := F$GenericAuthNameSpace.AS.ASAuthRecs[$tmp0];
    call $tmp2 := GenericAuthNameSpace.ValidateTicket_Req.get_ticket(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
    $tmp3 := F$GenericAuthNameSpace.GlobalObjects_base.RS;
    assume $tmp3 != null;
    call $tmp4 := GenericAuthNameSpace.ValidateTicket_Req.get_UserID(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
    call $tmp5 := GenericAuthNameSpace.ASAuthTicketRecords_Base.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp1, $tmp2, F$GenericAuthNameSpace.RS.Realm[$tmp3], $tmp4);
    local_0_Ref := $tmp5;
    call $tmp12 := GenericAuthNameSpace.Permission_Claim.get_permissions(local_0_Ref);
    assume $tmp12 != null;
    $tmp13 := conclusion;
    assume $tmp13 != null;
    $tmp14 := F$GenericAuthNameSpace.RS.AuthorizationConclusion.permissions[$tmp13];
    assume $tmp14 != null;
    if (!(F$GenericAuthNameSpace.Permissions.permissionSet[$tmp12] != F$GenericAuthNameSpace.Permissions.permissionSet[$tmp14]))
    {
        call $tmp9 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
        $tmp10 := F$GenericAuthNameSpace.GlobalObjects_base.RS;
        assume $tmp10 != null;
        call $tmp11 := System.String.op_Equality$System.String$System.String($tmp9, F$GenericAuthNameSpace.RS.Realm[$tmp10]);
    }
    else
    {
    }

    if ((if !(F$GenericAuthNameSpace.Permissions.permissionSet[$tmp12] != F$GenericAuthNameSpace.Permissions.permissionSet[$tmp14]) then $tmp11 else false))
    {
        call $tmp6 := GenericAuthNameSpace.Permission_Claim.get_UserID(local_0_Ref);
        $tmp7 := conclusion;
        assume $tmp7 != null;
        call $tmp8 := System.String.op_Equality$System.String$System.String($tmp6, F$GenericAuthNameSpace.RS.AuthorizationConclusion.UserID[$tmp7]);
    }
    else
    {
    }

    assert (if (if !(F$GenericAuthNameSpace.Permissions.permissionSet[$tmp12] != F$GenericAuthNameSpace.Permissions.permissionSet[$tmp14]) then $tmp11 else false) then $tmp8 else false);
}



implementation GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 88} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.GlobalObjects_base.#cctor();



implementation T$GenericAuthNameSpace.GlobalObjects_base.#cctor()
{
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := null;
    F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req := null;
    F$GenericAuthNameSpace.GlobalObjects_base.AS := null;
    F$GenericAuthNameSpace.GlobalObjects_base.RP := null;
    F$GenericAuthNameSpace.GlobalObjects_base.RS := null;
}



function T$GenericAuthNameSpace.Ticket() : Ref;

const unique T$GenericAuthNameSpace.Ticket: int;

procedure GenericAuthNameSpace.Ticket.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.Ticket.set_ticket$System.String($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.Ticket.#ctor($this: Ref);



implementation GenericAuthNameSpace.Ticket.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 89} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.Ticket.#cctor();



implementation T$GenericAuthNameSpace.Ticket.#cctor()
{
}



function T$GenericAuthNameSpace.AS() : Ref;

const unique T$GenericAuthNameSpace.AS: int;

procedure {:extern} OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref, Entry$in: Ref) returns ($result: bool);



implementation GenericAuthNameSpace.AS.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_0_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: bool;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: bool;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var $tmp20: Ref;
  var $tmp21: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 90} true;
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := req;
    if (req == null)
    {
        assume {:breadcrumb 91} true;
        local_1_Ref := null;
    }
    else
    {
        assume {:breadcrumb 92} true;
        if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP)
        {
            call $tmp0 := OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider)
            {
                call $tmp1 := OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
            }
            else
            {
                call $tmp2 := GenericAuthNameSpace.AS.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
            }
        }

        local_0_Ref := (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP then $tmp0 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider then $tmp1 else $tmp2));
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def)
        {
            assume $this != null;
            $tmp3 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
            $tmp4 := req;
            assume $tmp4 != null;
            if ($TypeConstructor($DynamicType(req)) == T$OpenID20NameSpace.AuthenticationRequest)
            {
                call $tmp5 := OpenID20NameSpace.AuthenticationRequest.get_Realm(req);
            }
            else
            {
                call $tmp6 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
            }

            call $tmp7 := OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp3, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp4], (if $TypeConstructor($DynamicType(req)) == T$OpenID20NameSpace.AuthenticationRequest then $tmp5 else $tmp6), local_0_Ref);
        }
        else
        {
            assume $this != null;
            $tmp8 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
            $tmp9 := req;
            assume $tmp9 != null;
            if ($TypeConstructor($DynamicType(req)) == T$OpenID20NameSpace.AuthenticationRequest)
            {
                call $tmp10 := OpenID20NameSpace.AuthenticationRequest.get_Realm(req);
            }
            else
            {
                call $tmp11 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
            }

            call $tmp12 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp8, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp9], (if $TypeConstructor($DynamicType(req)) == T$OpenID20NameSpace.AuthenticationRequest then $tmp10 else $tmp11), local_0_Ref);
        }

        if (!(if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def then $tmp7 else $tmp12))
        {
            assume {:breadcrumb 93} true;
            local_1_Ref := null;
        }
        else
        {
            assume {:breadcrumb 94} true;
            if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP)
            {
                if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
                {
                    call $tmp13 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(local_0_Ref);
                }
                else
                {
                    call $tmp14 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
                }

                call $tmp15 := OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp13 else $tmp14), local_0_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider)
                {
                    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
                    {
                        call $tmp16 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(local_0_Ref);
                    }
                    else
                    {
                        call $tmp17 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
                    }

                    call $tmp18 := OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp16 else $tmp17), local_0_Ref);
                }
                else
                {
                    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
                    {
                        call $tmp19 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(local_0_Ref);
                    }
                    else
                    {
                        call $tmp20 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
                    }

                    call $tmp21 := GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp19 else $tmp20), local_0_Ref);
                }
            }

            local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP then $tmp15 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider then $tmp18 else $tmp21));
            goto IL_004e;
        }
    }

  IL_004e:
    $result := local_1_Ref;
    return;
}



implementation GenericAuthNameSpace.AS.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.AS.IdpAuthRecs[$this] := null;
    F$GenericAuthNameSpace.AS.ASAuthRecs[$this] := null;
    assume {:breadcrumb 95} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.AS.#cctor();



implementation T$GenericAuthNameSpace.AS.#cctor()
{
}



function T$GenericAuthNameSpace.Permission_Claim() : Ref;

const unique T$GenericAuthNameSpace.Permission_Claim: int;

procedure GenericAuthNameSpace.Permission_Claim.get_Redir_dest($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.Permission_Claim.#ctor($this: Ref);



implementation GenericAuthNameSpace.Permission_Claim.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 96} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.Permission_Claim.#cctor();



implementation T$GenericAuthNameSpace.Permission_Claim.#cctor()
{
}



function T$GenericAuthNameSpace.Resource() : Ref;

const unique T$GenericAuthNameSpace.Resource: int;

var F$GenericAuthNameSpace.Resource.name: [Ref]Ref;

procedure GenericAuthNameSpace.Resource.get_value($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.Resource.set_value$System.Object($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.Resource.#ctor($this: Ref);



implementation GenericAuthNameSpace.Resource.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.Resource.name[$this] := null;
    assume {:breadcrumb 97} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.Resource.#cctor();



implementation T$GenericAuthNameSpace.Resource.#cctor()
{
}



function T$GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req() : Ref;

const unique T$GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req: int;

procedure GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.set_Realm$System.String($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#ctor($this: Ref);



implementation GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 98} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#cctor();



implementation T$GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#cctor()
{
}



function T$GenericAuthNameSpace.Permission() : Ref;

const unique T$GenericAuthNameSpace.Permission: int;

var F$GenericAuthNameSpace.Permission.name: [Ref]Ref;

procedure GenericAuthNameSpace.Permission.Equals$System.Object($this: Ref, obj$in: Ref) returns ($result: bool);



implementation GenericAuthNameSpace.Permission.Equals$System.Object($this: Ref, obj$in: Ref) returns ($result: bool)
{
  var obj: Ref;
  var local_1_bool: bool;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: bool;
  var $localExc: Ref;
  var $label: int;

    obj := obj$in;
    assume {:breadcrumb 99} true;
    if (obj == null)
    {
        assume {:breadcrumb 100} true;
        local_1_bool := false;
    }
    else
    {
        assume {:breadcrumb 101} true;
        local_0_Ref := $As(obj, T$GenericAuthNameSpace.Permission());
        if (local_0_Ref == null)
        {
            assume {:breadcrumb 102} true;
            local_1_bool := false;
        }
        else
        {
            assume {:breadcrumb 103} true;
            assume $this != null;
            $tmp0 := local_0_Ref;
            assume $tmp0 != null;
            call $tmp1 := System.String.op_Equality$System.String$System.String(F$GenericAuthNameSpace.Permission.name[$this], F$GenericAuthNameSpace.Permission.name[$tmp0]);
            local_1_bool := $tmp1;
            goto IL_003a;
        }
    }

  IL_003a:
    $result := local_1_bool;
    return;
}



procedure GenericAuthNameSpace.Permission.GetHashCode($this: Ref) returns ($result: int);



procedure {:extern} System.Object.GetHashCode($this: Ref) returns ($result: int);



implementation GenericAuthNameSpace.Permission.GetHashCode($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $tmp0: Ref;
  var $tmp1: int;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 104} true;
    assume $this != null;
    $tmp0 := F$GenericAuthNameSpace.Permission.name[$this];
    call $tmp1 := System.Object.GetHashCode($tmp0);
    local_0_int := $tmp1;
    goto IL_000f;

  IL_000f:
    $result := local_0_int;
    return;
}



procedure GenericAuthNameSpace.Permission.#ctor($this: Ref);



implementation GenericAuthNameSpace.Permission.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.Permission.name[$this] := null;
    assume {:breadcrumb 105} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.Permission.#cctor();



implementation T$GenericAuthNameSpace.Permission.#cctor()
{
}



function T$GenericAuthNameSpace.Resources() : Ref;

const unique T$GenericAuthNameSpace.Resources: int;

var F$GenericAuthNameSpace.Resources.resourceSet: [Ref]Ref;

procedure GenericAuthNameSpace.Resources.#ctor($this: Ref);



implementation GenericAuthNameSpace.Resources.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.Resources.resourceSet[$this] := null;
    assume {:breadcrumb 106} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.Resources.#cctor();



implementation T$GenericAuthNameSpace.Resources.#cctor()
{
}



function T$OpenIDExample.LogIn() : Ref;

const unique T$OpenIDExample.LogIn: int;

var F$OpenIDExample.LogIn.yahoo_str: Ref;

var F$OpenIDExample.LogIn.RP: [Ref]Ref;

var F$OpenIDExample.LogIn.expecting_redir: bool;

var F$OpenIDExample.LogIn.form1: [Ref]Ref;

var F$OpenIDExample.LogIn.notLoggedIn: [Ref]Ref;

var F$OpenIDExample.LogIn.Login: [Ref]Ref;

var F$OpenIDExample.LogIn.LoggedIn: [Ref]Ref;

var F$OpenIDExample.LogIn.logged_id: [Ref]Ref;

var F$OpenIDExample.LogIn.Logout: [Ref]Ref;

procedure OpenIDExample.LogIn.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



procedure {:extern} System.Web.UI.Page.get_Request($this: Ref) returns ($result: Ref);



procedure {:extern} System.Web.UI.Page.get_Session($this: Ref) returns ($result: Ref);



procedure {:extern} System.Web.HttpSessionStateWrapper.#ctor$System.Web.SessionState.HttpSessionState($this: Ref, httpSessionState$in: Ref);



function {:extern} T$System.Web.HttpSessionStateWrapper() : Ref;

const {:extern} unique T$System.Web.HttpSessionStateWrapper: int;

axiom $TypeConstructor(T$System.Web.HttpSessionStateWrapper()) == T$System.Web.HttpSessionStateWrapper;

procedure {:extern} System.Web.UI.Page.set_Visible$System.Boolean($this: Ref, value$in: bool);



function {:extern} T$System.Web.UI.Page() : Ref;

const {:extern} unique T$System.Web.UI.Page: int;

axiom $TypeConstructor(T$System.Web.UI.Page()) == T$System.Web.UI.Page;

function {:extern} T$System.Web.UI.TemplateControl() : Ref;

const {:extern} unique T$System.Web.UI.TemplateControl: int;

axiom $TypeConstructor(T$System.Web.UI.TemplateControl()) == T$System.Web.UI.TemplateControl;

procedure {:extern} System.Web.UI.Control.set_Visible$System.Boolean($this: Ref, value$in: bool);



const {:value "Your ID is {0}"} unique $string_literal_Your$ID$is$$0$_17: Ref;

const {:value "openid.identity"} unique $string_literal_openid.identity_18: Ref;

procedure {:extern} System.String.Format$System.String$System.Object(format$in: Ref, arg0$in: Ref) returns ($result: Ref);



procedure {:extern} System.Web.UI.HtmlControls.HtmlContainerControl.set_InnerHtml$System.String($this: Ref, value$in: Ref);



implementation OpenIDExample.LogIn.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: bool;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var $tmp20: Ref;
  var $tmp21: Ref;
  var $tmp22: Ref;
  var $tmp23: Ref;
  var $tmp24: Ref;
  var $tmp25: Ref;
  var $tmp26: Ref;
  var $tmp27: Ref;
  var $tmp28: Ref;
  var $tmp29: Ref;
  var $tmp30: Ref;
  var $tmp31: Ref;
  var $tmp32: Ref;
  var $tmp33: Ref;
  var $tmp34: Ref;
  var $tmp35: Ref;
  var $tmp36: Ref;
  var $tmp37: Ref;
  var $tmp38: Ref;
  var $tmp39: Ref;
  var $tmp40: Ref;
  var $tmp41: Ref;
  var $tmp42: Ref;
  var $tmp43: Ref;
  var $tmp44: Ref;
  var $tmp45: Ref;
  var $tmp46: Ref;
  var $tmp47: Ref;
  var $tmp48: Ref;
  var $tmp49: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 107} true;
    call $tmp3 := System.Web.UI.Page.get_Request($this);
    call $tmp4 := System.Web.HttpRequest.get_Params($tmp3);
    call $tmp5 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp4, $string_literal_openid.mode_5);
    call $tmp6 := System.String.IsNullOrEmpty$System.String($tmp5);
    if (!$tmp6)
    {
        assume $this != null;
        $tmp0 := F$OpenIDExample.LogIn.RP[$this];
        call $tmp1 := System.Web.UI.Page.get_Request($this);
        call $tmp2 := OpenID20NameSpace.RelyingParty.ValidateSignature$System.Web.HttpRequest($tmp0, $tmp1);
    }
    else
    {
    }

    if ((if !$tmp6 then $tmp2 else false))
    {
        assume {:breadcrumb 108} true;
        if (!F$OpenIDExample.LogIn.expecting_redir)
        {
            assume {:breadcrumb 110} true;
            return;
        }
        else
        {
            assume {:breadcrumb 111} true;
        }

        F$OpenIDExample.LogIn.expecting_redir := false;
        call $tmp7 := Alloc();
        call $tmp8 := System.Web.UI.Page.get_Session($this);
        call System.Web.HttpSessionStateWrapper.#ctor$System.Web.SessionState.HttpSessionState($tmp7, $tmp8);
        assume $DynamicType($tmp7) == T$System.Web.HttpSessionStateWrapper();
        assume $TypeConstructor($DynamicType($tmp7)) == T$System.Web.HttpSessionStateWrapper;
        assume $this != null;
        F$GenericAuthNameSpace.RP.CurrentSession[F$OpenIDExample.LogIn.RP[$this]] := $tmp7;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.RP[$this])) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram)
        {
            assume $this != null;
            $tmp9 := F$OpenIDExample.LogIn.RP[$this];
            assume $this != null;
            $tmp10 := F$OpenIDExample.LogIn.RP[$this];
            call $tmp11 := System.Web.UI.Page.get_Request($this);
            call $tmp12 := OpenID20NameSpace.RelyingParty.ParseAuthenticationResponse$System.Web.HttpRequest($tmp10, $tmp11);
            call $tmp13 := OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($tmp9, $tmp12);
        }
        else
        {
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.RP[$this])) == T$OpenID20NameSpace.Yahoo_RP)
            {
                assume $this != null;
                $tmp14 := F$OpenIDExample.LogIn.RP[$this];
                assume $this != null;
                $tmp15 := F$OpenIDExample.LogIn.RP[$this];
                call $tmp16 := System.Web.UI.Page.get_Request($this);
                call $tmp17 := OpenID20NameSpace.RelyingParty.ParseAuthenticationResponse$System.Web.HttpRequest($tmp15, $tmp16);
                call $tmp18 := OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($tmp14, $tmp17);
            }
            else
            {
                assume $this != null;
                if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.RP[$this])) == T$OpenID20NameSpace.RelyingParty)
                {
                    assume $this != null;
                    $tmp19 := F$OpenIDExample.LogIn.RP[$this];
                    assume $this != null;
                    $tmp20 := F$OpenIDExample.LogIn.RP[$this];
                    call $tmp21 := System.Web.UI.Page.get_Request($this);
                    call $tmp22 := OpenID20NameSpace.RelyingParty.ParseAuthenticationResponse$System.Web.HttpRequest($tmp20, $tmp21);
                    call $tmp23 := OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($tmp19, $tmp22);
                }
                else
                {
                    assume $this != null;
                    $tmp24 := F$OpenIDExample.LogIn.RP[$this];
                    assume $this != null;
                    $tmp25 := F$OpenIDExample.LogIn.RP[$this];
                    call $tmp26 := System.Web.UI.Page.get_Request($this);
                    call $tmp27 := OpenID20NameSpace.RelyingParty.ParseAuthenticationResponse$System.Web.HttpRequest($tmp25, $tmp26);
                    call $tmp28 := GenericAuthNameSpace.RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($tmp24, $tmp27);
                }
            }
        }

        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$OpenIDExample.LogIn)
        {
            assume {:breadcrumb 112} true;
            assume $this != null;
            $tmp29 := F$OpenIDExample.LogIn.notLoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp29, false);
        }
        else
        {
            assume {:breadcrumb 113} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.Page)
            {
                assume {:breadcrumb 114} true;
                assume $this != null;
                $tmp30 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Page.set_Visible$System.Boolean($tmp30, false);
            }
            else
            {
                assume {:breadcrumb 115} true;
                assume $this != null;
                if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.TemplateControl)
                {
                    assume {:breadcrumb 116} true;
                    assume $this != null;
                    $tmp31 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp31, false);
                }
                else
                {
                    assume {:breadcrumb 117} true;
                    assume $this != null;
                    $tmp32 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp32, false);
                }
            }
        }

        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$OpenIDExample.LogIn)
        {
            assume {:breadcrumb 118} true;
            assume $this != null;
            $tmp33 := F$OpenIDExample.LogIn.LoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp33, true);
        }
        else
        {
            assume {:breadcrumb 119} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.Page)
            {
                assume {:breadcrumb 120} true;
                assume $this != null;
                $tmp34 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Page.set_Visible$System.Boolean($tmp34, true);
            }
            else
            {
                assume {:breadcrumb 121} true;
                assume $this != null;
                if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.TemplateControl)
                {
                    assume {:breadcrumb 122} true;
                    assume $this != null;
                    $tmp35 := F$OpenIDExample.LogIn.LoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp35, true);
                }
                else
                {
                    assume {:breadcrumb 123} true;
                    assume $this != null;
                    $tmp36 := F$OpenIDExample.LogIn.LoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp36, true);
                }
            }
        }

        assume $this != null;
        $tmp37 := F$OpenIDExample.LogIn.logged_id[$this];
        call $tmp38 := System.Web.UI.Page.get_Request($this);
        call $tmp39 := System.Web.HttpRequest.get_Params($tmp38);
        call $tmp40 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp39, $string_literal_openid.identity_18);
        call $tmp41 := System.String.Format$System.String$System.Object($string_literal_Your$ID$is$$0$_17, $tmp40);
        call System.Web.UI.HtmlControls.HtmlContainerControl.set_InnerHtml$System.String($tmp37, $tmp41);
        return;
    }
    else
    {
        assume {:breadcrumb 109} true;
    }

    assume $this != null;
    if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$OpenIDExample.LogIn)
    {
        assume {:breadcrumb 124} true;
        assume $this != null;
        $tmp42 := F$OpenIDExample.LogIn.notLoggedIn[$this];
        call System.Web.UI.Page.set_Visible$System.Boolean($tmp42, true);
    }
    else
    {
        assume {:breadcrumb 125} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.Page)
        {
            assume {:breadcrumb 126} true;
            assume $this != null;
            $tmp43 := F$OpenIDExample.LogIn.notLoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp43, true);
        }
        else
        {
            assume {:breadcrumb 127} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.TemplateControl)
            {
                assume {:breadcrumb 128} true;
                assume $this != null;
                $tmp44 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp44, true);
            }
            else
            {
                assume {:breadcrumb 129} true;
                assume $this != null;
                $tmp45 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp45, true);
            }
        }
    }

    assume $this != null;
    if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$OpenIDExample.LogIn)
    {
        assume {:breadcrumb 130} true;
        assume $this != null;
        $tmp46 := F$OpenIDExample.LogIn.LoggedIn[$this];
        call System.Web.UI.Page.set_Visible$System.Boolean($tmp46, false);
    }
    else
    {
        assume {:breadcrumb 131} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.Page)
        {
            assume {:breadcrumb 132} true;
            assume $this != null;
            $tmp47 := F$OpenIDExample.LogIn.LoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp47, false);
        }
        else
        {
            assume {:breadcrumb 133} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.TemplateControl)
            {
                assume {:breadcrumb 134} true;
                assume $this != null;
                $tmp48 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp48, false);
            }
            else
            {
                assume {:breadcrumb 135} true;
                assume $this != null;
                $tmp49 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp49, false);
            }
        }
    }
}



procedure OpenIDExample.LogIn.LoginBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



const {:value "SignInIdP"} unique $string_literal_SignInIdP_19: Ref;

procedure {:extern} System.Type.GetMethod$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



const {:value "yahoo.com"} unique $string_literal_yahoo.com_20: Ref;

procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct$System.Reflection.MethodInfo$System.String$System.Boolean$System.Boolean(o$in: Ref, in_msg$in: Ref, out_msg$in: Ref, mi$in: Ref, partyName$in: Ref, signed$in: bool, server_to_server$in: bool);



const {:value "C:\Users\Daniel Song\Desktop\YahooIdP_SignInIdP.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$YahooIdP_SignInIdP.txt_21: Ref;

procedure OpenID20NameSpace.Yahoo_RP.GenerateURL$OpenID20NameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} System.Web.UI.Page.get_Response($this: Ref) returns ($result: Ref);



procedure {:extern} System.Web.HttpResponse.Redirect$System.String($this: Ref, url$in: Ref);



implementation OpenIDExample.LogIn.LoginBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_2_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var local_3_Ref: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var local_4_Ref: Ref;
  var $tmp14: bool;
  var $tmp15: Ref;
  var local_5_Ref: Ref;
  var $tmp16: int;
  var $tmp17: Ref;
  var $tmp18: int;
  var $tmp19: Ref;
  var $tmp20: Ref;
  var local_6_Ref: Ref;
  var $tmp21: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 136} true;
    F$OpenIDExample.LogIn.expecting_redir := true;
    assume $this != null;
    $tmp0 := F$OpenIDExample.LogIn.RP[$this];
    call $tmp1 := Alloc();
    call OpenID20NameSpace.AuthenticationResponse.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$OpenID20NameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp1)) == T$OpenID20NameSpace.AuthenticationResponse;
    call $tmp2 := OpenID20NameSpace.RelyingParty.RequestAuthentication$OpenID20NameSpace.AuthenticationResponse($tmp0, $tmp1);
    local_1_Ref := $tmp2;
    call $tmp3 := Alloc();
    call OpenID20NameSpace.AuthenticationRequest.#ctor($tmp3);
    assume $DynamicType($tmp3) == T$OpenID20NameSpace.AuthenticationRequest();
    assume $TypeConstructor($DynamicType($tmp3)) == T$OpenID20NameSpace.AuthenticationRequest;
    local_2_Ref := $tmp3;
    $tmp4 := local_1_Ref;
    assume $tmp4 != null;
    F$OpenID20NameSpace.AuthenticationRequest.claimed_id[local_2_Ref] := F$OpenID20NameSpace.AuthenticationRequest.claimed_id[$tmp4];
    $tmp5 := local_1_Ref;
    assume $tmp5 != null;
    F$OpenID20NameSpace.AuthenticationRequest.identity[local_2_Ref] := F$OpenID20NameSpace.AuthenticationRequest.identity[$tmp5];
    $tmp6 := local_1_Ref;
    assume $tmp6 != null;
    F$OpenID20NameSpace.AuthenticationRequest.return_to[local_2_Ref] := F$OpenID20NameSpace.AuthenticationRequest.return_to[$tmp6];
    $tmp7 := local_1_Ref;
    assume $tmp7 != null;
    F$OpenID20NameSpace.AuthenticationRequest.realm[local_2_Ref] := F$OpenID20NameSpace.AuthenticationRequest.realm[$tmp7];
    $tmp8 := local_1_Ref;
    assume $tmp8 != null;
    F$OpenID20NameSpace.AuthenticationRequest.ns[local_2_Ref] := F$OpenID20NameSpace.AuthenticationRequest.ns[$tmp8];
    $tmp9 := local_1_Ref;
    assume $tmp9 != null;
    F$OpenID20NameSpace.AuthenticationRequest.mode[local_2_Ref] := F$OpenID20NameSpace.AuthenticationRequest.mode[$tmp9];
    call $tmp10 := Alloc();
    call System.Diagnostics.Stopwatch.#ctor($tmp10);
    assume $DynamicType($tmp10) == T$System.Diagnostics.Stopwatch();
    assume $TypeConstructor($DynamicType($tmp10)) == T$System.Diagnostics.Stopwatch;
    local_3_Ref := $tmp10;
    call System.Diagnostics.Stopwatch.Start(local_3_Ref);
    call $tmp11 := Alloc();
    call OpenID20NameSpace.Yahoo_IdP.#ctor($tmp11);
    assume $DynamicType($tmp11) == T$OpenID20NameSpace.Yahoo_IdP();
    assume $TypeConstructor($DynamicType($tmp11)) == T$OpenID20NameSpace.Yahoo_IdP;
    $tmp12 := T$OpenID20NameSpace.Yahoo_IdP();
    call $tmp13 := System.Type.GetMethod$System.String($tmp12, $string_literal_SignInIdP_19);
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct$System.Reflection.MethodInfo$System.String$System.Boolean$System.Boolean($tmp11, local_1_Ref, local_2_Ref, $tmp13, $string_literal_yahoo.com_20, true, false);
    call System.Diagnostics.Stopwatch.Stop(local_3_Ref);
    local_4_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$YahooIdP_SignInIdP.txt_21;
    call $tmp14 := System.IO.File.Exists$System.String(local_4_Ref);
    if (!$tmp14)
    {
        assume {:breadcrumb 137} true;
        call $tmp15 := System.IO.File.CreateText$System.String(local_4_Ref);
        local_5_Ref := $tmp15;
        call $tmp16 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_3_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_5_Ref, $tmp16);
    }
    else
    {
        assume {:breadcrumb 138} true;
        call $tmp17 := System.IO.File.AppendText$System.String(local_4_Ref);
        local_5_Ref := $tmp17;
        call $tmp18 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_3_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_5_Ref, $tmp18);
    }

    assume $this != null;
    $tmp19 := F$OpenIDExample.LogIn.RP[$this];
    call $tmp20 := OpenID20NameSpace.Yahoo_RP.GenerateURL$OpenID20NameSpace.AuthenticationRequest($tmp19, local_2_Ref);
    local_6_Ref := $tmp20;
    call $tmp21 := System.Web.UI.Page.get_Response($this);
    call System.Web.HttpResponse.Redirect$System.String($tmp21, local_6_Ref);
}



procedure OpenIDExample.LogIn.LogoutBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



implementation OpenIDExample.LogIn.LogoutBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 139} true;
    assume $this != null;
    if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$OpenIDExample.LogIn)
    {
        assume {:breadcrumb 140} true;
        assume $this != null;
        $tmp0 := F$OpenIDExample.LogIn.notLoggedIn[$this];
        call System.Web.UI.Page.set_Visible$System.Boolean($tmp0, true);
    }
    else
    {
        assume {:breadcrumb 141} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.Page)
        {
            assume {:breadcrumb 142} true;
            assume $this != null;
            $tmp1 := F$OpenIDExample.LogIn.notLoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp1, true);
        }
        else
        {
            assume {:breadcrumb 143} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.TemplateControl)
            {
                assume {:breadcrumb 144} true;
                assume $this != null;
                $tmp2 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp2, true);
            }
            else
            {
                assume {:breadcrumb 145} true;
                assume $this != null;
                $tmp3 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp3, true);
            }
        }
    }

    assume $this != null;
    if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$OpenIDExample.LogIn)
    {
        assume {:breadcrumb 146} true;
        assume $this != null;
        $tmp4 := F$OpenIDExample.LogIn.LoggedIn[$this];
        call System.Web.UI.Page.set_Visible$System.Boolean($tmp4, false);
    }
    else
    {
        assume {:breadcrumb 147} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.Page)
        {
            assume {:breadcrumb 148} true;
            assume $this != null;
            $tmp5 := F$OpenIDExample.LogIn.LoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp5, false);
        }
        else
        {
            assume {:breadcrumb 149} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.TemplateControl)
            {
                assume {:breadcrumb 150} true;
                assume $this != null;
                $tmp6 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp6, false);
            }
            else
            {
                assume {:breadcrumb 151} true;
                assume $this != null;
                $tmp7 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp7, false);
            }
        }
    }
}



procedure OpenIDExample.LogIn.#ctor($this: Ref);



const {:value "http://localhost:32928/LogIn.aspx"} unique $string_literal_http$$$localhost$32928$LogIn.aspx_22: Ref;

procedure OpenID20NameSpace.Yahoo_RP.#ctor$System.String$System.String($this: Ref, return_uri$in: Ref, endpointUrl$in: Ref);



procedure {:extern} System.Web.UI.Page.#ctor($this: Ref);



implementation OpenIDExample.LogIn.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$OpenIDExample.LogIn.RP[$this] := null;
    F$OpenIDExample.LogIn.form1[$this] := null;
    F$OpenIDExample.LogIn.notLoggedIn[$this] := null;
    F$OpenIDExample.LogIn.Login[$this] := null;
    F$OpenIDExample.LogIn.LoggedIn[$this] := null;
    F$OpenIDExample.LogIn.logged_id[$this] := null;
    F$OpenIDExample.LogIn.Logout[$this] := null;
    assume {:breadcrumb 152} true;
    call $tmp0 := Alloc();
    call OpenID20NameSpace.Yahoo_RP.#ctor$System.String$System.String($tmp0, $string_literal_http$$$localhost$32928$LogIn.aspx_22, F$OpenIDExample.LogIn.yahoo_str);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.Yahoo_RP();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.Yahoo_RP;
    F$OpenIDExample.LogIn.RP[$this] := $tmp0;
    call System.Web.UI.Page.#ctor($this);
}



procedure OpenIDExample.LogIn.#cctor();



const {:value "https://open.login.yahooapis.com/openid/op/auth"} unique $string_literal_https$$$open.login.yahooapis.com$openid$op$auth_23: Ref;

implementation OpenIDExample.LogIn.#cctor()
{
  var $localExc: Ref;
  var $label: int;

    F$OpenIDExample.LogIn.yahoo_str := null;
    F$OpenIDExample.LogIn.expecting_redir := false;
    assume {:breadcrumb 153} true;
    F$OpenIDExample.LogIn.yahoo_str := $string_literal_https$$$open.login.yahooapis.com$openid$op$auth_23;
    F$OpenIDExample.LogIn.expecting_redir := false;
}



implementation OpenID20NameSpace.Yahoo_RP.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 154} true;
    call OpenID20NameSpace.RelyingParty.#ctor($this);
}



implementation OpenID20NameSpace.Yahoo_RP.#ctor$System.String$System.String($this: Ref, return_uri$in: Ref, endpointUrl$in: Ref)
{
  var return_uri: Ref;
  var endpointUrl: Ref;
  var $localExc: Ref;
  var $label: int;

    return_uri := return_uri$in;
    endpointUrl := endpointUrl$in;
    assume {:breadcrumb 155} true;
    call OpenID20NameSpace.RelyingParty.#ctor($this);
    call OpenID20NameSpace.RelyingParty.set_return_uri$System.String($this, return_uri);
    F$OpenID20NameSpace.RelyingParty.endpointUrl[$this] := endpointUrl;
}



procedure {:extern} System.Text.StringBuilder.#ctor$System.String($this: Ref, value$in: Ref);



const {:value "?openid.claimed_id={0}&openid.identity={1}&openid.return_to={2}?SymT={6}&openid.realm={5}&openid.mode={3}&openid.ns={4}"} unique $string_literal_?openid.claimed_id$$0$$openid.identity$$1$$openid.return_to$$2$?SymT$$6$$openid.realm$$5$$openid.mode$$3$$openid.ns$$4$_24: Ref;

procedure {:extern} System.Text.StringBuilder.AppendFormat$System.String$System.Objectarray($this: Ref, format$in: Ref, args$in: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.Yahoo_RP.GenerateURL$OpenID20NameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_1_Ref: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 156} true;
    call $tmp0 := Alloc();
    assume $this != null;
    call System.Text.StringBuilder.#ctor$System.String($tmp0, F$OpenID20NameSpace.RelyingParty.endpointUrl[$this]);
    assume $DynamicType($tmp0) == T$System.Text.StringBuilder();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Text.StringBuilder;
    local_0_Ref := $tmp0;
    call $tmp1 := Alloc();
    assume $ArrayLength($tmp1) == 1 * 7;
    call $tmp2 := System.Text.StringBuilder.AppendFormat$System.String$System.Objectarray(local_0_Ref, $string_literal_?openid.claimed_id$$0$$openid.identity$$1$$openid.return_to$$2$?SymT$$6$$openid.realm$$5$$openid.mode$$3$$openid.ns$$4$_24, $tmp1);
    call $tmp3 := System.Object.ToString(local_0_Ref);
    local_1_Ref := $tmp3;
    goto IL_0087;

  IL_0087:
    $result := local_1_Ref;
    return;
}



procedure OpenID20NameSpace.Yahoo_RP.GenerateURL$OpenID20NameSpace.AuthenticationResponse($this: Ref, req$in: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.Yahoo_RP.GenerateURL$OpenID20NameSpace.AuthenticationResponse($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_1_Ref: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 157} true;
    call $tmp0 := Alloc();
    assume $this != null;
    call System.Text.StringBuilder.#ctor$System.String($tmp0, F$OpenID20NameSpace.RelyingParty.endpointUrl[$this]);
    assume $DynamicType($tmp0) == T$System.Text.StringBuilder();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Text.StringBuilder;
    local_0_Ref := $tmp0;
    call $tmp1 := Alloc();
    assume $ArrayLength($tmp1) == 1 * 7;
    call $tmp2 := System.Text.StringBuilder.AppendFormat$System.String$System.Objectarray(local_0_Ref, $string_literal_?openid.claimed_id$$0$$openid.identity$$1$$openid.return_to$$2$?SymT$$6$$openid.realm$$5$$openid.mode$$3$$openid.ns$$4$_24, $tmp1);
    call $tmp3 := System.Object.ToString(local_0_Ref);
    local_1_Ref := $tmp3;
    goto IL_0087;

  IL_0087:
    $result := local_1_Ref;
    return;
}



procedure T$OpenID20NameSpace.Yahoo_RP.#cctor();



implementation T$OpenID20NameSpace.Yahoo_RP.#cctor()
{
}



function T$CST.Debug() : Ref;

const unique T$CST.Debug: int;

procedure CST.Debug.reached();



implementation CST.Debug.reached()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 158} true;
    assert false;
}



procedure CST.Debug.#ctor($this: Ref);



implementation CST.Debug.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 159} true;
    call System.Object.#ctor($this);
}



procedure T$CST.Debug.#cctor();



implementation T$CST.Debug.#cctor()
{
}



function T$CST.CST_Struct() : Ref;

const unique T$CST.CST_Struct: int;

var F$CST.CST_Struct.SignedBy: [Ref]Ref;

implementation CST.CST_Struct.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$CST.CST_Struct.SymT[$this] := null;
    F$CST.CST_Struct.SignedBy[$this] := null;
    assume {:breadcrumb 160} true;
    F$CST.CST_Struct.SymT[$this] := $string_literal__16;
    F$CST.CST_Struct.SignedBy[$this] := $string_literal__16;
    call System.Object.#ctor($this);
}



procedure T$CST.CST_Struct.#cctor();



implementation T$CST.CST_Struct.#cctor()
{
}



function T$CST.Nondet_Base() : Ref;

const unique T$CST.Nondet_Base: int;

procedure CST.Nondet_Base.Int($this: Ref) returns ($result: int);



procedure CST.Nondet_Base.Bool($this: Ref) returns ($result: bool);



var F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary: [Ref]Ref;

var F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary: [Ref]Ref;

procedure {:extern} System.Collections.Generic.Dictionary`2.#ctor($this: Ref);



function {:extern} TKey$T$System.Collections.Generic.Dictionary`2(parent: Ref) : Ref;

function {:extern} TValue$T$System.Collections.Generic.Dictionary`2(parent: Ref) : Ref;

function {:extern} T$System.Collections.Generic.Dictionary`2(TKey: Ref, TValue: Ref) : Ref;

const {:extern} unique T$System.Collections.Generic.Dictionary`2: int;

function {:extern} T$System.String() : Ref;

const {:extern} unique T$System.String: int;

axiom $TypeConstructor(T$System.String()) == T$System.String;

procedure {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1($this: Ref, key$in: Ref, value$in: Ref);



implementation OpenID20NameSpace.Yahoo_IdP.init($this: Ref)
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 161} true;
    assume $this != null;
    call OpenID20NameSpace.OpenIDProvider.init$OpenID20NameSpace.IDAssertionRecs($this, F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary[$this]);
    assume $this != null;
    $tmp0 := F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary[$this];
    assume $tmp0 != null;
    $tmp1 := F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$tmp0];
    $tmp2 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
    assume $tmp2 != null;
    call $tmp3 := Alloc();
    call System.Collections.Generic.Dictionary`2.#ctor($tmp3);
    assume $DynamicType($tmp3) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OpenID20NameSpace.IDAssertionEntry());
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp3)) == T$System.String();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp3)) == T$OpenID20NameSpace.IDAssertionEntry();
    call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp1, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp2], $tmp3);
}



procedure OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#ctor($this: Ref);



implementation OpenID20NameSpace.Yahoo_IdP.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary[$this] := null;
    assume {:breadcrumb 162} true;
    call $tmp0 := Alloc();
    call OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def;
    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary[$this] := $tmp0;
    call OpenID20NameSpace.OpenIDProvider.#ctor($this);
}



procedure {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0($this: Ref, key$in: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref) returns ($result: Ref)
{
  var IdPSessionSecret: Ref;
  var client_id: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    IdPSessionSecret := IdPSessionSecret$in;
    client_id := client_id$in;
    assume {:breadcrumb 163} true;
    assume $this != null;
    $tmp0 := F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this];
    call $tmp2 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp0, IdPSessionSecret);
    $tmp1 := $tmp2;
    call $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp1, client_id);
    $tmp3 := $tmp4;
    local_0_Ref := $tmp3;
    assume $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenID20NameSpace.IDAssertionEntry;
    local_1_Ref := local_0_Ref;
    goto IL_0033;

  IL_0033:
    $result := local_1_Ref;
    return;
}



implementation OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref, Entry$in: Ref) returns ($result: bool)
{
  var IdPSessionSecret: Ref;
  var client_id: Ref;
  var Entry: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var local_1_bool: bool;
  var $localExc: Ref;
  var $label: int;

    IdPSessionSecret := IdPSessionSecret$in;
    client_id := client_id$in;
    Entry := Entry$in;
    assume {:breadcrumb 164} true;
    call $tmp0 := Alloc();
    call OpenID20NameSpace.IDAssertionEntry.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.IDAssertionEntry();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.IDAssertionEntry;
    local_0_Ref := $tmp0;
    assume Entry != null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id[local_0_Ref] := F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id[Entry];
    assume Entry != null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_return_to[local_0_Ref] := F$OpenID20NameSpace.IDAssertionEntry.openid_return_to[Entry];
    assume $this != null;
    $tmp1 := F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this];
    call $tmp3 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp1, IdPSessionSecret);
    $tmp2 := $tmp3;
    call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp2, client_id, local_0_Ref);
    local_1_bool := true;
    goto IL_0041;

  IL_0041:
    $result := local_1_bool;
    return;
}



implementation OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this] := null;
    assume {:breadcrumb 165} true;
    call $tmp0 := Alloc();
    call System.Collections.Generic.Dictionary`2.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OpenID20NameSpace.IDAssertionEntry()));
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.String();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OpenID20NameSpace.IDAssertionEntry());
    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this] := $tmp0;
    call System.Object.#ctor($this);
}



procedure T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#cctor();



implementation T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#cctor()
{
}



procedure T$OpenID20NameSpace.Yahoo_IdP.#cctor();



implementation T$OpenID20NameSpace.Yahoo_IdP.#cctor()
{
}


