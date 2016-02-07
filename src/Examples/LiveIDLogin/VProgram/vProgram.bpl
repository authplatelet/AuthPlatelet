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

function T$PoirotMain() : Ref;

const unique T$PoirotMain: int;

var F$PoirotMain.Nondet: Ref;

procedure {:entrypoint} PoirotMain.Main();



procedure GlobalObjectsForCST.init();



procedure SynthesizedPortion.SynthesizedSequence();



implementation PoirotMain.Main()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 0} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 20} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 20} true;
    call GlobalObjectsForCST.init();
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 21} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 21} true;
    call SynthesizedPortion.SynthesizedSequence();
}



procedure PoirotMain.#ctor($this: Ref);



procedure {:extern} System.Object.#ctor($this: Ref);



implementation PoirotMain.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 1} true;
    call System.Object.#ctor($this);
}



procedure T$PoirotMain.#cctor();



implementation T$PoirotMain.#cctor()
{
    F$PoirotMain.Nondet := null;
}



function T$LiveIDNameSpace.LiveID_RP_For_vProgram() : Ref;

const unique T$LiveIDNameSpace.LiveID_RP_For_vProgram: int;

procedure LiveIDNameSpace.LiveID_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool);



procedure {:extern} GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion$in: Ref);



implementation LiveIDNameSpace.LiveID_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool)
{
  var conclusion: Ref;
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 2} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Assertion.cs"} {:sourceLine 10} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Assertion.cs"} {:sourceLine 10} true;
    call GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion);
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Assertion.cs"} {:sourceLine 11} true;
    $result := true;
    return;
}



procedure LiveIDNameSpace.LiveID_RP_For_vProgram.#ctor($this: Ref);



procedure {:extern} LiveIDNameSpace.LiveID_RP.#ctor($this: Ref);



implementation LiveIDNameSpace.LiveID_RP_For_vProgram.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 3} true;
    call LiveIDNameSpace.LiveID_RP.#ctor($this);
}



procedure T$LiveIDNameSpace.LiveID_RP_For_vProgram.#cctor();



implementation T$LiveIDNameSpace.LiveID_RP_For_vProgram.#cctor()
{
}



function T$SynthesizedPortion() : Ref;

const unique T$SynthesizedPortion: int;

procedure {:extern} OpenIDConnectNameSpace.NondetOpenIDConnect.AuthenticationResponse($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.RP: Ref;

procedure {:extern} OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.AS: Ref;

procedure {:extern} OpenIDConnectNameSpace.OpenIDProvider.TokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} OpenIDConnectNameSpace.RelyingParty.conclude$OpenIDConnectNameSpace.TokenResponse($this: Ref, tokenResp$in: Ref) returns ($result: Ref);



implementation SynthesizedPortion.SynthesizedSequence()
{
  var O1_Ref: Ref;
  var $tmp0: Ref;
  var O2_Ref: Ref;
  var $tmp1: Ref;
  var O3_Ref: Ref;
  var $tmp2: Ref;
  var G4_Ref: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 4} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 5} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 5} true;
    call $tmp0 := OpenIDConnectNameSpace.NondetOpenIDConnect.AuthenticationResponse(F$PoirotMain.Nondet);
    O1_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 6} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 6} true;
    call $tmp1 := OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse(F$GenericAuthNameSpace.GlobalObjects_base.RP, O1_Ref);
    O2_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 7} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 7} true;
    call $tmp2 := OpenIDConnectNameSpace.OpenIDProvider.TokenEndpoint$OpenIDConnectNameSpace.TokenRequest(F$GenericAuthNameSpace.GlobalObjects_base.AS, O2_Ref);
    O3_Ref := $tmp2;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 8} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 8} true;
    call $tmp3 := OpenIDConnectNameSpace.RelyingParty.conclude$OpenIDConnectNameSpace.TokenResponse(F$GenericAuthNameSpace.GlobalObjects_base.RP, O3_Ref);
    G4_Ref := $tmp3;
}



procedure SynthesizedPortion.#ctor($this: Ref);



implementation SynthesizedPortion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 5} true;
    call System.Object.#ctor($this);
}



procedure T$SynthesizedPortion.#cctor();



implementation T$SynthesizedPortion.#cctor()
{
}



function T$GlobalObjectsForCST() : Ref;

const unique T$GlobalObjectsForCST: int;

procedure {:extern} OpenIDConnectNameSpace.NondetOpenIDConnect.AuthenticationRequest($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req: Ref;

procedure {:extern} LiveIDNameSpace.LiveID_IdP.#ctor($this: Ref);



function {:extern} T$LiveIDNameSpace.LiveID_IdP() : Ref;

const {:extern} unique T$LiveIDNameSpace.LiveID_IdP: int;

axiom $TypeConstructor(T$LiveIDNameSpace.LiveID_IdP()) == T$LiveIDNameSpace.LiveID_IdP;

procedure {:extern} LiveIDNameSpace.LiveID_IdP.init($this: Ref);



implementation GlobalObjectsForCST.init()
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 6} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 10} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 10} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 10} true;
    call $tmp0 := OpenIDConnectNameSpace.NondetOpenIDConnect.AuthenticationRequest(F$PoirotMain.Nondet);
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := $tmp0;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 11} true;
    call $tmp1 := Alloc();
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 11} true;
    call LiveIDNameSpace.LiveID_IdP.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$LiveIDNameSpace.LiveID_IdP();
    assume $TypeConstructor($DynamicType($tmp1)) == T$LiveIDNameSpace.LiveID_IdP;
    F$GenericAuthNameSpace.GlobalObjects_base.AS := $tmp1;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 11} true;
    call LiveIDNameSpace.LiveID_IdP.init(F$GenericAuthNameSpace.GlobalObjects_base.AS);
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 12} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 12} true;
    call $tmp2 := Alloc();
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\LiveIDLogin\VProgram\Program.cs"} {:sourceLine 12} true;
    call LiveIDNameSpace.LiveID_RP_For_vProgram.#ctor($tmp2);
    assume $DynamicType($tmp2) == T$LiveIDNameSpace.LiveID_RP_For_vProgram();
    assume $TypeConstructor($DynamicType($tmp2)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram;
    F$GenericAuthNameSpace.GlobalObjects_base.RP := $tmp2;
}



procedure GlobalObjectsForCST.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref);



implementation GlobalObjectsForCST.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 7} true;
    call GenericAuthNameSpace.GlobalObjects_base.#ctor($this);
}



procedure T$GlobalObjectsForCST.#cctor();



implementation T$GlobalObjectsForCST.#cctor()
{
}



function T$OpenIDConnectNameSpace.NondetOpenIDConnect() : Ref;

const unique T$OpenIDConnectNameSpace.NondetOpenIDConnect: int;

procedure OpenIDConnectNameSpace.NondetOpenIDConnect.JsonWebTokenClaims($this: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.NondetOpenIDConnect.JsonWebToken($this: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.NondetOpenIDConnect.IDTokenAndAccessTokenEntry($this: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.NondetOpenIDConnect.AuthorizationCodeEntry($this: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.NondetOpenIDConnect.AuthorizationCodeDictionary($this: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.NondetOpenIDConnect.IDTokenAndAccessTokenDictionary($this: Ref) returns ($result: Ref);



function T$OpenIDConnectNameSpace.RelyingParty() : Ref;

const unique T$OpenIDConnectNameSpace.RelyingParty: int;

procedure OpenIDConnectNameSpace.RelyingParty.#ctor($this: Ref);



procedure {:extern} OAuth20NameSpace.Client.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.RelyingParty.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 8} true;
    call OAuth20NameSpace.Client.#ctor($this);
}



procedure OpenIDConnectNameSpace.RelyingParty.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id1$in: Ref, return_uri1$in: Ref, client_secret1$in: Ref, TokenEndpointUrl1$in: Ref);



procedure {:extern} OAuth20NameSpace.Client.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id1$in: Ref, return_uri1$in: Ref, client_secret1$in: Ref, TokenEndpointUrl1$in: Ref);



implementation OpenIDConnectNameSpace.RelyingParty.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id1$in: Ref, return_uri1$in: Ref, client_secret1$in: Ref, TokenEndpointUrl1$in: Ref)
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
    assume {:breadcrumb 9} true;
    call OAuth20NameSpace.Client.#ctor$System.String$System.String$System.String$System.String($this, client_id1, return_uri1, client_secret1, TokenEndpointUrl1);
}



procedure OpenIDConnectNameSpace.RelyingParty.parseAuthenticationResponse$System.Web.HttpRequest($this: Ref, rawRequest$in: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.AuthenticationResponse.#ctor($this: Ref);



function T$OpenIDConnectNameSpace.AuthenticationResponse() : Ref;

const unique T$OpenIDConnectNameSpace.AuthenticationResponse: int;

procedure {:extern} System.Web.HttpContext.get_Current() returns ($result: Ref);



procedure {:extern} System.Web.HttpRequest.get_QueryString($this: Ref) returns ($result: Ref);



const {:value "code"} unique $string_literal_code_0: Ref;

procedure {:extern} System.Collections.Specialized.NameValueCollection.get_Item$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



var {:extern} F$OAuth20NameSpace.AuthorizationResponse.code: [Ref]Ref;

const {:value "state"} unique $string_literal_state_1: Ref;

var {:extern} F$OAuth20NameSpace.AuthorizationResponse.state: [Ref]Ref;

procedure {:extern} System.String.IsNullOrEmpty$System.String(value$in: Ref) returns ($result: bool);



implementation OpenIDConnectNameSpace.RelyingParty.parseAuthenticationResponse$System.Web.HttpRequest($this: Ref, rawRequest$in: Ref) returns ($result: Ref)
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
  var $tmp6: Ref;
  var $tmp7: bool;
  var local_2_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    rawRequest := rawRequest$in;
    assume {:breadcrumb 10} true;
    call $tmp0 := Alloc();
    call OpenIDConnectNameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenIDConnectNameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenIDConnectNameSpace.AuthenticationResponse;
    local_0_Ref := $tmp0;
    call $tmp1 := System.Web.HttpContext.get_Current();
    local_1_Ref := $tmp1;
    call $tmp2 := System.Web.HttpRequest.get_QueryString(rawRequest);
    call $tmp3 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp2, $string_literal_code_0);
    F$OAuth20NameSpace.AuthorizationResponse.code[local_0_Ref] := $tmp3;
    call $tmp4 := System.Web.HttpRequest.get_QueryString(rawRequest);
    call $tmp5 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp4, $string_literal_state_1);
    F$OAuth20NameSpace.AuthorizationResponse.state[local_0_Ref] := $tmp5;
    $tmp6 := local_0_Ref;
    assume $tmp6 != null;
    call $tmp7 := System.String.IsNullOrEmpty$System.String(F$OAuth20NameSpace.AuthorizationResponse.code[$tmp6]);
    if ($tmp7)
    {
        assume {:breadcrumb 11} true;
        local_2_Ref := null;
    }
    else
    {
        assume {:breadcrumb 12} true;
        local_2_Ref := local_0_Ref;
        goto IL_0053;
    }

  IL_0053:
    $result := local_2_Ref;
    return;
}



procedure OpenIDConnectNameSpace.RelyingParty.AuthenticationUsingAuthorizationCodeFlow$OpenIDConnectNameSpace.AuthenticationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref);



procedure {:extern} LiveIDNameSpace.LiveID_RP.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this: Ref, req$in: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.RelyingParty.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this: Ref, req$in: Ref) returns ($result: Ref);



function {:extern} T$LiveIDNameSpace.LiveID_RP() : Ref;

const {:extern} unique T$LiveIDNameSpace.LiveID_RP: int;

axiom $TypeConstructor(T$LiveIDNameSpace.LiveID_RP()) == T$LiveIDNameSpace.LiveID_RP;

implementation OpenIDConnectNameSpace.RelyingParty.AuthenticationUsingAuthorizationCodeFlow$OpenIDConnectNameSpace.AuthenticationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref)
{
  var codeResp: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var local_2_Ref: Ref;
  var $tmp6: Ref;
  var $localExc: Ref;
  var $label: int;

    codeResp := codeResp$in;
    assume {:breadcrumb 13} true;
    if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram)
    {
        call $tmp0 := OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse($this, codeResp);
        call $tmp1 := LiveIDNameSpace.LiveID_RP.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this, $tmp0);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP)
        {
            call $tmp2 := OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse($this, codeResp);
            call $tmp3 := LiveIDNameSpace.LiveID_RP.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this, $tmp2);
        }
        else
        {
            call $tmp4 := OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse($this, codeResp);
            call $tmp5 := OpenIDConnectNameSpace.RelyingParty.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this, $tmp4);
        }
    }

    local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram then $tmp1 else (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP then $tmp3 else $tmp5));
    if (local_1_Ref == null)
    {
        assume {:breadcrumb 14} true;
        local_2_Ref := null;
    }
    else
    {
        assume {:breadcrumb 15} true;
        call $tmp6 := OpenIDConnectNameSpace.RelyingParty.conclude$OpenIDConnectNameSpace.TokenResponse($this, local_1_Ref);
        local_2_Ref := $tmp6;
        goto IL_002a;
    }

  IL_002a:
    $result := local_2_Ref;
    return;
}



procedure OpenIDConnectNameSpace.TokenRequest.#ctor($this: Ref);



function T$OpenIDConnectNameSpace.TokenRequest() : Ref;

const unique T$OpenIDConnectNameSpace.TokenRequest: int;

var {:extern} F$OAuth20NameSpace.AccessTokenRequest.code: [Ref]Ref;

const {:value "authorization_code"} unique $string_literal_authorization_code_2: Ref;

var {:extern} F$OAuth20NameSpace.AccessTokenRequest.grant_type: [Ref]Ref;

procedure {:extern} OAuth20NameSpace.Client.get_return_uri($this: Ref) returns ($result: Ref);



var {:extern} F$OAuth20NameSpace.AccessTokenRequest.redirect_uri: [Ref]Ref;

procedure {:extern} OAuth20NameSpace.Client.get_client_id($this: Ref) returns ($result: Ref);



var {:extern} F$OAuth20NameSpace.AccessTokenRequest.client_id: [Ref]Ref;

var {:extern} F$CST.CST_Struct.SymT: [Ref]Ref;

procedure {:extern} System.Diagnostics.Stopwatch.#ctor($this: Ref);



function {:extern} T$System.Diagnostics.Stopwatch() : Ref;

const {:extern} unique T$System.Diagnostics.Stopwatch: int;

axiom $TypeConstructor(T$System.Diagnostics.Stopwatch()) == T$System.Diagnostics.Stopwatch;

procedure {:extern} System.Diagnostics.Stopwatch.Start($this: Ref);



procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct(o$in: Ref, in_msg$in: Ref, out_msg$in: Ref);



procedure {:extern} System.Diagnostics.Stopwatch.Stop($this: Ref);



const {:value "C:\Users\Daniel Song\Desktop\LiveID_RP_constructTokenRequest.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$LiveID_RP_constructTokenRequest.txt_3: Ref;

procedure {:extern} System.IO.File.Exists$System.String(path$in: Ref) returns ($result: bool);



procedure {:extern} System.IO.File.CreateText$System.String(path$in: Ref) returns ($result: Ref);



procedure {:extern} System.Diagnostics.Stopwatch.get_ElapsedMilliseconds($this: Ref) returns ($result: int);



procedure {:extern} System.IO.TextWriter.WriteLine$System.Int64($this: Ref, value$in: int);



procedure {:extern} System.IO.File.AppendText$System.String(path$in: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref)
{
  var codeResp: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_1_Ref: Ref;
  var $tmp5: Ref;
  var local_2_Ref: Ref;
  var $tmp6: bool;
  var $tmp7: Ref;
  var local_3_Ref: Ref;
  var $tmp8: int;
  var $tmp9: Ref;
  var $tmp10: int;
  var local_4_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    codeResp := codeResp$in;
    assume {:breadcrumb 16} true;
    call $tmp0 := Alloc();
    call OpenIDConnectNameSpace.TokenRequest.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenIDConnectNameSpace.TokenRequest();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenIDConnectNameSpace.TokenRequest;
    local_0_Ref := $tmp0;
    $tmp1 := codeResp;
    assume $tmp1 != null;
    F$OAuth20NameSpace.AccessTokenRequest.code[local_0_Ref] := F$OAuth20NameSpace.AuthorizationResponse.code[$tmp1];
    F$OAuth20NameSpace.AccessTokenRequest.grant_type[local_0_Ref] := $string_literal_authorization_code_2;
    call $tmp2 := OAuth20NameSpace.Client.get_return_uri($this);
    F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[local_0_Ref] := $tmp2;
    call $tmp3 := OAuth20NameSpace.Client.get_client_id($this);
    F$OAuth20NameSpace.AccessTokenRequest.client_id[local_0_Ref] := $tmp3;
    $tmp4 := codeResp;
    assume $tmp4 != null;
    F$CST.CST_Struct.SymT[local_0_Ref] := F$CST.CST_Struct.SymT[$tmp4];
    call $tmp5 := Alloc();
    call System.Diagnostics.Stopwatch.#ctor($tmp5);
    assume $DynamicType($tmp5) == T$System.Diagnostics.Stopwatch();
    assume $TypeConstructor($DynamicType($tmp5)) == T$System.Diagnostics.Stopwatch;
    local_1_Ref := $tmp5;
    call System.Diagnostics.Stopwatch.Start(local_1_Ref);
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct($this, codeResp, local_0_Ref);
    call System.Diagnostics.Stopwatch.Stop(local_1_Ref);
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$LiveID_RP_constructTokenRequest.txt_3;
    call $tmp6 := System.IO.File.Exists$System.String(local_2_Ref);
    if (!$tmp6)
    {
        assume {:breadcrumb 17} true;
        call $tmp7 := System.IO.File.CreateText$System.String(local_2_Ref);
        local_3_Ref := $tmp7;
        call $tmp8 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp8);
    }
    else
    {
        assume {:breadcrumb 18} true;
        call $tmp9 := System.IO.File.AppendText$System.String(local_2_Ref);
        local_3_Ref := $tmp9;
        call $tmp10 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp10);
    }

    local_4_Ref := local_0_Ref;
    goto IL_00d2;

  IL_00d2:
    $result := local_4_Ref;
    return;
}



procedure OpenIDConnectNameSpace.JsonDataStrcuture.#ctor($this: Ref);



function T$OpenIDConnectNameSpace.JsonDataStrcuture() : Ref;

const unique T$OpenIDConnectNameSpace.JsonDataStrcuture: int;

var {:extern} F$OAuth20NameSpace.Client.TokenEndpointUrl: [Ref]Ref;

const {:value "client_id={0}&redirect_uri={1}&client_secret={2}&code={3}&grant_type=authorization_code"} unique $string_literal_client_id$$0$$redirect_uri$$1$$client_secret$$2$$code$$3$$grant_type$authorization_code_4: Ref;

procedure {:extern} System.String.Format$System.String$System.Objectarray(format$in: Ref, args$in: Ref) returns ($result: Ref);



const {:value "POST"} unique $string_literal_POST_5: Ref;

procedure {:extern} HTTP.HTTPComm.HttpReq$System.String$System.String$System.String(url$in: Ref, post$in: Ref, method$in: Ref) returns ($result: Ref);



procedure {:extern} System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($this: Ref, type$in: Ref);



function {:extern} T$System.Runtime.Serialization.Json.DataContractJsonSerializer() : Ref;

const {:extern} unique T$System.Runtime.Serialization.Json.DataContractJsonSerializer: int;

axiom $TypeConstructor(T$System.Runtime.Serialization.Json.DataContractJsonSerializer()) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;

procedure {:extern} System.Net.WebResponse.GetResponseStream($this: Ref) returns ($result: Ref);



procedure {:extern} System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream($this: Ref, stream$in: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.TokenResponse.#ctor($this: Ref);



function T$OpenIDConnectNameSpace.TokenResponse() : Ref;

const unique T$OpenIDConnectNameSpace.TokenResponse: int;

var {:extern} F$OAuth20NameSpace.Client.client_secret: [Ref]Ref;

procedure OpenIDConnectNameSpace.TokenResponse.parseJasonDataStructure$OpenIDConnectNameSpace.JsonDataStrcuture$System.String($this: Ref, JsonDataStrcuture$in: Ref, clientSecret$in: Ref) returns ($result: bool);



implementation OpenIDConnectNameSpace.RelyingParty.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_2_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var local_4_Ref: Ref;
  var $tmp8: bool;
  var local_5_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 19} true;
    call $tmp0 := Alloc();
    call OpenIDConnectNameSpace.JsonDataStrcuture.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenIDConnectNameSpace.JsonDataStrcuture();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenIDConnectNameSpace.JsonDataStrcuture;
    local_0_Ref := $tmp0;
    assume $this != null;
    call $tmp1 := Alloc();
    assume $ArrayLength($tmp1) == 1 * 5;
    call $tmp2 := System.String.Format$System.String$System.Objectarray($string_literal_client_id$$0$$redirect_uri$$1$$client_secret$$2$$code$$3$$grant_type$authorization_code_4, $tmp1);
    call $tmp3 := HTTP.HTTPComm.HttpReq$System.String$System.String$System.String(F$OAuth20NameSpace.Client.TokenEndpointUrl[$this], $tmp2, $string_literal_POST_5);
    local_2_Ref := $tmp3;
    if (local_2_Ref != null)
    {
        assume {:breadcrumb 20} true;
        call $tmp4 := Alloc();
        call System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($tmp4, T$OpenIDConnectNameSpace.JsonDataStrcuture());
        assume $DynamicType($tmp4) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer();
        assume $TypeConstructor($DynamicType($tmp4)) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;
        call $tmp5 := System.Net.WebResponse.GetResponseStream(local_2_Ref);
        call $tmp6 := System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream($tmp4, $tmp5);
        local_0_Ref := $As($tmp6, T$OpenIDConnectNameSpace.JsonDataStrcuture());
        if (local_0_Ref != null)
        {
            assume {:breadcrumb 22} true;
            call $tmp7 := Alloc();
            call OpenIDConnectNameSpace.TokenResponse.#ctor($tmp7);
            assume $DynamicType($tmp7) == T$OpenIDConnectNameSpace.TokenResponse();
            assume $TypeConstructor($DynamicType($tmp7)) == T$OpenIDConnectNameSpace.TokenResponse;
            local_4_Ref := $tmp7;
            assume $this != null;
            call $tmp8 := OpenIDConnectNameSpace.TokenResponse.parseJasonDataStructure$OpenIDConnectNameSpace.JsonDataStrcuture$System.String(local_4_Ref, local_0_Ref, F$OAuth20NameSpace.Client.client_secret[$this]);
            if ($tmp8)
            {
                assume {:breadcrumb 24} true;
                local_5_Ref := local_4_Ref;
                goto IL_00e1;
            }
            else
            {
                assume {:breadcrumb 25} true;
            }

            local_5_Ref := null;
            goto IL_00e1;
        }
        else
        {
            assume {:breadcrumb 23} true;
        }
    }
    else
    {
        assume {:breadcrumb 21} true;
    }

    local_5_Ref := null;
    goto IL_00e1;

  IL_00e1:
    $result := local_5_Ref;
    return;
}



procedure {:extern} GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref);



function {:extern} T$GenericAuthNameSpace.RP.AuthenticationConclusion() : Ref;

const {:extern} unique T$GenericAuthNameSpace.RP.AuthenticationConclusion: int;

axiom $TypeConstructor(T$GenericAuthNameSpace.RP.AuthenticationConclusion()) == T$GenericAuthNameSpace.RP.AuthenticationConclusion;

var F$OpenIDConnectNameSpace.TokenResponse.id_token: [Ref]Ref;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.get_Claims($this: Ref) returns ($result: Ref);



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_UserId($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID: [Ref]Ref;

procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct$System.Boolean$System.Boolean(o$in: Ref, in_msg$in: Ref, out_msg$in: Ref, signed$in: bool, server_to_server$in: bool);



const {:value "C:\Users\Daniel Song\Desktop\LiveID_RP_conclude.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$LiveID_RP_conclude.txt_6: Ref;

procedure {:extern} GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool);



function {:extern} T$OAuth20NameSpace.Client() : Ref;

const {:extern} unique T$OAuth20NameSpace.Client: int;

axiom $TypeConstructor(T$OAuth20NameSpace.Client()) == T$OAuth20NameSpace.Client;

implementation OpenIDConnectNameSpace.RelyingParty.conclude$OpenIDConnectNameSpace.TokenResponse($this: Ref, tokenResp$in: Ref) returns ($result: Ref)
{
  var tokenResp: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_1_Ref: Ref;
  var $tmp5: Ref;
  var local_2_Ref: Ref;
  var $tmp6: bool;
  var $tmp7: Ref;
  var local_3_Ref: Ref;
  var $tmp8: int;
  var $tmp9: Ref;
  var $tmp10: int;
  var $tmp11: bool;
  var $tmp12: bool;
  var $tmp13: bool;
  var $tmp14: bool;
  var $tmp15: bool;
  var local_4_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    tokenResp := tokenResp$in;
    assume {:breadcrumb 26} true;
    call $tmp0 := Alloc();
    call GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$GenericAuthNameSpace.RP.AuthenticationConclusion();
    assume $TypeConstructor($DynamicType($tmp0)) == T$GenericAuthNameSpace.RP.AuthenticationConclusion;
    local_0_Ref := $tmp0;
    $tmp1 := tokenResp;
    assume $tmp1 != null;
    $tmp2 := F$OpenIDConnectNameSpace.TokenResponse.id_token[$tmp1];
    call $tmp3 := OpenIDConnectNameSpace.JsonWebToken.get_Claims($tmp2);
    call $tmp4 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_UserId($tmp3);
    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[local_0_Ref] := $tmp4;
    call $tmp5 := Alloc();
    call System.Diagnostics.Stopwatch.#ctor($tmp5);
    assume $DynamicType($tmp5) == T$System.Diagnostics.Stopwatch();
    assume $TypeConstructor($DynamicType($tmp5)) == T$System.Diagnostics.Stopwatch;
    local_1_Ref := $tmp5;
    call System.Diagnostics.Stopwatch.Start(local_1_Ref);
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct$System.Boolean$System.Boolean($this, tokenResp, local_0_Ref, false, true);
    call System.Diagnostics.Stopwatch.Stop(local_1_Ref);
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$LiveID_RP_conclude.txt_6;
    call $tmp6 := System.IO.File.Exists$System.String(local_2_Ref);
    if (!$tmp6)
    {
        assume {:breadcrumb 27} true;
        call $tmp7 := System.IO.File.CreateText$System.String(local_2_Ref);
        local_3_Ref := $tmp7;
        call $tmp8 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp8);
    }
    else
    {
        assume {:breadcrumb 28} true;
        call $tmp9 := System.IO.File.AppendText$System.String(local_2_Ref);
        local_3_Ref := $tmp9;
        call $tmp10 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp10);
    }

    if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram)
    {
        call $tmp11 := LiveIDNameSpace.LiveID_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP)
        {
            call $tmp12 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.RelyingParty)
            {
                call $tmp13 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.Client)
                {
                    call $tmp14 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
                }
                else
                {
                    call $tmp15 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
                }
            }
        }
    }

    if ((if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram then $tmp11 else (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP then $tmp12 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.RelyingParty then $tmp13 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.Client then $tmp14 else $tmp15)))))
    {
        assume {:breadcrumb 29} true;
        local_4_Ref := local_0_Ref;
    }
    else
    {
        assume {:breadcrumb 30} true;
        local_4_Ref := null;
        goto IL_00c4;
    }

  IL_00c4:
    $result := local_4_Ref;
    return;
}



procedure T$OpenIDConnectNameSpace.RelyingParty.#cctor();



implementation T$OpenIDConnectNameSpace.RelyingParty.#cctor()
{
}



var F$OpenIDConnectNameSpace.JsonDataStrcuture.$AccessToken$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonDataStrcuture.$AuthenticationToken$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonDataStrcuture.$RefreshToken$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonDataStrcuture.$ExpiresIn$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonDataStrcuture.$Scope$k__BackingField: [Ref]Ref;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_AccessToken($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_AccessToken($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 31} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonDataStrcuture.$AccessToken$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_AccessToken$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_AccessToken$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 32} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AccessToken$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_AuthenticationToken($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_AuthenticationToken($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 33} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonDataStrcuture.$AuthenticationToken$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_AuthenticationToken$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_AuthenticationToken$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 34} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AuthenticationToken$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_RefreshToken($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_RefreshToken($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 35} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonDataStrcuture.$RefreshToken$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_RefreshToken$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_RefreshToken$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 36} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$RefreshToken$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_ExpiresIn($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_ExpiresIn($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 37} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonDataStrcuture.$ExpiresIn$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_ExpiresIn$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_ExpiresIn$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 38} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$ExpiresIn$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_Scope($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_Scope($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 39} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonDataStrcuture.$Scope$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_Scope$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_Scope$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 40} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$Scope$k__BackingField[$this] := value;
}



implementation OpenIDConnectNameSpace.JsonDataStrcuture.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AccessToken$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AuthenticationToken$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$RefreshToken$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$ExpiresIn$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$Scope$k__BackingField[$this] := null;
    assume {:breadcrumb 41} true;
    call System.Object.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.JsonDataStrcuture.#cctor();



implementation T$OpenIDConnectNameSpace.JsonDataStrcuture.#cctor()
{
}



procedure {:extern} OAuth20NameSpace.AccessTokenRequest.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.TokenRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 42} true;
    call OAuth20NameSpace.AccessTokenRequest.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.TokenRequest.#cctor();



implementation T$OpenIDConnectNameSpace.TokenRequest.#cctor()
{
}



function T$OpenIDConnectNameSpace.JsonWebToken() : Ref;

const unique T$OpenIDConnectNameSpace.JsonWebToken: int;

var F$OpenIDConnectNameSpace.JsonWebToken.ClaimsJsonSerializer: Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.EnvelopeJsonSerializer: Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.UTF8Encoder: Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.SHA256Provider: Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField: [Ref]Ref;

implementation OpenIDConnectNameSpace.JsonWebToken.get_Claims($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 43} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.set_Claims$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.set_Claims$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 44} true;
    F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 45} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.set_Envelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.set_Envelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 46} true;
    F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.get_Signature($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.get_Signature($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 47} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.set_Signature$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.set_Signature$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 48} true;
    F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField[$this] := value;
}



procedure OpenIDConnectNameSpace.JsonWebToken.get_IsExpired($this: Ref) returns ($result: bool);



procedure OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Expiration($this: Ref) returns ($result: Ref);



procedure System.DateTime.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



procedure {:extern} System.DateTime.get_Now() returns ($result: Ref);



procedure {:extern} System.DateTime.op_LessThan$System.DateTime$System.DateTime(t1$in: Ref, t2$in: Ref) returns ($result: bool);
  free requires t1$in != t2$in;



implementation OpenIDConnectNameSpace.JsonWebToken.get_IsExpired($this: Ref) returns ($result: bool)
{
  var local_0_bool: bool;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 49} true;
    call $tmp0 := OpenIDConnectNameSpace.JsonWebToken.get_Claims($this);
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Expiration($tmp0);
    call $tmp2 := System.DateTime.#copy_ctor($tmp1);
    call $tmp3 := System.DateTime.get_Now();
    call $tmp4 := System.DateTime.#copy_ctor($tmp3);
    call $tmp5 := System.DateTime.op_LessThan$System.DateTime$System.DateTime($tmp2, $tmp4);
    local_0_bool := $tmp5;
    goto IL_0019;

  IL_0019:
    $result := local_0_bool;
    return;
}



procedure OpenIDConnectNameSpace.JsonWebToken.#ctor$System.String$System.Collections.Generic.Dictionary$System.Int32$System.String$($this: Ref, token$in: Ref, keyIdsKeys$in: Ref);



procedure OpenIDConnectNameSpace.JsonWebToken.SplitToken$System.String($this: Ref, token$in: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.JsonWebToken.GetClaimsFromTokenSegment$System.String($this: Ref, claimsTokenSegment$in: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.JsonWebToken.GetEnvelopeFromTokenSegment$System.String($this: Ref, envelopeTokenSegment$in: Ref) returns ($result: Ref);



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($this: Ref) returns ($result: int);



procedure {:extern} System.Collections.Generic.Dictionary`2.ContainsKey$`0($this: Ref, key$in: Ref) returns ($result: bool);



const {:value "Could not find key with id {0}"} unique $string_literal_Could$not$find$key$with$id$$0$_7: Ref;

procedure {:extern} System.String.Format$System.String$System.Object(format$in: Ref, arg0$in: Ref) returns ($result: Ref);



procedure {:extern} System.Exception.#ctor$System.String($this: Ref, message$in: Ref);



function {:extern} T$System.Exception() : Ref;

const {:extern} unique T$System.Exception: int;

axiom $TypeConstructor(T$System.Exception()) == T$System.Exception;

procedure OpenIDConnectNameSpace.JsonWebToken.ValidateEnvelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this: Ref, envelope$in: Ref);



procedure {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0($this: Ref, key$in: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.JsonWebToken.ValidateSignature$System.String($this: Ref, key$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.#ctor$System.String$System.Collections.Generic.Dictionary$System.Int32$System.String$($this: Ref, token$in: Ref, keyIdsKeys$in: Ref)
{
  var token: Ref;
  var keyIdsKeys: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: int;
  var $tmp5: bool;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: int;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: int;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $localExc: Ref;
  var $label: int;

    token := token$in;
    keyIdsKeys := keyIdsKeys$in;
    F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField[$this] := null;
    assume {:breadcrumb 50} true;
    call System.Object.#ctor($this);
    call $tmp0 := OpenIDConnectNameSpace.JsonWebToken.SplitToken$System.String($this, token);
    if ($Exception != null)
    {
        return;
    }

    local_0_Ref := $tmp0;
    assume local_0_Ref != null;
    F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this] := $ArrayContents[local_0_Ref][1];
    assume $this != null;
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.GetClaimsFromTokenSegment$System.String($this, F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this]);
    if ($Exception != null)
    {
        return;
    }

    call OpenIDConnectNameSpace.JsonWebToken.set_Claims$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims($this, $tmp1);
    assume local_0_Ref != null;
    F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this] := $ArrayContents[local_0_Ref][0];
    assume $this != null;
    call $tmp2 := OpenIDConnectNameSpace.JsonWebToken.GetEnvelopeFromTokenSegment$System.String($this, F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this]);
    if ($Exception != null)
    {
        return;
    }

    call OpenIDConnectNameSpace.JsonWebToken.set_Envelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this, $tmp2);
    assume local_0_Ref != null;
    call OpenIDConnectNameSpace.JsonWebToken.set_Signature$System.String($this, $ArrayContents[local_0_Ref][2]);
    call $tmp3 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
    call $tmp4 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($tmp3);
    assume Union2Int(Int2Union($tmp4)) == $tmp4;
    call $tmp5 := System.Collections.Generic.Dictionary`2.ContainsKey$`0(keyIdsKeys, Int2Union($tmp4));
    if (!$tmp5)
    {
        assume {:breadcrumb 51} true;
        call $tmp6 := Alloc();
        call $tmp7 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
        call $tmp8 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($tmp7);
        call $tmp9 := $BoxFromInt($tmp8);
        call $tmp10 := System.String.Format$System.String$System.Object($string_literal_Could$not$find$key$with$id$$0$_7, $tmp9);
        call System.Exception.#ctor$System.String($tmp6, $tmp10);
        assume $DynamicType($tmp6) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp6)) == T$System.Exception;
        $Exception := $tmp6;
        return;
    }
    else
    {
        assume {:breadcrumb 52} true;
    }

    call $tmp11 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
    call OpenIDConnectNameSpace.JsonWebToken.ValidateEnvelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this, $tmp11);
    if ($Exception != null)
    {
        return;
    }

    call $tmp12 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
    call $tmp13 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($tmp12);
    assume Union2Int(Int2Union($tmp13)) == $tmp13;
    call $tmp15 := System.Collections.Generic.Dictionary`2.get_Item$`0(keyIdsKeys, Int2Union($tmp13));
    $tmp14 := $tmp15;
    call OpenIDConnectNameSpace.JsonWebToken.ValidateSignature$System.String($this, $tmp14);
    if ($Exception != null)
    {
        return;
    }
}



procedure OpenIDConnectNameSpace.JsonWebToken.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField[$this] := null;
    assume {:breadcrumb 53} true;
    call System.Object.#ctor($this);
}



procedure OpenIDConnectNameSpace.JsonWebToken.Base64UrlDecode$System.String($this: Ref, encodedSegment$in: Ref) returns ($result: Ref);



procedure {:extern} System.IO.MemoryStream.#ctor$System.Bytearray($this: Ref, buffer$in: Ref);



function {:extern} T$System.IO.MemoryStream() : Ref;

const {:extern} unique T$System.IO.MemoryStream: int;

axiom $TypeConstructor(T$System.IO.MemoryStream()) == T$System.IO.MemoryStream;

function T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims() : Ref;

const unique T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims: int;

implementation OpenIDConnectNameSpace.JsonWebToken.GetClaimsFromTokenSegment$System.String($this: Ref, claimsTokenSegment$in: Ref) returns ($result: Ref)
{
  var claimsTokenSegment: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_2_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    claimsTokenSegment := claimsTokenSegment$in;
    assume {:breadcrumb 54} true;
    call $tmp0 := Alloc();
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.Base64UrlDecode$System.String($this, claimsTokenSegment);
    if ($Exception != null)
    {
        return;
    }

    call System.IO.MemoryStream.#ctor$System.Bytearray($tmp0, $tmp1);
    assume $DynamicType($tmp0) == T$System.IO.MemoryStream();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.IO.MemoryStream;
    local_1_Ref := $tmp0;
    call $tmp2 := System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream(F$OpenIDConnectNameSpace.JsonWebToken.ClaimsJsonSerializer, local_1_Ref);
    local_2_Ref := $As($tmp2, T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims());
    $result := local_2_Ref;
    return;
}



function T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope() : Ref;

const unique T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope: int;

implementation OpenIDConnectNameSpace.JsonWebToken.GetEnvelopeFromTokenSegment$System.String($this: Ref, envelopeTokenSegment$in: Ref) returns ($result: Ref)
{
  var envelopeTokenSegment: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_2_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    envelopeTokenSegment := envelopeTokenSegment$in;
    assume {:breadcrumb 55} true;
    call $tmp0 := Alloc();
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.Base64UrlDecode$System.String($this, envelopeTokenSegment);
    if ($Exception != null)
    {
        return;
    }

    call System.IO.MemoryStream.#ctor$System.Bytearray($tmp0, $tmp1);
    assume $DynamicType($tmp0) == T$System.IO.MemoryStream();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.IO.MemoryStream;
    local_1_Ref := $tmp0;
    call $tmp2 := System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream(F$OpenIDConnectNameSpace.JsonWebToken.EnvelopeJsonSerializer, local_1_Ref);
    local_2_Ref := $As($tmp2, T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope());
    $result := local_2_Ref;
    return;
}



const {:value "Token is empty or null."} unique $string_literal_Token$is$empty$or$null._8: Ref;

procedure {:extern} System.String.Split$System.Chararray($this: Ref, separator$in: Ref) returns ($result: Ref);



const {:value "Invalid token format. Expected Envelope.Claims.Signature"} unique $string_literal_Invalid$token$format.$Expected$Envelope.Claims.Signature_9: Ref;

const {:value "Invalid token format. Envelope must not be empty"} unique $string_literal_Invalid$token$format.$Envelope$must$not$be$empty_10: Ref;

const {:value "Invalid token format. Claims must not be empty"} unique $string_literal_Invalid$token$format.$Claims$must$not$be$empty_11: Ref;

const {:value "Invalid token format. Signature must not be empty"} unique $string_literal_Invalid$token$format.$Signature$must$not$be$empty_12: Ref;

implementation OpenIDConnectNameSpace.JsonWebToken.SplitToken$System.String($this: Ref, token$in: Ref) returns ($result: Ref)
{
  var token: Ref;
  var $tmp0: bool;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var local_0_Ref: Ref;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $tmp6: Ref;
  var $tmp7: bool;
  var $tmp8: Ref;
  var $tmp9: bool;
  var $tmp10: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    token := token$in;
    assume {:breadcrumb 56} true;
    call $tmp0 := System.String.IsNullOrEmpty$System.String(token);
    if ($tmp0)
    {
        assume {:breadcrumb 57} true;
        call $tmp1 := Alloc();
        call System.Exception.#ctor$System.String($tmp1, $string_literal_Token$is$empty$or$null._8);
        assume $DynamicType($tmp1) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp1)) == T$System.Exception;
        $Exception := $tmp1;
        return;
    }
    else
    {
        assume {:breadcrumb 58} true;
    }

    call $tmp2 := Alloc();
    assume $ArrayLength($tmp2) == 1 * 1;
    call $tmp3 := System.String.Split$System.Chararray(token, $tmp2);
    local_0_Ref := $tmp3;
    if ($ArrayLength(local_0_Ref) != 3)
    {
        assume {:breadcrumb 59} true;
        call $tmp4 := Alloc();
        call System.Exception.#ctor$System.String($tmp4, $string_literal_Invalid$token$format.$Expected$Envelope.Claims.Signature_9);
        assume $DynamicType($tmp4) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp4)) == T$System.Exception;
        $Exception := $tmp4;
        return;
    }
    else
    {
        assume {:breadcrumb 60} true;
    }

    assume local_0_Ref != null;
    call $tmp5 := System.String.IsNullOrEmpty$System.String($ArrayContents[local_0_Ref][0]);
    if ($tmp5)
    {
        assume {:breadcrumb 61} true;
        call $tmp6 := Alloc();
        call System.Exception.#ctor$System.String($tmp6, $string_literal_Invalid$token$format.$Envelope$must$not$be$empty_10);
        assume $DynamicType($tmp6) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp6)) == T$System.Exception;
        $Exception := $tmp6;
        return;
    }
    else
    {
        assume {:breadcrumb 62} true;
    }

    assume local_0_Ref != null;
    call $tmp7 := System.String.IsNullOrEmpty$System.String($ArrayContents[local_0_Ref][1]);
    if ($tmp7)
    {
        assume {:breadcrumb 63} true;
        call $tmp8 := Alloc();
        call System.Exception.#ctor$System.String($tmp8, $string_literal_Invalid$token$format.$Claims$must$not$be$empty_11);
        assume $DynamicType($tmp8) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp8)) == T$System.Exception;
        $Exception := $tmp8;
        return;
    }
    else
    {
        assume {:breadcrumb 64} true;
    }

    assume local_0_Ref != null;
    call $tmp9 := System.String.IsNullOrEmpty$System.String($ArrayContents[local_0_Ref][2]);
    if ($tmp9)
    {
        assume {:breadcrumb 65} true;
        call $tmp10 := Alloc();
        call System.Exception.#ctor$System.String($tmp10, $string_literal_Invalid$token$format.$Signature$must$not$be$empty_12);
        assume $DynamicType($tmp10) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp10)) == T$System.Exception;
        $Exception := $tmp10;
        return;
    }
    else
    {
        assume {:breadcrumb 66} true;
    }

    local_1_Ref := local_0_Ref;
    goto IL_0099;

  IL_0099:
    $result := local_1_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Type($this: Ref) returns ($result: Ref);



const {:value "JWT"} unique $string_literal_JWT_13: Ref;

const {:value "Unsupported token type"} unique $string_literal_Unsupported$token$type_14: Ref;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Algorithm($this: Ref) returns ($result: Ref);



const {:value "HS256"} unique $string_literal_HS256_15: Ref;

const {:value "Unsupported crypto algorithm"} unique $string_literal_Unsupported$crypto$algorithm_16: Ref;

implementation OpenIDConnectNameSpace.JsonWebToken.ValidateEnvelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this: Ref, envelope$in: Ref)
{
  var envelope: Ref;
  var $tmp0: Ref;
  var $tmp1: bool;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: bool;
  var $tmp5: Ref;
  var $localExc: Ref;
  var $label: int;

    envelope := envelope$in;
    assume {:breadcrumb 67} true;
    call $tmp0 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Type(envelope);
    call $tmp1 := System.String.op_Inequality$System.String$System.String($tmp0, $string_literal_JWT_13);
    if ($tmp1)
    {
        assume {:breadcrumb 68} true;
        call $tmp2 := Alloc();
        call System.Exception.#ctor$System.String($tmp2, $string_literal_Unsupported$token$type_14);
        assume $DynamicType($tmp2) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp2)) == T$System.Exception;
        $Exception := $tmp2;
        return;
    }
    else
    {
        assume {:breadcrumb 69} true;
    }

    call $tmp3 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Algorithm(envelope);
    call $tmp4 := System.String.op_Inequality$System.String$System.String($tmp3, $string_literal_HS256_15);
    if ($tmp4)
    {
        assume {:breadcrumb 70} true;
        call $tmp5 := Alloc();
        call System.Exception.#ctor$System.String($tmp5, $string_literal_Unsupported$crypto$algorithm_16);
        assume $DynamicType($tmp5) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp5)) == T$System.Exception;
        $Exception := $tmp5;
        return;
    }
    else
    {
        assume {:breadcrumb 71} true;
    }
}



const {:value "JWTSig"} unique $string_literal_JWTSig_17: Ref;

procedure {:extern} System.String.Concat$System.String$System.String(str0$in: Ref, str1$in: Ref) returns ($result: Ref);



procedure {:extern} System.Text.Encoding.GetBytes$System.String($this: Ref, s$in: Ref) returns ($result: Ref);



procedure {:extern} System.Security.Cryptography.HashAlgorithm.ComputeHash$System.Bytearray($this: Ref, buffer$in: Ref) returns ($result: Ref);



const {:value "."} unique $string_literal_._18: Ref;

procedure {:extern} System.String.Concat$System.String$System.String$System.String(str0$in: Ref, str1$in: Ref, str2$in: Ref) returns ($result: Ref);



procedure {:extern} System.Security.Cryptography.HMACSHA256.#ctor$System.Bytearray($this: Ref, key$in: Ref);



function {:extern} T$System.Security.Cryptography.HMACSHA256() : Ref;

const {:extern} unique T$System.Security.Cryptography.HMACSHA256: int;

axiom $TypeConstructor(T$System.Security.Cryptography.HMACSHA256()) == T$System.Security.Cryptography.HMACSHA256;

procedure OpenIDConnectNameSpace.JsonWebToken.Base64UrlEncode$System.Bytearray($this: Ref, arg$in: Ref) returns ($result: Ref);



const {:value "Signature does not match."} unique $string_literal_Signature$does$not$match._19: Ref;

implementation OpenIDConnectNameSpace.JsonWebToken.ValidateSignature$System.String($this: Ref, key$in: Ref)
{
  var key: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_2_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_3_Ref: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: bool;
  var $tmp10: Ref;
  var $localExc: Ref;
  var $label: int;

    key := key$in;
    assume {:breadcrumb 72} true;
    call $tmp0 := System.String.Concat$System.String$System.String(key, $string_literal_JWTSig_17);
    call $tmp1 := System.Text.Encoding.GetBytes$System.String(F$OpenIDConnectNameSpace.JsonWebToken.UTF8Encoder, $tmp0);
    call $tmp2 := System.Security.Cryptography.HashAlgorithm.ComputeHash$System.Bytearray(F$OpenIDConnectNameSpace.JsonWebToken.SHA256Provider, $tmp1);
    local_1_Ref := $tmp2;
    assume $this != null;
    assume $this != null;
    call $tmp3 := System.String.Concat$System.String$System.String$System.String(F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this], $string_literal_._18, F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this]);
    call $tmp4 := System.Text.Encoding.GetBytes$System.String(F$OpenIDConnectNameSpace.JsonWebToken.UTF8Encoder, $tmp3);
    local_2_Ref := $tmp4;
    call $tmp5 := Alloc();
    call System.Security.Cryptography.HMACSHA256.#ctor$System.Bytearray($tmp5, local_1_Ref);
    assume $DynamicType($tmp5) == T$System.Security.Cryptography.HMACSHA256();
    assume $TypeConstructor($DynamicType($tmp5)) == T$System.Security.Cryptography.HMACSHA256;
    local_3_Ref := $tmp5;
    call $tmp6 := System.Security.Cryptography.HashAlgorithm.ComputeHash$System.Bytearray(local_3_Ref, local_2_Ref);
    call $tmp7 := OpenIDConnectNameSpace.JsonWebToken.Base64UrlEncode$System.Bytearray($this, $tmp6);
    call $tmp8 := OpenIDConnectNameSpace.JsonWebToken.get_Signature($this);
    call $tmp9 := System.String.op_Inequality$System.String$System.String($tmp7, $tmp8);
    if ($tmp9)
    {
        assume {:breadcrumb 73} true;
        call $tmp10 := Alloc();
        call System.Exception.#ctor$System.String($tmp10, $string_literal_Signature$does$not$match._19);
        assume $DynamicType($tmp10) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp10)) == T$System.Exception;
        $Exception := $tmp10;
        return;
    }
    else
    {
        assume {:breadcrumb 74} true;
    }
}



procedure {:extern} System.String.Replace$System.Char$System.Char($this: Ref, oldChar$in: int, newChar$in: int) returns ($result: Ref);



procedure {:extern} System.String.get_Length($this: Ref) returns ($result: int);



const {:value "=="} unique $string_literal_$$_20: Ref;

const {:value "="} unique $string_literal_$_21: Ref;

const {:value "Illegal base64url string"} unique $string_literal_Illegal$base64url$string_22: Ref;

procedure {:extern} System.Convert.FromBase64String$System.String(s$in: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.Base64UrlDecode$System.String($this: Ref, encodedSegment$in: Ref) returns ($result: Ref)
{
  var encodedSegment: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: int;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    encodedSegment := encodedSegment$in;
    assume {:breadcrumb 75} true;
    local_0_Ref := encodedSegment;
    call $tmp0 := System.String.Replace$System.Char$System.Char(local_0_Ref, 45, 43);
    local_0_Ref := $tmp0;
    call $tmp1 := System.String.Replace$System.Char$System.Char(local_0_Ref, 95, 47);
    local_0_Ref := $tmp1;
    call $tmp2 := System.String.get_Length(local_0_Ref);
    if ($tmp2 mod 4 == 0)
    {
        goto IL_003a;
    }
    else if ($tmp2 mod 4 == 1)
    {
        goto IL_0058;
    }
    else if ($tmp2 mod 4 == 2)
    {
        goto IL_003c;
    }
    else if ($tmp2 mod 4 == 3)
    {
        goto IL_004a;
    }

    goto IL_0058;

  IL_003a:
    goto IL_0063;

  IL_003c:
    call $tmp3 := System.String.Concat$System.String$System.String(local_0_Ref, $string_literal_$$_20);
    local_0_Ref := $tmp3;
    goto IL_0063;

  IL_004a:
    call $tmp4 := System.String.Concat$System.String$System.String(local_0_Ref, $string_literal_$_21);
    local_0_Ref := $tmp4;
    goto IL_0063;

  IL_0058:
    call $tmp5 := Alloc();
    call System.Exception.#ctor$System.String($tmp5, $string_literal_Illegal$base64url$string_22);
    assume $DynamicType($tmp5) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp5)) == T$System.Exception;
    $Exception := $tmp5;
    return;

  IL_0063:
    call $tmp6 := System.Convert.FromBase64String$System.String(local_0_Ref);
    local_1_Ref := $tmp6;
    goto IL_006c;

  IL_006c:
    $result := local_1_Ref;
    return;
}



procedure {:extern} System.Convert.ToBase64String$System.Bytearray(inArray$in: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.Base64UrlEncode$System.Bytearray($this: Ref, arg$in: Ref) returns ($result: Ref)
{
  var arg: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    arg := arg$in;
    assume {:breadcrumb 76} true;
    call $tmp0 := System.Convert.ToBase64String$System.Bytearray(arg);
    call $tmp1 := Alloc();
    assume $ArrayLength($tmp1) == 1 * 1;
    call $tmp2 := System.String.Split$System.Chararray($tmp0, $tmp1);
    assume $tmp2 != null;
    local_0_Ref := $ArrayContents[$tmp2][0];
    call $tmp3 := System.String.Replace$System.Char$System.Char(local_0_Ref, 43, 45);
    local_0_Ref := $tmp3;
    call $tmp4 := System.String.Replace$System.Char$System.Char(local_0_Ref, 47, 95);
    local_0_Ref := $tmp4;
    local_1_Ref := local_0_Ref;
    goto IL_0038;

  IL_0038:
    $result := local_1_Ref;
    return;
}



procedure OpenIDConnectNameSpace.JsonWebToken.#cctor();



procedure {:extern} System.Text.UTF8Encoding.#ctor$System.Boolean$System.Boolean($this: Ref, encoderShouldEmitUTF8Identifier$in: bool, throwOnInvalidBytes$in: bool);



function {:extern} T$System.Text.UTF8Encoding() : Ref;

const {:extern} unique T$System.Text.UTF8Encoding: int;

axiom $TypeConstructor(T$System.Text.UTF8Encoding()) == T$System.Text.UTF8Encoding;

procedure {:extern} System.Security.Cryptography.SHA256Managed.#ctor($this: Ref);



function {:extern} T$System.Security.Cryptography.SHA256Managed() : Ref;

const {:extern} unique T$System.Security.Cryptography.SHA256Managed: int;

axiom $TypeConstructor(T$System.Security.Cryptography.SHA256Managed()) == T$System.Security.Cryptography.SHA256Managed;

implementation OpenIDConnectNameSpace.JsonWebToken.#cctor()
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    F$OpenIDConnectNameSpace.JsonWebToken.ClaimsJsonSerializer := null;
    F$OpenIDConnectNameSpace.JsonWebToken.EnvelopeJsonSerializer := null;
    F$OpenIDConnectNameSpace.JsonWebToken.UTF8Encoder := null;
    F$OpenIDConnectNameSpace.JsonWebToken.SHA256Provider := null;
    assume {:breadcrumb 77} true;
    call $tmp0 := Alloc();
    call System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($tmp0, T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims());
    assume $DynamicType($tmp0) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;
    F$OpenIDConnectNameSpace.JsonWebToken.ClaimsJsonSerializer := $tmp0;
    call $tmp1 := Alloc();
    call System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($tmp1, T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope());
    assume $DynamicType($tmp1) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer();
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;
    F$OpenIDConnectNameSpace.JsonWebToken.EnvelopeJsonSerializer := $tmp1;
    call $tmp2 := Alloc();
    call System.Text.UTF8Encoding.#ctor$System.Boolean$System.Boolean($tmp2, true, true);
    assume $DynamicType($tmp2) == T$System.Text.UTF8Encoding();
    assume $TypeConstructor($DynamicType($tmp2)) == T$System.Text.UTF8Encoding;
    F$OpenIDConnectNameSpace.JsonWebToken.UTF8Encoder := $tmp2;
    call $tmp3 := Alloc();
    call System.Security.Cryptography.SHA256Managed.#ctor($tmp3);
    assume $DynamicType($tmp3) == T$System.Security.Cryptography.SHA256Managed();
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Security.Cryptography.SHA256Managed;
    F$OpenIDConnectNameSpace.JsonWebToken.SHA256Provider := $tmp3;
}



var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$expUnixTime$k__BackingField: [Ref]int;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Issuer$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Audience$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$UserId$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Version$k__BackingField: [Ref]int;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$ClientIdentifier$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$AppId$k__BackingField: [Ref]Ref;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_expUnixTime($this: Ref) returns ($result: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_expUnixTime($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 78} true;
    assume $this != null;
    local_0_int := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$expUnixTime$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_int;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_expUnixTime$System.Int32($this: Ref, value$in: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_expUnixTime$System.Int32($this: Ref, value$in: int)
{
  var value: int;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 79} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$expUnixTime$k__BackingField[$this] := value;
}



procedure System.DateTime.#default_ctor($this: Ref);



function {:extern} T$System.DateTime() : Ref;

const {:extern} unique T$System.DateTime: int;

axiom $TypeConstructor(T$System.DateTime()) == T$System.DateTime;

procedure {:extern} System.Nullable`1.get_HasValue($this: Ref) returns ($result: bool);



procedure System.Nullable.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



procedure {:extern} System.DateTime.#ctor$System.Int32$System.Int32$System.Int32$System.Int32$System.Int32$System.Int32($this: Ref, year$in: int, month$in: int, day$in: int, hour$in: int, minute$in: int, second$in: int);



procedure {:extern} System.DateTime.AddSeconds$System.Double($this: Ref, value$in: Real) returns ($result: Ref);



procedure {:extern} System.Nullable`1.#ctor$`0($this: Ref, value$in: Ref);



function {:extern} T$T$System.Nullable`1(parent: Ref) : Ref;

function {:extern} T$System.Nullable`1(T: Ref) : Ref;

const {:extern} unique T$System.Nullable`1: int;

procedure {:extern} System.Nullable`1.get_Value($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Expiration($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: int;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 80} true;
    call $tmp0 := Alloc();
    call System.DateTime.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.DateTime();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.DateTime;
    local_0_Ref := $tmp0;
    assume $this != null;
    $tmp1 := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this];
    call $tmp2 := System.Nullable`1.get_HasValue($tmp1);
    if (!$tmp2)
    {
        assume {:breadcrumb 81} true;
        call $tmp3 := Alloc();
        call $tmp4 := Alloc();
        call System.DateTime.#ctor$System.Int32$System.Int32$System.Int32$System.Int32$System.Int32$System.Int32($tmp4, 1970, 1, 1, 0, 0, 0);
        assume $DynamicType($tmp4) == T$System.DateTime();
        assume $TypeConstructor($DynamicType($tmp4)) == T$System.DateTime;
        $tmp5 := $tmp4;
        call $tmp6 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_expUnixTime($this);
        call $tmp7 := System.DateTime.AddSeconds$System.Double($tmp5, Int2Real($tmp6));
        call $tmp8 := System.DateTime.#copy_ctor($tmp7);
        call System.Nullable`1.#ctor$`0($tmp3, $tmp8);
        assume $DynamicType($tmp3) == T$System.Nullable`1(T$System.DateTime());
        assume $TypeConstructor($DynamicType($tmp3)) == T$System.Nullable`1;
        assume T$T$System.Nullable`1($DynamicType($tmp3)) == T$System.DateTime();
        F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this] := $tmp3;
    }
    else
    {
        assume {:breadcrumb 82} true;
    }

    assume $this != null;
    $tmp9 := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this];
    call $tmp11 := System.Nullable`1.get_Value($tmp9);
    $tmp10 := $tmp11;
    call local_0_Ref := System.DateTime.#copy_ctor($tmp10);
    goto IL_0049;

  IL_0049:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Issuer($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Issuer($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 83} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Issuer$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Issuer$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Issuer$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 84} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Issuer$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Audience($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Audience($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 85} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Audience$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Audience$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Audience$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 86} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Audience$k__BackingField[$this] := value;
}



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_UserId($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 87} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$UserId$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_UserId$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_UserId$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 88} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$UserId$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Version($this: Ref) returns ($result: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Version($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 89} true;
    assume $this != null;
    local_0_int := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Version$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_int;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Version$System.Int32($this: Ref, value$in: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Version$System.Int32($this: Ref, value$in: int)
{
  var value: int;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 90} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Version$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_ClientIdentifier($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_ClientIdentifier($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 91} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$ClientIdentifier$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_ClientIdentifier$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_ClientIdentifier$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 92} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$ClientIdentifier$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_AppId($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_AppId($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 93} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$AppId$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_AppId$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_AppId$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 94} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$AppId$k__BackingField[$this] := value;
}



procedure OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#ctor($this: Ref);



procedure System.Nullable$System.DateTime$.#default_ctor($this: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

    call $tmp0 := Alloc();
    call System.Nullable$System.DateTime$.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Nullable`1(T$System.DateTime());
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Nullable`1;
    assume T$T$System.Nullable`1($DynamicType($tmp0)) == T$System.DateTime();
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this] := $tmp0;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$expUnixTime$k__BackingField[$this] := 0;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Issuer$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Audience$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$UserId$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Version$k__BackingField[$this] := 0;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$ClientIdentifier$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$AppId$k__BackingField[$this] := null;
    assume {:breadcrumb 95} true;
    call $tmp1 := Alloc();
    call System.Nullable$System.DateTime$.#default_ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Nullable`1(T$System.DateTime());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Nullable`1;
    assume T$T$System.Nullable`1($DynamicType($tmp1)) == T$System.DateTime();
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this] := $tmp1;
    call System.Object.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#cctor();



implementation T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#cctor()
{
}



var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField: [Ref]int;

implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Type($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 96} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_Type$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_Type$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 97} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField[$this] := value;
}



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Algorithm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 98} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_Algorithm$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_Algorithm$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 99} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField[$this] := value;
}



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 100} true;
    assume $this != null;
    local_0_int := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_int;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_KeyId$System.Int32($this: Ref, value$in: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_KeyId$System.Int32($this: Ref, value$in: int)
{
  var value: int;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 101} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField[$this] := value;
}



procedure OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField[$this] := 0;
    assume {:breadcrumb 102} true;
    call System.Object.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#cctor();



implementation T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#cctor()
{
}



function T$OpenIDConnectNameSpace.OpenIDProvider() : Ref;

const unique T$OpenIDConnectNameSpace.OpenIDProvider: int;

procedure OpenIDConnectNameSpace.OpenIDProvider.get_AuthorizationCodeRecs($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.AS.IdpAuthRecs: [Ref]Ref;

implementation OpenIDConnectNameSpace.OpenIDProvider.get_AuthorizationCodeRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 103} true;
    assume $this != null;
    local_0_Ref := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



procedure OpenIDConnectNameSpace.OpenIDProvider.set_AuthorizationCodeRecs$OAuth20NameSpace.AuthorizationCodeRecs($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.set_AuthorizationCodeRecs$OAuth20NameSpace.AuthorizationCodeRecs($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 104} true;
    F$GenericAuthNameSpace.AS.IdpAuthRecs[$this] := value;
}



procedure OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 105} true;
    call $tmp0 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    local_0_Ref := $tmp0;
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



procedure OpenIDConnectNameSpace.OpenIDProvider.set_IDTokenAndAccessTokenRecs$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs($this: Ref, value$in: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.set_IDTokenAndAccessTokenRecs$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 106} true;
    call OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this, value);
}



procedure OpenIDConnectNameSpace.OpenIDProvider.init$OAuth20NameSpace.AuthorizationCodeRecs$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, IDTokenAndAccessTokenRecs1$in: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, AccessTokenRecs1$in: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.init$OAuth20NameSpace.AuthorizationCodeRecs$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, IDTokenAndAccessTokenRecs1$in: Ref)
{
  var AuthorizationCodeRecs1: Ref;
  var IDTokenAndAccessTokenRecs1: Ref;
  var $localExc: Ref;
  var $label: int;

    AuthorizationCodeRecs1 := AuthorizationCodeRecs1$in;
    IDTokenAndAccessTokenRecs1 := IDTokenAndAccessTokenRecs1$in;
    assume {:breadcrumb 107} true;
    call OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this, AuthorizationCodeRecs1, IDTokenAndAccessTokenRecs1);
}



procedure OpenIDConnectNameSpace.OpenIDProvider.AuthorizationEndpoint$OpenIDConnectNameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.AS.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



function {:extern} T$OAuth20NameSpace.AuthorizationServer() : Ref;

const {:extern} unique T$OAuth20NameSpace.AuthorizationServer: int;

axiom $TypeConstructor(T$OAuth20NameSpace.AuthorizationServer()) == T$OAuth20NameSpace.AuthorizationServer;

implementation OpenIDConnectNameSpace.OpenIDProvider.AuthorizationEndpoint$OpenIDConnectNameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 108} true;
    if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
    {
        call $tmp0 := OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
        {
            call $tmp1 := OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer)
            {
                call $tmp2 := OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
            }
            else
            {
                call $tmp3 := GenericAuthNameSpace.AS.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
            }
        }
    }

    local_0_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp0 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp1 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp2 else $tmp3)));
    goto IL_0010;

  IL_0010:
    $result := local_0_Ref;
    return;
}



procedure OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, claim$in: Ref) returns ($result: Ref);



function {:extern} T$OAuth20NameSpace.AuthorizationCodeEntry() : Ref;

const {:extern} unique T$OAuth20NameSpace.AuthorizationCodeEntry: int;

axiom $TypeConstructor(T$OAuth20NameSpace.AuthorizationCodeEntry()) == T$OAuth20NameSpace.AuthorizationCodeEntry;

var {:extern} F$OAuth20NameSpace.AuthorizationCodeEntry.code: [Ref]Ref;

const {:value "code="} unique $string_literal_code$_23: Ref;

procedure {:extern} HTTP.HTTPComm.HttpPost$System.String$System.String(url$in: Ref, post$in: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, claim$in: Ref) returns ($result: Ref)
{
  var dest: Ref;
  var claim: Ref;
  var local_0_Ref: Ref;
  var local_2_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

    dest := dest$in;
    claim := claim$in;
    assume {:breadcrumb 109} true;
    local_0_Ref := $As(claim, T$OAuth20NameSpace.AuthorizationCodeEntry());
    if (local_0_Ref == null)
    {
        assume {:breadcrumb 110} true;
        local_2_Ref := null;
    }
    else
    {
        assume {:breadcrumb 111} true;
        call $tmp0 := Alloc();
        call OpenIDConnectNameSpace.AuthenticationResponse.#ctor($tmp0);
        assume $DynamicType($tmp0) == T$OpenIDConnectNameSpace.AuthenticationResponse();
        assume $TypeConstructor($DynamicType($tmp0)) == T$OpenIDConnectNameSpace.AuthenticationResponse;
        local_1_Ref := $tmp0;
        $tmp1 := local_0_Ref;
        assume $tmp1 != null;
        F$OAuth20NameSpace.AuthorizationResponse.code[local_1_Ref] := F$OAuth20NameSpace.AuthorizationCodeEntry.code[$tmp1];
        $tmp2 := local_1_Ref;
        assume $tmp2 != null;
        call $tmp3 := System.String.Concat$System.String$System.String($string_literal_code$_23, F$OAuth20NameSpace.AuthorizationResponse.code[$tmp2]);
        call $tmp4 := HTTP.HTTPComm.HttpPost$System.String$System.String(dest, $tmp3);
        local_2_Ref := local_1_Ref;
        goto IL_0044;
    }

  IL_0044:
    $result := local_2_Ref;
    return;
}



procedure {:extern} LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.findISSByClientIDAndCode$System.String$System.String($this: Ref, client_id$in: Ref, authorization_code$in: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationCodeRecs.findISSByClientIDAndCode$System.String$System.String($this: Ref, client_id$in: Ref, authorization_code$in: Ref) returns ($result: Ref);



function {:extern} T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def() : Ref;

const {:extern} unique T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def: int;

axiom $TypeConstructor(T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def()) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;

procedure {:extern} LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, Realm$in: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.ID_Claim.get_Redir_dest($this: Ref) returns ($result: Ref);



var {:extern} F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AuthorizationCodeEntry.scope: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AuthorizationCodeEntry.state: [Ref]Ref;

procedure {:extern} LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this: Ref, redirect_uri$in: Ref, scope$in: Ref, state$in: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this: Ref, redirect_uri$in: Ref, scope$in: Ref, state$in: Ref) returns ($result: Ref);



var {:extern} F$OAuth20NameSpace.AccessTokenRequest.access_token: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AccessTokenRequest.UserID: [Ref]Ref;

procedure {:extern} LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($this: Ref, ticket$in: Ref, Realm$in: Ref, UserID$in: Ref, claim$in: Ref) returns ($result: bool);



procedure {:extern} GenericAuthNameSpace.ASAuthTicketRecords_Base.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($this: Ref, ticket$in: Ref, Realm$in: Ref, UserID$in: Ref, claim$in: Ref) returns ($result: bool);



function {:extern} T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def() : Ref;

const {:extern} unique T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def: int;

axiom $TypeConstructor(T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def()) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;

var {:extern} F$OAuth20NameSpace.AccessTokenEntry.access_token: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AccessTokenResponse.access_token: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AccessTokenEntry.refresh_token: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AccessTokenResponse.refresh_token: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AccessTokenEntry.scope: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AccessTokenResponse.scope: [Ref]Ref;

var F$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.id_token: [Ref]Ref;

procedure {:extern} OAuth20NameSpace.AuthorizationCodeEntry.get_UserID($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.ID_Claim.get_UserID($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.TokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_4_Ref: Ref;
  var $tmp0: Ref;
  var local_6_Ref: Ref;
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
  var local_2_Ref: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var local_3_Ref: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var $tmp20: Ref;
  var $tmp21: bool;
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
  var local_0_Ref: Ref;
  var $tmp34: Ref;
  var $tmp35: Ref;
  var $tmp36: Ref;
  var $tmp37: Ref;
  var $tmp38: bool;
  var $tmp39: Ref;
  var $tmp40: Ref;
  var $tmp41: Ref;
  var $tmp42: Ref;
  var $tmp43: bool;
  var $tmp44: Ref;
  var $tmp45: Ref;
  var local_1_Ref: Ref;
  var $tmp46: Ref;
  var $tmp47: Ref;
  var $tmp48: Ref;
  var $tmp49: Ref;
  var $tmp50: Ref;
  var $tmp51: Ref;
  var $tmp52: Ref;
  var $tmp53: Ref;
  var $tmp54: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 112} true;
    if (req == null)
    {
        assume {:breadcrumb 113} true;
        local_4_Ref := null;
    }
    else
    {
        assume {:breadcrumb 114} true;
        $tmp0 := req;
        assume $tmp0 != null;
        local_6_Ref := F$OAuth20NameSpace.AccessTokenRequest.grant_type[$tmp0];
        if (local_6_Ref != null)
        {
            assume {:breadcrumb 115} true;
            call $tmp1 := System.String.op_Equality$System.String$System.String(local_6_Ref, $string_literal_authorization_code_2);
            if (!$tmp1)
            {
                assume {:breadcrumb 117} true;
                goto IL_0138;
            }
            else
            {
                assume {:breadcrumb 118} true;
            }

            call $tmp10 := OpenIDConnectNameSpace.OpenIDProvider.get_AuthorizationCodeRecs($this);
            if ($TypeConstructor($DynamicType($tmp10)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
            {
                call $tmp2 := OpenIDConnectNameSpace.OpenIDProvider.get_AuthorizationCodeRecs($this);
                $tmp3 := req;
                assume $tmp3 != null;
                $tmp4 := req;
                assume $tmp4 != null;
                call $tmp5 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.findISSByClientIDAndCode$System.String$System.String($tmp2, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp3], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp4]);
            }
            else
            {
                call $tmp6 := OpenIDConnectNameSpace.OpenIDProvider.get_AuthorizationCodeRecs($this);
                $tmp7 := req;
                assume $tmp7 != null;
                $tmp8 := req;
                assume $tmp8 != null;
                call $tmp9 := OAuth20NameSpace.AuthorizationCodeRecs.findISSByClientIDAndCode$System.String$System.String($tmp6, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp7], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp8]);
            }

            local_2_Ref := (if $TypeConstructor($DynamicType($tmp10)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp5 else $tmp9);
            if (local_2_Ref == null)
            {
                assume {:breadcrumb 119} true;
                local_4_Ref := null;
            }
            else
            {
                assume {:breadcrumb 120} true;
                call $tmp17 := OpenIDConnectNameSpace.OpenIDProvider.get_AuthorizationCodeRecs($this);
                if ($TypeConstructor($DynamicType($tmp17)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
                {
                    call $tmp11 := OpenIDConnectNameSpace.OpenIDProvider.get_AuthorizationCodeRecs($this);
                    $tmp12 := req;
                    assume $tmp12 != null;
                    call $tmp13 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp11, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp12]);
                }
                else
                {
                    call $tmp14 := OpenIDConnectNameSpace.OpenIDProvider.get_AuthorizationCodeRecs($this);
                    $tmp15 := req;
                    assume $tmp15 != null;
                    call $tmp16 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp14, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp15]);
                }

                local_3_Ref := (if $TypeConstructor($DynamicType($tmp17)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp13 else $tmp16);
                if ($TypeConstructor($DynamicType(local_3_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                {
                    call $tmp18 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_3_Ref);
                }
                else
                {
                    call $tmp19 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_3_Ref);
                }

                $tmp20 := req;
                assume $tmp20 != null;
                call $tmp21 := System.String.op_Inequality$System.String$System.String((if $TypeConstructor($DynamicType(local_3_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp18 else $tmp19), F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[$tmp20]);
                if ($tmp21)
                {
                    assume {:breadcrumb 121} true;
                    local_4_Ref := null;
                }
                else
                {
                    assume {:breadcrumb 122} true;
                    if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
                    {
                        $tmp22 := local_3_Ref;
                        assume $tmp22 != null;
                        $tmp23 := local_3_Ref;
                        assume $tmp23 != null;
                        $tmp24 := local_3_Ref;
                        assume $tmp24 != null;
                        call $tmp25 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp22], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp23], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp24]);
                    }
                    else
                    {
                        if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
                        {
                            $tmp26 := local_3_Ref;
                            assume $tmp26 != null;
                            $tmp27 := local_3_Ref;
                            assume $tmp27 != null;
                            $tmp28 := local_3_Ref;
                            assume $tmp28 != null;
                            call $tmp29 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp26], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp27], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp28]);
                        }
                        else
                        {
                            $tmp30 := local_3_Ref;
                            assume $tmp30 != null;
                            $tmp31 := local_3_Ref;
                            assume $tmp31 != null;
                            $tmp32 := local_3_Ref;
                            assume $tmp32 != null;
                            call $tmp33 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp30], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp31], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp32]);
                        }
                    }

                    local_0_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp25 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp29 else $tmp33));
                    call $tmp44 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
                    if ($TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
                    {
                        call $tmp34 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
                        $tmp35 := req;
                        assume $tmp35 != null;
                        $tmp36 := req;
                        assume $tmp36 != null;
                        $tmp37 := req;
                        assume $tmp37 != null;
                        call $tmp38 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp34, F$OAuth20NameSpace.AccessTokenRequest.access_token[$tmp35], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp36], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp37], local_0_Ref);
                    }
                    else
                    {
                        call $tmp39 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
                        $tmp40 := req;
                        assume $tmp40 != null;
                        $tmp41 := req;
                        assume $tmp41 != null;
                        $tmp42 := req;
                        assume $tmp42 != null;
                        call $tmp43 := GenericAuthNameSpace.ASAuthTicketRecords_Base.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp39, F$OAuth20NameSpace.AccessTokenRequest.access_token[$tmp40], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp41], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp42], local_0_Ref);
                    }

                    if (!(if $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp38 else $tmp43))
                    {
                        assume {:breadcrumb 123} true;
                        local_4_Ref := null;
                    }
                    else
                    {
                        assume {:breadcrumb 124} true;
                        call $tmp45 := Alloc();
                        call OpenIDConnectNameSpace.TokenResponse.#ctor($tmp45);
                        assume $DynamicType($tmp45) == T$OpenIDConnectNameSpace.TokenResponse();
                        assume $TypeConstructor($DynamicType($tmp45)) == T$OpenIDConnectNameSpace.TokenResponse;
                        local_1_Ref := $tmp45;
                        $tmp46 := local_0_Ref;
                        assume $tmp46 != null;
                        F$OAuth20NameSpace.AccessTokenResponse.access_token[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp46];
                        $tmp47 := local_0_Ref;
                        assume $tmp47 != null;
                        F$OAuth20NameSpace.AccessTokenResponse.refresh_token[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$tmp47];
                        $tmp48 := local_0_Ref;
                        assume $tmp48 != null;
                        F$OAuth20NameSpace.AccessTokenResponse.scope[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp48];
                        $tmp49 := local_0_Ref;
                        assume $tmp49 != null;
                        F$OpenIDConnectNameSpace.TokenResponse.id_token[local_1_Ref] := F$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.id_token[$tmp49];
                        $tmp50 := local_1_Ref;
                        assume $tmp50 != null;
                        $tmp51 := F$OpenIDConnectNameSpace.TokenResponse.id_token[$tmp50];
                        call $tmp52 := OpenIDConnectNameSpace.JsonWebToken.get_Claims($tmp51);
                        if ($TypeConstructor($DynamicType(local_3_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                        {
                            call $tmp53 := OAuth20NameSpace.AuthorizationCodeEntry.get_UserID(local_3_Ref);
                        }
                        else
                        {
                            call $tmp54 := GenericAuthNameSpace.ID_Claim.get_UserID(local_3_Ref);
                        }

                        call OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_UserId$System.String($tmp52, (if $TypeConstructor($DynamicType(local_3_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp53 else $tmp54));
                        local_4_Ref := local_1_Ref;
                    }
                }
            }
        }
        else
        {
            assume {:breadcrumb 116} true;

          IL_0138:
            local_4_Ref := null;
            goto IL_013d;
        }
    }

  IL_013d:
    $result := local_4_Ref;
    return;
}



procedure OpenIDConnectNameSpace.OpenIDProvider.#ctor($this: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationServer.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 125} true;
    call OAuth20NameSpace.AuthorizationServer.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.OpenIDProvider.#cctor();



implementation T$OpenIDConnectNameSpace.OpenIDProvider.#cctor()
{
}



function T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry() : Ref;

const unique T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry: int;

procedure OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest($this: Ref) returns ($result: Ref);



var {:extern} F$OAuth20NameSpace.AccessTokenEntry.redirect_uri: [Ref]Ref;

implementation OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 126} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 127} true;
    assume $this != null;
    $tmp0 := F$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.id_token[$this];
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.get_Claims($tmp0);
    call $tmp2 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_UserId($tmp1);
    local_0_Ref := $tmp2;
    goto IL_0014;

  IL_0014:
    $result := local_0_Ref;
    return;
}



procedure OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#ctor($this: Ref);



procedure {:extern} OAuth20NameSpace.AccessTokenEntry.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.id_token[$this] := null;
    assume {:breadcrumb 128} true;
    call OAuth20NameSpace.AccessTokenEntry.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#cctor();



implementation T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#cctor()
{
}



procedure {:extern} OAuth20NameSpace.AccessToken.#ctor($this: Ref);



function {:extern} T$OAuth20NameSpace.AccessToken() : Ref;

const {:extern} unique T$OAuth20NameSpace.AccessToken: int;

axiom $TypeConstructor(T$OAuth20NameSpace.AccessToken()) == T$OAuth20NameSpace.AccessToken;

var {:extern} F$OAuth20NameSpace.AccessToken.token: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AccessTokenResponse.expires_in: [Ref]Ref;

procedure {:extern} System.Collections.Generic.Dictionary`2.#ctor($this: Ref);



function {:extern} TKey$T$System.Collections.Generic.Dictionary`2(parent: Ref) : Ref;

function {:extern} TValue$T$System.Collections.Generic.Dictionary`2(parent: Ref) : Ref;

function {:extern} T$System.Collections.Generic.Dictionary`2(TKey: Ref, TValue: Ref) : Ref;

const {:extern} unique T$System.Collections.Generic.Dictionary`2: int;

function {:extern} T$System.Int32() : Ref;

const {:extern} unique T$System.Int32: int;

axiom $TypeConstructor(T$System.Int32()) == T$System.Int32;

function {:extern} T$System.String() : Ref;

const {:extern} unique T$System.String: int;

axiom $TypeConstructor(T$System.String()) == T$System.String;

procedure {:extern} System.Collections.Generic.Dictionary`2.Add$`0$`1($this: Ref, key$in: Ref, value$in: Ref);



procedure {:extern} System.Console.Write$System.Object(value$in: Ref);



implementation OpenIDConnectNameSpace.TokenResponse.parseJasonDataStructure$OpenIDConnectNameSpace.JsonDataStrcuture$System.String($this: Ref, JsonDataStrcuture$in: Ref, clientSecret$in: Ref) returns ($result: bool)
{
  var JsonDataStrcuture: Ref;
  var clientSecret: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var local_0_Ref: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var local_2_bool: bool;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    JsonDataStrcuture := JsonDataStrcuture$in;
    clientSecret := clientSecret$in;
    assume {:breadcrumb 129} true;
    call $tmp0 := Alloc();
    call OAuth20NameSpace.AccessToken.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OAuth20NameSpace.AccessToken();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OAuth20NameSpace.AccessToken;
    F$OAuth20NameSpace.AccessTokenResponse.access_token[$this] := $tmp0;
    call $tmp1 := OpenIDConnectNameSpace.JsonDataStrcuture.get_AccessToken(JsonDataStrcuture);
    assume $this != null;
    F$OAuth20NameSpace.AccessToken.token[F$OAuth20NameSpace.AccessTokenResponse.access_token[$this]] := $tmp1;
    call $tmp2 := OpenIDConnectNameSpace.JsonDataStrcuture.get_RefreshToken(JsonDataStrcuture);
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[$this] := $tmp2;
    call $tmp3 := OpenIDConnectNameSpace.JsonDataStrcuture.get_ExpiresIn(JsonDataStrcuture);
    F$OAuth20NameSpace.AccessTokenResponse.expires_in[$this] := $tmp3;
    call $tmp4 := Alloc();
    call System.Collections.Generic.Dictionary`2.#ctor($tmp4);
    assume $DynamicType($tmp4) == T$System.Collections.Generic.Dictionary`2(T$System.Int32(), T$System.String());
    assume $TypeConstructor($DynamicType($tmp4)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp4)) == T$System.Int32();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp4)) == T$System.String();
    local_0_Ref := $tmp4;
    assume Union2Int(Int2Union(1)) == 1;
    call System.Collections.Generic.Dictionary`2.Add$`0$`1(local_0_Ref, Int2Union(1), clientSecret);
    call $tmp5 := Alloc();
    call $tmp6 := OpenIDConnectNameSpace.JsonDataStrcuture.get_AuthenticationToken(JsonDataStrcuture);
    call OpenIDConnectNameSpace.JsonWebToken.#ctor$System.String$System.Collections.Generic.Dictionary$System.Int32$System.String$($tmp5, $tmp6, local_0_Ref);
    assume $DynamicType($tmp5) == T$OpenIDConnectNameSpace.JsonWebToken();
    assume $TypeConstructor($DynamicType($tmp5)) == T$OpenIDConnectNameSpace.JsonWebToken;
    F$OpenIDConnectNameSpace.TokenResponse.id_token[$this] := $tmp5;
    assume $this != null;
    if (F$OpenIDConnectNameSpace.TokenResponse.id_token[$this] != null)
    {
        assume {:breadcrumb 130} true;
        local_2_bool := true;
    }
    else
    {
        assume {:breadcrumb 131} true;
    }

    local_2_bool := false;
    $label := -1;
    goto finally0;

  catch0:
    $localExc := $Exception;
    $Exception := null;
    if ($Subtype($DynamicType($localExc), T$System.Exception()))
    {
        local_1_Ref := $localExc;
        call System.Console.Write$System.Object(local_1_Ref);
        local_2_bool := false;
        $label := -1;
        goto finally0;
    }
    else if (false)
    {
        return;
    }

    $Exception := $localExc;
    $label := -1;
    goto finally0;

  finally0:
    if (true)
    {
        goto continuation0;
    }

  continuation0:
    if ($Exception != null)
    {
        return;
    }

    $result := local_2_bool;
    return;
}



procedure {:extern} OAuth20NameSpace.AccessTokenResponse.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.TokenResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenIDConnectNameSpace.TokenResponse.id_token[$this] := null;
    assume {:breadcrumb 132} true;
    call OAuth20NameSpace.AccessTokenResponse.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.TokenResponse.#cctor();



implementation T$OpenIDConnectNameSpace.TokenResponse.#cctor()
{
}



function T$OpenIDConnectNameSpace.AuthenticationRequest() : Ref;

const unique T$OpenIDConnectNameSpace.AuthenticationRequest: int;

var F$OpenIDConnectNameSpace.AuthenticationRequest.response_mode: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.nonce: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.display: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.prompt: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.max_age: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.ui_locales: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.id_token_hint: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.login_hint: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.acr_values: [Ref]Ref;

procedure OpenIDConnectNameSpace.AuthenticationRequest.#ctor($this: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationRequest.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.AuthenticationRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenIDConnectNameSpace.AuthenticationRequest.response_mode[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.nonce[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.display[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.prompt[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.max_age[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.ui_locales[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.id_token_hint[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.login_hint[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.acr_values[$this] := null;
    assume {:breadcrumb 133} true;
    F$OpenIDConnectNameSpace.AuthenticationRequest.response_mode[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.nonce[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.display[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.prompt[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.max_age[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.ui_locales[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.id_token_hint[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.login_hint[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.acr_values[$this] := null;
    call OAuth20NameSpace.AuthorizationRequest.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.AuthenticationRequest.#cctor();



implementation T$OpenIDConnectNameSpace.AuthenticationRequest.#cctor()
{
}



procedure {:extern} OAuth20NameSpace.AuthorizationResponse.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.AuthenticationResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 134} true;
    call OAuth20NameSpace.AuthorizationResponse.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.AuthenticationResponse.#cctor();



implementation T$OpenIDConnectNameSpace.AuthenticationResponse.#cctor()
{
}



function T$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs() : Ref;

const unique T$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs: int;

function T$GenericAuthNameSpace.SignInIdP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Req: int;

var F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret: [Ref]Ref;

procedure GenericAuthNameSpace.SignInIdP_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.SignInIdP_Req.set_Realm$System.String($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.SignInIdP_Req.#ctor($this: Ref);



procedure {:extern} CST.CST_Struct.#ctor($this: Ref);



implementation GenericAuthNameSpace.SignInIdP_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$this] := null;
    assume {:breadcrumb 135} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInIdP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Req.#cctor()
{
}



function T$GenericAuthNameSpace.ASAuthTicketRecords_Base() : Ref;

const unique T$GenericAuthNameSpace.ASAuthTicketRecords_Base: int;

procedure GenericAuthNameSpace.ASAuthTicketRecords_Base.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($this: Ref, ticket$in: Ref, Realm$in: Ref, UserID$in: Ref) returns ($result: Ref);



function T$GenericAuthNameSpace.GlobalObjects_base() : Ref;

const unique T$GenericAuthNameSpace.GlobalObjects_base: int;

var F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req: Ref;

var F$GenericAuthNameSpace.GlobalObjects_base.RS: Ref;

var F$GenericAuthNameSpace.RP.Realm: [Ref]Ref;

var F$GenericAuthNameSpace.RP.Domain: [Ref]Ref;

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
    assume {:breadcrumb 136} true;
    $tmp10 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
    assume $tmp10 != null;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$tmp10])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
    {
        $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
        assume $tmp0 != null;
        $tmp1 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$tmp0];
        $tmp2 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
        assume $tmp2 != null;
        $tmp3 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
        assume $tmp3 != null;
        call $tmp4 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp1, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp2], F$GenericAuthNameSpace.RP.Realm[$tmp3]);
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

    local_0_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$tmp10])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp4 else $tmp9);
    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
    {
        call $tmp15 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
    }
    else
    {
        call $tmp16 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
    }

    $tmp17 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp17 != null;
    call $tmp18 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp15 else $tmp16), F$GenericAuthNameSpace.RP.Domain[$tmp17]);
    if ($tmp18)
    {
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
        {
            call $tmp11 := OAuth20NameSpace.AuthorizationCodeEntry.get_UserID(local_0_Ref);
        }
        else
        {
            call $tmp12 := GenericAuthNameSpace.ID_Claim.get_UserID(local_0_Ref);
        }

        $tmp13 := conclusion;
        assume $tmp13 != null;
        call $tmp14 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp11 else $tmp12), F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp13]);
    }
    else
    {
    }

    assert (if $tmp18 then $tmp14 else false);
}



procedure GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotAccessGoodPersonsResource$GenericAuthNameSpace.RS.AuthorizationConclusion(conclusion$in: Ref);



var F$GenericAuthNameSpace.AS.ASAuthRecs: [Ref]Ref;

procedure {:extern} OAuth20NameSpace.ValidateTokenRequest.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.get_ticket($this: Ref) returns ($result: Ref);



function {:extern} T$OAuth20NameSpace.ValidateTokenRequest() : Ref;

const {:extern} unique T$OAuth20NameSpace.ValidateTokenRequest: int;

axiom $TypeConstructor(T$OAuth20NameSpace.ValidateTokenRequest()) == T$OAuth20NameSpace.ValidateTokenRequest;

var F$GenericAuthNameSpace.RS.Realm: [Ref]Ref;

procedure {:extern} OAuth20NameSpace.ValidateTokenRequest.get_UserID($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.get_UserID($this: Ref) returns ($result: Ref);



procedure {:extern} LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($this: Ref, ticket$in: Ref, Realm$in: Ref, UserID$in: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.Permission_Claim.get_UserID($this: Ref) returns ($result: Ref);



function {:extern} T$OAuth20NameSpace.AccessTokenEntry() : Ref;

const {:extern} unique T$OAuth20NameSpace.AccessTokenEntry: int;

axiom $TypeConstructor(T$OAuth20NameSpace.AccessTokenEntry()) == T$OAuth20NameSpace.AccessTokenEntry;

var F$GenericAuthNameSpace.RS.AuthorizationConclusion.UserID: [Ref]Ref;

procedure {:extern} OAuth20NameSpace.AccessTokenEntry.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.Permission_Claim.get_Realm($this: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AccessTokenEntry.get_permissions($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.Permission_Claim.get_permissions($this: Ref) returns ($result: Ref);



var F$GenericAuthNameSpace.Permissions.permissionSet: [Ref]Ref;

var F$GenericAuthNameSpace.RS.AuthorizationConclusion.permissions: [Ref]Ref;

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
  var $tmp20: Ref;
  var $tmp21: bool;
  var $tmp22: Ref;
  var $tmp23: Ref;
  var $tmp24: Ref;
  var $tmp25: Ref;
  var $tmp26: bool;
  var $tmp27: Ref;
  var $tmp28: Ref;
  var $tmp29: Ref;
  var $tmp30: Ref;
  var $tmp31: Ref;
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 137} true;
    $tmp16 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
    assume $tmp16 != null;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.ASAuthRecs[$tmp16])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
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

        call $tmp7 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp1, (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp2 else $tmp3), F$GenericAuthNameSpace.RS.Realm[$tmp4], (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp5 else $tmp6));
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

    local_0_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.ASAuthRecs[$tmp16])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp7 else $tmp15);
    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
    {
        call $tmp27 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
        {
            call $tmp28 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
        }
        else
        {
            call $tmp29 := GenericAuthNameSpace.Permission_Claim.get_permissions(local_0_Ref);
        }
    }

    assume (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp27 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp28 else $tmp29)) != null;
    $tmp30 := conclusion;
    assume $tmp30 != null;
    $tmp31 := F$GenericAuthNameSpace.RS.AuthorizationConclusion.permissions[$tmp30];
    assume $tmp31 != null;
    if (!(F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp27 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp28 else $tmp29))] != F$GenericAuthNameSpace.Permissions.permissionSet[$tmp31]))
    {
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
        {
            call $tmp22 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
            {
                call $tmp23 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
            }
            else
            {
                call $tmp24 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
            }
        }

        $tmp25 := F$GenericAuthNameSpace.GlobalObjects_base.RS;
        assume $tmp25 != null;
        call $tmp26 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp22 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp23 else $tmp24)), F$GenericAuthNameSpace.RS.Realm[$tmp25]);
    }
    else
    {
    }

    if ((if !(F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp27 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp28 else $tmp29))] != F$GenericAuthNameSpace.Permissions.permissionSet[$tmp31]) then $tmp26 else false))
    {
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
        {
            call $tmp17 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID(local_0_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
            {
                call $tmp18 := OAuth20NameSpace.AccessTokenEntry.get_UserID(local_0_Ref);
            }
            else
            {
                call $tmp19 := GenericAuthNameSpace.Permission_Claim.get_UserID(local_0_Ref);
            }
        }

        $tmp20 := conclusion;
        assume $tmp20 != null;
        call $tmp21 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp17 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp18 else $tmp19)), F$GenericAuthNameSpace.RS.AuthorizationConclusion.UserID[$tmp20]);
    }
    else
    {
    }

    assert (if (if !(F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp27 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp28 else $tmp29))] != F$GenericAuthNameSpace.Permissions.permissionSet[$tmp31]) then $tmp26 else false) then $tmp21 else false);
}



implementation GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 138} true;
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



function T$GenericAuthNameSpace.Permissions() : Ref;

const unique T$GenericAuthNameSpace.Permissions: int;

procedure GenericAuthNameSpace.Permissions.#ctor($this: Ref);



implementation GenericAuthNameSpace.Permissions.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.Permissions.permissionSet[$this] := null;
    assume {:breadcrumb 139} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.Permissions.#cctor();



implementation T$GenericAuthNameSpace.Permissions.#cctor()
{
}



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
    assume {:breadcrumb 140} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.ReqResourceRS_Req.#cctor();



implementation T$GenericAuthNameSpace.ReqResourceRS_Req.#cctor()
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
    assume {:breadcrumb 141} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.Resources.#cctor();



implementation T$GenericAuthNameSpace.Resources.#cctor()
{
}



function T$GenericAuthNameSpace.AS() : Ref;

const unique T$GenericAuthNameSpace.AS: int;

procedure {:extern} OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.AS.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationRequest.get_Realm($this: Ref) returns ($result: Ref);



function {:extern} T$OAuth20NameSpace.AuthorizationRequest() : Ref;

const {:extern} unique T$OAuth20NameSpace.AuthorizationRequest: int;

axiom $TypeConstructor(T$OAuth20NameSpace.AuthorizationRequest()) == T$OAuth20NameSpace.AuthorizationRequest;

procedure {:extern} LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref, Entry$in: Ref) returns ($result: bool);



procedure GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, Realm$in: Ref, _ID_Claim$in: Ref) returns ($result: bool);



procedure GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref);



implementation GenericAuthNameSpace.AS.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var local_0_Ref: Ref;
  var $tmp4: Ref;
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
  var $tmp15: bool;
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
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 142} true;
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := req;
    if (req == null)
    {
        assume {:breadcrumb 143} true;
        local_1_Ref := null;
    }
    else
    {
        assume {:breadcrumb 144} true;
        if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
        {
            call $tmp0 := OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
            {
                call $tmp1 := OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer)
                {
                    call $tmp2 := OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
                }
                else
                {
                    call $tmp3 := GenericAuthNameSpace.AS.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
                }
            }
        }

        local_0_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp0 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp1 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp2 else $tmp3)));
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
        {
            assume $this != null;
            $tmp4 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
            $tmp5 := req;
            assume $tmp5 != null;
            if ($TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest)
            {
                call $tmp6 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
            }
            else
            {
                if ($TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest)
                {
                    call $tmp7 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
                }
                else
                {
                    call $tmp8 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
                }
            }

            call $tmp9 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp4, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp5], (if $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp6 else (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp7 else $tmp8)), local_0_Ref);
        }
        else
        {
            assume $this != null;
            $tmp10 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
            $tmp11 := req;
            assume $tmp11 != null;
            if ($TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest)
            {
                call $tmp12 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
            }
            else
            {
                if ($TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest)
                {
                    call $tmp13 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
                }
                else
                {
                    call $tmp14 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
                }
            }

            call $tmp15 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp10, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp11], (if $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp12 else (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp13 else $tmp14)), local_0_Ref);
        }

        if (!(if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp9 else $tmp15))
        {
            assume {:breadcrumb 145} true;
            local_1_Ref := null;
        }
        else
        {
            assume {:breadcrumb 146} true;
            if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
            {
                if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                {
                    call $tmp16 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
                }
                else
                {
                    call $tmp17 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
                }

                call $tmp18 := OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp16 else $tmp17), local_0_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
                {
                    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                    {
                        call $tmp19 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
                    }
                    else
                    {
                        call $tmp20 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
                    }

                    call $tmp21 := OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp19 else $tmp20), local_0_Ref);
                }
                else
                {
                    if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer)
                    {
                        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                        {
                            call $tmp22 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
                        }
                        else
                        {
                            call $tmp23 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
                        }

                        call $tmp24 := GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp22 else $tmp23), local_0_Ref);
                    }
                    else
                    {
                        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                        {
                            call $tmp25 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
                        }
                        else
                        {
                            call $tmp26 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
                        }

                        call $tmp27 := GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp25 else $tmp26), local_0_Ref);
                    }
                }
            }

            local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp18 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp21 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp24 else $tmp27)));
            goto IL_004e;
        }
    }

  IL_004e:
    $result := local_1_Ref;
    return;
}



procedure GenericAuthNameSpace.AS.#ctor($this: Ref);



implementation GenericAuthNameSpace.AS.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.AS.IdpAuthRecs[$this] := null;
    F$GenericAuthNameSpace.AS.ASAuthRecs[$this] := null;
    assume {:breadcrumb 147} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.AS.#cctor();



implementation T$GenericAuthNameSpace.AS.#cctor()
{
}



function T$GenericAuthNameSpace.SignInRP_Resp() : Ref;

const unique T$GenericAuthNameSpace.SignInRP_Resp: int;

procedure GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref);



implementation GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 148} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInRP_Resp.#cctor();



implementation T$GenericAuthNameSpace.SignInRP_Resp.#cctor()
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

    assume {:breadcrumb 149} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.Permission_Claim.#cctor();



implementation T$GenericAuthNameSpace.Permission_Claim.#cctor()
{
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

    assume {:breadcrumb 150} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.Ticket.#cctor();



implementation T$GenericAuthNameSpace.Ticket.#cctor()
{
}



function T$GenericAuthNameSpace.IdPAuthRecords_Base() : Ref;

const unique T$GenericAuthNameSpace.IdPAuthRecords_Base: int;

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
    assume {:breadcrumb 151} true;
    if (obj == null)
    {
        assume {:breadcrumb 152} true;
        local_1_bool := false;
    }
    else
    {
        assume {:breadcrumb 153} true;
        local_0_Ref := $As(obj, T$GenericAuthNameSpace.Permission());
        if (local_0_Ref == null)
        {
            assume {:breadcrumb 154} true;
            local_1_bool := false;
        }
        else
        {
            assume {:breadcrumb 155} true;
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

    assume {:breadcrumb 156} true;
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
    assume {:breadcrumb 157} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.Permission.#cctor();



implementation T$GenericAuthNameSpace.Permission.#cctor()
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

    assume {:breadcrumb 158} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#cctor();



implementation T$GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#cctor()
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
    assume {:breadcrumb 159} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.Resource.#cctor();



implementation T$GenericAuthNameSpace.Resource.#cctor()
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

    assume {:breadcrumb 160} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#cctor();



implementation T$GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#cctor()
{
}



function T$GenericAuthNameSpace.RP() : Ref;

const unique T$GenericAuthNameSpace.RP: int;

var F$GenericAuthNameSpace.RP.CurrentSession: [Ref]Ref;

procedure GenericAuthNameSpace.RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} CST.CST_Ops.CertifyLocally$CST.CST_Struct(msg$in: Ref) returns ($result: bool);



const {:value "C:\Users\Daniel Song\Desktop\Certify.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$Certify.txt_24: Ref;

const {:value "UserID"} unique $string_literal_UserID_25: Ref;

procedure {:extern} System.Web.HttpSessionStateBase.get_Item$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



const {:value ""} unique $string_literal__26: Ref;

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
    assume {:breadcrumb 161} true;
    call $tmp0 := Alloc();
    call System.Diagnostics.Stopwatch.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Diagnostics.Stopwatch();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Diagnostics.Stopwatch;
    local_0_Ref := $tmp0;
    call System.Diagnostics.Stopwatch.Start(local_0_Ref);
    call $tmp1 := CST.CST_Ops.CertifyLocally$CST.CST_Struct(conclusion);
    local_1_bool := $tmp1;
    call System.Diagnostics.Stopwatch.Stop(local_0_Ref);
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$Certify.txt_24;
    call $tmp2 := System.IO.File.Exists$System.String(local_2_Ref);
    if (!$tmp2)
    {
        assume {:breadcrumb 162} true;
        call $tmp3 := System.IO.File.CreateText$System.String(local_2_Ref);
        local_3_Ref := $tmp3;
        call $tmp4 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp4);
    }
    else
    {
        assume {:breadcrumb 163} true;
        call $tmp5 := System.IO.File.AppendText$System.String(local_2_Ref);
        local_3_Ref := $tmp5;
        call $tmp6 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp6);
    }

    assume $this != null;
    $tmp7 := F$GenericAuthNameSpace.RP.CurrentSession[$this];
    call $tmp8 := System.Web.HttpSessionStateBase.get_Item$System.String($tmp7, $string_literal_UserID_25);
    if ($tmp8 != null)
    {
        assume {:breadcrumb 164} true;
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

        call System.Web.HttpSessionStateBase.set_Item$System.String$System.Object($tmp9, $string_literal_UserID_25, (if local_1_bool then F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp10] else $string_literal__26));
    }
    else
    {
        assume {:breadcrumb 165} true;
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

        call System.Web.HttpSessionStateBase.Add$System.String$System.Object($tmp11, $string_literal_UserID_25, (if local_1_bool then F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp12] else $string_literal__26));
    }

    local_4_bool := local_1_bool;
    goto IL_00ee;

  IL_00ee:
    $result := local_4_bool;
    return;
}



procedure GenericAuthNameSpace.RP.#ctor($this: Ref);



implementation GenericAuthNameSpace.RP.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RP.CurrentSession[$this] := null;
    F$GenericAuthNameSpace.RP.Domain[$this] := null;
    F$GenericAuthNameSpace.RP.Realm[$this] := null;
    assume {:breadcrumb 166} true;
    call System.Object.#ctor($this);
}



implementation GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$this] := null;
    assume {:breadcrumb 167} true;
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
    assume {:breadcrumb 168} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#cctor();



implementation T$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#cctor()
{
}



function T$GenericAuthNameSpace.ValidateTicket_Req() : Ref;

const unique T$GenericAuthNameSpace.ValidateTicket_Req: int;

procedure GenericAuthNameSpace.ValidateTicket_Req.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.set_Realm$System.String($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.set_UserID$System.String($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.get_permissions($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.set_permissions$GenericAuthNameSpace.Permissions($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.ValidateTicket_Req.#ctor($this: Ref);



implementation GenericAuthNameSpace.ValidateTicket_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 169} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.ValidateTicket_Req.#cctor();



implementation T$GenericAuthNameSpace.ValidateTicket_Req.#cctor()
{
}



function T$GenericAuthNameSpace.ID_Claim() : Ref;

const unique T$GenericAuthNameSpace.ID_Claim: int;

procedure GenericAuthNameSpace.ID_Claim.#ctor($this: Ref);



implementation GenericAuthNameSpace.ID_Claim.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 170} true;
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
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$Certify.txt_24;
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
    assume {:breadcrumb 174} true;
    call System.Object.#ctor($this);
}



function T$GenericAuthNameSpace.RS.AuthorizationConclusion() : Ref;

const unique T$GenericAuthNameSpace.RS.AuthorizationConclusion: int;

var F$GenericAuthNameSpace.RS.AuthorizationConclusion.ticket: [Ref]Ref;

var F$GenericAuthNameSpace.RS.AuthorizationConclusion.Realm: [Ref]Ref;

procedure GenericAuthNameSpace.RS.AuthorizationConclusion.#ctor($this: Ref);



implementation GenericAuthNameSpace.RS.AuthorizationConclusion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RS.AuthorizationConclusion.ticket[$this] := null;
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.permissions[$this] := null;
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.Realm[$this] := null;
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.UserID[$this] := null;
    assume {:breadcrumb 175} true;
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



function T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req: int;

procedure GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref);



implementation GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 176} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor()
{
}



function T$GenericAuthNameSpace.AuthTicketAS_Req() : Ref;

const unique T$GenericAuthNameSpace.AuthTicketAS_Req: int;

procedure GenericAuthNameSpace.AuthTicketAS_Req.get_ticket($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Req.set_ticket$GenericAuthNameSpace.Ticket($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Req.set_Realm$System.String($this: Ref, value$in: Ref);



procedure GenericAuthNameSpace.AuthTicketAS_Req.#ctor($this: Ref);



implementation GenericAuthNameSpace.AuthTicketAS_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 177} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.AuthTicketAS_Req.#cctor();



implementation T$GenericAuthNameSpace.AuthTicketAS_Req.#cctor()
{
}



function T$GenericAuthNameSpace.RSResourceRecords_Base() : Ref;

const unique T$GenericAuthNameSpace.RSResourceRecords_Base: int;

procedure GenericAuthNameSpace.RSResourceRecords_Base.setEntry$System.String$GenericAuthNameSpace.Permission$GenericAuthNameSpace.Resource($this: Ref, UserID$in: Ref, permission$in: Ref, resource$in: Ref) returns ($result: bool);



procedure GenericAuthNameSpace.RSResourceRecords_Base.getEntry$System.String$GenericAuthNameSpace.Permission($this: Ref, UserID$in: Ref, permission$in: Ref) returns ($result: Ref);



var F$LiveIDNameSpace.LiveID_IdP.Nondet: Ref;

var F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary: [Ref]Ref;

var F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary: [Ref]Ref;

implementation LiveIDNameSpace.LiveID_IdP.init($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 178} true;
    assume $this != null;
    assume $this != null;
    call OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this, F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary[$this], F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary[$this]);
}



var {:extern} F$OAuth20NameSpace.AccessTokenEntry.state: [Ref]Ref;

implementation LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this: Ref, redirect_uri$in: Ref, scope$in: Ref, state$in: Ref) returns ($result: Ref)
{
  var redirect_uri: Ref;
  var scope: Ref;
  var state: Ref;
  var local_1_Ref: Ref;
  var local_0_prime_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

    redirect_uri := redirect_uri$in;
    scope := scope$in;
    state := state$in;
    assume {:breadcrumb 179} true;
    call $tmp0 := Alloc();
    call OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    local_0_prime_Ref := $tmp0;
    F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[local_0_prime_Ref] := redirect_uri;
    F$OAuth20NameSpace.AccessTokenEntry.scope[local_0_prime_Ref] := scope;
    F$OAuth20NameSpace.AccessTokenEntry.state[local_0_prime_Ref] := state;
    call $tmp1 := OpenIDConnectNameSpace.NondetOpenIDConnect.JsonWebToken(F$LiveIDNameSpace.LiveID_IdP.Nondet);
    F$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.id_token[local_0_prime_Ref] := $tmp1;
    local_1_Ref := local_0_prime_Ref;
    goto IL_0030;

  IL_0030:
    $result := local_1_Ref;
    return;
}



procedure LiveIDNameSpace.LiveID_IdP.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



var {:extern} F$OAuth20NameSpace.AuthorizationRequest.redirect_uri: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AuthorizationRequest.scope: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AuthorizationRequest.state: [Ref]Ref;

implementation LiveIDNameSpace.LiveID_IdP.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 180} true;
    call $tmp0 := OpenIDConnectNameSpace.NondetOpenIDConnect.AuthorizationCodeEntry(F$LiveIDNameSpace.LiveID_IdP.Nondet);
    local_0_Ref := $tmp0;
    $tmp1 := req;
    assume $tmp1 != null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[local_0_Ref] := F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp1];
    $tmp2 := req;
    assume $tmp2 != null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.scope[local_0_Ref] := F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp2];
    $tmp3 := req;
    assume $tmp3 != null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.state[local_0_Ref] := F$OAuth20NameSpace.AuthorizationRequest.state[$tmp3];
    local_1_Ref := local_0_Ref;
    goto IL_0034;

  IL_0034:
    $result := local_1_Ref;
    return;
}



procedure LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#ctor($this: Ref);



procedure LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#ctor($this: Ref);



implementation LiveIDNameSpace.LiveID_IdP.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

    F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary[$this] := null;
    F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary[$this] := null;
    assume {:breadcrumb 181} true;
    call $tmp0 := Alloc();
    call LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def();
    assume $TypeConstructor($DynamicType($tmp0)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary[$this] := $tmp0;
    call $tmp1 := Alloc();
    call LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def();
    assume $TypeConstructor($DynamicType($tmp1)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary[$this] := $tmp1;
    call OpenIDConnectNameSpace.OpenIDProvider.#ctor($this);
}



var F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.Dictionary: [Ref]Ref;

implementation LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref) returns ($result: Ref)
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
    assume {:breadcrumb 182} true;
    assume $this != null;
    $tmp0 := F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.Dictionary[$this];
    call $tmp2 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp0, IdPSessionSecret);
    $tmp1 := $tmp2;
    call $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp1, client_id);
    $tmp3 := $tmp4;
    local_0_Ref := $tmp3;
    assume $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    local_1_Ref := local_0_Ref;
    goto IL_0033;

  IL_0033:
    $result := local_1_Ref;
    return;
}



procedure {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1($this: Ref, key$in: Ref, value$in: Ref);



implementation LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref, Entry$in: Ref) returns ($result: bool)
{
  var IdPSessionSecret: Ref;
  var client_id: Ref;
  var Entry: Ref;
  var local_0_Ref: Ref;
  var local_1_bool: bool;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

    IdPSessionSecret := IdPSessionSecret$in;
    client_id := client_id$in;
    Entry := Entry$in;
    assume {:breadcrumb 183} true;
    local_0_Ref := Entry;
    if (local_0_Ref == null)
    {
        assume {:breadcrumb 184} true;
        local_1_bool := false;
    }
    else
    {
        assume {:breadcrumb 185} true;
        assume $this != null;
        $tmp0 := F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.Dictionary[$this];
        call $tmp1 := Alloc();
        call System.Collections.Generic.Dictionary`2.#ctor($tmp1);
        assume $DynamicType($tmp1) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AuthorizationCodeEntry());
        assume $TypeConstructor($DynamicType($tmp1)) == T$System.Collections.Generic.Dictionary`2;
        assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp1)) == T$System.String();
        assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp1)) == T$OAuth20NameSpace.AuthorizationCodeEntry();
        call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp0, IdPSessionSecret, $tmp1);
        assume $this != null;
        $tmp2 := F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.Dictionary[$this];
        call $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp2, IdPSessionSecret);
        $tmp3 := $tmp4;
        call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp3, client_id, local_0_Ref);
        local_1_bool := true;
        goto IL_0041;
    }

  IL_0041:
    $result := local_1_bool;
    return;
}



procedure {:extern} CST.Nondet_Base.String($this: Ref) returns ($result: Ref);



implementation LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.findISSByClientIDAndCode$System.String$System.String($this: Ref, client_id$in: Ref, authorization_code$in: Ref) returns ($result: Ref)
{
  var client_id: Ref;
  var authorization_code: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: bool;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: bool;
  var $tmp9: Ref;
  var $tmp10: bool;
  var stack_0_System_Boolean_bool: bool;
  var local_2_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    client_id := client_id$in;
    authorization_code := authorization_code$in;
    assume {:breadcrumb 186} true;
    call $tmp0 := CST.Nondet_Base.String(F$LiveIDNameSpace.LiveID_IdP.Nondet);
    local_0_Ref := $tmp0;
    call $tmp1 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($this, local_0_Ref, client_id);
    assume $tmp1 != null;
    call $tmp2 := System.String.op_Equality$System.String$System.String(F$OAuth20NameSpace.AuthorizationCodeEntry.code[$tmp1], authorization_code);
    assume $tmp2;
    $tmp3 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
    assume $tmp3 != null;
    call $tmp4 := System.String.op_Equality$System.String$System.String(local_0_Ref, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp3]);
    if ($tmp4)
    {
        assume {:breadcrumb 187} true;
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenIDConnectNameSpace.AuthenticationRequest)
        {
            call $tmp5 := OAuth20NameSpace.AuthorizationRequest.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
        }
        else
        {
            if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OAuth20NameSpace.AuthorizationRequest)
            {
                call $tmp6 := OAuth20NameSpace.AuthorizationRequest.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
            }
            else
            {
                call $tmp7 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
            }
        }

        call $tmp8 := System.String.op_Equality$System.String$System.String(client_id, (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp5 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp6 else $tmp7)));
        if ($tmp8)
        {
            assume {:breadcrumb 189} true;
        }
        else
        {
            assume {:breadcrumb 190} true;
            goto IL_0062;
        }

        $tmp9 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
        assume $tmp9 != null;
        call $tmp10 := System.String.op_Equality$System.String$System.String(client_id, F$GenericAuthNameSpace.RP.Realm[$tmp9]);
        stack_0_System_Boolean_bool := $tmp10;
    }
    else
    {
        assume {:breadcrumb 188} true;

      IL_0062:
        stack_0_System_Boolean_bool := false;
    }

    assume stack_0_System_Boolean_bool != false;
    local_2_Ref := local_0_Ref;
    goto IL_006e;

  IL_006e:
    $result := local_2_Ref;
    return;
}



implementation LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.Dictionary[$this] := null;
    assume {:breadcrumb 191} true;
    call $tmp0 := Alloc();
    call System.Collections.Generic.Dictionary`2.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AuthorizationCodeEntry()));
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.String();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AuthorizationCodeEntry());
    F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.Dictionary[$this] := $tmp0;
    call System.Object.#ctor($this);
}



procedure T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#cctor();



implementation T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#cctor()
{
}



var F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.Dictionary: [Ref]Ref;

implementation LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($this: Ref, ticket$in: Ref, Realm$in: Ref, UserID$in: Ref) returns ($result: Ref)
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
  var $localExc: Ref;
  var $label: int;

    ticket := ticket$in;
    Realm := Realm$in;
    UserID := UserID$in;
    assume {:breadcrumb 192} true;
    assume $this != null;
    $tmp0 := F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.Dictionary[$this];
    call $tmp2 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp0, ticket);
    $tmp1 := $tmp2;
    call $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp1, Realm);
    $tmp3 := $tmp4;
    call $tmp6 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp3, UserID);
    $tmp5 := $tmp6;
    local_1_Ref := $tmp5;
    goto IL_0023;

  IL_0023:
    $result := local_1_Ref;
    return;
}



implementation LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($this: Ref, ticket$in: Ref, Realm$in: Ref, UserID$in: Ref, claim$in: Ref) returns ($result: bool)
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
    assume {:breadcrumb 193} true;
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
        assume {:breadcrumb 194} true;
        local_2_bool := false;
    }
    else
    {
        assume {:breadcrumb 195} true;
        assume $this != null;
        $tmp0 := F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.Dictionary[$this];
        call $tmp1 := Alloc();
        call System.Collections.Generic.Dictionary`2.#ctor($tmp1);
        assume $DynamicType($tmp1) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AccessTokenEntry()));
        assume $TypeConstructor($DynamicType($tmp1)) == T$System.Collections.Generic.Dictionary`2;
        assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp1)) == T$System.String();
        assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp1)) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AccessTokenEntry());
        call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp0, local_0_Ref, $tmp1);
        assume $this != null;
        $tmp2 := F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.Dictionary[$this];
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
        $tmp6 := F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.Dictionary[$this];
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



procedure LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.findISSByClientIDAndAccessToken$System.String$System.String$System.String($this: Ref, client_id$in: Ref, UserID$in: Ref, access_token$in: Ref) returns ($result: Ref);



implementation LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.findISSByClientIDAndAccessToken$System.String$System.String$System.String($this: Ref, client_id$in: Ref, UserID$in: Ref, access_token$in: Ref) returns ($result: Ref)
{
  var client_id: Ref;
  var UserID: Ref;
  var access_token: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_3_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    client_id := client_id$in;
    UserID := UserID$in;
    access_token := access_token$in;
    assume {:breadcrumb 196} true;
    call $tmp0 := CST.Nondet_Base.String(F$LiveIDNameSpace.LiveID_IdP.Nondet);
    local_0_Ref := $tmp0;
    call $tmp1 := Alloc();
    call OAuth20NameSpace.AccessToken.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$OAuth20NameSpace.AccessToken();
    assume $TypeConstructor($DynamicType($tmp1)) == T$OAuth20NameSpace.AccessToken;
    local_1_Ref := $tmp1;
    F$OAuth20NameSpace.AccessToken.token[local_1_Ref] := access_token;
    call $tmp2 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($this, local_1_Ref, client_id, UserID);
    assume $tmp2 != null;
    assume F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp2] == local_1_Ref;
    local_3_Ref := local_0_Ref;
    goto IL_003b;

  IL_003b:
    $result := local_3_Ref;
    return;
}



procedure LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.findISSByClientIDAndRefreshToken$System.String$System.String$System.String($this: Ref, client_id$in: Ref, UserID$in: Ref, refresh_token$in: Ref) returns ($result: Ref);



implementation LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.findISSByClientIDAndRefreshToken$System.String$System.String$System.String($this: Ref, client_id$in: Ref, UserID$in: Ref, refresh_token$in: Ref) returns ($result: Ref)
{
  var client_id: Ref;
  var UserID: Ref;
  var refresh_token: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_1_prime_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: bool;
  var local_3_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    client_id := client_id$in;
    UserID := UserID$in;
    refresh_token := refresh_token$in;
    assume {:breadcrumb 197} true;
    call $tmp0 := CST.Nondet_Base.String(F$LiveIDNameSpace.LiveID_IdP.Nondet);
    local_0_Ref := $tmp0;
    call $tmp1 := Alloc();
    call OAuth20NameSpace.AccessToken.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$OAuth20NameSpace.AccessToken();
    assume $TypeConstructor($DynamicType($tmp1)) == T$OAuth20NameSpace.AccessToken;
    local_1_prime_Ref := $tmp1;
    F$OAuth20NameSpace.AccessToken.token[local_1_prime_Ref] := refresh_token;
    call $tmp2 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($this, local_1_prime_Ref, client_id, UserID);
    assume $tmp2 != null;
    call $tmp3 := System.String.op_Equality$System.String$System.String(F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$tmp2], refresh_token);
    assume $tmp3;
    local_3_Ref := local_0_Ref;
    goto IL_003e;

  IL_003e:
    $result := local_3_Ref;
    return;
}



implementation LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.Dictionary[$this] := null;
    assume {:breadcrumb 198} true;
    call $tmp0 := Alloc();
    call System.Collections.Generic.Dictionary`2.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.Dictionary`2(T$OAuth20NameSpace.AccessToken(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AccessTokenEntry())));
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$OAuth20NameSpace.AccessToken();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AccessTokenEntry()));
    F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.Dictionary[$this] := $tmp0;
    call System.Object.#ctor($this);
}



procedure T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#cctor();



implementation T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#cctor()
{
}



procedure T$LiveIDNameSpace.LiveID_IdP.#cctor();



implementation T$LiveIDNameSpace.LiveID_IdP.#cctor()
{
    F$LiveIDNameSpace.LiveID_IdP.Nondet := null;
}



function T$login() : Ref;

const unique T$login: int;

var F$login.RP: [Ref]Ref;

procedure login.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



procedure {:extern} System.Web.UI.Page.get_Session($this: Ref) returns ($result: Ref);



procedure {:extern} System.Web.HttpSessionStateWrapper.#ctor$System.Web.SessionState.HttpSessionState($this: Ref, httpSessionState$in: Ref);



function {:extern} T$System.Web.HttpSessionStateWrapper() : Ref;

const {:extern} unique T$System.Web.HttpSessionStateWrapper: int;

axiom $TypeConstructor(T$System.Web.HttpSessionStateWrapper()) == T$System.Web.HttpSessionStateWrapper;

procedure {:extern} System.Web.HttpContext.get_Request($this: Ref) returns ($result: Ref);



procedure LiveIDNameSpace.LiveID_RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



implementation login.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var local_1_Ref: Ref;
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
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 199} true;
    call $tmp0 := Alloc();
    call $tmp1 := System.Web.UI.Page.get_Session($this);
    call System.Web.HttpSessionStateWrapper.#ctor$System.Web.SessionState.HttpSessionState($tmp0, $tmp1);
    assume $DynamicType($tmp0) == T$System.Web.HttpSessionStateWrapper();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Web.HttpSessionStateWrapper;
    assume $this != null;
    F$GenericAuthNameSpace.RP.CurrentSession[F$login.RP[$this]] := $tmp0;
    assume $this != null;
    $tmp2 := F$login.RP[$this];
    call $tmp3 := System.Web.HttpContext.get_Current();
    call $tmp4 := System.Web.HttpContext.get_Request($tmp3);
    call $tmp5 := OpenIDConnectNameSpace.RelyingParty.parseAuthenticationResponse$System.Web.HttpRequest($tmp2, $tmp4);
    local_1_Ref := $tmp5;
    if (local_1_Ref == null)
    {
        assume {:breadcrumb 200} true;
        return;
    }
    else
    {
        assume {:breadcrumb 201} true;
    }

    assume $this != null;
    if ($TypeConstructor($DynamicType(F$login.RP[$this])) == T$LiveIDNameSpace.LiveID_RP_For_vProgram)
    {
        assume $this != null;
        $tmp6 := F$login.RP[$this];
        call $tmp7 := LiveIDNameSpace.LiveID_RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($tmp6, local_1_Ref);
    }
    else
    {
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$login.RP[$this])) == T$LiveIDNameSpace.LiveID_RP)
        {
            assume $this != null;
            $tmp8 := F$login.RP[$this];
            call $tmp9 := LiveIDNameSpace.LiveID_RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($tmp8, local_1_Ref);
        }
        else
        {
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$login.RP[$this])) == T$OpenIDConnectNameSpace.RelyingParty)
            {
                assume $this != null;
                $tmp10 := F$login.RP[$this];
                call $tmp11 := GenericAuthNameSpace.RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($tmp10, local_1_Ref);
            }
            else
            {
                assume $this != null;
                if ($TypeConstructor($DynamicType(F$login.RP[$this])) == T$OAuth20NameSpace.Client)
                {
                    assume $this != null;
                    $tmp12 := F$login.RP[$this];
                    call $tmp13 := GenericAuthNameSpace.RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($tmp12, local_1_Ref);
                }
                else
                {
                    assume $this != null;
                    $tmp14 := F$login.RP[$this];
                    call $tmp15 := GenericAuthNameSpace.RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($tmp14, local_1_Ref);
                }
            }
        }
    }
}



procedure login.#ctor($this: Ref);



const {:value "000000004C108D95"} unique $string_literal_000000004C108D95_27: Ref;

const {:value "http://a.local.host:14022/login.aspx"} unique $string_literal_http$$$a.local.host$14022$login.aspx_28: Ref;

const {:value "zMVS1BpoNHwtdTnSzazSt2JgLd1hxRA1"} unique $string_literal_zMVS1BpoNHwtdTnSzazSt2JgLd1hxRA1_29: Ref;

const {:value "https://login.live.com/oauth20_token.srf"} unique $string_literal_https$$$login.live.com$oauth20_token.srf_30: Ref;

procedure LiveIDNameSpace.LiveID_RP.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id$in: Ref, return_uri$in: Ref, client_secret$in: Ref, TokenEndpointUrl$in: Ref);



procedure {:extern} System.Web.UI.Page.#ctor($this: Ref);



implementation login.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$login.RP[$this] := null;
    assume {:breadcrumb 202} true;
    call $tmp0 := Alloc();
    call LiveIDNameSpace.LiveID_RP.#ctor$System.String$System.String$System.String$System.String($tmp0, $string_literal_000000004C108D95_27, $string_literal_http$$$a.local.host$14022$login.aspx_28, $string_literal_zMVS1BpoNHwtdTnSzazSt2JgLd1hxRA1_29, $string_literal_https$$$login.live.com$oauth20_token.srf_30);
    assume $DynamicType($tmp0) == T$LiveIDNameSpace.LiveID_RP();
    assume $TypeConstructor($DynamicType($tmp0)) == T$LiveIDNameSpace.LiveID_RP;
    F$login.RP[$this] := $tmp0;
    call System.Web.UI.Page.#ctor($this);
}



procedure T$login.#cctor();



implementation T$login.#cctor()
{
}



implementation LiveIDNameSpace.LiveID_RP.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id$in: Ref, return_uri$in: Ref, client_secret$in: Ref, TokenEndpointUrl$in: Ref)
{
  var client_id: Ref;
  var return_uri: Ref;
  var client_secret: Ref;
  var TokenEndpointUrl: Ref;
  var $localExc: Ref;
  var $label: int;

    client_id := client_id$in;
    return_uri := return_uri$in;
    client_secret := client_secret$in;
    TokenEndpointUrl := TokenEndpointUrl$in;
    assume {:breadcrumb 203} true;
    call OpenIDConnectNameSpace.RelyingParty.#ctor$System.String$System.String$System.String$System.String($this, client_id, return_uri, client_secret, TokenEndpointUrl);
}



implementation LiveIDNameSpace.LiveID_RP.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 204} true;
    call LiveIDNameSpace.LiveID_RP.#ctor$System.String$System.String$System.String$System.String($this, $string_literal_000000004C108D95_27, $string_literal_http$$$a.local.host$14022$login.aspx_28, $string_literal_zMVS1BpoNHwtdTnSzazSt2JgLd1hxRA1_29, $string_literal_https$$$login.live.com$oauth20_token.srf_30);
}



implementation LiveIDNameSpace.LiveID_RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var local_2_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 205} true;
    call $tmp0 := OpenIDConnectNameSpace.RelyingParty.AuthenticationUsingAuthorizationCodeFlow$OpenIDConnectNameSpace.AuthenticationResponse($this, req);
    local_1_Ref := $tmp0;
    local_2_Ref := null;
    goto IL_0014;

  IL_0014:
    $result := local_2_Ref;
    return;
}



const {:value "TokenEndpoint"} unique $string_literal_TokenEndpoint_31: Ref;

procedure {:extern} System.Type.GetMethod$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



const {:value "live.com"} unique $string_literal_live.com_32: Ref;

procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct$System.Reflection.MethodInfo$System.String$System.Boolean$System.Boolean(o$in: Ref, in_msg$in: Ref, out_msg$in: Ref, mi$in: Ref, partyName$in: Ref, signed$in: bool, server_to_server$in: bool);



const {:value "C:\Users\Daniel Song\Desktop\LiveID_IdP_TokenEndPoint.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$LiveID_IdP_TokenEndPoint.txt_33: Ref;

implementation LiveIDNameSpace.LiveID_RP.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_2_Ref: Ref;
  var $tmp5: bool;
  var $tmp6: Ref;
  var local_3_Ref: Ref;
  var $tmp7: int;
  var $tmp8: Ref;
  var $tmp9: int;
  var local_4_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 206} true;
    call $tmp0 := OpenIDConnectNameSpace.RelyingParty.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this, req);
    local_0_Ref := $tmp0;
    call $tmp1 := Alloc();
    call System.Diagnostics.Stopwatch.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Diagnostics.Stopwatch();
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Diagnostics.Stopwatch;
    local_1_Ref := $tmp1;
    call System.Diagnostics.Stopwatch.Start(local_1_Ref);
    call $tmp2 := Alloc();
    call LiveIDNameSpace.LiveID_IdP.#ctor($tmp2);
    assume $DynamicType($tmp2) == T$LiveIDNameSpace.LiveID_IdP();
    assume $TypeConstructor($DynamicType($tmp2)) == T$LiveIDNameSpace.LiveID_IdP;
    $tmp3 := T$OpenIDConnectNameSpace.OpenIDProvider();
    call $tmp4 := System.Type.GetMethod$System.String($tmp3, $string_literal_TokenEndpoint_31);
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct$System.Reflection.MethodInfo$System.String$System.Boolean$System.Boolean($tmp2, req, local_0_Ref, $tmp4, $string_literal_live.com_32, false, false);
    call System.Diagnostics.Stopwatch.Stop(local_1_Ref);
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$LiveID_IdP_TokenEndPoint.txt_33;
    call $tmp5 := System.IO.File.Exists$System.String(local_2_Ref);
    if (!$tmp5)
    {
        assume {:breadcrumb 207} true;
        call $tmp6 := System.IO.File.CreateText$System.String(local_2_Ref);
        local_3_Ref := $tmp6;
        call $tmp7 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp7);
    }
    else
    {
        assume {:breadcrumb 208} true;
        call $tmp8 := System.IO.File.AppendText$System.String(local_2_Ref);
        local_3_Ref := $tmp8;
        call $tmp9 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
        call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp9);
    }

    local_4_Ref := local_0_Ref;
    goto IL_00b8;

  IL_00b8:
    $result := local_4_Ref;
    return;
}



procedure T$LiveIDNameSpace.LiveID_RP.#cctor();



implementation T$LiveIDNameSpace.LiveID_RP.#cctor()
{
}



function T$OAuth20NameSpace.AccessTokenRecs() : Ref;

const unique T$OAuth20NameSpace.AccessTokenRecs: int;

procedure OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndAccessToken$System.String$System.String$System.String($this: Ref, client_id$in: Ref, UserID$in: Ref, access_token$in: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndRefreshToken$System.String$System.String$System.String($this: Ref, client_id$in: Ref, UserID$in: Ref, refresh_token$in: Ref) returns ($result: Ref);



function T$OAuth20NameSpace.AuthorizationCodeRecs() : Ref;

const unique T$OAuth20NameSpace.AuthorizationCodeRecs: int;

var F$OAuth20NameSpace.AccessTokenEntry.user: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenEntry.client_id: [Ref]Ref;

implementation OAuth20NameSpace.AccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 209} true;
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

    assume {:breadcrumb 210} true;
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

    assume {:breadcrumb 211} true;
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

    assume {:breadcrumb 212} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AccessTokenEntry.client_id[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



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
    assume {:breadcrumb 213} true;
    call GenericAuthNameSpace.Permission_Claim.#ctor($this);
}



procedure T$OAuth20NameSpace.AccessTokenEntry.#cctor();



implementation T$OAuth20NameSpace.AccessTokenEntry.#cctor()
{
}



var F$OAuth20NameSpace.ValidateTokenRequest.access_token: [Ref]Ref;

var F$OAuth20NameSpace.ValidateTokenRequest.scope: [Ref]Ref;

var F$OAuth20NameSpace.ValidateTokenRequest.client_id: [Ref]Ref;

var F$OAuth20NameSpace.ValidateTokenRequest.user: [Ref]Ref;

implementation OAuth20NameSpace.ValidateTokenRequest.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 214} true;
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
    assume {:breadcrumb 215} true;
    F$OAuth20NameSpace.ValidateTokenRequest.access_token[$this] := value;
}



procedure OAuth20NameSpace.ValidateTokenRequest.get_permissions($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ValidateTokenRequest.get_permissions($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 216} true;
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
    assume {:breadcrumb 217} true;
    F$OAuth20NameSpace.ValidateTokenRequest.scope[$this] := value;
}



procedure OAuth20NameSpace.ValidateTokenRequest.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ValidateTokenRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 218} true;
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
    assume {:breadcrumb 219} true;
    F$OAuth20NameSpace.ValidateTokenRequest.client_id[$this] := value;
}



implementation OAuth20NameSpace.ValidateTokenRequest.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 220} true;
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
    assume {:breadcrumb 221} true;
    F$OAuth20NameSpace.ValidateTokenRequest.user[$this] := value;
}



procedure OAuth20NameSpace.ValidateTokenRequest.#ctor($this: Ref);



implementation OAuth20NameSpace.ValidateTokenRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ValidateTokenRequest.access_token[$this] := null;
    F$OAuth20NameSpace.ValidateTokenRequest.scope[$this] := null;
    F$OAuth20NameSpace.ValidateTokenRequest.client_id[$this] := null;
    F$OAuth20NameSpace.ValidateTokenRequest.user[$this] := null;
    assume {:breadcrumb 222} true;
    call GenericAuthNameSpace.ValidateTicket_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.ValidateTokenRequest.#cctor();



implementation T$OAuth20NameSpace.ValidateTokenRequest.#cctor()
{
}



function T$OAuth20NameSpace.ResourceRequest() : Ref;

const unique T$OAuth20NameSpace.ResourceRequest: int;

var F$OAuth20NameSpace.ResourceRequest.access_token: [Ref]Ref;

var F$OAuth20NameSpace.ResourceRequest.client_id: [Ref]Ref;

var F$OAuth20NameSpace.ResourceRequest.scope: [Ref]Ref;

procedure OAuth20NameSpace.ResourceRequest.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceRequest.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 223} true;
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
    assume {:breadcrumb 224} true;
    F$OAuth20NameSpace.ResourceRequest.access_token[$this] := value;
}



procedure OAuth20NameSpace.ResourceRequest.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 225} true;
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
    assume {:breadcrumb 226} true;
    F$OAuth20NameSpace.ResourceRequest.client_id[$this] := value;
}



procedure OAuth20NameSpace.ResourceRequest.#ctor($this: Ref);



implementation OAuth20NameSpace.ResourceRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ResourceRequest.access_token[$this] := null;
    F$OAuth20NameSpace.ResourceRequest.client_id[$this] := null;
    F$OAuth20NameSpace.ResourceRequest.scope[$this] := null;
    assume {:breadcrumb 227} true;
    call GenericAuthNameSpace.ReqResourceRS_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.ResourceRequest.#cctor();



implementation T$OAuth20NameSpace.ResourceRequest.#cctor()
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
    assume {:breadcrumb 228} true;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_description[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.state[$this] := null;
    call GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationErrorResponse.#cctor();



implementation T$OAuth20NameSpace.AuthorizationErrorResponse.#cctor()
{
}



function T$OAuth20NameSpace.ValidateTokenResponse() : Ref;

const unique T$OAuth20NameSpace.ValidateTokenResponse: int;

var F$OAuth20NameSpace.ValidateTokenResponse.access_token: [Ref]Ref;

var F$OAuth20NameSpace.ValidateTokenResponse.scope: [Ref]Ref;

var F$OAuth20NameSpace.ValidateTokenResponse.client_id: [Ref]Ref;

var F$OAuth20NameSpace.ValidateTokenResponse.user: [Ref]Ref;

procedure OAuth20NameSpace.ValidateTokenResponse.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 229} true;
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
    assume {:breadcrumb 230} true;
    F$OAuth20NameSpace.ValidateTokenResponse.access_token[$this] := value;
}



procedure OAuth20NameSpace.ValidateTokenResponse.get_permissions($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.get_permissions($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 231} true;
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
    assume {:breadcrumb 232} true;
    F$OAuth20NameSpace.ValidateTokenResponse.scope[$this] := value;
}



procedure OAuth20NameSpace.ValidateTokenResponse.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 233} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ValidateTokenResponse.client_id[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.ValidateTokenResponse.set_Realm$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.set_Realm$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 234} true;
    F$OAuth20NameSpace.ValidateTokenResponse.client_id[$this] := value;
}



procedure OAuth20NameSpace.ValidateTokenResponse.get_UserID($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 235} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ValidateTokenResponse.user[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.ValidateTokenResponse.set_UserID$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.set_UserID$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 236} true;
    F$OAuth20NameSpace.ValidateTokenResponse.user[$this] := value;
}



procedure OAuth20NameSpace.ValidateTokenResponse.#ctor($this: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ValidateTokenResponse.access_token[$this] := null;
    F$OAuth20NameSpace.ValidateTokenResponse.scope[$this] := null;
    F$OAuth20NameSpace.ValidateTokenResponse.client_id[$this] := null;
    F$OAuth20NameSpace.ValidateTokenResponse.user[$this] := null;
    assume {:breadcrumb 237} true;
    call GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.ValidateTokenResponse.#cctor();



implementation T$OAuth20NameSpace.ValidateTokenResponse.#cctor()
{
}



function T$OAuth20NameSpace.ResourceServer() : Ref;

const unique T$OAuth20NameSpace.ResourceServer: int;

var F$OAuth20NameSpace.ResourceServer.TokenEndpointUrl: [Ref]Ref;

procedure OAuth20NameSpace.ResourceServer.get_ResourceRecs($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceServer.get_ResourceRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 238} true;
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
    assume {:breadcrumb 239} true;
    F$GenericAuthNameSpace.RS.RSResourceRecs[$this] := value;
}



procedure OAuth20NameSpace.ResourceServer.init$OAuth20NameSpace.ResourceRecs($this: Ref, recs$in: Ref);



implementation OAuth20NameSpace.ResourceServer.init$OAuth20NameSpace.ResourceRecs($this: Ref, recs$in: Ref)
{
  var recs: Ref;
  var $localExc: Ref;
  var $label: int;

    recs := recs$in;
    assume {:breadcrumb 240} true;
    call OAuth20NameSpace.ResourceServer.set_ResourceRecs$OAuth20NameSpace.ResourceRecs($this, recs);
}



procedure OAuth20NameSpace.ResourceServer.createValidateTokenRequest$OAuth20NameSpace.ResourceRequest($this: Ref, res_req$in: Ref) returns ($result: Ref);



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
    assume {:breadcrumb 241} true;
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
        assume {:breadcrumb 242} true;
        $tmp3 := res_req;
        assume $tmp3 != null;
        call OAuth20NameSpace.ValidateTokenRequest.set_UserID$System.String(local_0_Ref, F$GenericAuthNameSpace.ReqResourceRS_Req.UserID[$tmp3]);
    }
    else
    {
        assume {:breadcrumb 243} true;
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

procedure OAuth20NameSpace.ResourceServer.callValidateTokenEndpoint$OAuth20NameSpace.ValidateTokenRequest($this: Ref, treq$in: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.ResourceServer.conclude$OAuth20NameSpace.ValidateTokenResponse($this: Ref, tresq$in: Ref) returns ($result: bool);



procedure {:extern} System.Collections.Generic.HashSet`1.#ctor($this: Ref);



function {:extern} T$T$System.Collections.Generic.HashSet`1(parent: Ref) : Ref;

function {:extern} T$System.Collections.Generic.HashSet`1(T: Ref) : Ref;

const {:extern} unique T$System.Collections.Generic.HashSet`1: int;

procedure System.Collections.Generic.HashSet.Enumerator.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



procedure {:extern} System.Collections.Generic.HashSet`1.GetEnumerator($this: Ref) returns ($result: Ref);



procedure {:extern} System.Collections.Generic.HashSet`1.Enumerator.get_Current($this: Ref) returns ($result: Ref);



procedure {:extern} System.Collections.Generic.HashSet`1.Add$`0($this: Ref, item$in: Ref) returns ($result: bool);



procedure {:extern} System.Collections.Generic.HashSet`1.Enumerator.MoveNext($this: Ref) returns ($result: bool);



procedure OAuth20NameSpace.ResourceResponse.#ctor($this: Ref);



function T$OAuth20NameSpace.ResourceResponse() : Ref;

const unique T$OAuth20NameSpace.ResourceResponse: int;

var F$OAuth20NameSpace.ResourceResponse.client_id: [Ref]Ref;

var F$OAuth20NameSpace.ResourceResponse.access_token: [Ref]Ref;

implementation OAuth20NameSpace.ResourceServer.RequestResource$OAuth20NameSpace.ResourceRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_7_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: bool;
  var $tmp4: Ref;
  var local_2_Ref: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var local_3_Ref: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: bool;
  var $tmp19: bool;
  var local_4_prime_Ref: Ref;
  var $tmp20: Ref;
  var $tmp21: Ref;
  var $tmp22: Ref;
  var $tmp23: Ref;
  var local_5_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 244} true;
    call $tmp0 := Alloc();
    call System.Collections.Generic.HashSet$GenericAuthNameSpace.Permission$.Enumerator.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.HashSet`1.Enumerator(T$GenericAuthNameSpace.Permission());
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    assume T$T$System.Collections.Generic.HashSet`1.Enumerator($DynamicType($tmp0)) == T$GenericAuthNameSpace.Permission();
    local_7_Ref := $tmp0;
    call $tmp1 := OAuth20NameSpace.ResourceServer.createValidateTokenRequest$OAuth20NameSpace.ResourceRequest($this, req);
    call $tmp2 := OAuth20NameSpace.ResourceServer.callValidateTokenEndpoint$OAuth20NameSpace.ValidateTokenRequest($this, $tmp1);
    local_1_Ref := $tmp2;
    call $tmp3 := OAuth20NameSpace.ResourceServer.conclude$OAuth20NameSpace.ValidateTokenResponse($this, local_1_Ref);
    if ($tmp3)
    {
        assume {:breadcrumb 245} true;
        call $tmp4 := Alloc();
        call GenericAuthNameSpace.Resources.#ctor($tmp4);
        assume $DynamicType($tmp4) == T$GenericAuthNameSpace.Resources();
        assume $TypeConstructor($DynamicType($tmp4)) == T$GenericAuthNameSpace.Resources;
        local_2_Ref := $tmp4;
        call $tmp5 := Alloc();
        call System.Collections.Generic.HashSet`1.#ctor($tmp5);
        assume $DynamicType($tmp5) == T$System.Collections.Generic.HashSet`1(T$GenericAuthNameSpace.Resource());
        assume $TypeConstructor($DynamicType($tmp5)) == T$System.Collections.Generic.HashSet`1;
        assume T$T$System.Collections.Generic.HashSet`1($DynamicType($tmp5)) == T$GenericAuthNameSpace.Resource();
        F$GenericAuthNameSpace.Resources.resourceSet[local_2_Ref] := $tmp5;
        $tmp6 := req;
        assume $tmp6 != null;
        $tmp7 := F$OAuth20NameSpace.ResourceRequest.scope[$tmp6];
        assume $tmp7 != null;
        $tmp8 := F$GenericAuthNameSpace.Permissions.permissionSet[$tmp7];
        call $tmp9 := System.Collections.Generic.HashSet`1.GetEnumerator($tmp8);
        call local_7_Ref := System.Collections.Generic.HashSet.Enumerator.#copy_ctor($tmp9);
        goto IL_0073;

      IL_004b:
        call $tmp11 := System.Collections.Generic.HashSet`1.Enumerator.get_Current(local_7_Ref);
        $tmp10 := $tmp11;
        local_3_Ref := $tmp10;
        $tmp12 := local_2_Ref;
        assume $tmp12 != null;
        $tmp13 := F$GenericAuthNameSpace.Resources.resourceSet[$tmp12];
        call $tmp14 := OAuth20NameSpace.ResourceServer.get_ResourceRecs($this);
        if ($TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse)
        {
            call $tmp15 := OAuth20NameSpace.ValidateTokenResponse.get_UserID(local_1_Ref);
        }
        else
        {
            call $tmp16 := GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_UserID(local_1_Ref);
        }

        call $tmp17 := GenericAuthNameSpace.RSResourceRecords_Base.getEntry$System.String$GenericAuthNameSpace.Permission($tmp14, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse then $tmp15 else $tmp16), local_3_Ref);
        call $tmp18 := System.Collections.Generic.HashSet`1.Add$`0($tmp13, $tmp17);

      IL_0073:
        call $tmp19 := System.Collections.Generic.HashSet`1.Enumerator.MoveNext(local_7_Ref);
        if ($tmp19)
        {
            assume {:breadcrumb 247} true;
            goto IL_004b;
        }
        else
        {
            assume {:breadcrumb 248} true;
        }

        call $tmp20 := Alloc();
        call OAuth20NameSpace.ResourceResponse.#ctor($tmp20);
        assume $DynamicType($tmp20) == T$OAuth20NameSpace.ResourceResponse();
        assume $TypeConstructor($DynamicType($tmp20)) == T$OAuth20NameSpace.ResourceResponse;
        local_4_prime_Ref := $tmp20;
        $tmp21 := local_1_Ref;
        assume $tmp21 != null;
        F$OAuth20NameSpace.ResourceResponse.client_id[local_4_prime_Ref] := F$OAuth20NameSpace.ValidateTokenResponse.client_id[$tmp21];
        $tmp22 := local_1_Ref;
        assume $tmp22 != null;
        F$OAuth20NameSpace.ResourceResponse.access_token[local_4_prime_Ref] := F$OAuth20NameSpace.ValidateTokenResponse.access_token[$tmp22];
        F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.resources[local_4_prime_Ref] := local_2_Ref;
        $tmp23 := local_1_Ref;
        assume $tmp23 != null;
        F$CST.CST_Struct.SymT[local_4_prime_Ref] := F$CST.CST_Struct.SymT[$tmp23];
        local_5_Ref := local_4_prime_Ref;
    }
    else
    {
        assume {:breadcrumb 246} true;
        local_5_Ref := null;
        goto IL_00d3;
    }

  IL_00d3:
    $result := local_5_Ref;
    return;
}



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
  var $localExc: Ref;
  var $label: int;

    tresq := tresq$in;
    assume {:breadcrumb 249} true;
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
    call $tmp6 := GenericAuthNameSpace.RS.RequestResourceDone$GenericAuthNameSpace.RS.AuthorizationConclusion($this, local_0_Ref);
    local_1_bool := $tmp6;
    goto IL_0040;

  IL_0040:
    $result := local_1_bool;
    return;
}



procedure OAuth20NameSpace.ResourceServer.#ctor($this: Ref);



implementation OAuth20NameSpace.ResourceServer.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ResourceServer.TokenEndpointUrl[$this] := null;
    assume {:breadcrumb 250} true;
    call GenericAuthNameSpace.RS.#ctor($this);
}



procedure T$OAuth20NameSpace.ResourceServer.#cctor();



implementation T$OAuth20NameSpace.ResourceServer.#cctor()
{
}



function T$OAuth20NameSpace.NondetOAuth20() : Ref;

const unique T$OAuth20NameSpace.NondetOAuth20: int;

procedure OAuth20NameSpace.NondetOAuth20.ValidateTicket_Req($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.NondetOAuth20.ValidateTokenRequest($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.NondetOAuth20.ResourceRequest($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.NondetOAuth20.ResourceResponse($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.NondetOAuth20.AccessTokenDictionary($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.NondetOAuth20.AccessTokenEntry($this: Ref) returns ($result: Ref);



function T$OAuth20NameSpace.AuthorizationResponse() : Ref;

const unique T$OAuth20NameSpace.AuthorizationResponse: int;

implementation OAuth20NameSpace.AuthorizationResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AuthorizationResponse.code[$this] := null;
    F$OAuth20NameSpace.AuthorizationResponse.state[$this] := null;
    assume {:breadcrumb 251} true;
    F$OAuth20NameSpace.AuthorizationResponse.state[$this] := null;
    call GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationResponse.#cctor();



implementation T$OAuth20NameSpace.AuthorizationResponse.#cctor()
{
}



procedure OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 252} true;
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
    assume {:breadcrumb 253} true;
    F$GenericAuthNameSpace.AS.IdpAuthRecs[$this] := value;
}



implementation OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 254} true;
    assume $this != null;
    local_0_Ref := F$GenericAuthNameSpace.AS.ASAuthRecs[$this];
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



implementation OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 255} true;
    F$GenericAuthNameSpace.AS.ASAuthRecs[$this] := value;
}



implementation OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, AccessTokenRecs1$in: Ref)
{
  var AuthorizationCodeRecs1: Ref;
  var AccessTokenRecs1: Ref;
  var $localExc: Ref;
  var $label: int;

    AuthorizationCodeRecs1 := AuthorizationCodeRecs1$in;
    AccessTokenRecs1 := AccessTokenRecs1$in;
    assume {:breadcrumb 256} true;
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
    assume {:breadcrumb 257} true;
    call OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this, AccessTokenRecs1);
}



procedure OAuth20NameSpace.AuthorizationServer.ValidateTicket$OAuth20NameSpace.ValidateTokenRequest($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} System.Collections.Generic.HashSet`1.IsSupersetOf$System.Collections.Generic.IEnumerable$`0$($this: Ref, other$in: Ref) returns ($result: bool);



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
  var $tmp16: Ref;
  var $tmp17: bool;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var $tmp20: Ref;
  var $tmp21: Ref;
  var $tmp22: Ref;
  var $tmp23: bool;
  var $tmp24: Ref;
  var $tmp25: Ref;
  var $tmp26: Ref;
  var $tmp27: Ref;
  var $tmp28: Ref;
  var $tmp29: Ref;
  var $tmp30: bool;
  var stack_0_System_Boolean_bool: bool;
  var local_3_bool: bool;
  var local_2_Ref: Ref;
  var $tmp31: Ref;
  var $tmp32: Ref;
  var $tmp33: Ref;
  var $tmp34: Ref;
  var $tmp35: bool;
  var local_1_prime_Ref: Ref;
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
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 258} true;
    assume req == F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req;
    call $tmp12 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    if ($TypeConstructor($DynamicType($tmp12)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
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

        call $tmp5 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp0, F$OAuth20NameSpace.ValidateTokenRequest.access_token[$tmp1], F$OAuth20NameSpace.ValidateTokenRequest.client_id[$tmp2], (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp3 else $tmp4));
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

    local_0_Ref := (if $TypeConstructor($DynamicType($tmp12)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp5 else $tmp11);
    $tmp13 := req;
    assume $tmp13 != null;
    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
    {
        call $tmp14 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
        {
            call $tmp15 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
        }
        else
        {
            call $tmp16 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
        }
    }

    call $tmp17 := System.String.op_Inequality$System.String$System.String(F$OAuth20NameSpace.ValidateTokenRequest.client_id[$tmp13], (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp14 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp15 else $tmp16)));
    if ($tmp17)
    {
        assume {:breadcrumb 259} true;
        if ($TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest)
        {
            call $tmp18 := OAuth20NameSpace.ValidateTokenRequest.get_UserID(req);
        }
        else
        {
            call $tmp19 := GenericAuthNameSpace.ValidateTicket_Req.get_UserID(req);
        }

        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
        {
            call $tmp20 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID(local_0_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
            {
                call $tmp21 := OAuth20NameSpace.AccessTokenEntry.get_UserID(local_0_Ref);
            }
            else
            {
                call $tmp22 := GenericAuthNameSpace.Permission_Claim.get_UserID(local_0_Ref);
            }
        }

        call $tmp23 := System.String.op_Inequality$System.String$System.String((if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp18 else $tmp19), (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp20 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp21 else $tmp22)));
        if ($tmp23)
        {
            assume {:breadcrumb 261} true;
        }
        else
        {
            assume {:breadcrumb 262} true;
            goto IL_0078;
        }

        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
        {
            call $tmp24 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
            {
                call $tmp25 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
            }
            else
            {
                call $tmp26 := GenericAuthNameSpace.Permission_Claim.get_permissions(local_0_Ref);
            }
        }

        assume (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp24 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp25 else $tmp26)) != null;
        $tmp27 := F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp24 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp25 else $tmp26))];
        if ($TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest)
        {
            call $tmp28 := OAuth20NameSpace.ValidateTokenRequest.get_permissions(req);
        }
        else
        {
            call $tmp29 := GenericAuthNameSpace.ValidateTicket_Req.get_permissions(req);
        }

        assume (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp28 else $tmp29) != null;
        call $tmp30 := System.Collections.Generic.HashSet`1.IsSupersetOf$System.Collections.Generic.IEnumerable$`0$($tmp27, F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp28 else $tmp29)]);
        stack_0_System_Boolean_bool := !$tmp30;
    }
    else
    {
        assume {:breadcrumb 260} true;

      IL_0078:
        stack_0_System_Boolean_bool := true;
    }

    local_3_bool := stack_0_System_Boolean_bool != false;
    if (!local_3_bool)
    {
        assume {:breadcrumb 263} true;
        local_2_Ref := null;
    }
    else
    {
        assume {:breadcrumb 264} true;
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
        {
            call $tmp31 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
            {
                call $tmp32 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
            }
            else
            {
                call $tmp33 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
            }
        }

        $tmp34 := F$GenericAuthNameSpace.GlobalObjects_base.RS;
        assume $tmp34 != null;
        call $tmp35 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp31 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp32 else $tmp33)), F$GenericAuthNameSpace.RS.Realm[$tmp34]);
        assume $tmp35;
        call $tmp36 := Alloc();
        call OAuth20NameSpace.ValidateTokenResponse.#ctor($tmp36);
        assume $DynamicType($tmp36) == T$OAuth20NameSpace.ValidateTokenResponse();
        assume $TypeConstructor($DynamicType($tmp36)) == T$OAuth20NameSpace.ValidateTokenResponse;
        local_1_prime_Ref := $tmp36;
        $tmp37 := req;
        assume $tmp37 != null;
        F$OAuth20NameSpace.ValidateTokenResponse.access_token[local_1_prime_Ref] := F$OAuth20NameSpace.ValidateTokenRequest.access_token[$tmp37];
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
        {
            call $tmp38 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
            {
                call $tmp39 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
            }
            else
            {
                call $tmp40 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
            }
        }

        F$OAuth20NameSpace.ValidateTokenResponse.client_id[local_1_prime_Ref] := (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp38 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp39 else $tmp40));
        if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
        {
            call $tmp41 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
            {
                call $tmp42 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
            }
            else
            {
                call $tmp43 := GenericAuthNameSpace.Permission_Claim.get_permissions(local_0_Ref);
            }
        }

        F$OAuth20NameSpace.ValidateTokenResponse.scope[local_1_prime_Ref] := (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp41 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp42 else $tmp43));
        if ($TypeConstructor($DynamicType(local_1_prime_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse)
        {
            assume {:breadcrumb 265} true;
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
            {
                call $tmp44 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID(local_0_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
                {
                    call $tmp45 := OAuth20NameSpace.AccessTokenEntry.get_UserID(local_0_Ref);
                }
                else
                {
                    call $tmp46 := GenericAuthNameSpace.Permission_Claim.get_UserID(local_0_Ref);
                }
            }

            call OAuth20NameSpace.ValidateTokenResponse.set_UserID$System.String(local_1_prime_Ref, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp44 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp45 else $tmp46)));
        }
        else
        {
            assume {:breadcrumb 266} true;
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
            {
                call $tmp47 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID(local_0_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
                {
                    call $tmp48 := OAuth20NameSpace.AccessTokenEntry.get_UserID(local_0_Ref);
                }
                else
                {
                    call $tmp49 := GenericAuthNameSpace.Permission_Claim.get_UserID(local_0_Ref);
                }
            }

            call GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_UserID$System.String(local_1_prime_Ref, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp47 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp48 else $tmp49)));
        }

        if ($TypeConstructor($DynamicType(local_1_prime_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse)
        {
            assume {:breadcrumb 267} true;
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
            {
                call $tmp50 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
                {
                    call $tmp51 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
                }
                else
                {
                    call $tmp52 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
                }
            }

            call OAuth20NameSpace.ValidateTokenResponse.set_Realm$System.String(local_1_prime_Ref, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp50 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp51 else $tmp52)));
        }
        else
        {
            assume {:breadcrumb 268} true;
            if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
            {
                call $tmp53 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
                {
                    call $tmp54 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
                }
                else
                {
                    call $tmp55 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
                }
            }

            call GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_Realm$System.String(local_1_prime_Ref, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp53 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp54 else $tmp55)));
        }

        local_2_Ref := local_1_prime_Ref;
        goto IL_00e5;
    }

  IL_00e5:
    $result := local_2_Ref;
    return;
}



var F$OAuth20NameSpace.AuthorizationRequest.response_type: [Ref]Ref;

const {:value "token"} unique $string_literal_token_34: Ref;

procedure OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



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
  var $tmp5: Ref;
  var local_1_Ref: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: bool;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: bool;
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
  var local_2_Ref: Ref;
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
  var $tmp50: Ref;
  var $tmp51: Ref;
  var $tmp52: Ref;
  var $tmp53: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 269} true;
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := req;
    if (req == null)
    {
        assume {:breadcrumb 270} true;
        local_3_Ref := null;
    }
    else
    {
        assume {:breadcrumb 271} true;
        local_0_Ref := req;
        $tmp0 := local_0_Ref;
        assume $tmp0 != null;
        local_5_Ref := F$OAuth20NameSpace.AuthorizationRequest.response_type[$tmp0];
        if (local_5_Ref != null)
        {
            assume {:breadcrumb 272} true;
            call $tmp1 := System.String.op_Equality$System.String$System.String(local_5_Ref, $string_literal_code_0);
            if (!$tmp1)
            {
                assume {:breadcrumb 274} true;
                call $tmp2 := System.String.op_Equality$System.String$System.String(local_5_Ref, $string_literal_token_34);
                if ($tmp2)
                {
                    assume {:breadcrumb 276} true;
                    goto IL_0078;
                }
                else
                {
                    assume {:breadcrumb 277} true;
                }

                goto IL_00ab;
            }
            else
            {
                assume {:breadcrumb 275} true;
            }

            if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
            {
                call $tmp3 := LiveIDNameSpace.LiveID_IdP.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
                {
                    call $tmp4 := OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
                }
                else
                {
                    call $tmp5 := OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
                }
            }

            local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp3 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp4 else $tmp5));
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
            {
                assume $this != null;
                $tmp6 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
                $tmp7 := local_0_Ref;
                assume $tmp7 != null;
                if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest)
                {
                    call $tmp8 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
                }
                else
                {
                    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest)
                    {
                        call $tmp9 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
                    }
                    else
                    {
                        call $tmp10 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(local_0_Ref);
                    }
                }

                call $tmp11 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp6, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp7], (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp8 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp9 else $tmp10)), local_1_Ref);
            }
            else
            {
                assume $this != null;
                $tmp12 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
                $tmp13 := local_0_Ref;
                assume $tmp13 != null;
                if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest)
                {
                    call $tmp14 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
                }
                else
                {
                    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest)
                    {
                        call $tmp15 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
                    }
                    else
                    {
                        call $tmp16 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(local_0_Ref);
                    }
                }

                call $tmp17 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp12, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp13], (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp14 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp15 else $tmp16)), local_1_Ref);
            }

            if (!(if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp11 else $tmp17))
            {
                assume {:breadcrumb 278} true;
                local_3_Ref := null;
                goto IL_00bf;
            }
            else
            {
                assume {:breadcrumb 279} true;
            }

            goto IL_00af;

          IL_0078:
            if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
            {
                $tmp18 := local_0_Ref;
                assume $tmp18 != null;
                $tmp19 := local_0_Ref;
                assume $tmp19 != null;
                $tmp20 := local_0_Ref;
                assume $tmp20 != null;
                call $tmp21 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp18], F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp19], F$OAuth20NameSpace.AuthorizationRequest.state[$tmp20]);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
                {
                    $tmp22 := local_0_Ref;
                    assume $tmp22 != null;
                    $tmp23 := local_0_Ref;
                    assume $tmp23 != null;
                    $tmp24 := local_0_Ref;
                    assume $tmp24 != null;
                    call $tmp25 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp22], F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp23], F$OAuth20NameSpace.AuthorizationRequest.state[$tmp24]);
                }
                else
                {
                    $tmp26 := local_0_Ref;
                    assume $tmp26 != null;
                    $tmp27 := local_0_Ref;
                    assume $tmp27 != null;
                    $tmp28 := local_0_Ref;
                    assume $tmp28 != null;
                    call $tmp29 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp26], F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp27], F$OAuth20NameSpace.AuthorizationRequest.state[$tmp28]);
                }
            }

            local_2_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp21 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp25 else $tmp29));
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
            {
                assume $this != null;
                $tmp30 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
                $tmp31 := local_0_Ref;
                assume $tmp31 != null;
                if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest)
                {
                    call $tmp32 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
                }
                else
                {
                    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest)
                    {
                        call $tmp33 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
                    }
                    else
                    {
                        call $tmp34 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(local_0_Ref);
                    }
                }

                call $tmp35 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp30, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp31], (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp32 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp33 else $tmp34)));
            }
            else
            {
                assume $this != null;
                $tmp36 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
                $tmp37 := local_0_Ref;
                assume $tmp37 != null;
                if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest)
                {
                    call $tmp38 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
                }
                else
                {
                    if ($TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest)
                    {
                        call $tmp39 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
                    }
                    else
                    {
                        call $tmp40 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(local_0_Ref);
                    }
                }

                call $tmp41 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp36, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp37], (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp38 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp39 else $tmp40)));
            }

            local_1_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp35 else $tmp41);
        }
        else
        {
            assume {:breadcrumb 273} true;

          IL_00ab:
            local_3_Ref := null;
            goto IL_00bf;
        }

      IL_00af:
        if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
        {
            if ($TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
            {
                call $tmp42 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_1_Ref);
            }
            else
            {
                call $tmp43 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
            }

            call $tmp44 := OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp42 else $tmp43), local_1_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
            {
                if ($TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                {
                    call $tmp45 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_1_Ref);
                }
                else
                {
                    call $tmp46 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
                }

                call $tmp47 := OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp45 else $tmp46), local_1_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer)
                {
                    if ($TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                    {
                        call $tmp48 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_1_Ref);
                    }
                    else
                    {
                        call $tmp49 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
                    }

                    call $tmp50 := GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp48 else $tmp49), local_1_Ref);
                }
                else
                {
                    if ($TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                    {
                        call $tmp51 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_1_Ref);
                    }
                    else
                    {
                        call $tmp52 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
                    }

                    call $tmp53 := GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp51 else $tmp52), local_1_Ref);
                }
            }
        }

        local_3_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp44 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp47 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp50 else $tmp53)));
        goto IL_00bf;
    }

  IL_00bf:
    $result := local_3_Ref;
    return;
}



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
  var $tmp5: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    req1 := req1$in;
    assume {:breadcrumb 280} true;
    local_0_Ref := req1;
    $tmp0 := local_0_Ref;
    assume $tmp0 != null;
    local_2_Ref := F$OAuth20NameSpace.AuthorizationRequest.response_type[$tmp0];
    if (local_2_Ref != null)
    {
        assume {:breadcrumb 281} true;
        call $tmp1 := System.String.op_Equality$System.String$System.String(local_2_Ref, $string_literal_code_0);
        if (!$tmp1)
        {
            assume {:breadcrumb 283} true;
            call $tmp2 := System.String.op_Equality$System.String$System.String(local_2_Ref, $string_literal_token_34);
            if ($tmp2)
            {
                assume {:breadcrumb 285} true;
                goto IL_0038;
            }
            else
            {
                assume {:breadcrumb 286} true;
            }

            goto IL_0038;
        }
        else
        {
            assume {:breadcrumb 284} true;
        }

        if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
        {
            call $tmp3 := LiveIDNameSpace.LiveID_IdP.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
            {
                call $tmp4 := OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
            }
            else
            {
                call $tmp5 := OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
            }
        }

        local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp3 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp4 else $tmp5));
    }
    else
    {
        assume {:breadcrumb 282} true;

      IL_0038:
        local_1_Ref := null;
        goto IL_003c;
    }

  IL_003c:
    $result := local_1_Ref;
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.AuthorizationEndpoint$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AuthorizationServer.AuthorizationEndpoint$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 287} true;
    if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
    {
        call $tmp0 := OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
        {
            call $tmp1 := OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer)
            {
                call $tmp2 := OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
            }
            else
            {
                call $tmp3 := GenericAuthNameSpace.AS.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
            }
        }
    }

    local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp0 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp1 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp2 else $tmp3)));
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
    assume {:breadcrumb 288} true;
}



procedure OAuth20NameSpace.AuthorizationServer.TokenEndpoint$OAuth20NameSpace.AccessTokenRequest($this: Ref, req$in: Ref) returns ($result: Ref);



const {:value "refresh_token"} unique $string_literal_refresh_token_35: Ref;

function T$OAuth20NameSpace.AccessTokenResponse() : Ref;

const unique T$OAuth20NameSpace.AccessTokenResponse: int;

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
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var local_2_Ref: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var local_3_Ref: Ref;
  var $tmp19: Ref;
  var $tmp20: Ref;
  var $tmp21: bool;
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
  var local_0_Ref: Ref;
  var $tmp34: Ref;
  var $tmp35: Ref;
  var $tmp36: Ref;
  var $tmp37: Ref;
  var $tmp38: bool;
  var $tmp39: Ref;
  var $tmp40: Ref;
  var $tmp41: Ref;
  var $tmp42: Ref;
  var $tmp43: bool;
  var $tmp44: Ref;
  var $tmp45: Ref;
  var local_1_Ref: Ref;
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
  var $tmp66: Ref;
  var $tmp67: Ref;
  var $tmp68: Ref;
  var $tmp69: Ref;
  var $tmp70: Ref;
  var $tmp71: Ref;
  var $tmp72: Ref;
  var $tmp73: Ref;
  var $tmp74: Ref;
  var $tmp75: Ref;
  var $tmp76: Ref;
  var $tmp77: Ref;
  var $tmp78: Ref;
  var $tmp79: Ref;
  var $tmp80: Ref;
  var $tmp81: Ref;
  var $tmp82: Ref;
  var local_4_Ref: Ref;
  var $tmp83: Ref;
  var $tmp84: Ref;
  var $tmp85: Ref;
  var $tmp86: Ref;
  var $tmp87: bool;
  var $tmp88: Ref;
  var $tmp89: Ref;
  var $tmp90: Ref;
  var $tmp91: Ref;
  var $tmp92: bool;
  var $tmp93: Ref;
  var $tmp94: Ref;
  var $tmp95: Ref;
  var $tmp96: Ref;
  var $tmp97: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 289} true;
    if (req == null)
    {
        assume {:breadcrumb 290} true;
        local_5_Ref := null;
    }
    else
    {
        assume {:breadcrumb 291} true;
        $tmp0 := req;
        assume $tmp0 != null;
        local_7_Ref := F$OAuth20NameSpace.AccessTokenRequest.grant_type[$tmp0];
        if (local_7_Ref != null)
        {
            assume {:breadcrumb 292} true;
            call $tmp1 := System.String.op_Equality$System.String$System.String(local_7_Ref, $string_literal_authorization_code_2);
            if (!$tmp1)
            {
                assume {:breadcrumb 294} true;
                call $tmp2 := System.String.op_Equality$System.String$System.String(local_7_Ref, $string_literal_refresh_token_35);
                if ($tmp2)
                {
                    assume {:breadcrumb 296} true;
                    goto IL_0127;
                }
                else
                {
                    assume {:breadcrumb 297} true;
                }

                goto IL_01f1;
            }
            else
            {
                assume {:breadcrumb 295} true;
            }

            call $tmp11 := OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this);
            if ($TypeConstructor($DynamicType($tmp11)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
            {
                call $tmp3 := OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this);
                $tmp4 := req;
                assume $tmp4 != null;
                $tmp5 := req;
                assume $tmp5 != null;
                call $tmp6 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.findISSByClientIDAndCode$System.String$System.String($tmp3, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp4], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp5]);
            }
            else
            {
                call $tmp7 := OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this);
                $tmp8 := req;
                assume $tmp8 != null;
                $tmp9 := req;
                assume $tmp9 != null;
                call $tmp10 := OAuth20NameSpace.AuthorizationCodeRecs.findISSByClientIDAndCode$System.String$System.String($tmp7, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp8], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp9]);
            }

            local_2_Ref := (if $TypeConstructor($DynamicType($tmp11)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp6 else $tmp10);
            if (local_2_Ref == null)
            {
                assume {:breadcrumb 298} true;
                local_5_Ref := null;
            }
            else
            {
                assume {:breadcrumb 299} true;
                call $tmp18 := OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this);
                if ($TypeConstructor($DynamicType($tmp18)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
                {
                    call $tmp12 := OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this);
                    $tmp13 := req;
                    assume $tmp13 != null;
                    call $tmp14 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp12, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp13]);
                }
                else
                {
                    call $tmp15 := OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this);
                    $tmp16 := req;
                    assume $tmp16 != null;
                    call $tmp17 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp15, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp16]);
                }

                local_3_Ref := (if $TypeConstructor($DynamicType($tmp18)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp14 else $tmp17);
                $tmp19 := local_3_Ref;
                assume $tmp19 != null;
                $tmp20 := req;
                assume $tmp20 != null;
                call $tmp21 := System.String.op_Inequality$System.String$System.String(F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp19], F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[$tmp20]);
                if ($tmp21)
                {
                    assume {:breadcrumb 300} true;
                    local_5_Ref := null;
                }
                else
                {
                    assume {:breadcrumb 301} true;
                    if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
                    {
                        $tmp22 := local_3_Ref;
                        assume $tmp22 != null;
                        $tmp23 := local_3_Ref;
                        assume $tmp23 != null;
                        $tmp24 := local_3_Ref;
                        assume $tmp24 != null;
                        call $tmp25 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp22], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp23], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp24]);
                    }
                    else
                    {
                        if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
                        {
                            $tmp26 := local_3_Ref;
                            assume $tmp26 != null;
                            $tmp27 := local_3_Ref;
                            assume $tmp27 != null;
                            $tmp28 := local_3_Ref;
                            assume $tmp28 != null;
                            call $tmp29 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp26], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp27], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp28]);
                        }
                        else
                        {
                            $tmp30 := local_3_Ref;
                            assume $tmp30 != null;
                            $tmp31 := local_3_Ref;
                            assume $tmp31 != null;
                            $tmp32 := local_3_Ref;
                            assume $tmp32 != null;
                            call $tmp33 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp30], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp31], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp32]);
                        }
                    }

                    local_0_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp25 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp29 else $tmp33));
                    call $tmp44 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                    if ($TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
                    {
                        call $tmp34 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                        $tmp35 := local_0_Ref;
                        assume $tmp35 != null;
                        $tmp36 := req;
                        assume $tmp36 != null;
                        $tmp37 := req;
                        assume $tmp37 != null;
                        call $tmp38 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp34, F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp35], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp36], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp37], local_0_Ref);
                    }
                    else
                    {
                        call $tmp39 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                        $tmp40 := local_0_Ref;
                        assume $tmp40 != null;
                        $tmp41 := req;
                        assume $tmp41 != null;
                        $tmp42 := req;
                        assume $tmp42 != null;
                        call $tmp43 := GenericAuthNameSpace.ASAuthTicketRecords_Base.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp39, F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp40], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp41], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp42], local_0_Ref);
                    }

                    if (!(if $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp38 else $tmp43))
                    {
                        assume {:breadcrumb 302} true;
                        local_5_Ref := null;
                    }
                    else
                    {
                        assume {:breadcrumb 303} true;
                        call $tmp45 := Alloc();
                        call OAuth20NameSpace.AccessTokenResponse.#ctor($tmp45);
                        assume $DynamicType($tmp45) == T$OAuth20NameSpace.AccessTokenResponse();
                        assume $TypeConstructor($DynamicType($tmp45)) == T$OAuth20NameSpace.AccessTokenResponse;
                        local_1_Ref := $tmp45;
                        $tmp46 := local_0_Ref;
                        assume $tmp46 != null;
                        F$OAuth20NameSpace.AccessTokenResponse.access_token[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp46];
                        $tmp47 := local_0_Ref;
                        assume $tmp47 != null;
                        F$OAuth20NameSpace.AccessTokenResponse.refresh_token[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$tmp47];
                        $tmp48 := local_0_Ref;
                        assume $tmp48 != null;
                        F$OAuth20NameSpace.AccessTokenResponse.scope[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp48];
                        local_5_Ref := local_1_Ref;
                        goto IL_01f6;

                      IL_0127:
                        call $tmp59 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                        if ($TypeConstructor($DynamicType($tmp59)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
                        {
                            call $tmp49 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                            $tmp50 := req;
                            assume $tmp50 != null;
                            $tmp51 := req;
                            assume $tmp51 != null;
                            $tmp52 := req;
                            assume $tmp52 != null;
                            call $tmp53 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.findISSByClientIDAndRefreshToken$System.String$System.String$System.String($tmp49, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp50], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp51], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp52]);
                        }
                        else
                        {
                            call $tmp54 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                            $tmp55 := req;
                            assume $tmp55 != null;
                            $tmp56 := req;
                            assume $tmp56 != null;
                            $tmp57 := req;
                            assume $tmp57 != null;
                            call $tmp58 := OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndRefreshToken$System.String$System.String$System.String($tmp54, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp55], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp56], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp57]);
                        }

                        if ((if $TypeConstructor($DynamicType($tmp59)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp53 else $tmp58) == null)
                        {
                            assume {:breadcrumb 304} true;
                            local_5_Ref := null;
                        }
                        else
                        {
                            assume {:breadcrumb 305} true;
                            call $tmp70 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                            if ($TypeConstructor($DynamicType($tmp70)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
                            {
                                call $tmp60 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                                $tmp61 := req;
                                assume $tmp61 != null;
                                $tmp62 := req;
                                assume $tmp62 != null;
                                $tmp63 := req;
                                assume $tmp63 != null;
                                call $tmp64 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp60, F$OAuth20NameSpace.AccessTokenRequest.access_token[$tmp61], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp62], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp63]);
                            }
                            else
                            {
                                call $tmp65 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                                $tmp66 := req;
                                assume $tmp66 != null;
                                $tmp67 := req;
                                assume $tmp67 != null;
                                $tmp68 := req;
                                assume $tmp68 != null;
                                call $tmp69 := GenericAuthNameSpace.ASAuthTicketRecords_Base.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp65, F$OAuth20NameSpace.AccessTokenRequest.access_token[$tmp66], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp67], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp68]);
                            }

                            local_0_Ref := (if $TypeConstructor($DynamicType($tmp70)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp64 else $tmp69);
                            if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
                            {
                                $tmp71 := local_0_Ref;
                                assume $tmp71 != null;
                                $tmp72 := local_0_Ref;
                                assume $tmp72 != null;
                                $tmp73 := local_0_Ref;
                                assume $tmp73 != null;
                                call $tmp74 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$tmp71], F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp72], F$OAuth20NameSpace.AccessTokenEntry.state[$tmp73]);
                            }
                            else
                            {
                                if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
                                {
                                    $tmp75 := local_0_Ref;
                                    assume $tmp75 != null;
                                    $tmp76 := local_0_Ref;
                                    assume $tmp76 != null;
                                    $tmp77 := local_0_Ref;
                                    assume $tmp77 != null;
                                    call $tmp78 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$tmp75], F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp76], F$OAuth20NameSpace.AccessTokenEntry.state[$tmp77]);
                                }
                                else
                                {
                                    $tmp79 := local_0_Ref;
                                    assume $tmp79 != null;
                                    $tmp80 := local_0_Ref;
                                    assume $tmp80 != null;
                                    $tmp81 := local_0_Ref;
                                    assume $tmp81 != null;
                                    call $tmp82 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$tmp79], F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp80], F$OAuth20NameSpace.AccessTokenEntry.state[$tmp81]);
                                }
                            }

                            local_4_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp74 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp78 else $tmp82));
                            call $tmp93 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                            if ($TypeConstructor($DynamicType($tmp93)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
                            {
                                call $tmp83 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                                $tmp84 := local_4_Ref;
                                assume $tmp84 != null;
                                $tmp85 := req;
                                assume $tmp85 != null;
                                $tmp86 := req;
                                assume $tmp86 != null;
                                call $tmp87 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp83, F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp84], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp85], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp86], local_4_Ref);
                            }
                            else
                            {
                                call $tmp88 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                                $tmp89 := local_4_Ref;
                                assume $tmp89 != null;
                                $tmp90 := req;
                                assume $tmp90 != null;
                                $tmp91 := req;
                                assume $tmp91 != null;
                                call $tmp92 := GenericAuthNameSpace.ASAuthTicketRecords_Base.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp88, F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp89], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp90], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp91], local_4_Ref);
                            }

                            if (!(if $TypeConstructor($DynamicType($tmp93)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp87 else $tmp92))
                            {
                                assume {:breadcrumb 306} true;
                                local_5_Ref := null;
                            }
                            else
                            {
                                assume {:breadcrumb 307} true;
                                call $tmp94 := Alloc();
                                call OAuth20NameSpace.AccessTokenResponse.#ctor($tmp94);
                                assume $DynamicType($tmp94) == T$OAuth20NameSpace.AccessTokenResponse();
                                assume $TypeConstructor($DynamicType($tmp94)) == T$OAuth20NameSpace.AccessTokenResponse;
                                local_1_Ref := $tmp94;
                                $tmp95 := local_0_Ref;
                                assume $tmp95 != null;
                                F$OAuth20NameSpace.AccessTokenResponse.access_token[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp95];
                                $tmp96 := local_0_Ref;
                                assume $tmp96 != null;
                                F$OAuth20NameSpace.AccessTokenResponse.refresh_token[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$tmp96];
                                $tmp97 := local_0_Ref;
                                assume $tmp97 != null;
                                F$OAuth20NameSpace.AccessTokenResponse.scope[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp97];
                                local_5_Ref := local_1_Ref;
                            }
                        }
                    }
                }
            }
        }
        else
        {
            assume {:breadcrumb 293} true;

          IL_01f1:
            local_5_Ref := null;
            goto IL_01f6;
        }
    }

  IL_01f6:
    $result := local_5_Ref;
    return;
}



implementation OAuth20NameSpace.AuthorizationServer.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 308} true;
    call GenericAuthNameSpace.AS.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationServer.#cctor();



implementation T$OAuth20NameSpace.AuthorizationServer.#cctor()
{
}



implementation OAuth20NameSpace.Client.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.Client.client_secret[$this] := null;
    F$OAuth20NameSpace.Client.TokenEndpointUrl[$this] := null;
    assume {:breadcrumb 309} true;
    call GenericAuthNameSpace.RP.#ctor($this);
}



implementation OAuth20NameSpace.Client.get_client_id($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 310} true;
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
    assume {:breadcrumb 311} true;
    F$GenericAuthNameSpace.RP.Realm[$this] := value;
}



implementation OAuth20NameSpace.Client.get_return_uri($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 312} true;
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
    assume {:breadcrumb 313} true;
    F$GenericAuthNameSpace.RP.Domain[$this] := value;
}



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
    assume {:breadcrumb 314} true;
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



function T$OAuth20NameSpace.ResourceRecs() : Ref;

const unique T$OAuth20NameSpace.ResourceRecs: int;

var F$OAuth20NameSpace.AccessTokenResponse.token_type: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenResponse.client_id: [Ref]Ref;

procedure OAuth20NameSpace.AccessTokenResponse.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessTokenResponse.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 315} true;
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
    assume {:breadcrumb 316} true;
    F$OAuth20NameSpace.AccessTokenResponse.access_token[$this] := value;
}



procedure OAuth20NameSpace.AccessTokenResponse.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessTokenResponse.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 317} true;
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
    assume {:breadcrumb 318} true;
    F$OAuth20NameSpace.AccessTokenResponse.client_id[$this] := value;
}



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
    assume {:breadcrumb 319} true;
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[$this] := null;
    call GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.AccessTokenResponse.#cctor();



implementation T$OAuth20NameSpace.AccessTokenResponse.#cctor()
{
}



procedure OAuth20NameSpace.ResourceResponse.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceResponse.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 320} true;
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
    assume {:breadcrumb 321} true;
    F$OAuth20NameSpace.ResourceResponse.access_token[$this] := value;
}



procedure OAuth20NameSpace.ResourceResponse.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceResponse.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 322} true;
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
    assume {:breadcrumb 323} true;
    F$OAuth20NameSpace.ResourceResponse.client_id[$this] := value;
}



implementation OAuth20NameSpace.ResourceResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.ResourceResponse.access_token[$this] := null;
    F$OAuth20NameSpace.ResourceResponse.client_id[$this] := null;
    assume {:breadcrumb 324} true;
    call GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.ResourceResponse.#cctor();



implementation T$OAuth20NameSpace.ResourceResponse.#cctor()
{
}



function T$OAuth20NameSpace.AccessTokenRequest() : Ref;

const unique T$OAuth20NameSpace.AccessTokenRequest: int;

var F$OAuth20NameSpace.AccessTokenRequest.refresh_token: [Ref]Ref;

procedure OAuth20NameSpace.AccessTokenRequest.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessTokenRequest.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 325} true;
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
    assume {:breadcrumb 326} true;
    F$OAuth20NameSpace.AccessTokenRequest.access_token[$this] := value;
}



procedure OAuth20NameSpace.AccessTokenRequest.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessTokenRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 327} true;
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
    assume {:breadcrumb 328} true;
    F$OAuth20NameSpace.AccessTokenRequest.client_id[$this] := value;
}



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
    assume {:breadcrumb 329} true;
    F$OAuth20NameSpace.AccessTokenRequest.refresh_token[$this] := null;
    call GenericAuthNameSpace.AuthTicketAS_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.AccessTokenRequest.#cctor();



implementation T$OAuth20NameSpace.AccessTokenRequest.#cctor()
{
}



var F$OAuth20NameSpace.AuthorizationCodeEntry.user: [Ref]Ref;

implementation OAuth20NameSpace.AuthorizationCodeEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 330} true;
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

    assume {:breadcrumb 331} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.AuthorizationCodeEntry.#ctor($this: Ref);



implementation OAuth20NameSpace.AuthorizationCodeEntry.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AuthorizationCodeEntry.code[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.user[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.state[$this] := null;
    assume {:breadcrumb 332} true;
    call GenericAuthNameSpace.ID_Claim.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationCodeEntry.#cctor();



implementation T$OAuth20NameSpace.AuthorizationCodeEntry.#cctor()
{
}



var F$OAuth20NameSpace.AuthorizationRequest.client_id: [Ref]Ref;

implementation OAuth20NameSpace.AuthorizationRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 333} true;
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
    assume {:breadcrumb 334} true;
    F$OAuth20NameSpace.AuthorizationRequest.client_id[$this] := value;
}



implementation OAuth20NameSpace.AuthorizationRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AuthorizationRequest.response_type[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.client_id[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.scope[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.state[$this] := null;
    assume {:breadcrumb 335} true;
    F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.state[$this] := null;
    call GenericAuthNameSpace.SignInIdP_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationRequest.#cctor();



implementation T$OAuth20NameSpace.AuthorizationRequest.#cctor()
{
}



procedure OAuth20NameSpace.AccessToken.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessToken.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 336} true;
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
    assume {:breadcrumb 337} true;
    F$OAuth20NameSpace.AccessToken.token[$this] := value;
}



procedure OAuth20NameSpace.AccessToken.GetHashCode($this: Ref) returns ($result: int);



implementation OAuth20NameSpace.AccessToken.GetHashCode($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $tmp0: Ref;
  var $tmp1: int;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 338} true;
    assume $this != null;
    $tmp0 := F$OAuth20NameSpace.AccessToken.token[$this];
    call $tmp1 := System.Object.GetHashCode($tmp0);
    local_0_int := $tmp1;
    goto IL_000f;

  IL_000f:
    $result := local_0_int;
    return;
}



implementation OAuth20NameSpace.AccessToken.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AccessToken.token[$this] := null;
    assume {:breadcrumb 339} true;
    call GenericAuthNameSpace.Ticket.#ctor($this);
}



procedure T$OAuth20NameSpace.AccessToken.#cctor();



implementation T$OAuth20NameSpace.AccessToken.#cctor()
{
}



function T$CST.Debug() : Ref;

const unique T$CST.Debug: int;

procedure CST.Debug.reached();



implementation CST.Debug.reached()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 340} true;
    assert false;
}



procedure CST.Debug.#ctor($this: Ref);



implementation CST.Debug.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 341} true;
    call System.Object.#ctor($this);
}



procedure T$CST.Debug.#cctor();



implementation T$CST.Debug.#cctor()
{
}



function T$CST.Nondet_Base() : Ref;

const unique T$CST.Nondet_Base: int;

procedure CST.Nondet_Base.Int($this: Ref) returns ($result: int);



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
    assume {:breadcrumb 342} true;
    F$CST.CST_Struct.SymT[$this] := $string_literal__26;
    F$CST.CST_Struct.SignedBy[$this] := $string_literal__26;
    call System.Object.#ctor($this);
}



procedure T$CST.CST_Struct.#cctor();



implementation T$CST.CST_Struct.#cctor()
{
}


