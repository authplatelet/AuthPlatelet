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

function T$SynthesizedPortion() : Ref;

const unique T$SynthesizedPortion: int;

procedure SynthesizedPortion.SynthesizedSequence();



var F$PoirotMain.Nondet: Ref;

procedure {:extern} OAuth20NameSpace.NondetOAuth20.ResourceRequest($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.RS: Ref;

procedure {:extern} OAuth20NameSpace.ResourceServer.createValidateTokenRequest$OAuth20NameSpace.ResourceRequest($this: Ref, res_req$in: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.AS: Ref;

procedure {:extern} OAuth20NameSpace.AuthorizationServer.ValidateTicket$OAuth20NameSpace.ValidateTokenRequest($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.ResourceServer.conclude$OAuth20NameSpace.ValidateTokenResponse($this: Ref, tresq$in: Ref) returns ($result: bool);



implementation SynthesizedPortion.SynthesizedSequence()
{
  var O1_Ref: Ref;
  var $tmp0: Ref;
  var O2_Ref: Ref;
  var $tmp1: Ref;
  var O3_Ref: Ref;
  var $tmp2: Ref;
  var S4_bool: bool;
  var $tmp3: bool;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 0} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\SynthesizedPortion.cs"} {:sourceLine 5} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\SynthesizedPortion.cs"} {:sourceLine 5} true;
    call $tmp0 := OAuth20NameSpace.NondetOAuth20.ResourceRequest(F$PoirotMain.Nondet);
    O1_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\SynthesizedPortion.cs"} {:sourceLine 6} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\SynthesizedPortion.cs"} {:sourceLine 6} true;
    call $tmp1 := OAuth20NameSpace.ResourceServer.createValidateTokenRequest$OAuth20NameSpace.ResourceRequest(F$GenericAuthNameSpace.GlobalObjects_base.RS, O1_Ref);
    O2_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\SynthesizedPortion.cs"} {:sourceLine 7} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\SynthesizedPortion.cs"} {:sourceLine 7} true;
    call $tmp2 := OAuth20NameSpace.AuthorizationServer.ValidateTicket$OAuth20NameSpace.ValidateTokenRequest(F$GenericAuthNameSpace.GlobalObjects_base.AS, O2_Ref);
    O3_Ref := $tmp2;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\SynthesizedPortion.cs"} {:sourceLine 8} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\SynthesizedPortion.cs"} {:sourceLine 8} true;
    call $tmp3 := OAuth20NameSpace.ResourceServer.conclude$OAuth20NameSpace.ValidateTokenResponse(F$GenericAuthNameSpace.GlobalObjects_base.RS, O3_Ref);
    S4_bool := $tmp3;
}



procedure SynthesizedPortion.#ctor($this: Ref);



procedure {:extern} System.Object.#ctor($this: Ref);



implementation SynthesizedPortion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 1} true;
    call System.Object.#ctor($this);
}



procedure T$SynthesizedPortion.#cctor();



implementation T$SynthesizedPortion.#cctor()
{
}



function T$GlobalObjectsForCST() : Ref;

const unique T$GlobalObjectsForCST: int;

procedure GlobalObjectsForCST.init();



procedure {:extern} OAuth20NameSpace.NondetOAuth20.ValidateTicket_Req($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req: Ref;

procedure {:extern} OAuth20NameSpace.AuthorizationServerImpl.#ctor($this: Ref);



function {:extern} T$OAuth20NameSpace.AuthorizationServerImpl() : Ref;

const {:extern} unique T$OAuth20NameSpace.AuthorizationServerImpl: int;

axiom $TypeConstructor(T$OAuth20NameSpace.AuthorizationServerImpl()) == T$OAuth20NameSpace.AuthorizationServerImpl;

procedure {:extern} OAuth20NameSpace.AuthorizationServerImpl.init($this: Ref);



procedure OAuth20NameSpace.For_vProgram.#ctor($this: Ref);



function T$OAuth20NameSpace.For_vProgram() : Ref;

const unique T$OAuth20NameSpace.For_vProgram: int;

implementation GlobalObjectsForCST.init()
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 2} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 10} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 10} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 10} true;
    call $tmp0 := OAuth20NameSpace.NondetOAuth20.ValidateTicket_Req(F$PoirotMain.Nondet);
    F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req := $tmp0;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 11} true;
    call $tmp1 := Alloc();
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 11} true;
    call OAuth20NameSpace.AuthorizationServerImpl.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$OAuth20NameSpace.AuthorizationServerImpl();
    assume $TypeConstructor($DynamicType($tmp1)) == T$OAuth20NameSpace.AuthorizationServerImpl;
    F$GenericAuthNameSpace.GlobalObjects_base.AS := $tmp1;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 11} true;
    call OAuth20NameSpace.AuthorizationServerImpl.init(F$GenericAuthNameSpace.GlobalObjects_base.AS);
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 12} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 12} true;
    call $tmp2 := Alloc();
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 12} true;
    call OAuth20NameSpace.For_vProgram.#ctor($tmp2);
    assume $DynamicType($tmp2) == T$OAuth20NameSpace.For_vProgram();
    assume $TypeConstructor($DynamicType($tmp2)) == T$OAuth20NameSpace.For_vProgram;
    F$GenericAuthNameSpace.GlobalObjects_base.RS := $tmp2;
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



implementation PoirotMain.Main()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 4} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 21} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 21} true;
    call GlobalObjectsForCST.init();
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 22} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Program.cs"} {:sourceLine 22} true;
    call SynthesizedPortion.SynthesizedSequence();
}



procedure PoirotMain.#ctor($this: Ref);



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



procedure OAuth20NameSpace.For_vProgram.RequestResourceDone$GenericAuthNameSpace.RS.AuthorizationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool);



procedure {:extern} GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotAccessGoodPersonsResource$GenericAuthNameSpace.RS.AuthorizationConclusion(conclusion$in: Ref);



implementation OAuth20NameSpace.For_vProgram.RequestResourceDone$GenericAuthNameSpace.RS.AuthorizationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool)
{
  var conclusion: Ref;
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 6} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Assertion.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Assertion.cs"} {:sourceLine 11} true;
    call GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotAccessGoodPersonsResource$GenericAuthNameSpace.RS.AuthorizationConclusion(conclusion);
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\FacebookGraphAuth\VProgram\Assertion.cs"} {:sourceLine 13} true;
    $result := true;
    return;
}



procedure {:extern} OAuth20NameSpace.ResourceServerImpl.#ctor($this: Ref);



implementation OAuth20NameSpace.For_vProgram.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 7} true;
    call OAuth20NameSpace.ResourceServerImpl.#ctor($this);
}



procedure T$OAuth20NameSpace.For_vProgram.#cctor();



implementation T$OAuth20NameSpace.For_vProgram.#cctor()
{
}



function T$OAuth20NameSpace.AuthorizationServer() : Ref;

const unique T$OAuth20NameSpace.AuthorizationServer: int;

procedure OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.AS.IdpAuthRecs: [Ref]Ref;

implementation OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 8} true;
    assume $this != null;
    local_0_Ref := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.set_AuthorizationCodeRecs$OAuth20NameSpace.AuthorizationCodeRecs($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.AuthorizationServer.set_AuthorizationCodeRecs$OAuth20NameSpace.AuthorizationCodeRecs($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 9} true;
    F$GenericAuthNameSpace.AS.IdpAuthRecs[$this] := value;
}



procedure OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.AS.ASAuthRecs: [Ref]Ref;

implementation OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 10} true;
    assume $this != null;
    local_0_Ref := F$GenericAuthNameSpace.AS.ASAuthRecs[$this];
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 11} true;
    F$GenericAuthNameSpace.AS.ASAuthRecs[$this] := value;
}



procedure OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, AccessTokenRecs1$in: Ref);



implementation OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, AccessTokenRecs1$in: Ref)
{
  var AuthorizationCodeRecs1: Ref;
  var AccessTokenRecs1: Ref;
  var $localExc: Ref;
  var $label: int;

    AuthorizationCodeRecs1 := AuthorizationCodeRecs1$in;
    AccessTokenRecs1 := AccessTokenRecs1$in;
    assume {:breadcrumb 12} true;
    call OAuth20NameSpace.AuthorizationServer.set_AuthorizationCodeRecs$OAuth20NameSpace.AuthorizationCodeRecs($this, AuthorizationCodeRecs1);
    call OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this, AccessTokenRecs1);
}



procedure OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AccessTokenRecs($this: Ref, AccessTokenRecs1$in: Ref);



implementation OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AccessTokenRecs($this: Ref, AccessTokenRecs1$in: Ref)
{
  var AccessTokenRecs1: Ref;
  var $localExc: Ref;
  var $label: int;

    AccessTokenRecs1 := AccessTokenRecs1$in;
    assume {:breadcrumb 13} true;
    call OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this, AccessTokenRecs1);
}



var F$OAuth20NameSpace.ValidateTokenRequest.access_token: [Ref]Ref;

var F$OAuth20NameSpace.ValidateTokenRequest.client_id: [Ref]Ref;

procedure OAuth20NameSpace.ValidateTokenRequest.get_UserID($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.ValidateTicket_Req.get_UserID($this: Ref) returns ($result: Ref);



function T$OAuth20NameSpace.ValidateTokenRequest() : Ref;

const unique T$OAuth20NameSpace.ValidateTokenRequest: int;

procedure {:extern} OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($this: Ref, ticket$in: Ref, Realm$in: Ref, UserID$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.ASAuthTicketRecords_Base.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($this: Ref, ticket$in: Ref, Realm$in: Ref, UserID$in: Ref) returns ($result: Ref);



function {:extern} T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def() : Ref;

const {:extern} unique T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def: int;

axiom $TypeConstructor(T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def()) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def;

procedure OAuth20NameSpace.AccessTokenEntry.get_Realm($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.Permission_Claim.get_Realm($this: Ref) returns ($result: Ref);



function T$OAuth20NameSpace.AccessTokenEntry() : Ref;

const unique T$OAuth20NameSpace.AccessTokenEntry: int;

procedure OAuth20NameSpace.AccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.Permission_Claim.get_UserID($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.AccessTokenEntry.get_permissions($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.Permission_Claim.get_permissions($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.Permissions.permissionSet: [Ref]Ref;

procedure OAuth20NameSpace.ValidateTokenRequest.get_permissions($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.ValidateTicket_Req.get_permissions($this: Ref) returns ($result: Ref);



procedure {:extern} System.Collections.Generic.HashSet`1.IsSupersetOf$System.Collections.Generic.IEnumerable$`0$($this: Ref, other$in: Ref) returns ($result: bool);



var {:extern} F$GenericAuthNameSpace.RS.Realm: [Ref]Ref;

procedure OAuth20NameSpace.ValidateTokenResponse.#ctor($this: Ref);



function T$OAuth20NameSpace.ValidateTokenResponse() : Ref;

const unique T$OAuth20NameSpace.ValidateTokenResponse: int;

var F$OAuth20NameSpace.ValidateTokenResponse.access_token: [Ref]Ref;

var F$OAuth20NameSpace.ValidateTokenResponse.client_id: [Ref]Ref;

var F$OAuth20NameSpace.ValidateTokenResponse.scope: [Ref]Ref;

procedure OAuth20NameSpace.ValidateTokenResponse.set_UserID$System.String($this: Ref, value$in: Ref);



procedure {:extern} GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_UserID$System.String($this: Ref, value$in: Ref);



procedure OAuth20NameSpace.ValidateTokenResponse.set_Realm$System.String($this: Ref, value$in: Ref);



procedure {:extern} GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_Realm$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.AuthorizationServer.ValidateTicket$OAuth20NameSpace.ValidateTokenRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
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
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: bool;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var $tmp20: Ref;
  var $tmp21: bool;
  var $tmp22: Ref;
  var $tmp23: Ref;
  var $tmp24: Ref;
  var $tmp25: Ref;
  var $tmp26: Ref;
  var $tmp27: bool;
  var stack_0_System_Boolean_bool: bool;
  var local_3_bool: bool;
  var local_2_Ref: Ref;
  var $tmp28: Ref;
  var $tmp29: Ref;
  var $tmp30: Ref;
  var $tmp31: bool;
  var local_1_prime_Ref: Ref;
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
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 14} true;
    assume req == F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req;
    call $tmp12 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    if ($TypeConstructor($DynamicType($tmp12)) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def)
    {
        call $tmp0 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
        $tmp1 := req;
        assume $tmp1 != null;
        $tmp2 := req;
        assume $tmp2 != null;
        if ($TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest)
        {
            call $tmp3 := OAuth20NameSpace.ValidateTokenRequest.get_UserID(req);
        }
        else
        {
            call $tmp4 := GenericAuthNameSpace.ValidateTicket_Req.get_UserID(req);
        }

        call $tmp5 := OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp0, F$OAuth20NameSpace.ValidateTokenRequest.access_token[$tmp1], F$OAuth20NameSpace.ValidateTokenRequest.client_id[$tmp2], (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp3 else $tmp4));
    }
    else
    {
        call $tmp6 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
        $tmp7 := req;
        assume $tmp7 != null;
        $tmp8 := req;
        assume $tmp8 != null;
        if ($TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest)
        {
            call $tmp9 := OAuth20NameSpace.ValidateTokenRequest.get_UserID(req);
        }
        else
        {
            call $tmp10 := GenericAuthNameSpace.ValidateTicket_Req.get_UserID(req);
        }

        call $tmp11 := GenericAuthNameSpace.ASAuthTicketRecords_Base.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp6, F$OAuth20NameSpace.ValidateTokenRequest.access_token[$tmp7], F$OAuth20NameSpace.ValidateTokenRequest.client_id[$tmp8], (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp9 else $tmp10));
    }

    local_0_Ref := (if $TypeConstructor($DynamicType($tmp12)) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def then $tmp5 else $tmp11);
    $tmp13 := req;
    assume $tmp13 != null;
    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
    {
        call $tmp14 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
    }
    else
    {
        call $tmp15 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
    }

    call $tmp16 := System.String.op_Inequality$System.String$System.String(F$OAuth20NameSpace.ValidateTokenRequest.client_id[$tmp13], (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp14 else $tmp15));
    if ($tmp16)
    {
        assume {:breadcrumb 15} true;
        if ($TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest)
        {
            call $tmp17 := OAuth20NameSpace.ValidateTokenRequest.get_UserID(req);
        }
        else
        {
            call $tmp18 := GenericAuthNameSpace.ValidateTicket_Req.get_UserID(req);
        }

        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
        {
            call $tmp19 := OAuth20NameSpace.AccessTokenEntry.get_UserID(local_0_Ref);
        }
        else
        {
            call $tmp20 := GenericAuthNameSpace.Permission_Claim.get_UserID(local_0_Ref);
        }

        call $tmp21 := System.String.op_Inequality$System.String$System.String((if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp17 else $tmp18), (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp19 else $tmp20));
        if ($tmp21)
        {
            assume {:breadcrumb 17} true;
        }
        else
        {
            assume {:breadcrumb 18} true;
            goto IL_0078;
        }

        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
        {
            call $tmp22 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
        }
        else
        {
            call $tmp23 := GenericAuthNameSpace.Permission_Claim.get_permissions(local_0_Ref);
        }

        assume (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp22 else $tmp23) != null;
        $tmp24 := F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp22 else $tmp23)];
        if ($TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest)
        {
            call $tmp25 := OAuth20NameSpace.ValidateTokenRequest.get_permissions(req);
        }
        else
        {
            call $tmp26 := GenericAuthNameSpace.ValidateTicket_Req.get_permissions(req);
        }

        assume (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp25 else $tmp26) != null;
        call $tmp27 := System.Collections.Generic.HashSet`1.IsSupersetOf$System.Collections.Generic.IEnumerable$`0$($tmp24, F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp25 else $tmp26)]);
        stack_0_System_Boolean_bool := !$tmp27;
    }
    else
    {
        assume {:breadcrumb 16} true;

      IL_0078:
        stack_0_System_Boolean_bool := true;
    }

    local_3_bool := stack_0_System_Boolean_bool != false;
    if (!local_3_bool)
    {
        assume {:breadcrumb 19} true;
        local_2_Ref := null;
    }
    else
    {
        assume {:breadcrumb 20} true;
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
        {
            call $tmp28 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
        }
        else
        {
            call $tmp29 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
        }

        $tmp30 := F$GenericAuthNameSpace.GlobalObjects_base.RS;
        assume $tmp30 != null;
        call $tmp31 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp28 else $tmp29), F$GenericAuthNameSpace.RS.Realm[$tmp30]);
        assume $tmp31;
        call $tmp32 := Alloc();
        call OAuth20NameSpace.ValidateTokenResponse.#ctor($tmp32);
        assume $DynamicType($tmp32) == T$OAuth20NameSpace.ValidateTokenResponse();
        assume $TypeConstructor($DynamicType($tmp32)) == T$OAuth20NameSpace.ValidateTokenResponse;
        local_1_prime_Ref := $tmp32;
        $tmp33 := req;
        assume $tmp33 != null;
        F$OAuth20NameSpace.ValidateTokenResponse.access_token[local_1_prime_Ref] := F$OAuth20NameSpace.ValidateTokenRequest.access_token[$tmp33];
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
        {
            call $tmp34 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
        }
        else
        {
            call $tmp35 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
        }

        F$OAuth20NameSpace.ValidateTokenResponse.client_id[local_1_prime_Ref] := (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp34 else $tmp35);
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
        {
            call $tmp36 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
        }
        else
        {
            call $tmp37 := GenericAuthNameSpace.Permission_Claim.get_permissions(local_0_Ref);
        }

        F$OAuth20NameSpace.ValidateTokenResponse.scope[local_1_prime_Ref] := (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp36 else $tmp37);
        if ($TypeConstructor($DynamicType(local_1_prime_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse)
        {
            assume {:breadcrumb 21} true;
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
            {
                call $tmp38 := OAuth20NameSpace.AccessTokenEntry.get_UserID(local_0_Ref);
            }
            else
            {
                call $tmp39 := GenericAuthNameSpace.Permission_Claim.get_UserID(local_0_Ref);
            }

            call OAuth20NameSpace.ValidateTokenResponse.set_UserID$System.String(local_1_prime_Ref, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp38 else $tmp39));
        }
        else
        {
            assume {:breadcrumb 22} true;
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
            {
                call $tmp40 := OAuth20NameSpace.AccessTokenEntry.get_UserID(local_0_Ref);
            }
            else
            {
                call $tmp41 := GenericAuthNameSpace.Permission_Claim.get_UserID(local_0_Ref);
            }

            call GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_UserID$System.String(local_1_prime_Ref, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp40 else $tmp41));
        }

        if ($TypeConstructor($DynamicType(local_1_prime_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse)
        {
            assume {:breadcrumb 23} true;
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
            {
                call $tmp42 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
            }
            else
            {
                call $tmp43 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
            }

            call OAuth20NameSpace.ValidateTokenResponse.set_Realm$System.String(local_1_prime_Ref, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp42 else $tmp43));
        }
        else
        {
            assume {:breadcrumb 24} true;
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
            {
                call $tmp44 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
            }
            else
            {
                call $tmp45 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
            }

            call GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_Realm$System.String(local_1_prime_Ref, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp44 else $tmp45));
        }

        local_2_Ref := local_1_prime_Ref;
        goto IL_00e5;
    }

  IL_00e5:
    $result := local_2_Ref;
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req: Ref;

var F$OAuth20NameSpace.AuthorizationRequest.response_type: [Ref]Ref;

const {:value "code"} unique $string_literal_code_0: Ref;

const {:value "token"} unique $string_literal_token_1: Ref;

procedure {:extern} OAuth20NameSpace.AuthorizationServerImpl.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret: [Ref]Ref;

procedure OAuth20NameSpace.AuthorizationRequest.get_Realm($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.SignInIdP_Req.get_Realm($this: Ref) returns ($result: Ref);



function T$OAuth20NameSpace.AuthorizationRequest() : Ref;

const unique T$OAuth20NameSpace.AuthorizationRequest: int;

procedure {:extern} GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, Realm$in: Ref, _ID_Claim$in: Ref) returns ($result: bool);



var F$OAuth20NameSpace.AuthorizationRequest.redirect_uri: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationRequest.scope: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationRequest.state: [Ref]Ref;

procedure {:extern} OAuth20NameSpace.AuthorizationServerImpl.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this: Ref, redirect_uri$in: Ref, scope$in: Ref, state$in: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this: Ref, redirect_uri$in: Ref, scope$in: Ref, state$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, Realm$in: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.ID_Claim.get_Redir_dest($this: Ref) returns ($result: Ref);



function T$OAuth20NameSpace.AuthorizationCodeEntry() : Ref;

const unique T$OAuth20NameSpace.AuthorizationCodeEntry: int;

procedure {:extern} OAuth20NameSpace.AuthorizationServerImpl.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_3_Ref: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_5_Ref: Ref;
  var $tmp1: bool;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_1_Ref: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: bool;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var local_2_Ref: Ref;
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
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 25} true;
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := req;
    if (req == null)
    {
        assume {:breadcrumb 26} true;
        local_3_Ref := null;
    }
    else
    {
        assume {:breadcrumb 27} true;
        local_0_Ref := req;
        $tmp0 := local_0_Ref;
        assume $tmp0 != null;
        local_5_Ref := F$OAuth20NameSpace.AuthorizationRequest.response_type[$tmp0];
        if (local_5_Ref != null)
        {
            assume {:breadcrumb 28} true;
            call $tmp1 := System.String.op_Equality$System.String$System.String(local_5_Ref, $string_literal_code_0);
            if (!$tmp1)
            {
                assume {:breadcrumb 30} true;
                call $tmp2 := System.String.op_Equality$System.String$System.String(local_5_Ref, $string_literal_token_1);
                if ($tmp2)
                {
                    assume {:breadcrumb 32} true;
                    goto IL_0078;
                }
                else
                {
                    assume {:breadcrumb 33} true;
                }

                goto IL_00ab;
            }
            else
            {
                assume {:breadcrumb 31} true;
            }

            if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl)
            {
                call $tmp3 := OAuth20NameSpace.AuthorizationServerImpl.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
                if ($Exception != null)
                {
                    return;
                }
            }
            else
            {
                call $tmp4 := OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
            }

            local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl then $tmp3 else $tmp4);
            assume $this != null;
            $tmp5 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
            $tmp6 := local_0_Ref;
            assume $tmp6 != null;
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest)
            {
                call $tmp7 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
            }
            else
            {
                call $tmp8 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(local_0_Ref);
            }

            call $tmp9 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp5, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp6], (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp7 else $tmp8), local_1_Ref);
            if (!$tmp9)
            {
                assume {:breadcrumb 34} true;
                local_3_Ref := null;
                goto IL_00bf;
            }
            else
            {
                assume {:breadcrumb 35} true;
            }

            goto IL_00af;

          IL_0078:
            if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl)
            {
                $tmp10 := local_0_Ref;
                assume $tmp10 != null;
                $tmp11 := local_0_Ref;
                assume $tmp11 != null;
                $tmp12 := local_0_Ref;
                assume $tmp12 != null;
                call $tmp13 := OAuth20NameSpace.AuthorizationServerImpl.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp10], F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp11], F$OAuth20NameSpace.AuthorizationRequest.state[$tmp12]);
                if ($Exception != null)
                {
                    return;
                }
            }
            else
            {
                $tmp14 := local_0_Ref;
                assume $tmp14 != null;
                $tmp15 := local_0_Ref;
                assume $tmp15 != null;
                $tmp16 := local_0_Ref;
                assume $tmp16 != null;
                call $tmp17 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp14], F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp15], F$OAuth20NameSpace.AuthorizationRequest.state[$tmp16]);
            }

            local_2_Ref := (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl then $tmp13 else $tmp17);
            assume $this != null;
            $tmp18 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
            $tmp19 := local_0_Ref;
            assume $tmp19 != null;
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest)
            {
                call $tmp20 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
            }
            else
            {
                call $tmp21 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(local_0_Ref);
            }

            call $tmp22 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp18, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp19], (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp20 else $tmp21));
            local_1_Ref := $tmp22;
        }
        else
        {
            assume {:breadcrumb 29} true;

          IL_00ab:
            local_3_Ref := null;
            goto IL_00bf;
        }

      IL_00af:
        if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl)
        {
            if ($TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
            {
                call $tmp23 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_1_Ref);
            }
            else
            {
                call $tmp24 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
            }

            call $tmp25 := OAuth20NameSpace.AuthorizationServerImpl.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp23 else $tmp24), local_1_Ref);
            if ($Exception != null)
            {
                return;
            }
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer)
            {
                if ($TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                {
                    call $tmp26 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_1_Ref);
                }
                else
                {
                    call $tmp27 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
                }

                call $tmp28 := GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp26 else $tmp27), local_1_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                {
                    call $tmp29 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_1_Ref);
                }
                else
                {
                    call $tmp30 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
                }

                call $tmp31 := GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp29 else $tmp30), local_1_Ref);
            }
        }

        local_3_Ref := (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl then $tmp25 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp28 else $tmp31));
        goto IL_00bf;
    }

  IL_00bf:
    $result := local_3_Ref;
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref)
{
  var req1: Ref;
  var local_0_Ref: Ref;
  var local_2_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: bool;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    req1 := req1$in;
    assume {:breadcrumb 36} true;
    local_0_Ref := req1;
    $tmp0 := local_0_Ref;
    assume $tmp0 != null;
    local_2_Ref := F$OAuth20NameSpace.AuthorizationRequest.response_type[$tmp0];
    if (local_2_Ref != null)
    {
        assume {:breadcrumb 37} true;
        call $tmp1 := System.String.op_Equality$System.String$System.String(local_2_Ref, $string_literal_code_0);
        if (!$tmp1)
        {
            assume {:breadcrumb 39} true;
            call $tmp2 := System.String.op_Equality$System.String$System.String(local_2_Ref, $string_literal_token_1);
            if ($tmp2)
            {
                assume {:breadcrumb 41} true;
                goto IL_0038;
            }
            else
            {
                assume {:breadcrumb 42} true;
            }

            goto IL_0038;
        }
        else
        {
            assume {:breadcrumb 40} true;
        }

        if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl)
        {
            call $tmp3 := OAuth20NameSpace.AuthorizationServerImpl.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
            if ($Exception != null)
            {
                return;
            }
        }
        else
        {
            call $tmp4 := OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
        }

        local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl then $tmp3 else $tmp4);
    }
    else
    {
        assume {:breadcrumb 38} true;

      IL_0038:
        local_1_Ref := null;
        goto IL_003c;
    }

  IL_003c:
    $result := local_1_Ref;
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.AuthorizationEndpoint$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.AS.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AuthorizationServer.AuthorizationEndpoint$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 43} true;
    if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl)
    {
        call $tmp0 := OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer)
        {
            call $tmp1 := OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
        }
        else
        {
            call $tmp2 := GenericAuthNameSpace.AS.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
        }
    }

    local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl then $tmp0 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp1 else $tmp2));
    goto IL_0012;

  IL_0012:
    $result := local_1_Ref;
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.AuthorizationGrant$OAuth20NameSpace.AuthorizationResponse($this: Ref, resp$in: Ref);



implementation OAuth20NameSpace.AuthorizationServer.AuthorizationGrant$OAuth20NameSpace.AuthorizationResponse($this: Ref, resp$in: Ref)
{
  var resp: Ref;
  var $localExc: Ref;
  var $label: int;

    resp := resp$in;
    assume {:breadcrumb 44} true;
}



procedure OAuth20NameSpace.AuthorizationServer.TokenEndpoint$OAuth20NameSpace.AccessTokenRequest($this: Ref, req$in: Ref) returns ($result: Ref);



var F$OAuth20NameSpace.AccessTokenRequest.grant_type: [Ref]Ref;

const {:value "authorization_code"} unique $string_literal_authorization_code_2: Ref;

const {:value "refresh_token"} unique $string_literal_refresh_token_3: Ref;

var F$OAuth20NameSpace.AccessTokenRequest.client_id: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenRequest.code: [Ref]Ref;

procedure OAuth20NameSpace.AuthorizationCodeRecs.findISSByClientIDAndCode$System.String$System.String($this: Ref, client_id$in: Ref, authorization_code$in: Ref) returns ($result: Ref);



var F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenRequest.redirect_uri: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationCodeEntry.scope: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationCodeEntry.state: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenEntry.access_token: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenRequest.UserID: [Ref]Ref;

procedure {:extern} OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($this: Ref, ticket$in: Ref, Realm$in: Ref, UserID$in: Ref, claim$in: Ref) returns ($result: bool);



procedure {:extern} GenericAuthNameSpace.ASAuthTicketRecords_Base.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($this: Ref, ticket$in: Ref, Realm$in: Ref, UserID$in: Ref, claim$in: Ref) returns ($result: bool);



procedure OAuth20NameSpace.AccessTokenResponse.#ctor($this: Ref);



function T$OAuth20NameSpace.AccessTokenResponse() : Ref;

const unique T$OAuth20NameSpace.AccessTokenResponse: int;

var F$OAuth20NameSpace.AccessTokenResponse.access_token: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenEntry.refresh_token: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenResponse.refresh_token: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenEntry.scope: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenResponse.scope: [Ref]Ref;

procedure {:extern} OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.findISSByClientIDAndRefreshToken$System.String$System.String$System.String($this: Ref, client_id$in: Ref, UserID$in: Ref, refresh_token$in: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndRefreshToken$System.String$System.String$System.String($this: Ref, client_id$in: Ref, UserID$in: Ref, refresh_token$in: Ref) returns ($result: Ref);



var F$OAuth20NameSpace.AccessTokenRequest.access_token: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenEntry.redirect_uri: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenEntry.state: [Ref]Ref;

implementation OAuth20NameSpace.AuthorizationServer.TokenEndpoint$OAuth20NameSpace.AccessTokenRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_5_Ref: Ref;
  var $tmp0: Ref;
  var local_7_Ref: Ref;
  var $tmp1: bool;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var local_2_Ref: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var local_3_Ref: Ref;
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
  var local_0_Ref: Ref;
  var $tmp21: Ref;
  var $tmp22: Ref;
  var $tmp23: Ref;
  var $tmp24: Ref;
  var $tmp25: bool;
  var $tmp26: Ref;
  var $tmp27: Ref;
  var $tmp28: Ref;
  var $tmp29: Ref;
  var $tmp30: bool;
  var $tmp31: Ref;
  var $tmp32: Ref;
  var local_1_Ref: Ref;
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
  var $tmp50: Ref;
  var $tmp51: Ref;
  var $tmp52: Ref;
  var $tmp53: Ref;
  var $tmp54: Ref;
  var $tmp55: Ref;
  var $tmp56: Ref;
  var $tmp57: Ref;
  var $tmp58: Ref;
  var $tmp59: Ref;
  var $tmp60: Ref;
  var $tmp61: Ref;
  var $tmp62: Ref;
  var $tmp63: Ref;
  var $tmp64: Ref;
  var $tmp65: Ref;
  var local_4_Ref: Ref;
  var $tmp66: Ref;
  var $tmp67: Ref;
  var $tmp68: Ref;
  var $tmp69: Ref;
  var $tmp70: bool;
  var $tmp71: Ref;
  var $tmp72: Ref;
  var $tmp73: Ref;
  var $tmp74: Ref;
  var $tmp75: bool;
  var $tmp76: Ref;
  var $tmp77: Ref;
  var $tmp78: Ref;
  var $tmp79: Ref;
  var $tmp80: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 45} true;
    if (req == null)
    {
        assume {:breadcrumb 46} true;
        local_5_Ref := null;
    }
    else
    {
        assume {:breadcrumb 47} true;
        $tmp0 := req;
        assume $tmp0 != null;
        local_7_Ref := F$OAuth20NameSpace.AccessTokenRequest.grant_type[$tmp0];
        if (local_7_Ref != null)
        {
            assume {:breadcrumb 48} true;
            call $tmp1 := System.String.op_Equality$System.String$System.String(local_7_Ref, $string_literal_authorization_code_2);
            if (!$tmp1)
            {
                assume {:breadcrumb 50} true;
                call $tmp2 := System.String.op_Equality$System.String$System.String(local_7_Ref, $string_literal_refresh_token_3);
                if ($tmp2)
                {
                    assume {:breadcrumb 52} true;
                    goto IL_0127;
                }
                else
                {
                    assume {:breadcrumb 53} true;
                }

                goto IL_01f1;
            }
            else
            {
                assume {:breadcrumb 51} true;
            }

            call $tmp3 := OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this);
            $tmp4 := req;
            assume $tmp4 != null;
            $tmp5 := req;
            assume $tmp5 != null;
            call $tmp6 := OAuth20NameSpace.AuthorizationCodeRecs.findISSByClientIDAndCode$System.String$System.String($tmp3, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp4], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp5]);
            local_2_Ref := $tmp6;
            if (local_2_Ref == null)
            {
                assume {:breadcrumb 54} true;
                local_5_Ref := null;
            }
            else
            {
                assume {:breadcrumb 55} true;
                call $tmp7 := OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this);
                $tmp8 := req;
                assume $tmp8 != null;
                call $tmp9 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp7, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp8]);
                local_3_Ref := $tmp9;
                $tmp10 := local_3_Ref;
                assume $tmp10 != null;
                $tmp11 := req;
                assume $tmp11 != null;
                call $tmp12 := System.String.op_Inequality$System.String$System.String(F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp10], F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[$tmp11]);
                if ($tmp12)
                {
                    assume {:breadcrumb 56} true;
                    local_5_Ref := null;
                }
                else
                {
                    assume {:breadcrumb 57} true;
                    if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl)
                    {
                        $tmp13 := local_3_Ref;
                        assume $tmp13 != null;
                        $tmp14 := local_3_Ref;
                        assume $tmp14 != null;
                        $tmp15 := local_3_Ref;
                        assume $tmp15 != null;
                        call $tmp16 := OAuth20NameSpace.AuthorizationServerImpl.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp13], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp14], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp15]);
                        if ($Exception != null)
                        {
                            return;
                        }
                    }
                    else
                    {
                        $tmp17 := local_3_Ref;
                        assume $tmp17 != null;
                        $tmp18 := local_3_Ref;
                        assume $tmp18 != null;
                        $tmp19 := local_3_Ref;
                        assume $tmp19 != null;
                        call $tmp20 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp17], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp18], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp19]);
                    }

                    local_0_Ref := (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl then $tmp16 else $tmp20);
                    call $tmp31 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                    if ($TypeConstructor($DynamicType($tmp31)) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def)
                    {
                        call $tmp21 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                        $tmp22 := local_0_Ref;
                        assume $tmp22 != null;
                        $tmp23 := req;
                        assume $tmp23 != null;
                        $tmp24 := req;
                        assume $tmp24 != null;
                        call $tmp25 := OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp21, F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp22], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp23], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp24], local_0_Ref);
                    }
                    else
                    {
                        call $tmp26 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                        $tmp27 := local_0_Ref;
                        assume $tmp27 != null;
                        $tmp28 := req;
                        assume $tmp28 != null;
                        $tmp29 := req;
                        assume $tmp29 != null;
                        call $tmp30 := GenericAuthNameSpace.ASAuthTicketRecords_Base.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp26, F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp27], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp28], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp29], local_0_Ref);
                    }

                    if (!(if $TypeConstructor($DynamicType($tmp31)) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def then $tmp25 else $tmp30))
                    {
                        assume {:breadcrumb 58} true;
                        local_5_Ref := null;
                    }
                    else
                    {
                        assume {:breadcrumb 59} true;
                        call $tmp32 := Alloc();
                        call OAuth20NameSpace.AccessTokenResponse.#ctor($tmp32);
                        assume $DynamicType($tmp32) == T$OAuth20NameSpace.AccessTokenResponse();
                        assume $TypeConstructor($DynamicType($tmp32)) == T$OAuth20NameSpace.AccessTokenResponse;
                        local_1_Ref := $tmp32;
                        $tmp33 := local_0_Ref;
                        assume $tmp33 != null;
                        F$OAuth20NameSpace.AccessTokenResponse.access_token[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp33];
                        $tmp34 := local_0_Ref;
                        assume $tmp34 != null;
                        F$OAuth20NameSpace.AccessTokenResponse.refresh_token[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$tmp34];
                        $tmp35 := local_0_Ref;
                        assume $tmp35 != null;
                        F$OAuth20NameSpace.AccessTokenResponse.scope[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp35];
                        local_5_Ref := local_1_Ref;
                        goto IL_01f6;

                      IL_0127:
                        call $tmp46 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                        if ($TypeConstructor($DynamicType($tmp46)) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def)
                        {
                            call $tmp36 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                            $tmp37 := req;
                            assume $tmp37 != null;
                            $tmp38 := req;
                            assume $tmp38 != null;
                            $tmp39 := req;
                            assume $tmp39 != null;
                            call $tmp40 := OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.findISSByClientIDAndRefreshToken$System.String$System.String$System.String($tmp36, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp37], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp38], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp39]);
                        }
                        else
                        {
                            call $tmp41 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                            $tmp42 := req;
                            assume $tmp42 != null;
                            $tmp43 := req;
                            assume $tmp43 != null;
                            $tmp44 := req;
                            assume $tmp44 != null;
                            call $tmp45 := OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndRefreshToken$System.String$System.String$System.String($tmp41, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp42], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp43], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp44]);
                        }

                        if ((if $TypeConstructor($DynamicType($tmp46)) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def then $tmp40 else $tmp45) == null)
                        {
                            assume {:breadcrumb 60} true;
                            local_5_Ref := null;
                        }
                        else
                        {
                            assume {:breadcrumb 61} true;
                            call $tmp57 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                            if ($TypeConstructor($DynamicType($tmp57)) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def)
                            {
                                call $tmp47 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                                $tmp48 := req;
                                assume $tmp48 != null;
                                $tmp49 := req;
                                assume $tmp49 != null;
                                $tmp50 := req;
                                assume $tmp50 != null;
                                call $tmp51 := OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp47, F$OAuth20NameSpace.AccessTokenRequest.access_token[$tmp48], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp49], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp50]);
                            }
                            else
                            {
                                call $tmp52 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                                $tmp53 := req;
                                assume $tmp53 != null;
                                $tmp54 := req;
                                assume $tmp54 != null;
                                $tmp55 := req;
                                assume $tmp55 != null;
                                call $tmp56 := GenericAuthNameSpace.ASAuthTicketRecords_Base.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp52, F$OAuth20NameSpace.AccessTokenRequest.access_token[$tmp53], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp54], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp55]);
                            }

                            local_0_Ref := (if $TypeConstructor($DynamicType($tmp57)) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def then $tmp51 else $tmp56);
                            if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl)
                            {
                                $tmp58 := local_0_Ref;
                                assume $tmp58 != null;
                                $tmp59 := local_0_Ref;
                                assume $tmp59 != null;
                                $tmp60 := local_0_Ref;
                                assume $tmp60 != null;
                                call $tmp61 := OAuth20NameSpace.AuthorizationServerImpl.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$tmp58], F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp59], F$OAuth20NameSpace.AccessTokenEntry.state[$tmp60]);
                                if ($Exception != null)
                                {
                                    return;
                                }
                            }
                            else
                            {
                                $tmp62 := local_0_Ref;
                                assume $tmp62 != null;
                                $tmp63 := local_0_Ref;
                                assume $tmp63 != null;
                                $tmp64 := local_0_Ref;
                                assume $tmp64 != null;
                                call $tmp65 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$tmp62], F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp63], F$OAuth20NameSpace.AccessTokenEntry.state[$tmp64]);
                            }

                            local_4_Ref := (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl then $tmp61 else $tmp65);
                            call $tmp76 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                            if ($TypeConstructor($DynamicType($tmp76)) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def)
                            {
                                call $tmp66 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                                $tmp67 := local_4_Ref;
                                assume $tmp67 != null;
                                $tmp68 := req;
                                assume $tmp68 != null;
                                $tmp69 := req;
                                assume $tmp69 != null;
                                call $tmp70 := OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp66, F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp67], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp68], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp69], local_4_Ref);
                            }
                            else
                            {
                                call $tmp71 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                                $tmp72 := local_4_Ref;
                                assume $tmp72 != null;
                                $tmp73 := req;
                                assume $tmp73 != null;
                                $tmp74 := req;
                                assume $tmp74 != null;
                                call $tmp75 := GenericAuthNameSpace.ASAuthTicketRecords_Base.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp71, F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp72], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp73], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp74], local_4_Ref);
                            }

                            if (!(if $TypeConstructor($DynamicType($tmp76)) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def then $tmp70 else $tmp75))
                            {
                                assume {:breadcrumb 62} true;
                                local_5_Ref := null;
                            }
                            else
                            {
                                assume {:breadcrumb 63} true;
                                call $tmp77 := Alloc();
                                call OAuth20NameSpace.AccessTokenResponse.#ctor($tmp77);
                                assume $DynamicType($tmp77) == T$OAuth20NameSpace.AccessTokenResponse();
                                assume $TypeConstructor($DynamicType($tmp77)) == T$OAuth20NameSpace.AccessTokenResponse;
                                local_1_Ref := $tmp77;
                                $tmp78 := local_0_Ref;
                                assume $tmp78 != null;
                                F$OAuth20NameSpace.AccessTokenResponse.access_token[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp78];
                                $tmp79 := local_0_Ref;
                                assume $tmp79 != null;
                                F$OAuth20NameSpace.AccessTokenResponse.refresh_token[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$tmp79];
                                $tmp80 := local_0_Ref;
                                assume $tmp80 != null;
                                F$OAuth20NameSpace.AccessTokenResponse.scope[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp80];
                                local_5_Ref := local_1_Ref;
                            }
                        }
                    }
                }
            }
        }
        else
        {
            assume {:breadcrumb 49} true;

          IL_01f1:
            local_5_Ref := null;
            goto IL_01f6;
        }
    }

  IL_01f6:
    $result := local_5_Ref;
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.AS.#ctor($this: Ref);



implementation OAuth20NameSpace.AuthorizationServer.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 64} true;
    call GenericAuthNameSpace.AS.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationServer.#cctor();



implementation T$OAuth20NameSpace.AuthorizationServer.#cctor()
{
}



function T$OAuth20NameSpace.Properties.Resources() : Ref;

const unique T$OAuth20NameSpace.Properties.Resources: int;

var F$OAuth20NameSpace.Properties.Resources.resourceMan: Ref;

var F$OAuth20NameSpace.Properties.Resources.resourceCulture: Ref;

procedure OAuth20NameSpace.Properties.Resources.#ctor($this: Ref);



implementation OAuth20NameSpace.Properties.Resources.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 65} true;
    call System.Object.#ctor($this);
}



procedure OAuth20NameSpace.Properties.Resources.get_ResourceManager() returns ($result: Ref);



procedure {:extern} System.Object.ReferenceEquals$System.Object$System.Object(objA$in: Ref, objB$in: Ref) returns ($result: bool);



const {:value "OAuth20NameSpace.Properties.Resources"} unique $string_literal_OAuth20NameSpace.Properties.Resources_4: Ref;

procedure {:extern} System.Type.get_Assembly($this: Ref) returns ($result: Ref);



procedure {:extern} System.Resources.ResourceManager.#ctor$System.String$System.Reflection.Assembly($this: Ref, baseName$in: Ref, assembly$in: Ref);



function {:extern} T$System.Resources.ResourceManager() : Ref;

const {:extern} unique T$System.Resources.ResourceManager: int;

axiom $TypeConstructor(T$System.Resources.ResourceManager()) == T$System.Resources.ResourceManager;

implementation OAuth20NameSpace.Properties.Resources.get_ResourceManager() returns ($result: Ref)
{
  var $tmp0: bool;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 66} true;
    call $tmp0 := System.Object.ReferenceEquals$System.Object$System.Object(F$OAuth20NameSpace.Properties.Resources.resourceMan, null);
    if ($tmp0)
    {
        assume {:breadcrumb 67} true;
        call $tmp1 := Alloc();
        $tmp2 := T$OAuth20NameSpace.Properties.Resources();
        call $tmp3 := System.Type.get_Assembly($tmp2);
        call System.Resources.ResourceManager.#ctor$System.String$System.Reflection.Assembly($tmp1, $string_literal_OAuth20NameSpace.Properties.Resources_4, $tmp3);
        assume $DynamicType($tmp1) == T$System.Resources.ResourceManager();
        assume $TypeConstructor($DynamicType($tmp1)) == T$System.Resources.ResourceManager;
        F$OAuth20NameSpace.Properties.Resources.resourceMan := $tmp1;
    }
    else
    {
        assume {:breadcrumb 68} true;
    }

    local_1_Ref := F$OAuth20NameSpace.Properties.Resources.resourceMan;
    goto IL_003d;

  IL_003d:
    $result := local_1_Ref;
    return;
}



procedure OAuth20NameSpace.Properties.Resources.get_Culture() returns ($result: Ref);



implementation OAuth20NameSpace.Properties.Resources.get_Culture() returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 69} true;
    local_0_Ref := F$OAuth20NameSpace.Properties.Resources.resourceCulture;
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.Properties.Resources.set_Culture$System.Globalization.CultureInfo(value$in: Ref);



implementation OAuth20NameSpace.Properties.Resources.set_Culture$System.Globalization.CultureInfo(value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 70} true;
    F$OAuth20NameSpace.Properties.Resources.resourceCulture := value;
}



procedure OAuth20NameSpace.Properties.Resources.get_Assertion() returns ($result: Ref);



const {:value "Assertion"} unique $string_literal_Assertion_5: Ref;

procedure {:extern} System.Resources.ResourceManager.GetString$System.String$System.Globalization.CultureInfo($this: Ref, name$in: Ref, culture$in: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.Properties.Resources.get_Assertion() returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 71} true;
    call $tmp0 := OAuth20NameSpace.Properties.Resources.get_ResourceManager();
    call $tmp1 := System.Resources.ResourceManager.GetString$System.String$System.Globalization.CultureInfo($tmp0, $string_literal_Assertion_5, F$OAuth20NameSpace.Properties.Resources.resourceCulture);
    local_0_Ref := $tmp1;
    goto IL_0018;

  IL_0018:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.Properties.Resources.get_Program() returns ($result: Ref);



const {:value "Program"} unique $string_literal_Program_6: Ref;

implementation OAuth20NameSpace.Properties.Resources.get_Program() returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 72} true;
    call $tmp0 := OAuth20NameSpace.Properties.Resources.get_ResourceManager();
    call $tmp1 := System.Resources.ResourceManager.GetString$System.String$System.Globalization.CultureInfo($tmp0, $string_literal_Program_6, F$OAuth20NameSpace.Properties.Resources.resourceCulture);
    local_0_Ref := $tmp1;
    goto IL_0018;

  IL_0018:
    $result := local_0_Ref;
    return;
}



procedure T$OAuth20NameSpace.Properties.Resources.#cctor();



implementation T$OAuth20NameSpace.Properties.Resources.#cctor()
{
    F$OAuth20NameSpace.Properties.Resources.resourceMan := null;
    F$OAuth20NameSpace.Properties.Resources.resourceCulture := null;
}



function T$OAuth20NameSpace.ResourceRecs() : Ref;

const unique T$OAuth20NameSpace.ResourceRecs: int;

var F$OAuth20NameSpace.AuthorizationCodeEntry.code: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationCodeEntry.user: [Ref]Ref;

procedure OAuth20NameSpace.AuthorizationCodeEntry.get_UserID($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AuthorizationCodeEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 73} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AuthorizationCodeEntry.user[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



implementation OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 74} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.AuthorizationCodeEntry.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.ID_Claim.#ctor($this: Ref);



implementation OAuth20NameSpace.AuthorizationCodeEntry.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AuthorizationCodeEntry.code[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.user[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.state[$this] := null;
    assume {:breadcrumb 75} true;
    call GenericAuthNameSpace.ID_Claim.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationCodeEntry.#cctor();



implementation T$OAuth20NameSpace.AuthorizationCodeEntry.#cctor()
{
}



function T$OAuth20NameSpace.Client() : Ref;

const unique T$OAuth20NameSpace.Client: int;

var F$OAuth20NameSpace.Client.client_secret: [Ref]Ref;

var F$OAuth20NameSpace.Client.TokenEndpointUrl: [Ref]Ref;

procedure OAuth20NameSpace.Client.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.RP.#ctor($this: Ref);



implementation OAuth20NameSpace.Client.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.Client.client_secret[$this] := null;
    F$OAuth20NameSpace.Client.TokenEndpointUrl[$this] := null;
    assume {:breadcrumb 76} true;
    call GenericAuthNameSpace.RP.#ctor($this);
}



procedure OAuth20NameSpace.Client.get_client_id($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.RP.Realm: [Ref]Ref;

implementation OAuth20NameSpace.Client.get_client_id($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 77} true;
    assume $this != null;
    local_0_Ref := F$GenericAuthNameSpace.RP.Realm[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.Client.set_client_id$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.Client.set_client_id$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 78} true;
    F$GenericAuthNameSpace.RP.Realm[$this] := value;
}



procedure OAuth20NameSpace.Client.get_return_uri($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.RP.Domain: [Ref]Ref;

implementation OAuth20NameSpace.Client.get_return_uri($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 79} true;
    assume $this != null;
    local_0_Ref := F$GenericAuthNameSpace.RP.Domain[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.Client.set_return_uri$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.Client.set_return_uri$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 80} true;
    F$GenericAuthNameSpace.RP.Domain[$this] := value;
}



procedure OAuth20NameSpace.Client.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id1$in: Ref, return_uri1$in: Ref, client_secret1$in: Ref, TokenEndpointUrl1$in: Ref);



implementation OAuth20NameSpace.Client.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id1$in: Ref, return_uri1$in: Ref, client_secret1$in: Ref, TokenEndpointUrl1$in: Ref)
{
  var client_id1: Ref;
  var return_uri1: Ref;
  var client_secret1: Ref;
  var TokenEndpointUrl1: Ref;
  var $localExc: Ref;
  var $label: int;

    client_id1 := client_id1$in;
    return_uri1 := return_uri1$in;
    client_secret1 := client_secret1$in;
    TokenEndpointUrl1 := TokenEndpointUrl1$in;
    F$OAuth20NameSpace.Client.client_secret[$this] := null;
    F$OAuth20NameSpace.Client.TokenEndpointUrl[$this] := null;
    assume {:breadcrumb 81} true;
    call GenericAuthNameSpace.RP.#ctor($this);
    call OAuth20NameSpace.Client.set_client_id$System.String($this, client_id1);
    call OAuth20NameSpace.Client.set_return_uri$System.String($this, return_uri1);
    F$OAuth20NameSpace.Client.client_secret[$this] := client_secret1;
    F$OAuth20NameSpace.Client.TokenEndpointUrl[$this] := TokenEndpointUrl1;
}



procedure T$OAuth20NameSpace.Client.#cctor();



implementation T$OAuth20NameSpace.Client.#cctor()
{
}



var F$OAuth20NameSpace.AccessTokenEntry.user: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenEntry.client_id: [Ref]Ref;

implementation OAuth20NameSpace.AccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 82} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AccessTokenEntry.user[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.AccessTokenEntry.get_Redir_dest($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessTokenEntry.get_Redir_dest($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 83} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



implementation OAuth20NameSpace.AccessTokenEntry.get_permissions($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 84} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AccessTokenEntry.scope[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



implementation OAuth20NameSpace.AccessTokenEntry.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 85} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AccessTokenEntry.client_id[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.AccessTokenEntry.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.Permission_Claim.#ctor($this: Ref);



implementation OAuth20NameSpace.AccessTokenEntry.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AccessTokenEntry.access_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.user[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.scope[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.state[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.client_id[$this] := null;
    assume {:breadcrumb 86} true;
    call GenericAuthNameSpace.Permission_Claim.#ctor($this);
}



procedure T$OAuth20NameSpace.AccessTokenEntry.#cctor();



implementation T$OAuth20NameSpace.AccessTokenEntry.#cctor()
{
}



var F$OAuth20NameSpace.AuthorizationRequest.client_id: [Ref]Ref;

implementation OAuth20NameSpace.AuthorizationRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 87} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AuthorizationRequest.client_id[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.AuthorizationRequest.set_Realm$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.AuthorizationRequest.set_Realm$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 88} true;
    F$OAuth20NameSpace.AuthorizationRequest.client_id[$this] := value;
}



procedure OAuth20NameSpace.AuthorizationRequest.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.SignInIdP_Req.#ctor($this: Ref);



implementation OAuth20NameSpace.AuthorizationRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AuthorizationRequest.response_type[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.client_id[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.scope[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.state[$this] := null;
    assume {:breadcrumb 89} true;
    F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.state[$this] := null;
    call GenericAuthNameSpace.SignInIdP_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationRequest.#cctor();



implementation T$OAuth20NameSpace.AuthorizationRequest.#cctor()
{
}



var F$OAuth20NameSpace.ValidateTokenRequest.scope: [Ref]Ref;

var F$OAuth20NameSpace.ValidateTokenRequest.user: [Ref]Ref;

procedure OAuth20NameSpace.ValidateTokenRequest.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ValidateTokenRequest.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 90} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ValidateTokenRequest.access_token[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.ValidateTokenRequest.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ValidateTokenRequest.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 91} true;
    F$OAuth20NameSpace.ValidateTokenRequest.access_token[$this] := value;
}



implementation OAuth20NameSpace.ValidateTokenRequest.get_permissions($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 92} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ValidateTokenRequest.scope[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.ValidateTokenRequest.set_permissions$GenericAuthNameSpace.Permissions($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ValidateTokenRequest.set_permissions$GenericAuthNameSpace.Permissions($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 93} true;
    F$OAuth20NameSpace.ValidateTokenRequest.scope[$this] := value;
}



procedure OAuth20NameSpace.ValidateTokenRequest.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ValidateTokenRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 94} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ValidateTokenRequest.client_id[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.ValidateTokenRequest.set_Realm$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ValidateTokenRequest.set_Realm$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 95} true;
    F$OAuth20NameSpace.ValidateTokenRequest.client_id[$this] := value;
}



implementation OAuth20NameSpace.ValidateTokenRequest.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 96} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ValidateTokenRequest.user[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.ValidateTokenRequest.set_UserID$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ValidateTokenRequest.set_UserID$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 97} true;
    F$OAuth20NameSpace.ValidateTokenRequest.user[$this] := value;
}



procedure OAuth20NameSpace.ValidateTokenRequest.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.ValidateTicket_Req.#ctor($this: Ref);



implementation OAuth20NameSpace.ValidateTokenRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ValidateTokenRequest.access_token[$this] := null;
    F$OAuth20NameSpace.ValidateTokenRequest.scope[$this] := null;
    F$OAuth20NameSpace.ValidateTokenRequest.client_id[$this] := null;
    F$OAuth20NameSpace.ValidateTokenRequest.user[$this] := null;
    assume {:breadcrumb 98} true;
    call GenericAuthNameSpace.ValidateTicket_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.ValidateTokenRequest.#cctor();



implementation T$OAuth20NameSpace.ValidateTokenRequest.#cctor()
{
}



function T$OAuth20NameSpace.ResourceResponse() : Ref;

const unique T$OAuth20NameSpace.ResourceResponse: int;

var F$OAuth20NameSpace.ResourceResponse.access_token: [Ref]Ref;

var F$OAuth20NameSpace.ResourceResponse.client_id: [Ref]Ref;

procedure OAuth20NameSpace.ResourceResponse.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceResponse.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 99} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ResourceResponse.access_token[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.ResourceResponse.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ResourceResponse.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 100} true;
    F$OAuth20NameSpace.ResourceResponse.access_token[$this] := value;
}



procedure OAuth20NameSpace.ResourceResponse.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceResponse.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 101} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ResourceResponse.client_id[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.ResourceResponse.set_Realm$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ResourceResponse.set_Realm$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 102} true;
    F$OAuth20NameSpace.ResourceResponse.client_id[$this] := value;
}



procedure OAuth20NameSpace.ResourceResponse.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#ctor($this: Ref);



implementation OAuth20NameSpace.ResourceResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ResourceResponse.access_token[$this] := null;
    F$OAuth20NameSpace.ResourceResponse.client_id[$this] := null;
    assume {:breadcrumb 103} true;
    call GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.ResourceResponse.#cctor();



implementation T$OAuth20NameSpace.ResourceResponse.#cctor()
{
}



function T$OAuth20NameSpace.AuthorizationCodeRecs() : Ref;

const unique T$OAuth20NameSpace.AuthorizationCodeRecs: int;

function T$OAuth20NameSpace.ResourceServer() : Ref;

const unique T$OAuth20NameSpace.ResourceServer: int;

var F$OAuth20NameSpace.ResourceServer.TokenEndpointUrl: [Ref]Ref;

procedure OAuth20NameSpace.ResourceServer.get_ResourceRecs($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.RS.RSResourceRecs: [Ref]Ref;

implementation OAuth20NameSpace.ResourceServer.get_ResourceRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 104} true;
    assume $this != null;
    local_0_Ref := F$GenericAuthNameSpace.RS.RSResourceRecs[$this];
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.ResourceServer.set_ResourceRecs$OAuth20NameSpace.ResourceRecs($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ResourceServer.set_ResourceRecs$OAuth20NameSpace.ResourceRecs($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 105} true;
    F$GenericAuthNameSpace.RS.RSResourceRecs[$this] := value;
}



procedure OAuth20NameSpace.ResourceServer.init$OAuth20NameSpace.ResourceRecs($this: Ref, recs$in: Ref);



var {:extern} F$CST.VProgramGenerator.Assertion_cs: Ref;

var {:extern} F$CST.VProgramGenerator.Program_cs: Ref;

implementation OAuth20NameSpace.ResourceServer.init$OAuth20NameSpace.ResourceRecs($this: Ref, recs$in: Ref)
{
  var recs: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

    recs := recs$in;
    assume {:breadcrumb 106} true;
    call OAuth20NameSpace.ResourceServer.set_ResourceRecs$OAuth20NameSpace.ResourceRecs($this, recs);
    call $tmp0 := OAuth20NameSpace.Properties.Resources.get_Assertion();
    F$CST.VProgramGenerator.Assertion_cs := $tmp0;
    call $tmp1 := OAuth20NameSpace.Properties.Resources.get_Program();
    F$CST.VProgramGenerator.Program_cs := $tmp1;
}



var F$OAuth20NameSpace.ResourceRequest.access_token: [Ref]Ref;

var F$OAuth20NameSpace.ResourceRequest.scope: [Ref]Ref;

var {:extern} F$GenericAuthNameSpace.ReqResourceRS_Req.UserID: [Ref]Ref;

procedure {:extern} GenericAuthNameSpace.ValidateTicket_Req.set_UserID$System.String($this: Ref, value$in: Ref);



procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct(o$in: Ref, in_msg$in: Ref, out_msg$in: Ref);



implementation OAuth20NameSpace.ResourceServer.createValidateTokenRequest$OAuth20NameSpace.ResourceRequest($this: Ref, res_req$in: Ref) returns ($result: Ref)
{
  var res_req: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    res_req := res_req$in;
    assume {:breadcrumb 107} true;
    call $tmp0 := Alloc();
    call OAuth20NameSpace.ValidateTokenRequest.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OAuth20NameSpace.ValidateTokenRequest();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OAuth20NameSpace.ValidateTokenRequest;
    local_0_Ref := $tmp0;
    $tmp1 := res_req;
    assume $tmp1 != null;
    F$OAuth20NameSpace.ValidateTokenRequest.access_token[local_0_Ref] := F$OAuth20NameSpace.ResourceRequest.access_token[$tmp1];
    $tmp2 := res_req;
    assume $tmp2 != null;
    F$OAuth20NameSpace.ValidateTokenRequest.scope[local_0_Ref] := F$OAuth20NameSpace.ResourceRequest.scope[$tmp2];
    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.ValidateTokenRequest)
    {
        assume {:breadcrumb 108} true;
        $tmp3 := res_req;
        assume $tmp3 != null;
        call OAuth20NameSpace.ValidateTokenRequest.set_UserID$System.String(local_0_Ref, F$GenericAuthNameSpace.ReqResourceRS_Req.UserID[$tmp3]);
    }
    else
    {
        assume {:breadcrumb 109} true;
        $tmp4 := res_req;
        assume $tmp4 != null;
        call GenericAuthNameSpace.ValidateTicket_Req.set_UserID$System.String(local_0_Ref, F$GenericAuthNameSpace.ReqResourceRS_Req.UserID[$tmp4]);
    }

    assume $this != null;
    F$OAuth20NameSpace.ValidateTokenRequest.client_id[local_0_Ref] := F$GenericAuthNameSpace.RS.Realm[$this];
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct($this, res_req, local_0_Ref);
    local_1_Ref := local_0_Ref;
    goto IL_0045;

  IL_0045:
    $result := local_1_Ref;
    return;
}



procedure OAuth20NameSpace.ResourceServer.RequestResource$OAuth20NameSpace.ResourceRequest($this: Ref, req$in: Ref) returns ($result: Ref);



procedure System.Collections.Generic.HashSet$GenericAuthNameSpace.Permission$.Enumerator.#default_ctor($this: Ref);



function {:extern} T$T$System.Collections.Generic.HashSet`1.Enumerator(parent: Ref) : Ref;

function {:extern} T$System.Collections.Generic.HashSet`1.Enumerator(T: Ref) : Ref;

const {:extern} unique T$System.Collections.Generic.HashSet`1.Enumerator: int;

function {:extern} T$GenericAuthNameSpace.Permission() : Ref;

const {:extern} unique T$GenericAuthNameSpace.Permission: int;

axiom $TypeConstructor(T$GenericAuthNameSpace.Permission()) == T$GenericAuthNameSpace.Permission;

procedure {:extern} OAuth20NameSpace.ResourceServerImpl.callValidateTokenEndpoint$OAuth20NameSpace.ValidateTokenRequest($this: Ref, treq$in: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.ResourceServer.callValidateTokenEndpoint$OAuth20NameSpace.ValidateTokenRequest($this: Ref, treq$in: Ref) returns ($result: Ref);



function {:extern} T$OAuth20NameSpace.ResourceServerImpl() : Ref;

const {:extern} unique T$OAuth20NameSpace.ResourceServerImpl: int;

axiom $TypeConstructor(T$OAuth20NameSpace.ResourceServerImpl()) == T$OAuth20NameSpace.ResourceServerImpl;

procedure {:extern} GenericAuthNameSpace.Resources.#ctor($this: Ref);



function {:extern} T$GenericAuthNameSpace.Resources() : Ref;

const {:extern} unique T$GenericAuthNameSpace.Resources: int;

axiom $TypeConstructor(T$GenericAuthNameSpace.Resources()) == T$GenericAuthNameSpace.Resources;

procedure {:extern} System.Collections.Generic.HashSet`1.#ctor($this: Ref);



function {:extern} T$T$System.Collections.Generic.HashSet`1(parent: Ref) : Ref;

function {:extern} T$System.Collections.Generic.HashSet`1(T: Ref) : Ref;

const {:extern} unique T$System.Collections.Generic.HashSet`1: int;

function {:extern} T$GenericAuthNameSpace.Resource() : Ref;

const {:extern} unique T$GenericAuthNameSpace.Resource: int;

axiom $TypeConstructor(T$GenericAuthNameSpace.Resource()) == T$GenericAuthNameSpace.Resource;

var {:extern} F$GenericAuthNameSpace.Resources.resourceSet: [Ref]Ref;

procedure System.Collections.Generic.HashSet.Enumerator.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



procedure {:extern} System.Collections.Generic.HashSet`1.GetEnumerator($this: Ref) returns ($result: Ref);



procedure {:extern} System.Collections.Generic.HashSet`1.Enumerator.get_Current($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.ValidateTokenResponse.get_UserID($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_UserID($this: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.getEntry$System.String$GenericAuthNameSpace.Permission($this: Ref, UserID$in: Ref, permission$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.RSResourceRecords_Base.getEntry$System.String$GenericAuthNameSpace.Permission($this: Ref, UserID$in: Ref, permission$in: Ref) returns ($result: Ref);



function {:extern} T$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def() : Ref;

const {:extern} unique T$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def: int;

axiom $TypeConstructor(T$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def()) == T$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def;

procedure {:extern} System.Collections.Generic.HashSet`1.Add$`0($this: Ref, item$in: Ref) returns ($result: bool);



procedure {:extern} System.Collections.Generic.HashSet`1.Enumerator.MoveNext($this: Ref) returns ($result: bool);



var {:extern} F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.resources: [Ref]Ref;

var {:extern} F$CST.CST_Struct.SymT: [Ref]Ref;

implementation OAuth20NameSpace.ResourceServer.RequestResource$OAuth20NameSpace.ResourceRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_7_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: bool;
  var $tmp8: Ref;
  var local_2_Ref: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var local_3_Ref: Ref;
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
  var $tmp27: bool;
  var $tmp28: bool;
  var local_4_prime_Ref: Ref;
  var $tmp29: Ref;
  var $tmp30: Ref;
  var $tmp31: Ref;
  var $tmp32: Ref;
  var local_5_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 110} true;
    call $tmp0 := Alloc();
    call System.Collections.Generic.HashSet$GenericAuthNameSpace.Permission$.Enumerator.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.HashSet`1.Enumerator(T$GenericAuthNameSpace.Permission());
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    assume T$T$System.Collections.Generic.HashSet`1.Enumerator($DynamicType($tmp0)) == T$GenericAuthNameSpace.Permission();
    local_7_Ref := $tmp0;
    if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.For_vProgram)
    {
        call $tmp1 := OAuth20NameSpace.ResourceServer.createValidateTokenRequest$OAuth20NameSpace.ResourceRequest($this, req);
        call $tmp2 := OAuth20NameSpace.ResourceServerImpl.callValidateTokenEndpoint$OAuth20NameSpace.ValidateTokenRequest($this, $tmp1);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.ResourceServerImpl)
        {
            call $tmp3 := OAuth20NameSpace.ResourceServer.createValidateTokenRequest$OAuth20NameSpace.ResourceRequest($this, req);
            call $tmp4 := OAuth20NameSpace.ResourceServerImpl.callValidateTokenEndpoint$OAuth20NameSpace.ValidateTokenRequest($this, $tmp3);
        }
        else
        {
            call $tmp5 := OAuth20NameSpace.ResourceServer.createValidateTokenRequest$OAuth20NameSpace.ResourceRequest($this, req);
            call $tmp6 := OAuth20NameSpace.ResourceServer.callValidateTokenEndpoint$OAuth20NameSpace.ValidateTokenRequest($this, $tmp5);
        }
    }

    local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.For_vProgram then $tmp2 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.ResourceServerImpl then $tmp4 else $tmp6));
    call $tmp7 := OAuth20NameSpace.ResourceServer.conclude$OAuth20NameSpace.ValidateTokenResponse($this, local_1_Ref);
    if ($tmp7)
    {
        assume {:breadcrumb 111} true;
        call $tmp8 := Alloc();
        call GenericAuthNameSpace.Resources.#ctor($tmp8);
        assume $DynamicType($tmp8) == T$GenericAuthNameSpace.Resources();
        assume $TypeConstructor($DynamicType($tmp8)) == T$GenericAuthNameSpace.Resources;
        local_2_Ref := $tmp8;
        call $tmp9 := Alloc();
        call System.Collections.Generic.HashSet`1.#ctor($tmp9);
        assume $DynamicType($tmp9) == T$System.Collections.Generic.HashSet`1(T$GenericAuthNameSpace.Resource());
        assume $TypeConstructor($DynamicType($tmp9)) == T$System.Collections.Generic.HashSet`1;
        assume T$T$System.Collections.Generic.HashSet`1($DynamicType($tmp9)) == T$GenericAuthNameSpace.Resource();
        F$GenericAuthNameSpace.Resources.resourceSet[local_2_Ref] := $tmp9;
        $tmp10 := req;
        assume $tmp10 != null;
        $tmp11 := F$OAuth20NameSpace.ResourceRequest.scope[$tmp10];
        assume $tmp11 != null;
        $tmp12 := F$GenericAuthNameSpace.Permissions.permissionSet[$tmp11];
        call $tmp13 := System.Collections.Generic.HashSet`1.GetEnumerator($tmp12);
        call local_7_Ref := System.Collections.Generic.HashSet.Enumerator.#copy_ctor($tmp13);
        goto IL_0073;

      IL_004b:
        call $tmp15 := System.Collections.Generic.HashSet`1.Enumerator.get_Current(local_7_Ref);
        $tmp14 := $tmp15;
        local_3_Ref := $tmp14;
        $tmp16 := local_2_Ref;
        assume $tmp16 != null;
        $tmp17 := F$GenericAuthNameSpace.Resources.resourceSet[$tmp16];
        call $tmp26 := OAuth20NameSpace.ResourceServer.get_ResourceRecs($this);
        if ($TypeConstructor($DynamicType($tmp26)) == T$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def)
        {
            call $tmp18 := OAuth20NameSpace.ResourceServer.get_ResourceRecs($this);
            if ($TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse)
            {
                call $tmp19 := OAuth20NameSpace.ValidateTokenResponse.get_UserID(local_1_Ref);
            }
            else
            {
                call $tmp20 := GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_UserID(local_1_Ref);
            }

            call $tmp21 := OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.getEntry$System.String$GenericAuthNameSpace.Permission($tmp18, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse then $tmp19 else $tmp20), local_3_Ref);
        }
        else
        {
            call $tmp22 := OAuth20NameSpace.ResourceServer.get_ResourceRecs($this);
            if ($TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse)
            {
                call $tmp23 := OAuth20NameSpace.ValidateTokenResponse.get_UserID(local_1_Ref);
            }
            else
            {
                call $tmp24 := GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_UserID(local_1_Ref);
            }

            call $tmp25 := GenericAuthNameSpace.RSResourceRecords_Base.getEntry$System.String$GenericAuthNameSpace.Permission($tmp22, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse then $tmp23 else $tmp24), local_3_Ref);
        }

        call $tmp27 := System.Collections.Generic.HashSet`1.Add$`0($tmp17, (if $TypeConstructor($DynamicType($tmp26)) == T$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def then $tmp21 else $tmp25));

      IL_0073:
        call $tmp28 := System.Collections.Generic.HashSet`1.Enumerator.MoveNext(local_7_Ref);
        if ($tmp28)
        {
            assume {:breadcrumb 113} true;
            goto IL_004b;
        }
        else
        {
            assume {:breadcrumb 114} true;
        }

        call $tmp29 := Alloc();
        call OAuth20NameSpace.ResourceResponse.#ctor($tmp29);
        assume $DynamicType($tmp29) == T$OAuth20NameSpace.ResourceResponse();
        assume $TypeConstructor($DynamicType($tmp29)) == T$OAuth20NameSpace.ResourceResponse;
        local_4_prime_Ref := $tmp29;
        $tmp30 := local_1_Ref;
        assume $tmp30 != null;
        F$OAuth20NameSpace.ResourceResponse.client_id[local_4_prime_Ref] := F$OAuth20NameSpace.ValidateTokenResponse.client_id[$tmp30];
        $tmp31 := local_1_Ref;
        assume $tmp31 != null;
        F$OAuth20NameSpace.ResourceResponse.access_token[local_4_prime_Ref] := F$OAuth20NameSpace.ValidateTokenResponse.access_token[$tmp31];
        F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.resources[local_4_prime_Ref] := local_2_Ref;
        $tmp32 := local_1_Ref;
        assume $tmp32 != null;
        F$CST.CST_Struct.SymT[local_4_prime_Ref] := F$CST.CST_Struct.SymT[$tmp32];
        local_5_Ref := local_4_prime_Ref;
    }
    else
    {
        assume {:breadcrumb 112} true;
        local_5_Ref := null;
        goto IL_00d3;
    }

  IL_00d3:
    $result := local_5_Ref;
    return;
}



procedure {:extern} GenericAuthNameSpace.RS.AuthorizationConclusion.#ctor($this: Ref);



function {:extern} T$GenericAuthNameSpace.RS.AuthorizationConclusion() : Ref;

const {:extern} unique T$GenericAuthNameSpace.RS.AuthorizationConclusion: int;

axiom $TypeConstructor(T$GenericAuthNameSpace.RS.AuthorizationConclusion()) == T$GenericAuthNameSpace.RS.AuthorizationConclusion;

var {:extern} F$GenericAuthNameSpace.RS.AuthorizationConclusion.UserID: [Ref]Ref;

var {:extern} F$GenericAuthNameSpace.RS.AuthorizationConclusion.permissions: [Ref]Ref;

procedure OAuth20NameSpace.ValidateTokenResponse.get_Realm($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_Realm($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.RS.AuthorizationConclusion.Realm: [Ref]Ref;

procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct$System.Boolean$System.Boolean(o$in: Ref, in_msg$in: Ref, out_msg$in: Ref, signed$in: bool, server_to_server$in: bool);



procedure {:extern} GenericAuthNameSpace.RS.RequestResourceDone$GenericAuthNameSpace.RS.AuthorizationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool);



implementation OAuth20NameSpace.ResourceServer.conclude$OAuth20NameSpace.ValidateTokenResponse($this: Ref, tresq$in: Ref) returns ($result: bool)
{
  var tresq: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var local_1_bool: bool;
  var $tmp6: bool;
  var $tmp7: bool;
  var $tmp8: bool;
  var $tmp9: bool;
  var $localExc: Ref;
  var $label: int;

    tresq := tresq$in;
    assume {:breadcrumb 115} true;
    call $tmp0 := Alloc();
    call GenericAuthNameSpace.RS.AuthorizationConclusion.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$GenericAuthNameSpace.RS.AuthorizationConclusion();
    assume $TypeConstructor($DynamicType($tmp0)) == T$GenericAuthNameSpace.RS.AuthorizationConclusion;
    local_0_Ref := $tmp0;
    if ($TypeConstructor($DynamicType(tresq)) == T$OAuth20NameSpace.ValidateTokenResponse)
    {
        call $tmp1 := OAuth20NameSpace.ValidateTokenResponse.get_UserID(tresq);
    }
    else
    {
        call $tmp2 := GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_UserID(tresq);
    }

    F$GenericAuthNameSpace.RS.AuthorizationConclusion.UserID[local_0_Ref] := (if $TypeConstructor($DynamicType(tresq)) == T$OAuth20NameSpace.ValidateTokenResponse then $tmp1 else $tmp2);
    $tmp3 := tresq;
    assume $tmp3 != null;
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.permissions[local_0_Ref] := F$OAuth20NameSpace.ValidateTokenResponse.scope[$tmp3];
    if ($TypeConstructor($DynamicType(tresq)) == T$OAuth20NameSpace.ValidateTokenResponse)
    {
        call $tmp4 := OAuth20NameSpace.ValidateTokenResponse.get_Realm(tresq);
    }
    else
    {
        call $tmp5 := GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_Realm(tresq);
    }

    F$GenericAuthNameSpace.RS.AuthorizationConclusion.Realm[local_0_Ref] := (if $TypeConstructor($DynamicType(tresq)) == T$OAuth20NameSpace.ValidateTokenResponse then $tmp4 else $tmp5);
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct$System.Boolean$System.Boolean($this, tresq, local_0_Ref, false, true);
    if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.For_vProgram)
    {
        call $tmp6 := OAuth20NameSpace.For_vProgram.RequestResourceDone$GenericAuthNameSpace.RS.AuthorizationConclusion($this, local_0_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.ResourceServerImpl)
        {
            call $tmp7 := GenericAuthNameSpace.RS.RequestResourceDone$GenericAuthNameSpace.RS.AuthorizationConclusion($this, local_0_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.ResourceServer)
            {
                call $tmp8 := GenericAuthNameSpace.RS.RequestResourceDone$GenericAuthNameSpace.RS.AuthorizationConclusion($this, local_0_Ref);
            }
            else
            {
                call $tmp9 := GenericAuthNameSpace.RS.RequestResourceDone$GenericAuthNameSpace.RS.AuthorizationConclusion($this, local_0_Ref);
            }
        }
    }

    local_1_bool := (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.For_vProgram then $tmp6 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.ResourceServerImpl then $tmp7 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.ResourceServer then $tmp8 else $tmp9)));
    goto IL_0040;

  IL_0040:
    $result := local_1_bool;
    return;
}



procedure OAuth20NameSpace.ResourceServer.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.RS.#ctor($this: Ref);



implementation OAuth20NameSpace.ResourceServer.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ResourceServer.TokenEndpointUrl[$this] := null;
    assume {:breadcrumb 116} true;
    call GenericAuthNameSpace.RS.#ctor($this);
}



procedure T$OAuth20NameSpace.ResourceServer.#cctor();



implementation T$OAuth20NameSpace.ResourceServer.#cctor()
{
}



function T$OAuth20NameSpace.ResourceRequest() : Ref;

const unique T$OAuth20NameSpace.ResourceRequest: int;

var F$OAuth20NameSpace.ResourceRequest.client_id: [Ref]Ref;

procedure OAuth20NameSpace.ResourceRequest.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceRequest.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 117} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ResourceRequest.access_token[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.ResourceRequest.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ResourceRequest.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 118} true;
    F$OAuth20NameSpace.ResourceRequest.access_token[$this] := value;
}



procedure OAuth20NameSpace.ResourceRequest.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 119} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ResourceRequest.client_id[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.ResourceRequest.set_Realm$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ResourceRequest.set_Realm$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 120} true;
    F$OAuth20NameSpace.ResourceRequest.client_id[$this] := value;
}



procedure OAuth20NameSpace.ResourceRequest.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.ReqResourceRS_Req.#ctor($this: Ref);



implementation OAuth20NameSpace.ResourceRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ResourceRequest.access_token[$this] := null;
    F$OAuth20NameSpace.ResourceRequest.client_id[$this] := null;
    F$OAuth20NameSpace.ResourceRequest.scope[$this] := null;
    assume {:breadcrumb 121} true;
    call GenericAuthNameSpace.ReqResourceRS_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.ResourceRequest.#cctor();



implementation T$OAuth20NameSpace.ResourceRequest.#cctor()
{
}



function T$OAuth20NameSpace.AuthorizationResponse() : Ref;

const unique T$OAuth20NameSpace.AuthorizationResponse: int;

var F$OAuth20NameSpace.AuthorizationResponse.code: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationResponse.state: [Ref]Ref;

procedure OAuth20NameSpace.AuthorizationResponse.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref);



implementation OAuth20NameSpace.AuthorizationResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AuthorizationResponse.code[$this] := null;
    F$OAuth20NameSpace.AuthorizationResponse.state[$this] := null;
    assume {:breadcrumb 122} true;
    F$OAuth20NameSpace.AuthorizationResponse.state[$this] := null;
    call GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationResponse.#cctor();



implementation T$OAuth20NameSpace.AuthorizationResponse.#cctor()
{
}



var F$OAuth20NameSpace.AccessTokenResponse.token_type: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenResponse.expires_in: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenResponse.client_id: [Ref]Ref;

procedure OAuth20NameSpace.AccessTokenResponse.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessTokenResponse.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 123} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AccessTokenResponse.access_token[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.AccessTokenResponse.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.AccessTokenResponse.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 124} true;
    F$OAuth20NameSpace.AccessTokenResponse.access_token[$this] := value;
}



procedure OAuth20NameSpace.AccessTokenResponse.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessTokenResponse.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 125} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AccessTokenResponse.client_id[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.AccessTokenResponse.set_Realm$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.AccessTokenResponse.set_Realm$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 126} true;
    F$OAuth20NameSpace.AccessTokenResponse.client_id[$this] := value;
}



procedure {:extern} GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#ctor($this: Ref);



implementation OAuth20NameSpace.AccessTokenResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AccessTokenResponse.access_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.token_type[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.expires_in[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.client_id[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.scope[$this] := null;
    assume {:breadcrumb 127} true;
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[$this] := null;
    call GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.AccessTokenResponse.#cctor();



implementation T$OAuth20NameSpace.AccessTokenResponse.#cctor()
{
}



function T$OAuth20NameSpace.AuthorizationErrorResponse() : Ref;

const unique T$OAuth20NameSpace.AuthorizationErrorResponse: int;

var F$OAuth20NameSpace.AuthorizationErrorResponse.error: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationErrorResponse.error_description: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationErrorResponse.error_uri: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationErrorResponse.state: [Ref]Ref;

procedure OAuth20NameSpace.AuthorizationErrorResponse.#ctor($this: Ref);



implementation OAuth20NameSpace.AuthorizationErrorResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AuthorizationErrorResponse.error[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_description[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.state[$this] := null;
    assume {:breadcrumb 128} true;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_description[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.state[$this] := null;
    call GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationErrorResponse.#cctor();



implementation T$OAuth20NameSpace.AuthorizationErrorResponse.#cctor()
{
}



function T$OAuth20NameSpace.NondetOAuth20() : Ref;

const unique T$OAuth20NameSpace.NondetOAuth20: int;

procedure OAuth20NameSpace.NondetOAuth20.ValidateTokenRequest($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.NondetOAuth20.ResourceResponse($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.NondetOAuth20.AccessTokenDictionary($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.NondetOAuth20.AccessTokenEntry($this: Ref) returns ($result: Ref);



function T$OAuth20NameSpace.AccessToken() : Ref;

const unique T$OAuth20NameSpace.AccessToken: int;

var F$OAuth20NameSpace.AccessToken.token: [Ref]Ref;

procedure OAuth20NameSpace.AccessToken.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessToken.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 129} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AccessToken.token[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.AccessToken.set_ticket$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.AccessToken.set_ticket$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 130} true;
    F$OAuth20NameSpace.AccessToken.token[$this] := value;
}



procedure OAuth20NameSpace.AccessToken.GetHashCode($this: Ref) returns ($result: int);



procedure {:extern} System.Object.GetHashCode($this: Ref) returns ($result: int);



implementation OAuth20NameSpace.AccessToken.GetHashCode($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $tmp0: Ref;
  var $tmp1: int;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 131} true;
    assume $this != null;
    $tmp0 := F$OAuth20NameSpace.AccessToken.token[$this];
    call $tmp1 := System.Object.GetHashCode($tmp0);
    local_0_int := $tmp1;
    goto IL_000f;

  IL_000f:
    $result := local_0_int;
    return;
}



procedure OAuth20NameSpace.AccessToken.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.Ticket.#ctor($this: Ref);



implementation OAuth20NameSpace.AccessToken.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AccessToken.token[$this] := null;
    assume {:breadcrumb 132} true;
    call GenericAuthNameSpace.Ticket.#ctor($this);
}



procedure T$OAuth20NameSpace.AccessToken.#cctor();



implementation T$OAuth20NameSpace.AccessToken.#cctor()
{
}



function T$OAuth20NameSpace.AccessTokenRecs() : Ref;

const unique T$OAuth20NameSpace.AccessTokenRecs: int;

procedure OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndAccessToken$System.String$System.String$System.String($this: Ref, client_id$in: Ref, UserID$in: Ref, access_token$in: Ref) returns ($result: Ref);



function T$OAuth20NameSpace.AccessTokenRequest() : Ref;

const unique T$OAuth20NameSpace.AccessTokenRequest: int;

var F$OAuth20NameSpace.AccessTokenRequest.refresh_token: [Ref]Ref;

procedure OAuth20NameSpace.AccessTokenRequest.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessTokenRequest.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 133} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AccessTokenRequest.access_token[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.AccessTokenRequest.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.AccessTokenRequest.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 134} true;
    F$OAuth20NameSpace.AccessTokenRequest.access_token[$this] := value;
}



procedure OAuth20NameSpace.AccessTokenRequest.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessTokenRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 135} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AccessTokenRequest.client_id[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.AccessTokenRequest.set_Realm$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.AccessTokenRequest.set_Realm$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 136} true;
    F$OAuth20NameSpace.AccessTokenRequest.client_id[$this] := value;
}



procedure OAuth20NameSpace.AccessTokenRequest.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.AuthTicketAS_Req.#ctor($this: Ref);



implementation OAuth20NameSpace.AccessTokenRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AccessTokenRequest.access_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.UserID[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.grant_type[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.code[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.client_id[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.refresh_token[$this] := null;
    assume {:breadcrumb 137} true;
    F$OAuth20NameSpace.AccessTokenRequest.refresh_token[$this] := null;
    call GenericAuthNameSpace.AuthTicketAS_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.AccessTokenRequest.#cctor();



implementation T$OAuth20NameSpace.AccessTokenRequest.#cctor()
{
}



var F$OAuth20NameSpace.ValidateTokenResponse.user: [Ref]Ref;

procedure OAuth20NameSpace.ValidateTokenResponse.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 138} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ValidateTokenResponse.access_token[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.ValidateTokenResponse.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 139} true;
    F$OAuth20NameSpace.ValidateTokenResponse.access_token[$this] := value;
}



procedure OAuth20NameSpace.ValidateTokenResponse.get_permissions($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.get_permissions($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 140} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ValidateTokenResponse.scope[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.ValidateTokenResponse.set_permissions$GenericAuthNameSpace.Permissions($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.set_permissions$GenericAuthNameSpace.Permissions($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 141} true;
    F$OAuth20NameSpace.ValidateTokenResponse.scope[$this] := value;
}



implementation OAuth20NameSpace.ValidateTokenResponse.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 142} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ValidateTokenResponse.client_id[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



implementation OAuth20NameSpace.ValidateTokenResponse.set_Realm$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 143} true;
    F$OAuth20NameSpace.ValidateTokenResponse.client_id[$this] := value;
}



implementation OAuth20NameSpace.ValidateTokenResponse.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 144} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ValidateTokenResponse.user[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



implementation OAuth20NameSpace.ValidateTokenResponse.set_UserID$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 145} true;
    F$OAuth20NameSpace.ValidateTokenResponse.user[$this] := value;
}



procedure {:extern} GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#ctor($this: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ValidateTokenResponse.access_token[$this] := null;
    F$OAuth20NameSpace.ValidateTokenResponse.scope[$this] := null;
    F$OAuth20NameSpace.ValidateTokenResponse.client_id[$this] := null;
    F$OAuth20NameSpace.ValidateTokenResponse.user[$this] := null;
    assume {:breadcrumb 146} true;
    call GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.ValidateTokenResponse.#cctor();



implementation T$OAuth20NameSpace.ValidateTokenResponse.#cctor()
{
}



function T$GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req() : Ref;

const unique T$GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req: int;

procedure GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_permissions($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_permissions$GenericAuthNameSpace.Permissions($this: Ref, value$in: Ref);



procedure {:extern} CST.CST_Struct.#ctor($this: Ref);



implementation GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 147} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#cctor();



implementation T$GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#cctor()
{
}



function T$GenericAuthNameSpace.RSResourceRecords_Base() : Ref;

const unique T$GenericAuthNameSpace.RSResourceRecords_Base: int;

procedure GenericAuthNameSpace.RSResourceRecords_Base.setEntry$System.String$GenericAuthNameSpace.Permission$GenericAuthNameSpace.Resource($this: Ref, UserID$in: Ref, permission$in: Ref, resource$in: Ref) returns ($result: bool);



function T$GenericAuthNameSpace.SignInIdP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Req: int;

procedure GenericAuthNameSpace.SignInIdP_Req.set_Realm$System.String($this: Ref, value$in: Ref);



implementation GenericAuthNameSpace.SignInIdP_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$this] := null;
    assume {:breadcrumb 148} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInIdP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Req.#cctor()
{
}



function T$GenericAuthNameSpace.Permissions() : Ref;

const unique T$GenericAuthNameSpace.Permissions: int;

procedure GenericAuthNameSpace.Permissions.#ctor($this: Ref);



implementation GenericAuthNameSpace.Permissions.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.Permissions.permissionSet[$this] := null;
    assume {:breadcrumb 149} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.Permissions.#cctor();



implementation T$GenericAuthNameSpace.Permissions.#cctor()
{
}



function T$GenericAuthNameSpace.ID_Claim() : Ref;

const unique T$GenericAuthNameSpace.ID_Claim: int;

procedure GenericAuthNameSpace.ID_Claim.get_UserID($this: Ref) returns ($result: Ref);



implementation GenericAuthNameSpace.ID_Claim.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 150} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.ID_Claim.#cctor();



implementation T$GenericAuthNameSpace.ID_Claim.#cctor()
{
}



function T$GenericAuthNameSpace.IdPAuthRecords_Base() : Ref;

const unique T$GenericAuthNameSpace.IdPAuthRecords_Base: int;

function T$GenericAuthNameSpace.AS() : Ref;

const unique T$GenericAuthNameSpace.AS: int;

procedure GenericAuthNameSpace.AS.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



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
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 151} true;
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := req;
    if (req == null)
    {
        assume {:breadcrumb 152} true;
        local_1_Ref := null;
    }
    else
    {
        assume {:breadcrumb 153} true;
        if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl)
        {
            call $tmp0 := OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer)
            {
                call $tmp1 := OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
            }
            else
            {
                call $tmp2 := GenericAuthNameSpace.AS.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
            }
        }

        local_0_Ref := (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl then $tmp0 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp1 else $tmp2));
        assume $this != null;
        $tmp3 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
        $tmp4 := req;
        assume $tmp4 != null;
        if ($TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest)
        {
            call $tmp5 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
        }
        else
        {
            call $tmp6 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
        }

        call $tmp7 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp3, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp4], (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp5 else $tmp6), local_0_Ref);
        if (!$tmp7)
        {
            assume {:breadcrumb 154} true;
            local_1_Ref := null;
        }
        else
        {
            assume {:breadcrumb 155} true;
            if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl)
            {
                if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                {
                    call $tmp8 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
                }
                else
                {
                    call $tmp9 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
                }

                call $tmp10 := OAuth20NameSpace.AuthorizationServerImpl.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp8 else $tmp9), local_0_Ref);
                if ($Exception != null)
                {
                    return;
                }
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer)
                {
                    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                    {
                        call $tmp11 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
                    }
                    else
                    {
                        call $tmp12 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
                    }

                    call $tmp13 := GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp11 else $tmp12), local_0_Ref);
                }
                else
                {
                    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                    {
                        call $tmp14 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
                    }
                    else
                    {
                        call $tmp15 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
                    }

                    call $tmp16 := GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp14 else $tmp15), local_0_Ref);
                }
            }

            local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServerImpl then $tmp10 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp13 else $tmp16));
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
    assume {:breadcrumb 156} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.AS.#cctor();



implementation T$GenericAuthNameSpace.AS.#cctor()
{
}



function T$GenericAuthNameSpace.ValidateTicket_Req() : Ref;

const unique T$GenericAuthNameSpace.ValidateTicket_Req: int;

procedure GenericAuthNameSpace.ValidateTicket_Req.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.set_Realm$System.String($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.set_permissions$GenericAuthNameSpace.Permissions($this: Ref, value$in: Ref);



implementation GenericAuthNameSpace.ValidateTicket_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 157} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.ValidateTicket_Req.#cctor();



implementation T$GenericAuthNameSpace.ValidateTicket_Req.#cctor()
{
}



function T$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req() : Ref;

const unique T$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req: int;

var F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.UserID: [Ref]Ref;

procedure GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.set_Realm$System.String($this: Ref, value$in: Ref);



implementation GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.resources[$this] := null;
    F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.UserID[$this] := null;
    assume {:breadcrumb 158} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#cctor();



implementation T$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#cctor()
{
}



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
    assume {:breadcrumb 159} true;
    if (obj == null)
    {
        assume {:breadcrumb 160} true;
        local_1_bool := false;
    }
    else
    {
        assume {:breadcrumb 161} true;
        local_0_Ref := $As(obj, T$GenericAuthNameSpace.Permission());
        if (local_0_Ref == null)
        {
            assume {:breadcrumb 162} true;
            local_1_bool := false;
        }
        else
        {
            assume {:breadcrumb 163} true;
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



implementation GenericAuthNameSpace.Permission.GetHashCode($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $tmp0: Ref;
  var $tmp1: int;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 164} true;
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
    assume {:breadcrumb 165} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.Permission.#cctor();



implementation T$GenericAuthNameSpace.Permission.#cctor()
{
}



function T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req: int;

implementation GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 166} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor()
{
}



function T$GenericAuthNameSpace.GlobalObjects_base() : Ref;

const unique T$GenericAuthNameSpace.GlobalObjects_base: int;

var F$GenericAuthNameSpace.GlobalObjects_base.RP: Ref;

procedure GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion$in: Ref);



var F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID: [Ref]Ref;

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
  var $tmp8: bool;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: bool;
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 167} true;
    $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
    assume $tmp0 != null;
    $tmp1 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$tmp0];
    $tmp2 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
    assume $tmp2 != null;
    $tmp3 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp3 != null;
    call $tmp4 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp1, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp2], F$GenericAuthNameSpace.RP.Realm[$tmp3]);
    local_0_Ref := $tmp4;
    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
    {
        call $tmp9 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
    }
    else
    {
        call $tmp10 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
    }

    $tmp11 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp11 != null;
    call $tmp12 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp9 else $tmp10), F$GenericAuthNameSpace.RP.Domain[$tmp11]);
    if ($tmp12)
    {
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
        {
            call $tmp5 := OAuth20NameSpace.AuthorizationCodeEntry.get_UserID(local_0_Ref);
        }
        else
        {
            call $tmp6 := GenericAuthNameSpace.ID_Claim.get_UserID(local_0_Ref);
        }

        $tmp7 := conclusion;
        assume $tmp7 != null;
        call $tmp8 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp5 else $tmp6), F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp7]);
    }
    else
    {
    }

    assert (if $tmp12 then $tmp8 else false);
}



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
  var $tmp20: bool;
  var $tmp21: Ref;
  var $tmp22: Ref;
  var $tmp23: Ref;
  var $tmp24: bool;
  var $tmp25: Ref;
  var $tmp26: Ref;
  var $tmp27: Ref;
  var $tmp28: Ref;
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 168} true;
    $tmp16 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
    assume $tmp16 != null;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.ASAuthRecs[$tmp16])) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def)
    {
        $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
        assume $tmp0 != null;
        $tmp1 := F$GenericAuthNameSpace.AS.ASAuthRecs[$tmp0];
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest)
        {
            call $tmp2 := OAuth20NameSpace.ValidateTokenRequest.get_ticket(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
        }
        else
        {
            call $tmp3 := GenericAuthNameSpace.ValidateTicket_Req.get_ticket(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
        }

        $tmp4 := F$GenericAuthNameSpace.GlobalObjects_base.RS;
        assume $tmp4 != null;
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest)
        {
            call $tmp5 := OAuth20NameSpace.ValidateTokenRequest.get_UserID(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
        }
        else
        {
            call $tmp6 := GenericAuthNameSpace.ValidateTicket_Req.get_UserID(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
        }

        call $tmp7 := OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp1, (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp2 else $tmp3), F$GenericAuthNameSpace.RS.Realm[$tmp4], (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp5 else $tmp6));
    }
    else
    {
        $tmp8 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
        assume $tmp8 != null;
        $tmp9 := F$GenericAuthNameSpace.AS.ASAuthRecs[$tmp8];
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest)
        {
            call $tmp10 := OAuth20NameSpace.ValidateTokenRequest.get_ticket(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
        }
        else
        {
            call $tmp11 := GenericAuthNameSpace.ValidateTicket_Req.get_ticket(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
        }

        $tmp12 := F$GenericAuthNameSpace.GlobalObjects_base.RS;
        assume $tmp12 != null;
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest)
        {
            call $tmp13 := OAuth20NameSpace.ValidateTokenRequest.get_UserID(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
        }
        else
        {
            call $tmp14 := GenericAuthNameSpace.ValidateTicket_Req.get_UserID(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
        }

        call $tmp15 := GenericAuthNameSpace.ASAuthTicketRecords_Base.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp9, (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp10 else $tmp11), F$GenericAuthNameSpace.RS.Realm[$tmp12], (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp13 else $tmp14));
    }

    local_0_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.ASAuthRecs[$tmp16])) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def then $tmp7 else $tmp15);
    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
    {
        call $tmp25 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
    }
    else
    {
        call $tmp26 := GenericAuthNameSpace.Permission_Claim.get_permissions(local_0_Ref);
    }

    assume (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp25 else $tmp26) != null;
    $tmp27 := conclusion;
    assume $tmp27 != null;
    $tmp28 := F$GenericAuthNameSpace.RS.AuthorizationConclusion.permissions[$tmp27];
    assume $tmp28 != null;
    if (!(F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp25 else $tmp26)] != F$GenericAuthNameSpace.Permissions.permissionSet[$tmp28]))
    {
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
        {
            call $tmp21 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
        }
        else
        {
            call $tmp22 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
        }

        $tmp23 := F$GenericAuthNameSpace.GlobalObjects_base.RS;
        assume $tmp23 != null;
        call $tmp24 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp21 else $tmp22), F$GenericAuthNameSpace.RS.Realm[$tmp23]);
    }
    else
    {
    }

    if ((if !(F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp25 else $tmp26)] != F$GenericAuthNameSpace.Permissions.permissionSet[$tmp28]) then $tmp24 else false))
    {
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
        {
            call $tmp17 := OAuth20NameSpace.AccessTokenEntry.get_UserID(local_0_Ref);
        }
        else
        {
            call $tmp18 := GenericAuthNameSpace.Permission_Claim.get_UserID(local_0_Ref);
        }

        $tmp19 := conclusion;
        assume $tmp19 != null;
        call $tmp20 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp17 else $tmp18), F$GenericAuthNameSpace.RS.AuthorizationConclusion.UserID[$tmp19]);
    }
    else
    {
    }

    assert (if (if !(F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp25 else $tmp26)] != F$GenericAuthNameSpace.Permissions.permissionSet[$tmp28]) then $tmp24 else false) then $tmp20 else false);
}



implementation GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 169} true;
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



function T$GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req() : Ref;

const unique T$GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req: int;

procedure GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.set_Realm$System.String($this: Ref, value$in: Ref);



implementation GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 170} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#cctor();



implementation T$GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#cctor()
{
}



function T$GenericAuthNameSpace.RP() : Ref;

const unique T$GenericAuthNameSpace.RP: int;

var F$GenericAuthNameSpace.RP.CurrentSession: [Ref]Ref;

procedure GenericAuthNameSpace.RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool);



procedure {:extern} System.Diagnostics.Stopwatch.#ctor($this: Ref);



function {:extern} T$System.Diagnostics.Stopwatch() : Ref;

const {:extern} unique T$System.Diagnostics.Stopwatch: int;

axiom $TypeConstructor(T$System.Diagnostics.Stopwatch()) == T$System.Diagnostics.Stopwatch;

procedure {:extern} System.Diagnostics.Stopwatch.Start($this: Ref);



procedure {:extern} CST.CST_Ops.CertifyLocally$CST.CST_Struct(msg$in: Ref) returns ($result: bool);



procedure {:extern} System.Diagnostics.Stopwatch.Stop($this: Ref);



const {:value "C:\Users\Daniel Song\Desktop\Certify.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$Certify.txt_7: Ref;

procedure {:extern} System.IO.File.Exists$System.String(path$in: Ref) returns ($result: bool);



procedure {:extern} System.IO.File.CreateText$System.String(path$in: Ref) returns ($result: Ref);



procedure {:extern} System.Diagnostics.Stopwatch.get_ElapsedMilliseconds($this: Ref) returns ($result: int);



procedure {:extern} System.IO.TextWriter.WriteLine$System.Int64($this: Ref, value$in: int);



procedure {:extern} System.IO.File.AppendText$System.String(path$in: Ref) returns ($result: Ref);



const {:value "UserID"} unique $string_literal_UserID_8: Ref;

procedure {:extern} System.Web.HttpSessionStateBase.get_Item$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



const {:value ""} unique $string_literal__9: Ref;

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
    assume {:breadcrumb 171} true;
    call $tmp0 := Alloc();
    call System.Diagnostics.Stopwatch.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Diagnostics.Stopwatch();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Diagnostics.Stopwatch;
    local_0_Ref := $tmp0;
    call System.Diagnostics.Stopwatch.Start(local_0_Ref);
    call $tmp1 := CST.CST_Ops.CertifyLocally$CST.CST_Struct(conclusion);
    local_1_bool := $tmp1;
    call System.Diagnostics.Stopwatch.Stop(local_0_Ref);
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$Certify.txt_7;
    call $tmp2 := System.IO.File.Exists$System.String(local_2_Ref);
    if (!$tmp2)
    {
        assume {:breadcrumb 172} true;
        call $tmp3 := System.IO.File.CreateText$System.String(local_2_Ref);
        local_3_Ref := $tmp3;
        call $tmp4 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp4);
    }
    else
    {
        assume {:breadcrumb 173} true;
        call $tmp5 := System.IO.File.AppendText$System.String(local_2_Ref);
        local_3_Ref := $tmp5;
        call $tmp6 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp6);
    }

    assume $this != null;
    $tmp7 := F$GenericAuthNameSpace.RP.CurrentSession[$this];
    call $tmp8 := System.Web.HttpSessionStateBase.get_Item$System.String($tmp7, $string_literal_UserID_8);
    if ($tmp8 != null)
    {
        assume {:breadcrumb 174} true;
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

        call System.Web.HttpSessionStateBase.set_Item$System.String$System.Object($tmp9, $string_literal_UserID_8, (if local_1_bool then F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp10] else $string_literal__9));
    }
    else
    {
        assume {:breadcrumb 175} true;
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

        call System.Web.HttpSessionStateBase.Add$System.String$System.Object($tmp11, $string_literal_UserID_8, (if local_1_bool then F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp12] else $string_literal__9));
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
    assume {:breadcrumb 176} true;
    call System.Object.#ctor($this);
}



function T$GenericAuthNameSpace.RP.AuthenticationConclusion() : Ref;

const unique T$GenericAuthNameSpace.RP.AuthenticationConclusion: int;

procedure GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref);



implementation GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$this] := null;
    assume {:breadcrumb 177} true;
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



function T$GenericAuthNameSpace.Permission_Claim() : Ref;

const unique T$GenericAuthNameSpace.Permission_Claim: int;

procedure GenericAuthNameSpace.Permission_Claim.get_Redir_dest($this: Ref) returns ($result: Ref);



implementation GenericAuthNameSpace.Permission_Claim.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 178} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.Permission_Claim.#cctor();



implementation T$GenericAuthNameSpace.Permission_Claim.#cctor()
{
}



var F$GenericAuthNameSpace.Resource.name: [Ref]Ref;

procedure GenericAuthNameSpace.Resource.get_value($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.Resource.set_value$System.Object($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.Resource.#ctor($this: Ref);



implementation GenericAuthNameSpace.Resource.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.Resource.name[$this] := null;
    assume {:breadcrumb 179} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.Resource.#cctor();



implementation T$GenericAuthNameSpace.Resource.#cctor()
{
}



function T$GenericAuthNameSpace.AuthTicketAS_Req() : Ref;

const unique T$GenericAuthNameSpace.AuthTicketAS_Req: int;

procedure GenericAuthNameSpace.AuthTicketAS_Req.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Req.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Req.set_Realm$System.String($this: Ref, value$in: Ref);



implementation GenericAuthNameSpace.AuthTicketAS_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 180} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.AuthTicketAS_Req.#cctor();



implementation T$GenericAuthNameSpace.AuthTicketAS_Req.#cctor()
{
}



function T$GenericAuthNameSpace.ReqResourceRS_Req() : Ref;

const unique T$GenericAuthNameSpace.ReqResourceRS_Req: int;

var F$GenericAuthNameSpace.ReqResourceRS_Req.resource: [Ref]Ref;

procedure GenericAuthNameSpace.ReqResourceRS_Req.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ReqResourceRS_Req.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ReqResourceRS_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ReqResourceRS_Req.set_Realm$System.String($this: Ref, value$in: Ref);



implementation GenericAuthNameSpace.ReqResourceRS_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.ReqResourceRS_Req.resource[$this] := null;
    F$GenericAuthNameSpace.ReqResourceRS_Req.UserID[$this] := null;
    assume {:breadcrumb 181} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.ReqResourceRS_Req.#cctor();



implementation T$GenericAuthNameSpace.ReqResourceRS_Req.#cctor()
{
}



function T$GenericAuthNameSpace.ASAuthTicketRecords_Base() : Ref;

const unique T$GenericAuthNameSpace.ASAuthTicketRecords_Base: int;

function T$GenericAuthNameSpace.RS() : Ref;

const unique T$GenericAuthNameSpace.RS: int;

var F$GenericAuthNameSpace.RS.Domain: [Ref]Ref;

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
    assume {:breadcrumb 182} true;
    call $tmp0 := Alloc();
    call System.Diagnostics.Stopwatch.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Diagnostics.Stopwatch();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Diagnostics.Stopwatch;
    local_0_Ref := $tmp0;
    call System.Diagnostics.Stopwatch.Start(local_0_Ref);
    call $tmp1 := CST.CST_Ops.CertifyLocally$CST.CST_Struct(conclusion);
    local_1_bool := $tmp1;
    call System.Diagnostics.Stopwatch.Stop(local_0_Ref);
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$Certify.txt_7;
    call $tmp2 := System.IO.File.Exists$System.String(local_2_Ref);
    if (!$tmp2)
    {
        assume {:breadcrumb 183} true;
        call $tmp3 := System.IO.File.CreateText$System.String(local_2_Ref);
        local_3_Ref := $tmp3;
        call $tmp4 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp4);
    }
    else
    {
        assume {:breadcrumb 184} true;
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



implementation GenericAuthNameSpace.RS.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RS.RSResourceRecs[$this] := null;
    F$GenericAuthNameSpace.RS.Domain[$this] := null;
    F$GenericAuthNameSpace.RS.Realm[$this] := null;
    assume {:breadcrumb 185} true;
    call System.Object.#ctor($this);
}



var F$GenericAuthNameSpace.RS.AuthorizationConclusion.ticket: [Ref]Ref;

implementation GenericAuthNameSpace.RS.AuthorizationConclusion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RS.AuthorizationConclusion.ticket[$this] := null;
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.permissions[$this] := null;
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.Realm[$this] := null;
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.UserID[$this] := null;
    assume {:breadcrumb 186} true;
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



function T$GenericAuthNameSpace.Ticket() : Ref;

const unique T$GenericAuthNameSpace.Ticket: int;

procedure GenericAuthNameSpace.Ticket.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.Ticket.set_ticket$System.String($this: Ref, value$in: Ref);



implementation GenericAuthNameSpace.Ticket.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 187} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.Ticket.#cctor();



implementation T$GenericAuthNameSpace.Ticket.#cctor()
{
}



implementation GenericAuthNameSpace.Resources.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.Resources.resourceSet[$this] := null;
    assume {:breadcrumb 188} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.Resources.#cctor();



implementation T$GenericAuthNameSpace.Resources.#cctor()
{
}



function T$GenericAuthNameSpace.SignInRP_Resp() : Ref;

const unique T$GenericAuthNameSpace.SignInRP_Resp: int;

procedure GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref);



implementation GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 189} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInRP_Resp.#cctor();



implementation T$GenericAuthNameSpace.SignInRP_Resp.#cctor()
{
}



var F$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary: [Ref]Ref;

implementation OAuth20NameSpace.AuthorizationServerImpl.init($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 190} true;
    assume $this != null;
    call OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AccessTokenRecs($this, F$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary[$this]);
}



procedure {:extern} System.NotImplementedException.#ctor($this: Ref);



function {:extern} T$System.NotImplementedException() : Ref;

const {:extern} unique T$System.NotImplementedException: int;

axiom $TypeConstructor(T$System.NotImplementedException()) == T$System.NotImplementedException;

implementation OAuth20NameSpace.AuthorizationServerImpl.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref)
{
  var dest: Ref;
  var _ID_Claim: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    dest := dest$in;
    _ID_Claim := _ID_Claim$in;
    assume {:breadcrumb 191} true;
    call $tmp0 := Alloc();
    call System.NotImplementedException.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.NotImplementedException();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.NotImplementedException;
    $Exception := $tmp0;
    return;
}



implementation OAuth20NameSpace.AuthorizationServerImpl.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this: Ref, redirect_uri$in: Ref, scope$in: Ref, state$in: Ref) returns ($result: Ref)
{
  var redirect_uri: Ref;
  var scope: Ref;
  var state: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    redirect_uri := redirect_uri$in;
    scope := scope$in;
    state := state$in;
    assume {:breadcrumb 192} true;
    call $tmp0 := Alloc();
    call System.NotImplementedException.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.NotImplementedException();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.NotImplementedException;
    $Exception := $tmp0;
    return;
}



implementation OAuth20NameSpace.AuthorizationServerImpl.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 193} true;
    call $tmp0 := Alloc();
    call System.NotImplementedException.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.NotImplementedException();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.NotImplementedException;
    $Exception := $tmp0;
    return;
}



procedure OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.#ctor($this: Ref);



implementation OAuth20NameSpace.AuthorizationServerImpl.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary[$this] := null;
    assume {:breadcrumb 194} true;
    call $tmp0 := Alloc();
    call OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def;
    F$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary[$this] := $tmp0;
    call OAuth20NameSpace.AuthorizationServer.#ctor($this);
}



var F$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.dict: [Ref]Ref;

procedure {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0($this: Ref, key$in: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($this: Ref, ticket$in: Ref, Realm$in: Ref, UserID$in: Ref) returns ($result: Ref)
{
  var ticket: Ref;
  var Realm: Ref;
  var UserID: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var local_2_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    ticket := ticket$in;
    Realm := Realm$in;
    UserID := UserID$in;
    assume {:breadcrumb 195} true;
    assume $this != null;
    $tmp0 := F$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.dict[$this];
    call $tmp2 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp0, ticket);
    $tmp1 := $tmp2;
    call $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp1, Realm);
    $tmp3 := $tmp4;
    call $tmp6 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp3, UserID);
    $tmp5 := $tmp6;
    local_1_Ref := $tmp5;
    assume $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    local_2_Ref := local_1_Ref;
    goto IL_0040;

  IL_0040:
    $result := local_2_Ref;
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

procedure {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1($this: Ref, key$in: Ref, value$in: Ref);



implementation OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($this: Ref, ticket$in: Ref, Realm$in: Ref, UserID$in: Ref, claim$in: Ref) returns ($result: bool)
{
  var ticket: Ref;
  var Realm: Ref;
  var UserID: Ref;
  var claim: Ref;
  var local_0_Ref: Ref;
  var local_1_Ref: Ref;
  var local_2_bool: bool;
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
  var $localExc: Ref;
  var $label: int;

    ticket := ticket$in;
    Realm := Realm$in;
    UserID := UserID$in;
    claim := claim$in;
    assume {:breadcrumb 196} true;
    local_0_Ref := ticket;
    local_1_Ref := claim;
    if (local_0_Ref == null)
    {
    }
    else
    {
    }

    if ((if local_0_Ref == null then claim == null else false))
    {
        assume {:breadcrumb 197} true;
        local_2_bool := false;
    }
    else
    {
        assume {:breadcrumb 198} true;
        assume $this != null;
        $tmp0 := F$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.dict[$this];
        call $tmp1 := Alloc();
        call System.Collections.Generic.Dictionary`2.#ctor($tmp1);
        assume $DynamicType($tmp1) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AccessTokenEntry()));
        assume $TypeConstructor($DynamicType($tmp1)) == T$System.Collections.Generic.Dictionary`2;
        assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp1)) == T$System.String();
        assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp1)) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AccessTokenEntry());
        call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp0, local_0_Ref, $tmp1);
        assume $this != null;
        $tmp2 := F$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.dict[$this];
        call $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp2, local_0_Ref);
        $tmp3 := $tmp4;
        call $tmp5 := Alloc();
        call System.Collections.Generic.Dictionary`2.#ctor($tmp5);
        assume $DynamicType($tmp5) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AccessTokenEntry());
        assume $TypeConstructor($DynamicType($tmp5)) == T$System.Collections.Generic.Dictionary`2;
        assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp5)) == T$System.String();
        assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp5)) == T$OAuth20NameSpace.AccessTokenEntry();
        call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp3, Realm, $tmp5);
        assume $this != null;
        $tmp6 := F$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.dict[$this];
        call $tmp8 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp6, local_0_Ref);
        $tmp7 := $tmp8;
        call $tmp10 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp7, Realm);
        $tmp9 := $tmp10;
        call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp9, UserID, local_1_Ref);
        local_2_bool := true;
        goto IL_006f;
    }

  IL_006f:
    $result := local_2_bool;
    return;
}



procedure OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.findISSByClientIDAndAccessToken$System.String$System.String$System.String($this: Ref, client_id$in: Ref, UserID$in: Ref, access_token$in: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.findISSByClientIDAndAccessToken$System.String$System.String$System.String($this: Ref, client_id$in: Ref, UserID$in: Ref, access_token$in: Ref) returns ($result: Ref)
{
  var client_id: Ref;
  var UserID: Ref;
  var access_token: Ref;
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    client_id := client_id$in;
    UserID := UserID$in;
    access_token := access_token$in;
    assume {:breadcrumb 199} true;
    local_0_Ref := null;
    goto IL_0005;

  IL_0005:
    $result := local_0_Ref;
    return;
}



implementation OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.findISSByClientIDAndRefreshToken$System.String$System.String$System.String($this: Ref, client_id$in: Ref, UserID$in: Ref, refresh_token$in: Ref) returns ($result: Ref)
{
  var client_id: Ref;
  var UserID: Ref;
  var refresh_token: Ref;
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    client_id := client_id$in;
    UserID := UserID$in;
    refresh_token := refresh_token$in;
    assume {:breadcrumb 200} true;
    local_0_Ref := null;
    goto IL_0005;

  IL_0005:
    $result := local_0_Ref;
    return;
}



implementation OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.dict[$this] := null;
    assume {:breadcrumb 201} true;
    call $tmp0 := Alloc();
    call System.Collections.Generic.Dictionary`2.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.Dictionary`2(T$OAuth20NameSpace.AccessToken(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AccessTokenEntry())));
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$OAuth20NameSpace.AccessToken();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AccessTokenEntry()));
    F$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.dict[$this] := $tmp0;
    call System.Object.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.#cctor();



implementation T$OAuth20NameSpace.AuthorizationServerImpl.AccessTokenDictionary_def.#cctor()
{
}



procedure T$OAuth20NameSpace.AuthorizationServerImpl.#cctor();



implementation T$OAuth20NameSpace.AuthorizationServerImpl.#cctor()
{
}



function T$FacebookGraphApiExample.Facebook_GraphAuth() : Ref;

const unique T$FacebookGraphApiExample.Facebook_GraphAuth: int;

var F$FacebookGraphApiExample.Facebook_GraphAuth.client_id: Ref;

var F$FacebookGraphApiExample.Facebook_GraphAuth.user_id: Ref;

var F$FacebookGraphApiExample.Facebook_GraphAuth.client_secret: Ref;

var F$FacebookGraphApiExample.Facebook_GraphAuth.realm: Ref;

var F$FacebookGraphApiExample.Facebook_GraphAuth.redirect_uri: Ref;

var F$FacebookGraphApiExample.Facebook_GraphAuth.RS: [Ref]Ref;

var F$FacebookGraphApiExample.Facebook_GraphAuth.form1: [Ref]Ref;

var F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn: [Ref]Ref;

var F$FacebookGraphApiExample.Facebook_GraphAuth.Login: [Ref]Ref;

var F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn: [Ref]Ref;

var F$FacebookGraphApiExample.Facebook_GraphAuth.email: [Ref]Ref;

var F$FacebookGraphApiExample.Facebook_GraphAuth.Logout: [Ref]Ref;

procedure FacebookGraphApiExample.Facebook_GraphAuth.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



procedure {:extern} System.Web.UI.Page.get_Request($this: Ref) returns ($result: Ref);



procedure {:extern} System.Web.HttpRequest.get_Params($this: Ref) returns ($result: Ref);



const {:value "access_token"} unique $string_literal_access_token_10: Ref;

procedure {:extern} System.Collections.Specialized.NameValueCollection.get_Item$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



procedure {:extern} System.String.IsNullOrEmpty$System.String(value$in: Ref) returns ($result: bool);



procedure OAuth20NameSpace.ResourceServerImpl.setCode$System.String($this: Ref, code$in: Ref);



var F$OAuth20NameSpace.ResourceServerImpl.get_token_url: [Ref]Ref;

procedure {:extern} System.Net.WebRequest.Create$System.String(requestUriString$in: Ref) returns ($result: Ref);



procedure {:extern} System.Net.WebRequest.GetResponse($this: Ref) returns ($result: Ref);



function T$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture() : Ref;

const unique T$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture: int;

procedure {:extern} System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($this: Ref, type$in: Ref);



function {:extern} T$System.Runtime.Serialization.Json.DataContractJsonSerializer() : Ref;

const {:extern} unique T$System.Runtime.Serialization.Json.DataContractJsonSerializer: int;

axiom $TypeConstructor(T$System.Runtime.Serialization.Json.DataContractJsonSerializer()) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;

procedure FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.#ctor($this: Ref);



procedure {:extern} System.Net.WebResponse.GetResponseStream($this: Ref) returns ($result: Ref);



procedure {:extern} System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream($this: Ref, stream$in: Ref) returns ($result: Ref);



procedure {:System.Runtime.CompilerServices.CompilerGenerated} FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.get_AccessToken($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.ResourceServerImpl.EmailPermission.#ctor($this: Ref);



function T$OAuth20NameSpace.ResourceServerImpl.EmailPermission() : Ref;

const unique T$OAuth20NameSpace.ResourceServerImpl.EmailPermission: int;

const {:value "verification failed"} unique $string_literal_verification$failed_11: Ref;

procedure {:extern} System.Web.UI.HtmlControls.HtmlContainerControl.set_InnerHtml$System.String($this: Ref, value$in: Ref);



const {:value "John's email is "} unique $string_literal_John's$email$is$_12: Ref;

procedure {:extern} System.Linq.Enumerable.First``1$System.Collections.Generic.IEnumerable$``0$(source$in: Ref, TSource: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.ResourceServerImpl.EmailResource.get_value($this: Ref) returns ($result: Ref);



function T$OAuth20NameSpace.ResourceServerImpl.EmailResource() : Ref;

const unique T$OAuth20NameSpace.ResourceServerImpl.EmailResource: int;

procedure {:extern} System.String.Concat$System.Object$System.Object(arg0$in: Ref, arg1$in: Ref) returns ($result: Ref);



procedure {:extern} System.Web.UI.Page.set_Visible$System.Boolean($this: Ref, value$in: bool);



function {:extern} T$System.Web.UI.Page() : Ref;

const {:extern} unique T$System.Web.UI.Page: int;

axiom $TypeConstructor(T$System.Web.UI.Page()) == T$System.Web.UI.Page;

function {:extern} T$System.Web.UI.TemplateControl() : Ref;

const {:extern} unique T$System.Web.UI.TemplateControl: int;

axiom $TypeConstructor(T$System.Web.UI.TemplateControl()) == T$System.Web.UI.TemplateControl;

procedure {:extern} System.Web.UI.Control.set_Visible$System.Boolean($this: Ref, value$in: bool);



implementation FacebookGraphApiExample.Facebook_GraphAuth.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
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
  var $tmp6: bool;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var local_4_Ref: Ref;
  var $tmp11: Ref;
  var local_5_Ref: Ref;
  var $tmp12: Ref;
  var local_6_Ref: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var local_7_Ref: Ref;
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
  var $tmp26: bool;
  var $tmp27: Ref;
  var $tmp28: Ref;
  var local_8_Ref: Ref;
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
  var $tmp46: bool;
  var $tmp47: Ref;
  var $tmp48: Ref;
  var $tmp49: Ref;
  var $tmp50: Ref;
  var $tmp51: Ref;
  var $tmp52: Ref;
  var $tmp53: Ref;
  var $tmp54: Ref;
  var $tmp55: Ref;
  var $tmp56: Ref;
  var $tmp57: Ref;
  var $tmp58: Ref;
  var $tmp59: Ref;
  var $tmp60: Ref;
  var $tmp61: Ref;
  var $tmp62: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 202} true;
    call $tmp0 := System.Web.UI.Page.get_Request($this);
    call $tmp1 := System.Web.HttpRequest.get_Params($tmp0);
    call $tmp2 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp1, $string_literal_access_token_10);
    local_1_Ref := $tmp2;
    call $tmp3 := System.Web.UI.Page.get_Request($this);
    call $tmp4 := System.Web.HttpRequest.get_Params($tmp3);
    call $tmp5 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp4, $string_literal_code_0);
    local_2_Ref := $tmp5;
    call $tmp6 := System.String.IsNullOrEmpty$System.String(local_2_Ref);
    if (!$tmp6)
    {
        assume {:breadcrumb 203} true;
        assume $this != null;
        $tmp7 := F$FacebookGraphApiExample.Facebook_GraphAuth.RS[$this];
        call OAuth20NameSpace.ResourceServerImpl.setCode$System.String($tmp7, local_2_Ref);
        assume $this != null;
        $tmp8 := F$FacebookGraphApiExample.Facebook_GraphAuth.RS[$this];
        assume $tmp8 != null;
        call $tmp9 := System.Net.WebRequest.Create$System.String(F$OAuth20NameSpace.ResourceServerImpl.get_token_url[$tmp8]);
        call $tmp10 := System.Net.WebRequest.GetResponse($tmp9);
        local_4_Ref := $tmp10;
        call $tmp11 := Alloc();
        call System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($tmp11, T$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture());
        assume $DynamicType($tmp11) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer();
        assume $TypeConstructor($DynamicType($tmp11)) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;
        local_5_Ref := $tmp11;
        call $tmp12 := Alloc();
        call FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.#ctor($tmp12);
        assume $DynamicType($tmp12) == T$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture();
        assume $TypeConstructor($DynamicType($tmp12)) == T$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture;
        local_6_Ref := $tmp12;
        call $tmp13 := System.Net.WebResponse.GetResponseStream(local_4_Ref);
        call $tmp14 := System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream(local_5_Ref, $tmp13);
        local_6_Ref := $As($tmp14, T$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture());
        call $tmp15 := Alloc();
        call OAuth20NameSpace.ResourceRequest.#ctor($tmp15);
        assume $DynamicType($tmp15) == T$OAuth20NameSpace.ResourceRequest();
        assume $TypeConstructor($DynamicType($tmp15)) == T$OAuth20NameSpace.ResourceRequest;
        local_7_Ref := $tmp15;
        call $tmp16 := Alloc();
        call OAuth20NameSpace.AccessToken.#ctor($tmp16);
        assume $DynamicType($tmp16) == T$OAuth20NameSpace.AccessToken();
        assume $TypeConstructor($DynamicType($tmp16)) == T$OAuth20NameSpace.AccessToken;
        F$OAuth20NameSpace.ResourceRequest.access_token[local_7_Ref] := $tmp16;
        call $tmp17 := FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.get_AccessToken(local_6_Ref);
        $tmp18 := local_7_Ref;
        assume $tmp18 != null;
        F$OAuth20NameSpace.AccessToken.token[F$OAuth20NameSpace.ResourceRequest.access_token[$tmp18]] := $tmp17;
        F$GenericAuthNameSpace.ReqResourceRS_Req.UserID[local_7_Ref] := F$FacebookGraphApiExample.Facebook_GraphAuth.user_id;
        call $tmp19 := Alloc();
        call GenericAuthNameSpace.Permissions.#ctor($tmp19);
        assume $DynamicType($tmp19) == T$GenericAuthNameSpace.Permissions();
        assume $TypeConstructor($DynamicType($tmp19)) == T$GenericAuthNameSpace.Permissions;
        F$OAuth20NameSpace.ResourceRequest.scope[local_7_Ref] := $tmp19;
        call $tmp20 := Alloc();
        call System.Collections.Generic.HashSet`1.#ctor($tmp20);
        assume $DynamicType($tmp20) == T$System.Collections.Generic.HashSet`1(T$GenericAuthNameSpace.Permission());
        assume $TypeConstructor($DynamicType($tmp20)) == T$System.Collections.Generic.HashSet`1;
        assume T$T$System.Collections.Generic.HashSet`1($DynamicType($tmp20)) == T$GenericAuthNameSpace.Permission();
        $tmp21 := local_7_Ref;
        assume $tmp21 != null;
        F$GenericAuthNameSpace.Permissions.permissionSet[F$OAuth20NameSpace.ResourceRequest.scope[$tmp21]] := $tmp20;
        $tmp22 := local_7_Ref;
        assume $tmp22 != null;
        $tmp23 := F$OAuth20NameSpace.ResourceRequest.scope[$tmp22];
        assume $tmp23 != null;
        $tmp24 := F$GenericAuthNameSpace.Permissions.permissionSet[$tmp23];
        call $tmp25 := Alloc();
        call OAuth20NameSpace.ResourceServerImpl.EmailPermission.#ctor($tmp25);
        assume $DynamicType($tmp25) == T$OAuth20NameSpace.ResourceServerImpl.EmailPermission();
        assume $TypeConstructor($DynamicType($tmp25)) == T$OAuth20NameSpace.ResourceServerImpl.EmailPermission;
        call $tmp26 := System.Collections.Generic.HashSet`1.Add$`0($tmp24, $tmp25);
        assume $this != null;
        $tmp27 := F$FacebookGraphApiExample.Facebook_GraphAuth.RS[$this];
        call $tmp28 := OAuth20NameSpace.ResourceServer.RequestResource$OAuth20NameSpace.ResourceRequest($tmp27, local_7_Ref);
        local_8_Ref := $tmp28;
        if (local_8_Ref == null)
        {
            assume {:breadcrumb 205} true;
            assume $this != null;
            $tmp29 := F$FacebookGraphApiExample.Facebook_GraphAuth.email[$this];
            call System.Web.UI.HtmlControls.HtmlContainerControl.set_InnerHtml$System.String($tmp29, $string_literal_verification$failed_11);
        }
        else
        {
            assume {:breadcrumb 206} true;
            assume $this != null;
            $tmp30 := F$FacebookGraphApiExample.Facebook_GraphAuth.email[$this];
            $tmp41 := local_8_Ref;
            assume $tmp41 != null;
            $tmp42 := F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.resources[$tmp41];
            assume $tmp42 != null;
            call $tmp44 := System.Linq.Enumerable.First``1$System.Collections.Generic.IEnumerable$``0$(F$GenericAuthNameSpace.Resources.resourceSet[$tmp42], T$GenericAuthNameSpace.Resource());
            $tmp43 := $tmp44;
            if ($TypeConstructor($DynamicType($tmp43)) == T$OAuth20NameSpace.ResourceServerImpl.EmailResource)
            {
                $tmp31 := local_8_Ref;
                assume $tmp31 != null;
                $tmp32 := F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.resources[$tmp31];
                assume $tmp32 != null;
                call $tmp34 := System.Linq.Enumerable.First``1$System.Collections.Generic.IEnumerable$``0$(F$GenericAuthNameSpace.Resources.resourceSet[$tmp32], T$GenericAuthNameSpace.Resource());
                $tmp33 := $tmp34;
                call $tmp35 := OAuth20NameSpace.ResourceServerImpl.EmailResource.get_value($tmp33);
            }
            else
            {
                $tmp36 := local_8_Ref;
                assume $tmp36 != null;
                $tmp37 := F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.resources[$tmp36];
                assume $tmp37 != null;
                call $tmp39 := System.Linq.Enumerable.First``1$System.Collections.Generic.IEnumerable$``0$(F$GenericAuthNameSpace.Resources.resourceSet[$tmp37], T$GenericAuthNameSpace.Resource());
                $tmp38 := $tmp39;
                call $tmp40 := GenericAuthNameSpace.Resource.get_value($tmp38);
            }

            call $tmp45 := System.String.Concat$System.Object$System.Object($string_literal_John's$email$is$_12, (if $TypeConstructor($DynamicType($tmp43)) == T$OAuth20NameSpace.ResourceServerImpl.EmailResource then $tmp35 else $tmp40));
            call System.Web.UI.HtmlControls.HtmlContainerControl.set_InnerHtml$System.String($tmp30, $tmp45);
        }

        return;
    }
    else
    {
        assume {:breadcrumb 204} true;
    }

    call $tmp46 := System.String.IsNullOrEmpty$System.String(local_1_Ref);
    if (!$tmp46)
    {
        assume {:breadcrumb 207} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this])) == T$FacebookGraphApiExample.Facebook_GraphAuth)
        {
            assume {:breadcrumb 209} true;
            assume $this != null;
            $tmp47 := F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp47, false);
        }
        else
        {
            assume {:breadcrumb 210} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this])) == T$System.Web.UI.Page)
            {
                assume {:breadcrumb 211} true;
                assume $this != null;
                $tmp48 := F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this];
                call System.Web.UI.Page.set_Visible$System.Boolean($tmp48, false);
            }
            else
            {
                assume {:breadcrumb 212} true;
                assume $this != null;
                if ($TypeConstructor($DynamicType(F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this])) == T$System.Web.UI.TemplateControl)
                {
                    assume {:breadcrumb 213} true;
                    assume $this != null;
                    $tmp49 := F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp49, false);
                }
                else
                {
                    assume {:breadcrumb 214} true;
                    assume $this != null;
                    $tmp50 := F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp50, false);
                }
            }
        }

        assume $this != null;
        if ($TypeConstructor($DynamicType(F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this])) == T$FacebookGraphApiExample.Facebook_GraphAuth)
        {
            assume {:breadcrumb 215} true;
            assume $this != null;
            $tmp51 := F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp51, true);
        }
        else
        {
            assume {:breadcrumb 216} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this])) == T$System.Web.UI.Page)
            {
                assume {:breadcrumb 217} true;
                assume $this != null;
                $tmp52 := F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this];
                call System.Web.UI.Page.set_Visible$System.Boolean($tmp52, true);
            }
            else
            {
                assume {:breadcrumb 218} true;
                assume $this != null;
                if ($TypeConstructor($DynamicType(F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this])) == T$System.Web.UI.TemplateControl)
                {
                    assume {:breadcrumb 219} true;
                    assume $this != null;
                    $tmp53 := F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp53, true);
                }
                else
                {
                    assume {:breadcrumb 220} true;
                    assume $this != null;
                    $tmp54 := F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp54, true);
                }
            }
        }

        return;
    }
    else
    {
        assume {:breadcrumb 208} true;
    }

    assume $this != null;
    if ($TypeConstructor($DynamicType(F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this])) == T$FacebookGraphApiExample.Facebook_GraphAuth)
    {
        assume {:breadcrumb 221} true;
        assume $this != null;
        $tmp55 := F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this];
        call System.Web.UI.Page.set_Visible$System.Boolean($tmp55, true);
    }
    else
    {
        assume {:breadcrumb 222} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this])) == T$System.Web.UI.Page)
        {
            assume {:breadcrumb 223} true;
            assume $this != null;
            $tmp56 := F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp56, true);
        }
        else
        {
            assume {:breadcrumb 224} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this])) == T$System.Web.UI.TemplateControl)
            {
                assume {:breadcrumb 225} true;
                assume $this != null;
                $tmp57 := F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp57, true);
            }
            else
            {
                assume {:breadcrumb 226} true;
                assume $this != null;
                $tmp58 := F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp58, true);
            }
        }
    }

    assume $this != null;
    if ($TypeConstructor($DynamicType(F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this])) == T$FacebookGraphApiExample.Facebook_GraphAuth)
    {
        assume {:breadcrumb 227} true;
        assume $this != null;
        $tmp59 := F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this];
        call System.Web.UI.Page.set_Visible$System.Boolean($tmp59, false);
    }
    else
    {
        assume {:breadcrumb 228} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this])) == T$System.Web.UI.Page)
        {
            assume {:breadcrumb 229} true;
            assume $this != null;
            $tmp60 := F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp60, false);
        }
        else
        {
            assume {:breadcrumb 230} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this])) == T$System.Web.UI.TemplateControl)
            {
                assume {:breadcrumb 231} true;
                assume $this != null;
                $tmp61 := F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp61, false);
            }
            else
            {
                assume {:breadcrumb 232} true;
                assume $this != null;
                $tmp62 := F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp62, false);
            }
        }
    }
}



procedure FacebookGraphApiExample.Facebook_GraphAuth.LoginBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



procedure {:extern} System.Web.UI.Page.get_Response($this: Ref) returns ($result: Ref);



var F$OAuth20NameSpace.ResourceServerImpl.get_code_url: [Ref]Ref;

procedure {:extern} System.Web.HttpResponse.Redirect$System.String($this: Ref, url$in: Ref);



implementation FacebookGraphApiExample.Facebook_GraphAuth.LoginBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 233} true;
    call $tmp0 := System.Web.UI.Page.get_Response($this);
    assume $this != null;
    $tmp1 := F$FacebookGraphApiExample.Facebook_GraphAuth.RS[$this];
    assume $tmp1 != null;
    call System.Web.HttpResponse.Redirect$System.String($tmp0, F$OAuth20NameSpace.ResourceServerImpl.get_code_url[$tmp1]);
}



procedure FacebookGraphApiExample.Facebook_GraphAuth.LogoutBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



implementation FacebookGraphApiExample.Facebook_GraphAuth.LogoutBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 234} true;
    call $tmp0 := System.Web.UI.Page.get_Response($this);
    assume $this != null;
    $tmp1 := F$FacebookGraphApiExample.Facebook_GraphAuth.RS[$this];
    assume $tmp1 != null;
    call System.Web.HttpResponse.Redirect$System.String($tmp0, F$OAuth20NameSpace.ResourceServerImpl.get_token_url[$tmp1]);
}



procedure FacebookGraphApiExample.Facebook_GraphAuth.#ctor($this: Ref);



procedure OAuth20NameSpace.ResourceServerImpl.#ctor$System.String$System.String$System.String$System.String($this: Ref, rl$in: Ref, client_id$in: Ref, client_secret$in: Ref, redirect_uri$in: Ref);



procedure {:extern} System.Web.UI.Page.#ctor($this: Ref);



implementation FacebookGraphApiExample.Facebook_GraphAuth.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$FacebookGraphApiExample.Facebook_GraphAuth.RS[$this] := null;
    F$FacebookGraphApiExample.Facebook_GraphAuth.form1[$this] := null;
    F$FacebookGraphApiExample.Facebook_GraphAuth.notLoggedIn[$this] := null;
    F$FacebookGraphApiExample.Facebook_GraphAuth.Login[$this] := null;
    F$FacebookGraphApiExample.Facebook_GraphAuth.LoggedIn[$this] := null;
    F$FacebookGraphApiExample.Facebook_GraphAuth.email[$this] := null;
    F$FacebookGraphApiExample.Facebook_GraphAuth.Logout[$this] := null;
    assume {:breadcrumb 235} true;
    call $tmp0 := Alloc();
    call OAuth20NameSpace.ResourceServerImpl.#ctor$System.String$System.String$System.String$System.String($tmp0, F$FacebookGraphApiExample.Facebook_GraphAuth.realm, F$FacebookGraphApiExample.Facebook_GraphAuth.client_id, F$FacebookGraphApiExample.Facebook_GraphAuth.client_secret, F$FacebookGraphApiExample.Facebook_GraphAuth.redirect_uri);
    assume $DynamicType($tmp0) == T$OAuth20NameSpace.ResourceServerImpl();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OAuth20NameSpace.ResourceServerImpl;
    F$FacebookGraphApiExample.Facebook_GraphAuth.RS[$this] := $tmp0;
    call System.Web.UI.Page.#ctor($this);
}



procedure FacebookGraphApiExample.Facebook_GraphAuth.#cctor();



const {:value "503819873126032"} unique $string_literal_503819873126032_13: Ref;

const {:value "1665122330392017"} unique $string_literal_1665122330392017_14: Ref;

const {:value "4e6b2f4926d0ed9fc199d30fd6efc95c"} unique $string_literal_4e6b2f4926d0ed9fc199d30fd6efc95c_15: Ref;

const {:value "localhost"} unique $string_literal_localhost_16: Ref;

const {:value "http://localhost:57999/Facebook_GraphAuth.aspx"} unique $string_literal_http$$$localhost$57999$Facebook_GraphAuth.aspx_17: Ref;

implementation FacebookGraphApiExample.Facebook_GraphAuth.#cctor()
{
  var $localExc: Ref;
  var $label: int;

    F$FacebookGraphApiExample.Facebook_GraphAuth.client_id := null;
    F$FacebookGraphApiExample.Facebook_GraphAuth.user_id := null;
    F$FacebookGraphApiExample.Facebook_GraphAuth.client_secret := null;
    F$FacebookGraphApiExample.Facebook_GraphAuth.realm := null;
    F$FacebookGraphApiExample.Facebook_GraphAuth.redirect_uri := null;
    assume {:breadcrumb 236} true;
    F$FacebookGraphApiExample.Facebook_GraphAuth.client_id := $string_literal_503819873126032_13;
    F$FacebookGraphApiExample.Facebook_GraphAuth.user_id := $string_literal_1665122330392017_14;
    F$FacebookGraphApiExample.Facebook_GraphAuth.client_secret := $string_literal_4e6b2f4926d0ed9fc199d30fd6efc95c_15;
    F$FacebookGraphApiExample.Facebook_GraphAuth.realm := $string_literal_localhost_16;
    F$FacebookGraphApiExample.Facebook_GraphAuth.redirect_uri := $string_literal_http$$$localhost$57999$Facebook_GraphAuth.aspx_17;
}



var F$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.$AccessToken$k__BackingField: [Ref]Ref;

var F$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.$TokenType$k__BackingField: [Ref]Ref;

var F$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.$ExpiresIn$k__BackingField: [Ref]Ref;

implementation FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.get_AccessToken($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 237} true;
    assume $this != null;
    local_0_Ref := F$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.$AccessToken$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.set_AccessToken$System.String($this: Ref, value$in: Ref);



implementation FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.set_AccessToken$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 238} true;
    F$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.$AccessToken$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.get_TokenType($this: Ref) returns ($result: Ref);



implementation FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.get_TokenType($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 239} true;
    assume $this != null;
    local_0_Ref := F$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.$TokenType$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.set_TokenType$System.String($this: Ref, value$in: Ref);



implementation FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.set_TokenType$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 240} true;
    F$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.$TokenType$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.get_ExpiresIn($this: Ref) returns ($result: Ref);



implementation FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.get_ExpiresIn($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 241} true;
    assume $this != null;
    local_0_Ref := F$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.$ExpiresIn$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.set_ExpiresIn$System.String($this: Ref, value$in: Ref);



implementation FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.set_ExpiresIn$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 242} true;
    F$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.$ExpiresIn$k__BackingField[$this] := value;
}



implementation FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.$AccessToken$k__BackingField[$this] := null;
    F$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.$TokenType$k__BackingField[$this] := null;
    F$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.$ExpiresIn$k__BackingField[$this] := null;
    assume {:breadcrumb 243} true;
    call System.Object.#ctor($this);
}



procedure T$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.#cctor();



implementation T$FacebookGraphApiExample.Facebook_GraphAuth.JsonDataStrcuture.#cctor()
{
}



var F$OAuth20NameSpace.ResourceServerImpl._client_id: [Ref]Ref;

var F$OAuth20NameSpace.ResourceServerImpl._client_secret: [Ref]Ref;

var F$OAuth20NameSpace.ResourceServerImpl.access_token: [Ref]Ref;

var F$OAuth20NameSpace.ResourceServerImpl.redirect_uri: [Ref]Ref;

var F$OAuth20NameSpace.ResourceServerImpl.ResourceRecs: [Ref]Ref;

var F$OAuth20NameSpace.ResourceServerImpl.fbid: [Ref]Ref;

var F$OAuth20NameSpace.ResourceServerImpl.fbemail: [Ref]Ref;

var F$OAuth20NameSpace.ResourceServerImpl.client_id_: Ref;

var F$OAuth20NameSpace.ResourceServerImpl.user_id: Ref;

var F$OAuth20NameSpace.ResourceServerImpl.client_secret_: Ref;

var F$OAuth20NameSpace.ResourceServerImpl.redirect_uri_: Ref;

var F$OAuth20NameSpace.ResourceServerImpl.rl: Ref;

implementation OAuth20NameSpace.ResourceServerImpl.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 244} true;
    call OAuth20NameSpace.ResourceServerImpl.#ctor$System.String$System.String$System.String$System.String($this, F$OAuth20NameSpace.ResourceServerImpl.rl, F$OAuth20NameSpace.ResourceServerImpl.client_id_, F$OAuth20NameSpace.ResourceServerImpl.client_secret_, F$OAuth20NameSpace.ResourceServerImpl.redirect_uri_);
}



const {:value "https://graph.facebook.com/v2.3/oauth/access_token?"} unique $string_literal_https$$$graph.facebook.com$v2.3$oauth$access_token?_18: Ref;

procedure OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.#ctor($this: Ref);



const {:value "johndoe.test.789@gmail.com"} unique $string_literal_johndoe.test.789$gmail.com_19: Ref;

procedure {:extern} System.String.Concat$System.Stringarray(values$in: Ref) returns ($result: Ref);



const {:value "https://graph.facebook.com"} unique $string_literal_https$$$graph.facebook.com_20: Ref;

procedure OAuth20NameSpace.ResourceServerImpl.EmailResource.#ctor($this: Ref);



var F$OAuth20NameSpace.ResourceServerImpl.EmailResource.email: [Ref]Ref;

procedure OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.setEntry$System.String$GenericAuthNameSpace.Permission$GenericAuthNameSpace.Resource($this: Ref, UserID$in: Ref, permission$in: Ref, resource$in: Ref) returns ($result: bool);



implementation OAuth20NameSpace.ResourceServerImpl.#ctor$System.String$System.String$System.String$System.String($this: Ref, rl$in: Ref, client_id$in: Ref, client_secret$in: Ref, redirect_uri$in: Ref)
{
  var rl: Ref;
  var client_id: Ref;
  var client_secret: Ref;
  var redirect_uri: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_1_prime_Ref: Ref;
  var $tmp5: Ref;
  var $tmp6: bool;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: bool;
  var $localExc: Ref;
  var $label: int;

    rl := rl$in;
    client_id := client_id$in;
    client_secret := client_secret$in;
    redirect_uri := redirect_uri$in;
    F$OAuth20NameSpace.ResourceServerImpl._client_id[$this] := null;
    F$OAuth20NameSpace.ResourceServerImpl._client_secret[$this] := null;
    F$OAuth20NameSpace.ResourceServerImpl.get_token_url[$this] := null;
    F$OAuth20NameSpace.ResourceServerImpl.get_code_url[$this] := null;
    F$OAuth20NameSpace.ResourceServerImpl.access_token[$this] := null;
    F$OAuth20NameSpace.ResourceServerImpl.redirect_uri[$this] := null;
    F$OAuth20NameSpace.ResourceServerImpl.ResourceRecs[$this] := null;
    F$OAuth20NameSpace.ResourceServerImpl.fbid[$this] := null;
    F$OAuth20NameSpace.ResourceServerImpl.fbemail[$this] := null;
    assume {:breadcrumb 245} true;
    F$OAuth20NameSpace.ResourceServerImpl.get_token_url[$this] := $string_literal_https$$$graph.facebook.com$v2.3$oauth$access_token?_18;
    F$OAuth20NameSpace.ResourceServerImpl.get_code_url[$this] := $string_literal_https$$$graph.facebook.com$v2.3$oauth$access_token?_18;
    call $tmp0 := Alloc();
    call OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def;
    F$OAuth20NameSpace.ResourceServerImpl.ResourceRecs[$this] := $tmp0;
    F$OAuth20NameSpace.ResourceServerImpl.fbid[$this] := $string_literal_1665122330392017_14;
    F$OAuth20NameSpace.ResourceServerImpl.fbemail[$this] := $string_literal_johndoe.test.789$gmail.com_19;
    call OAuth20NameSpace.ResourceServer.#ctor($this);
    F$GenericAuthNameSpace.RS.Realm[$this] := rl;
    F$OAuth20NameSpace.ResourceServerImpl._client_id[$this] := client_id;
    F$OAuth20NameSpace.ResourceServerImpl._client_secret[$this] := client_secret;
    F$OAuth20NameSpace.ResourceServerImpl.redirect_uri[$this] := redirect_uri;
    call $tmp1 := Alloc();
    assume $ArrayLength($tmp1) == 1 * 5;
    call $tmp2 := System.String.Concat$System.Stringarray($tmp1);
    F$OAuth20NameSpace.ResourceServerImpl.get_code_url[$this] := $tmp2;
    F$OAuth20NameSpace.ResourceServer.TokenEndpointUrl[$this] := $string_literal_https$$$graph.facebook.com_20;
    assume $this != null;
    call OAuth20NameSpace.ResourceServer.init$OAuth20NameSpace.ResourceRecs($this, F$OAuth20NameSpace.ResourceServerImpl.ResourceRecs[$this]);
    assume $this != null;
    if ($TypeConstructor($DynamicType(F$OAuth20NameSpace.ResourceServerImpl.ResourceRecs[$this])) == T$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def)
    {
        assume $this != null;
        $tmp3 := F$OAuth20NameSpace.ResourceServerImpl.ResourceRecs[$this];
        assume $this != null;
        call $tmp4 := Alloc();
        call OAuth20NameSpace.ResourceServerImpl.EmailPermission.#ctor($tmp4);
        assume $DynamicType($tmp4) == T$OAuth20NameSpace.ResourceServerImpl.EmailPermission();
        assume $TypeConstructor($DynamicType($tmp4)) == T$OAuth20NameSpace.ResourceServerImpl.EmailPermission;
        call $tmp5 := Alloc();
        call OAuth20NameSpace.ResourceServerImpl.EmailResource.#ctor($tmp5);
        assume $DynamicType($tmp5) == T$OAuth20NameSpace.ResourceServerImpl.EmailResource();
        assume $TypeConstructor($DynamicType($tmp5)) == T$OAuth20NameSpace.ResourceServerImpl.EmailResource;
        local_1_prime_Ref := $tmp5;
        assume $this != null;
        F$OAuth20NameSpace.ResourceServerImpl.EmailResource.email[local_1_prime_Ref] := F$OAuth20NameSpace.ResourceServerImpl.fbemail[$this];
        call $tmp6 := OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.setEntry$System.String$GenericAuthNameSpace.Permission$GenericAuthNameSpace.Resource($tmp3, F$OAuth20NameSpace.ResourceServerImpl.fbid[$this], $tmp4, local_1_prime_Ref);
    }
    else
    {
        assume $this != null;
        $tmp7 := F$OAuth20NameSpace.ResourceServerImpl.ResourceRecs[$this];
        assume $this != null;
        call $tmp8 := Alloc();
        call OAuth20NameSpace.ResourceServerImpl.EmailPermission.#ctor($tmp8);
        assume $DynamicType($tmp8) == T$OAuth20NameSpace.ResourceServerImpl.EmailPermission();
        assume $TypeConstructor($DynamicType($tmp8)) == T$OAuth20NameSpace.ResourceServerImpl.EmailPermission;
        call $tmp9 := Alloc();
        call OAuth20NameSpace.ResourceServerImpl.EmailResource.#ctor($tmp9);
        assume $DynamicType($tmp9) == T$OAuth20NameSpace.ResourceServerImpl.EmailResource();
        assume $TypeConstructor($DynamicType($tmp9)) == T$OAuth20NameSpace.ResourceServerImpl.EmailResource;
        local_1_prime_Ref := $tmp9;
        assume $this != null;
        F$OAuth20NameSpace.ResourceServerImpl.EmailResource.email[local_1_prime_Ref] := F$OAuth20NameSpace.ResourceServerImpl.fbemail[$this];
        call $tmp10 := GenericAuthNameSpace.RSResourceRecords_Base.setEntry$System.String$GenericAuthNameSpace.Permission$GenericAuthNameSpace.Resource($tmp7, F$OAuth20NameSpace.ResourceServerImpl.fbid[$this], $tmp8, local_1_prime_Ref);
    }
}



procedure OAuth20NameSpace.ResourceServerImpl.setToken$System.String($this: Ref, access_token$in: Ref);



implementation OAuth20NameSpace.ResourceServerImpl.setToken$System.String($this: Ref, access_token$in: Ref)
{
  var access_token: Ref;
  var $localExc: Ref;
  var $label: int;

    access_token := access_token$in;
    assume {:breadcrumb 246} true;
    F$OAuth20NameSpace.ResourceServerImpl.access_token[$this] := access_token;
}



implementation OAuth20NameSpace.ResourceServerImpl.setCode$System.String($this: Ref, code$in: Ref)
{
  var code: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

    code := code$in;
    assume {:breadcrumb 247} true;
    call $tmp0 := Alloc();
    assume $ArrayLength($tmp0) == 1 * 8;
    call $tmp1 := System.String.Concat$System.Stringarray($tmp0);
    F$OAuth20NameSpace.ResourceServerImpl.get_token_url[$this] := $tmp1;
}



procedure OAuth20NameSpace.ResourceServerImpl.FBPermssionData.#ctor($this: Ref);



function T$OAuth20NameSpace.ResourceServerImpl.FBPermssionData() : Ref;

const unique T$OAuth20NameSpace.ResourceServerImpl.FBPermssionData: int;

const {:value "ValidateTicket"} unique $string_literal_ValidateTicket_21: Ref;

procedure {:extern} System.Type.GetMethod$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



const {:value "facebook.com"} unique $string_literal_facebook.com_22: Ref;

procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct$System.Reflection.MethodInfo$System.String$System.Boolean$System.Boolean(o$in: Ref, in_msg$in: Ref, out_msg$in: Ref, mi$in: Ref, partyName$in: Ref, signed$in: bool, server_to_server$in: bool);



implementation OAuth20NameSpace.ResourceServerImpl.callValidateTokenEndpoint$OAuth20NameSpace.ValidateTokenRequest($this: Ref, treq$in: Ref) returns ($result: Ref)
{
  var treq: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $tmp1: Ref;
  var local_4_Ref: Ref;
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
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var local_6_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    treq := treq$in;
    assume {:breadcrumb 248} true;
    call $tmp0 := Alloc();
    call OAuth20NameSpace.ValidateTokenResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OAuth20NameSpace.ValidateTokenResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OAuth20NameSpace.ValidateTokenResponse;
    local_0_Ref := $tmp0;
    call $tmp1 := Alloc();
    call OAuth20NameSpace.ResourceServerImpl.FBPermssionData.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$OAuth20NameSpace.ResourceServerImpl.FBPermssionData();
    assume $TypeConstructor($DynamicType($tmp1)) == T$OAuth20NameSpace.ResourceServerImpl.FBPermssionData;
    local_1_Ref := $tmp1;
    call $tmp2 := Alloc();
    assume $ArrayLength($tmp2) == 1 * 5;
    call $tmp3 := System.String.Concat$System.Stringarray($tmp2);
    call $tmp4 := System.Net.WebRequest.Create$System.String($tmp3);
    call $tmp5 := System.Net.WebRequest.GetResponse($tmp4);
    local_4_Ref := $tmp5;
    call $tmp6 := Alloc();
    call System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($tmp6, T$OAuth20NameSpace.ResourceServerImpl.FBPermssionData());
    assume $DynamicType($tmp6) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer();
    assume $TypeConstructor($DynamicType($tmp6)) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;
    call $tmp7 := System.Net.WebResponse.GetResponseStream(local_4_Ref);
    call $tmp8 := System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream($tmp6, $tmp7);
    local_1_Ref := $As($tmp8, T$OAuth20NameSpace.ResourceServerImpl.FBPermssionData());
    call $tmp9 := Alloc();
    call OAuth20NameSpace.AuthorizationServerImpl.#ctor($tmp9);
    assume $DynamicType($tmp9) == T$OAuth20NameSpace.AuthorizationServerImpl();
    assume $TypeConstructor($DynamicType($tmp9)) == T$OAuth20NameSpace.AuthorizationServerImpl;
    $tmp10 := T$OAuth20NameSpace.AuthorizationServer();
    call $tmp11 := System.Type.GetMethod$System.String($tmp10, $string_literal_ValidateTicket_21);
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct$System.Reflection.MethodInfo$System.String$System.Boolean$System.Boolean($tmp9, treq, local_0_Ref, $tmp11, $string_literal_facebook.com_22, false, false);
    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse)
    {
        assume {:breadcrumb 249} true;
        if ($TypeConstructor($DynamicType(treq)) == T$OAuth20NameSpace.ValidateTokenRequest)
        {
            call $tmp12 := OAuth20NameSpace.ValidateTokenRequest.get_UserID(treq);
        }
        else
        {
            call $tmp13 := GenericAuthNameSpace.ValidateTicket_Req.get_UserID(treq);
        }

        call OAuth20NameSpace.ValidateTokenResponse.set_UserID$System.String(local_0_Ref, (if $TypeConstructor($DynamicType(treq)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp12 else $tmp13));
    }
    else
    {
        assume {:breadcrumb 250} true;
        if ($TypeConstructor($DynamicType(treq)) == T$OAuth20NameSpace.ValidateTokenRequest)
        {
            call $tmp14 := OAuth20NameSpace.ValidateTokenRequest.get_UserID(treq);
        }
        else
        {
            call $tmp15 := GenericAuthNameSpace.ValidateTicket_Req.get_UserID(treq);
        }

        call GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_UserID$System.String(local_0_Ref, (if $TypeConstructor($DynamicType(treq)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp14 else $tmp15));
    }

    $tmp16 := treq;
    assume $tmp16 != null;
    F$OAuth20NameSpace.ValidateTokenResponse.scope[local_0_Ref] := F$OAuth20NameSpace.ValidateTokenRequest.scope[$tmp16];
    $tmp17 := treq;
    assume $tmp17 != null;
    F$OAuth20NameSpace.ValidateTokenResponse.access_token[local_0_Ref] := F$OAuth20NameSpace.ValidateTokenRequest.access_token[$tmp17];
    local_6_Ref := local_0_Ref;
    goto IL_00e2;

  IL_00e2:
    $result := local_6_Ref;
    return;
}



procedure OAuth20NameSpace.ResourceServerImpl.#cctor();



implementation OAuth20NameSpace.ResourceServerImpl.#cctor()
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ResourceServerImpl.client_id_ := null;
    F$OAuth20NameSpace.ResourceServerImpl.user_id := null;
    F$OAuth20NameSpace.ResourceServerImpl.client_secret_ := null;
    F$OAuth20NameSpace.ResourceServerImpl.redirect_uri_ := null;
    F$OAuth20NameSpace.ResourceServerImpl.rl := null;
    assume {:breadcrumb 251} true;
    F$OAuth20NameSpace.ResourceServerImpl.client_id_ := $string_literal_503819873126032_13;
    F$OAuth20NameSpace.ResourceServerImpl.user_id := $string_literal_1665122330392017_14;
    F$OAuth20NameSpace.ResourceServerImpl.client_secret_ := $string_literal_4e6b2f4926d0ed9fc199d30fd6efc95c_15;
    F$OAuth20NameSpace.ResourceServerImpl.redirect_uri_ := $string_literal_http$$$localhost$57999$Facebook_GraphAuth.aspx_17;
    F$OAuth20NameSpace.ResourceServerImpl.rl := $string_literal_localhost_16;
}



var F$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.resourceDB: [Ref]Ref;

implementation OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.resourceDB[$this] := null;
    assume {:breadcrumb 252} true;
    call $tmp0 := Alloc();
    call System.Collections.Generic.Dictionary`2.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.Collections.Generic.Dictionary`2(T$GenericAuthNameSpace.Permission(), T$GenericAuthNameSpace.Resource()));
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.String();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2(T$GenericAuthNameSpace.Permission(), T$GenericAuthNameSpace.Resource());
    F$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.resourceDB[$this] := $tmp0;
    call System.Object.#ctor($this);
}



implementation OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.getEntry$System.String$GenericAuthNameSpace.Permission($this: Ref, UserID$in: Ref, permission$in: Ref) returns ($result: Ref)
{
  var UserID: Ref;
  var permission: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

    UserID := UserID$in;
    permission := permission$in;
    assume {:breadcrumb 253} true;
    assume $this != null;
    $tmp0 := F$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.resourceDB[$this];
    call $tmp2 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp0, UserID);
    $tmp1 := $tmp2;
    call $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp1, permission);
    $tmp3 := $tmp4;
    local_0_Ref := $tmp3;
    goto IL_0016;

  IL_0016:
    $result := local_0_Ref;
    return;
}



procedure {:extern} System.Collections.Generic.Dictionary`2.ContainsKey$`0($this: Ref, key$in: Ref) returns ($result: bool);



implementation OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.setEntry$System.String$GenericAuthNameSpace.Permission$GenericAuthNameSpace.Resource($this: Ref, UserID$in: Ref, permission$in: Ref, resource$in: Ref) returns ($result: bool)
{
  var UserID: Ref;
  var permission: Ref;
  var resource: Ref;
  var $tmp0: Ref;
  var $tmp1: bool;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var local_0_bool: bool;
  var $localExc: Ref;
  var $label: int;

    UserID := UserID$in;
    permission := permission$in;
    resource := resource$in;
    assume {:breadcrumb 254} true;
    assume $this != null;
    $tmp0 := F$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.resourceDB[$this];
    call $tmp1 := System.Collections.Generic.Dictionary`2.ContainsKey$`0($tmp0, UserID);
    if (!$tmp1)
    {
        assume {:breadcrumb 255} true;
        assume $this != null;
        $tmp2 := F$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.resourceDB[$this];
        call $tmp3 := Alloc();
        call System.Collections.Generic.Dictionary`2.#ctor($tmp3);
        assume $DynamicType($tmp3) == T$System.Collections.Generic.Dictionary`2(T$GenericAuthNameSpace.Permission(), T$GenericAuthNameSpace.Resource());
        assume $TypeConstructor($DynamicType($tmp3)) == T$System.Collections.Generic.Dictionary`2;
        assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp3)) == T$GenericAuthNameSpace.Permission();
        assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp3)) == T$GenericAuthNameSpace.Resource();
        call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp2, UserID, $tmp3);
    }
    else
    {
        assume {:breadcrumb 256} true;
    }

    assume $this != null;
    $tmp4 := F$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.resourceDB[$this];
    call $tmp6 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp4, UserID);
    $tmp5 := $tmp6;
    call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp5, permission, resource);
    local_0_bool := true;
    goto IL_003b;

  IL_003b:
    $result := local_0_bool;
    return;
}



procedure T$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.#cctor();



implementation T$OAuth20NameSpace.ResourceServerImpl.ResourceRecs_def.#cctor()
{
}



implementation OAuth20NameSpace.ResourceServerImpl.EmailResource.get_value($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 257} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ResourceServerImpl.EmailResource.email[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.ResourceServerImpl.EmailResource.set_value$System.Object($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ResourceServerImpl.EmailResource.set_value$System.Object($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 258} true;
    F$OAuth20NameSpace.ResourceServerImpl.EmailResource.email[$this] := value;
}



const {:value "email"} unique $string_literal_email_23: Ref;

implementation OAuth20NameSpace.ResourceServerImpl.EmailResource.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ResourceServerImpl.EmailResource.email[$this] := null;
    assume {:breadcrumb 259} true;
    call GenericAuthNameSpace.Resource.#ctor($this);
    F$GenericAuthNameSpace.Resource.name[$this] := $string_literal_email_23;
}



procedure T$OAuth20NameSpace.ResourceServerImpl.EmailResource.#cctor();



implementation T$OAuth20NameSpace.ResourceServerImpl.EmailResource.#cctor()
{
}



var F$OAuth20NameSpace.ResourceServerImpl.EmailPermission.email: [Ref]Ref;

implementation OAuth20NameSpace.ResourceServerImpl.EmailPermission.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ResourceServerImpl.EmailPermission.email[$this] := null;
    assume {:breadcrumb 260} true;
    call GenericAuthNameSpace.Permission.#ctor($this);
    F$GenericAuthNameSpace.Permission.name[$this] := $string_literal_email_23;
}



procedure T$OAuth20NameSpace.ResourceServerImpl.EmailPermission.#cctor();



implementation T$OAuth20NameSpace.ResourceServerImpl.EmailPermission.#cctor()
{
}



function T$OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon() : Ref;

const unique T$OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon: int;

var F$OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.$permission$k__BackingField: [Ref]Ref;

var F$OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.$status$k__BackingField: [Ref]Ref;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.get_permission($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.get_permission($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 261} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.$permission$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.set_permission$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.set_permission$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 262} true;
    F$OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.$permission$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.get_status($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.get_status($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 263} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.$status$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.set_status$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.set_status$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 264} true;
    F$OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.$status$k__BackingField[$this] := value;
}



procedure OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.#ctor($this: Ref);



implementation OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.$permission$k__BackingField[$this] := null;
    F$OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.$status$k__BackingField[$this] := null;
    assume {:breadcrumb 265} true;
    call System.Object.#ctor($this);
}



procedure T$OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.#cctor();



implementation T$OAuth20NameSpace.ResourceServerImpl.FBPermssionJSon.#cctor()
{
}



var F$OAuth20NameSpace.ResourceServerImpl.FBPermssionData.$data$k__BackingField: [Ref]Ref;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} OAuth20NameSpace.ResourceServerImpl.FBPermssionData.get_data($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceServerImpl.FBPermssionData.get_data($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 266} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ResourceServerImpl.FBPermssionData.$data$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OAuth20NameSpace.ResourceServerImpl.FBPermssionData.set_data$OAuth20NameSpace.ResourceServerImpl.FBPermssionJSonarray($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ResourceServerImpl.FBPermssionData.set_data$OAuth20NameSpace.ResourceServerImpl.FBPermssionJSonarray($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 267} true;
    F$OAuth20NameSpace.ResourceServerImpl.FBPermssionData.$data$k__BackingField[$this] := value;
}



implementation OAuth20NameSpace.ResourceServerImpl.FBPermssionData.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ResourceServerImpl.FBPermssionData.$data$k__BackingField[$this] := null;
    assume {:breadcrumb 268} true;
    call System.Object.#ctor($this);
}



procedure T$OAuth20NameSpace.ResourceServerImpl.FBPermssionData.#cctor();



implementation T$OAuth20NameSpace.ResourceServerImpl.FBPermssionData.#cctor()
{
}



function T$CST.Nondet_Base() : Ref;

const unique T$CST.Nondet_Base: int;

procedure CST.Nondet_Base.Int($this: Ref) returns ($result: int);



procedure CST.Nondet_Base.String($this: Ref) returns ($result: Ref);



procedure CST.Nondet_Base.Bool($this: Ref) returns ($result: bool);



function T$CST.CST_Struct() : Ref;

const unique T$CST.CST_Struct: int;

var F$CST.CST_Struct.SignedBy: [Ref]Ref;

implementation CST.CST_Struct.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$CST.CST_Struct.SymT[$this] := null;
    F$CST.CST_Struct.SignedBy[$this] := null;
    assume {:breadcrumb 269} true;
    F$CST.CST_Struct.SymT[$this] := $string_literal__9;
    F$CST.CST_Struct.SignedBy[$this] := $string_literal__9;
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

    assume {:breadcrumb 270} true;
    assert false;
}



procedure CST.Debug.#ctor($this: Ref);



implementation CST.Debug.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 271} true;
    call System.Object.#ctor($this);
}



procedure T$CST.Debug.#cctor();



implementation T$CST.Debug.#cctor()
{
}


