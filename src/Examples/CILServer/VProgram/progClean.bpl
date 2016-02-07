const hashsetEmpty: [Union]bool;

axiom (forall x: Union :: { hashsetEmpty[x] } !hashsetEmpty[x]);

var hashsets: [Ref][Union]bool;

var hashsetSize: [Ref]int;

procedure {:extern} System.Collections.Generic.HashSet`1.#ctor($this: Ref);



implementation {:extern} System.Collections.Generic.HashSet`1.#ctor($this: Ref)
{

  anon0:
    hashsets[$this] := hashsetEmpty;
    hashsetSize[$this] := 0;
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.Add$`0($this: Ref, item$in: Union) returns ($result: bool);



implementation {:extern} System.Collections.Generic.HashSet`1.Add$`0($this: Ref, item$in: Union) returns ($result: bool)
{

  anon0:
    $result := !hashsets[$this][item$in];
    hashsets[$this][item$in] := true;
    goto anon2_Then, anon2_Else;

  anon2_Then:
    assume {:partition} $result;
    hashsetSize[$this] := hashsetSize[$this] + 1;
    return;

  anon2_Else:
    assume {:partition} !$result;
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool);



implementation {:extern} System.Collections.Generic.HashSet`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool)
{

  anon0:
    $result := hashsets[$this][item$in];
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool);



implementation {:extern} System.Collections.Generic.HashSet`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool)
{

  anon0:
    $result := hashsets[$this][item$in];
    hashsets[$this][item$in] := false;
    goto anon2_Then, anon2_Else;

  anon2_Then:
    assume {:partition} $result;
    hashsetSize[$this] := hashsetSize[$this] - 1;
    return;

  anon2_Else:
    assume {:partition} !$result;
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.get_Count($this: Ref) returns ($result: int);



implementation {:extern} System.Collections.Generic.HashSet`1.get_Count($this: Ref) returns ($result: int)
{

  anon0:
    $result := hashsetSize[$this];
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.New($this: Ref) returns ($result: Ref);



implementation {:extern} System.Collections.Generic.HashSet`1.New($this: Ref) returns ($result: Ref)
{

  anon0:
    call $result := Alloc();
    call System.Collections.Generic.HashSet`1.#ctor($result);
    assume $DynamicType($result) == $DynamicType($this);
    return;
}



var stacks: [Ref][int]Union;

var stackPtr: [Ref]int;

procedure {:extern} System.Collections.Generic.Stack`1.#ctor($this: Ref);



implementation {:extern} System.Collections.Generic.Stack`1.#ctor($this: Ref)
{

  anon0:
    stackPtr[$this] := 0;
    return;
}



procedure {:extern} System.Collections.Generic.Stack`1.Push$`0($this: Ref, item$in: Union);



implementation {:extern} System.Collections.Generic.Stack`1.Push$`0($this: Ref, item$in: Union)
{

  anon0:
    stacks[$this][stackPtr[$this]] := item$in;
    stackPtr[$this] := stackPtr[$this] + 1;
    return;
}



procedure {:extern} System.Collections.Generic.Stack`1.Pop($this: Ref) returns ($result: Union);



implementation {:extern} System.Collections.Generic.Stack`1.Pop($this: Ref) returns ($result: Union)
{

  anon0:
    stackPtr[$this] := stackPtr[$this] - 1;
    $result := stacks[$this][stackPtr[$this]];
    return;
}



procedure {:extern} System.Collections.Generic.Stack`1.get_Count($this: Ref) returns ($result: int);



implementation {:extern} System.Collections.Generic.Stack`1.get_Count($this: Ref) returns ($result: int)
{

  anon0:
    $result := stackPtr[$this];
    return;
}



procedure {:extern} System.Collections.Generic.Stack`1.Peek($this: Ref) returns ($result: Union);



implementation {:extern} System.Collections.Generic.Stack`1.Peek($this: Ref) returns ($result: Union)
{

  anon0:
    $result := stacks[$this][stackPtr[$this] - 1];
    return;
}



var listContents: [Ref][int]Union;

var listSize: [Ref]int;

procedure {:extern} System.Collections.Generic.List`1.#ctor($this: Ref);



implementation {:extern} System.Collections.Generic.List`1.#ctor($this: Ref)
{

  anon0:
    listSize[$this] := 0;
    return;
}



procedure {:extern} System.Collections.Generic.List`1.Add$`0($this: Ref, item$in: Union);



implementation {:extern} System.Collections.Generic.List`1.Add$`0($this: Ref, item$in: Union)
{
  var size: int;

  anon0:
    size := listSize[$this];
    listContents[$this][size] := item$in;
    listSize[$this] := size + 1;
    return;
}



procedure {:extern} System.Collections.Generic.List`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool);



implementation {:extern} System.Collections.Generic.List`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool)
{
  var iter: int;

  anon0:
    $result := false;
    iter := 0;
    goto anon6_LoopHead;

  anon6_LoopHead:
    goto anon6_LoopDone, anon6_LoopBody;

  anon6_LoopBody:
    assume {:partition} iter < listSize[$this] && !$result;
    $result := item$in == listContents[$this][iter];
    iter := iter + 1;
    goto anon6_LoopHead;

  anon6_LoopDone:
    assume {:partition} !(iter < listSize[$this] && !$result);
    goto anon2;

  anon2:
    goto anon7_LoopHead;

  anon7_LoopHead:
    goto anon7_LoopDone, anon7_LoopBody;

  anon7_LoopBody:
    assume {:partition} iter < listSize[$this];
    listContents[$this][iter - 1] := listContents[$this][iter];
    iter := iter + 1;
    goto anon7_LoopHead;

  anon7_LoopDone:
    assume {:partition} listSize[$this] <= iter;
    goto anon4;

  anon4:
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} $result;
    listSize[$this] := listSize[$this] - 1;
    return;

  anon8_Else:
    assume {:partition} !$result;
    return;
}



procedure {:extern} System.Collections.Generic.List`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool);



implementation {:extern} System.Collections.Generic.List`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool)
{
  var iter: int;

  anon0:
    $result := false;
    iter := 0;
    goto anon2_LoopHead;

  anon2_LoopHead:
    goto anon2_LoopDone, anon2_LoopBody;

  anon2_LoopBody:
    assume {:partition} iter < listSize[$this] && !$result;
    $result := item$in == listContents[$this][iter];
    iter := iter + 1;
    goto anon2_LoopHead;

  anon2_LoopDone:
    assume {:partition} !(iter < listSize[$this] && !$result);
    return;
}



procedure {:extern} System.Collections.Generic.List`1.get_Count($this: Ref) returns ($result: int);



implementation {:extern} System.Collections.Generic.List`1.get_Count($this: Ref) returns ($result: int)
{

  anon0:
    $result := listSize[$this];
    return;
}



procedure {:extern} System.Collections.Generic.List`1.Clear($this: Ref);



implementation {:extern} System.Collections.Generic.List`1.Clear($this: Ref)
{

  anon0:
    listSize[$this] := 0;
    return;
}



procedure {:extern} System.Collections.Generic.List`1.get_Item$System.Int32($this: Ref, index$in: int) returns ($result: Union);



implementation {:extern} System.Collections.Generic.List`1.get_Item$System.Int32($this: Ref, index$in: int) returns ($result: Union)
{

  anon0:
    $result := listContents[$this][index$in];
    return;
}



procedure {:extern} System.Collections.Generic.List`1.set_Item$System.Int32$`0($this: Ref, index$in: int, value$in: Union);



implementation {:extern} System.Collections.Generic.List`1.set_Item$System.Int32$`0($this: Ref, index$in: int, value$in: Union)
{

  anon0:
    listContents[$this][index$in] := value$in;
    return;
}



var AllMaps: [Ref][Union]Union;

procedure {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0(this: Ref, key$in: Union) returns ($result: Union);



implementation {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0(this: Ref, key$in: Union) returns ($result: Union)
{

  anon0:
    $result := AllMaps[this][key$in];
    return;
}



procedure {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1(this: Ref, key$in: Union, value$in: Union);



implementation {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1(this: Ref, key$in: Union, value$in: Union)
{

  anon0:
    AllMaps[this][key$in] := value$in;
    return;
}



procedure {:inline 1} Alloc() returns (x: Ref);
  modifies $Alloc;



implementation {:inline 1} Alloc() returns (x: Ref)
{

  anon0:
    assume $Alloc[x] == false && x != null;
    $Alloc[x] := true;
    return;
}



procedure {:inline 1} System.Object.GetType(this: Ref) returns ($result: Ref);



implementation {:inline 1} System.Object.GetType(this: Ref) returns ($result: Ref)
{

  anon0:
    $result := $DynamicType(this);
    return;
}



axiom Union2Int(null) == 0;

axiom Union2Bool(null) == false;

function $ThreadDelegate(Ref) : Ref;

procedure {:inline 1} System.Threading.Thread.#ctor$System.Threading.ParameterizedThreadStart(this: Ref, start$in: Ref);



implementation {:inline 1} System.Threading.Thread.#ctor$System.Threading.ParameterizedThreadStart(this: Ref, start$in: Ref)
{

  anon0:
    assume $ThreadDelegate(this) == start$in;
    return;
}



procedure {:inline 1} System.Threading.Thread.Start$System.Object(this: Ref, parameter$in: Ref);



implementation {:inline 1} System.Threading.Thread.Start$System.Object(this: Ref, parameter$in: Ref)
{

  anon0:
    async call Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object($ThreadDelegate(this), parameter$in);
    return;
}



procedure Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref);



implementation Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref)
{

  anon0:
    $Exception := null;
    call System.Threading.ParameterizedThreadStart.Invoke$System.Object(this, obj$in);
    return;
}



procedure {:extern} System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref);



procedure {:inline 1} System.Threading.Thread.#ctor$System.Threading.ThreadStart(this: Ref, start$in: Ref);



implementation {:inline 1} System.Threading.Thread.#ctor$System.Threading.ThreadStart(this: Ref, start$in: Ref)
{

  anon0:
    assume $ThreadDelegate(this) == start$in;
    return;
}



procedure {:inline 1} System.Threading.Thread.Start(this: Ref);



implementation {:inline 1} System.Threading.Thread.Start(this: Ref)
{

  anon0:
    async call Wrapper_System.Threading.ThreadStart.Invoke($ThreadDelegate(this));
    return;
}



procedure Wrapper_System.Threading.ThreadStart.Invoke(this: Ref);



implementation Wrapper_System.Threading.ThreadStart.Invoke(this: Ref)
{

  anon0:
    $Exception := null;
    call System.Threading.ThreadStart.Invoke(this);
    return;
}



procedure {:extern} System.Threading.ThreadStart.Invoke(this: Ref);



procedure {:inline 1} System.String.op_Equality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool);



procedure {:inline 1} System.String.op_Inequality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool);



implementation System.String.op_Equality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool)
{

  anon0:
    $result := a$in == b$in;
    return;
}



implementation System.String.op_Inequality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool)
{

  anon0:
    $result := a$in != b$in;
    return;
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

  anon0:
    call r := Alloc();
    assume $TypeConstructor($DynamicType(r)) == $BoolValueType;
    assume Union2Bool(r) == b;
    return;
}



procedure {:inline 1} $BoxFromInt(i: int) returns (r: Ref);



implementation {:inline 1} $BoxFromInt(i: int) returns (r: Ref)
{

  anon0:
    call r := Alloc();
    assume $TypeConstructor($DynamicType(r)) == $IntValueType;
    assume Union2Int(r) == i;
    return;
}



procedure {:inline 1} $BoxFromReal(r: Real) returns (rf: Ref);



implementation {:inline 1} $BoxFromReal(r: Real) returns (rf: Ref)
{

  anon0:
    call rf := Alloc();
    assume $TypeConstructor($DynamicType(rf)) == $RealValueType;
    assume Union2Real(rf) == r;
    return;
}



procedure {:inline 1} $BoxFromUnion(u: Union) returns (r: Ref);



implementation {:inline 1} $BoxFromUnion(u: Union) returns (r: Ref)
{

  anon0:
    r := u;
    return;
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

  anon0:
    call T$PoirotMain.#cctor();
    call T$LiveIDNameSpace.LiveID_RP_For_vProgram.#cctor();
    call T$SynthesizedPortion.#cctor();
    call T$GlobalObjectsForCST.#cctor();
    call T$OpenIDConnectNameSpace.RelyingParty.#cctor();
    call T$OpenIDConnectNameSpace.JsonDataStrcuture.#cctor();
    call T$OpenIDConnectNameSpace.TokenRequest.#cctor();
    call OpenIDConnectNameSpace.JsonWebToken.#cctor();
    call T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#cctor();
    call T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#cctor();
    call T$OpenIDConnectNameSpace.OpenIDProvider.#cctor();
    call T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#cctor();
    call T$OpenIDConnectNameSpace.TokenResponse.#cctor();
    call T$OpenIDConnectNameSpace.AuthenticationRequest.#cctor();
    call T$OpenIDConnectNameSpace.AuthenticationResponse.#cctor();
    call T$GenericAuthNameSpace.SignInIdP_Req.#cctor();
    call T$GenericAuthNameSpace.GlobalObjects_base.#cctor();
    call T$GenericAuthNameSpace.Permissions.#cctor();
    call T$GenericAuthNameSpace.ReqResourceRS_Req.#cctor();
    call T$GenericAuthNameSpace.Resources.#cctor();
    call T$GenericAuthNameSpace.AS.#cctor();
    call T$GenericAuthNameSpace.SignInRP_Resp.#cctor();
    call T$GenericAuthNameSpace.Permission_Claim.#cctor();
    call T$GenericAuthNameSpace.Ticket.#cctor();
    call T$GenericAuthNameSpace.Permission.#cctor();
    call T$GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#cctor();
    call T$GenericAuthNameSpace.Resource.#cctor();
    call T$GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#cctor();
    call T$GenericAuthNameSpace.RP.AuthenticationConclusion.#cctor();
    call T$GenericAuthNameSpace.RP.#cctor();
    call T$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#cctor();
    call T$GenericAuthNameSpace.ValidateTicket_Req.#cctor();
    call T$GenericAuthNameSpace.ID_Claim.#cctor();
    call T$GenericAuthNameSpace.RS.AuthorizationConclusion.#cctor();
    call T$GenericAuthNameSpace.RS.#cctor();
    call T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor();
    call T$GenericAuthNameSpace.AuthTicketAS_Req.#cctor();
    call T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#cctor();
    call T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#cctor();
    call T$LiveIDNameSpace.LiveID_IdP.#cctor();
    call T$LiveIDNameSpace.LiveID_RP.#cctor();
    call T$$$f__AnonymousType1`1.#cctor();
    call T$CILRepository.Models.ManageUserViewModel.#cctor();
    call T$CILRepository.Models.MSLoginViewModel.#cctor();
    call T$CILRepository.Models.RegisterViewModel.#cctor();
    call T$CILRepository.Models.LoginViewModel.#cctor();
    call T$CILRepository.Models.ApplicationUser.#cctor();
    call T$CILRepository.Models.ExternalLoginConfirmationViewModel.#cctor();
    call T$CILRepository.Models.ApplicationDbContext.#cctor();
    call T$CILRepository.Controllers.CILController.#cctor();
    call T$CILRepository.Controllers.AccountController.ChallengeResult.#cctor();
    call T$CILRepository.Controllers.AccountController.$DllHandle$o__SiteContainer0.#cctor();
    call T$CILRepository.Controllers.AccountController.$DepHandle$o__SiteContainer2.#cctor();
    call T$CILRepository.Controllers.AccountController.$DownloadMethodRecord$o__SiteContainer4.#cctor();
    call T$CILRepository.Controllers.AccountController.$Login$o__SiteContainer6.#cctor();
    call T$CILRepository.Controllers.AccountController.$MSLoginCallback$o__SiteContainer8.#cctor();
    call T$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer27.#cctor();
    call T$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer2b.#cctor();
    call T$CILRepository.Controllers.AccountController.$ExternalLoginCallback$o__SiteContainer31.#cctor();
    call T$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$o__SiteContainer42.#cctor();
    call T$CILRepository.Controllers.AccountController.$RemoveAccountList$o__SiteContainer4c.#cctor();
    call T$CILRepository.Controllers.AccountController.#cctor();
    call T$CILRepository.Controllers.HomeController.$About$o__SiteContainer0.#cctor();
    call T$CILRepository.Controllers.HomeController.$Contact$o__SiteContainer2.#cctor();
    call T$CILRepository.Controllers.HomeController.$Upload$o__SiteContainer4.#cctor();
    call T$CILRepository.Controllers.HomeController.$Download$o__SiteContainer6.#cctor();
    call T$CILRepository.Controllers.HomeController.$DownloadToken$o__SiteContainer8.#cctor();
    call T$CILRepository.Controllers.HomeController.$DLLHandle$o__SiteContainera.#cctor();
    call T$CILRepository.Controllers.HomeController.$UploadDll$o__SiteContainerc.#cctor();
    call T$CILRepository.Controllers.HomeController.#cctor();
    call T$CILRepository.RouteConfig.#cctor();
    call T$CILRepository.Startup.#cctor();
    call T$CILRepository.FilterConfig.#cctor();
    call T$CILRepository.BundleConfig.#cctor();
    call T$CILRepository.MvcApplication.#cctor();
    call T$$$f__AnonymousType0`3.#cctor();
    call T$$$f__AnonymousType2`1.#cctor();
    call T$OAuth20NameSpace.AccessToken.#cctor();
    call T$OAuth20NameSpace.ResourceRequest.#cctor();
    call T$OAuth20NameSpace.AuthorizationResponse.#cctor();
    call T$OAuth20NameSpace.ResourceServer.#cctor();
    call T$OAuth20NameSpace.AccessTokenEntry.#cctor();
    call T$OAuth20NameSpace.ValidateTokenResponse.#cctor();
    call T$OAuth20NameSpace.AccessTokenResponse.#cctor();
    call T$OAuth20NameSpace.ValidateTokenRequest.#cctor();
    call T$OAuth20NameSpace.AuthorizationRequest.#cctor();
    call T$OAuth20NameSpace.Client.#cctor();
    call T$OAuth20NameSpace.ResourceResponse.#cctor();
    call T$OAuth20NameSpace.AuthorizationErrorResponse.#cctor();
    call T$OAuth20NameSpace.AuthorizationCodeEntry.#cctor();
    call T$OAuth20NameSpace.AccessTokenRequest.#cctor();
    call T$OAuth20NameSpace.AuthorizationServer.#cctor();
    call T$CST.CST_Struct.#cctor();
    call T$CST.Debug.#cctor();
    $Exception := null;
    $GetMeHereTracker := 0;
    assume {:breadcrumb 0} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 20} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 20} true;
    call GlobalObjectsForCST.init();
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 21} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 21} true;
    call SynthesizedPortion.SynthesizedSequence();
    return;
}



procedure PoirotMain.#ctor($this: Ref);



procedure {:extern} System.Object.#ctor($this: Ref);



implementation PoirotMain.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 1} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$PoirotMain.#cctor();



implementation T$PoirotMain.#cctor()
{

  anon0:
    F$PoirotMain.Nondet := null;
    return;
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

  anon0:
    conclusion := conclusion$in;
    assume {:breadcrumb 2} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Assertion.cs"} {:sourceLine 9} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Assertion.cs"} {:sourceLine 9} true;
    call GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion);
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Assertion.cs"} {:sourceLine 10} true;
    $result := true;
    return;
}



procedure LiveIDNameSpace.LiveID_RP_For_vProgram.#ctor($this: Ref);



procedure {:extern} LiveIDNameSpace.LiveID_RP.#ctor($this: Ref);



implementation LiveIDNameSpace.LiveID_RP_For_vProgram.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 3} true;
    call LiveIDNameSpace.LiveID_RP.#ctor($this);
    return;
}



procedure T$LiveIDNameSpace.LiveID_RP_For_vProgram.#cctor();



implementation T$LiveIDNameSpace.LiveID_RP_For_vProgram.#cctor()
{

  anon0:
    return;
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

  anon0:
    assume {:breadcrumb 4} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\SynthesizedPortion.cs"} {:sourceLine 5} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\SynthesizedPortion.cs"} {:sourceLine 5} true;
    call $tmp0 := OpenIDConnectNameSpace.NondetOpenIDConnect.AuthenticationResponse(F$PoirotMain.Nondet);
    O1_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\SynthesizedPortion.cs"} {:sourceLine 6} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\SynthesizedPortion.cs"} {:sourceLine 6} true;
    call $tmp1 := OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse(F$GenericAuthNameSpace.GlobalObjects_base.RP, O1_Ref);
    O2_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\SynthesizedPortion.cs"} {:sourceLine 7} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\SynthesizedPortion.cs"} {:sourceLine 7} true;
    call $tmp2 := OpenIDConnectNameSpace.OpenIDProvider.TokenEndpoint$OpenIDConnectNameSpace.TokenRequest(F$GenericAuthNameSpace.GlobalObjects_base.AS, O2_Ref);
    O3_Ref := $tmp2;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\SynthesizedPortion.cs"} {:sourceLine 8} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\SynthesizedPortion.cs"} {:sourceLine 8} true;
    call $tmp3 := OpenIDConnectNameSpace.RelyingParty.conclude$OpenIDConnectNameSpace.TokenResponse(F$GenericAuthNameSpace.GlobalObjects_base.RP, O3_Ref);
    G4_Ref := $tmp3;
    return;
}



procedure SynthesizedPortion.#ctor($this: Ref);



implementation SynthesizedPortion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 5} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$SynthesizedPortion.#cctor();



implementation T$SynthesizedPortion.#cctor()
{

  anon0:
    return;
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

  anon0:
    assume {:breadcrumb 6} true;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 10} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 10} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 10} true;
    call $tmp0 := OpenIDConnectNameSpace.NondetOpenIDConnect.AuthenticationRequest(F$PoirotMain.Nondet);
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := $tmp0;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 11} true;
    call $tmp1 := Alloc();
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 11} true;
    call LiveIDNameSpace.LiveID_IdP.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$LiveIDNameSpace.LiveID_IdP();
    assume $TypeConstructor($DynamicType($tmp1)) == T$LiveIDNameSpace.LiveID_IdP;
    F$GenericAuthNameSpace.GlobalObjects_base.AS := $tmp1;
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 11} true;
    call LiveIDNameSpace.LiveID_IdP.init(F$GenericAuthNameSpace.GlobalObjects_base.AS);
    assert {:first} {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 12} true;
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 12} true;
    call $tmp2 := Alloc();
    assert {:sourceFile "c:\Users\Daniel Song\Desktop\AuthClassLib\src\Examples\CILServer\VProgram\Program.cs"} {:sourceLine 12} true;
    call LiveIDNameSpace.LiveID_RP_For_vProgram.#ctor($tmp2);
    assume $DynamicType($tmp2) == T$LiveIDNameSpace.LiveID_RP_For_vProgram();
    assume $TypeConstructor($DynamicType($tmp2)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram;
    F$GenericAuthNameSpace.GlobalObjects_base.RP := $tmp2;
    return;
}



procedure GlobalObjectsForCST.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref);



implementation GlobalObjectsForCST.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 7} true;
    call GenericAuthNameSpace.GlobalObjects_base.#ctor($this);
    return;
}



procedure T$GlobalObjectsForCST.#cctor();



implementation T$GlobalObjectsForCST.#cctor()
{

  anon0:
    return;
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

  anon0:
    assume {:breadcrumb 8} true;
    call OAuth20NameSpace.Client.#ctor($this);
    return;
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

  anon0:
    client_id1 := client_id1$in;
    return_uri1 := return_uri1$in;
    client_secret1 := client_secret1$in;
    TokenEndpointUrl1 := TokenEndpointUrl1$in;
    assume {:breadcrumb 9} true;
    call OAuth20NameSpace.Client.#ctor$System.String$System.String$System.String$System.String($this, client_id1, return_uri1, client_secret1, TokenEndpointUrl1);
    return;
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

  anon0:
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
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} $tmp7;
    assume {:breadcrumb 11} true;
    local_2_Ref := null;
    goto IL_0053;

  anon3_Else:
    assume {:partition} !$tmp7;
    assume {:breadcrumb 12} true;
    local_2_Ref := local_0_Ref;
    goto IL_0053;

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

  anon0:
    codeResp := codeResp$in;
    assume {:breadcrumb 13} true;
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram;
    call $tmp0 := OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse($this, codeResp);
    call $tmp1 := LiveIDNameSpace.LiveID_RP.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this, $tmp0);
    goto anon5;

  anon8_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_RP_For_vProgram;
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP;
    call $tmp2 := OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse($this, codeResp);
    call $tmp3 := LiveIDNameSpace.LiveID_RP.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this, $tmp2);
    goto anon5;

  anon9_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_RP;
    call $tmp4 := OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse($this, codeResp);
    call $tmp5 := OpenIDConnectNameSpace.RelyingParty.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this, $tmp4);
    goto anon5;

  anon5:
    local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram then $tmp1 else (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP then $tmp3 else $tmp5));
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} local_1_Ref == null;
    assume {:breadcrumb 14} true;
    local_2_Ref := null;
    goto IL_002a;

  anon10_Else:
    assume {:partition} local_1_Ref != null;
    assume {:breadcrumb 15} true;
    call $tmp6 := OpenIDConnectNameSpace.RelyingParty.conclude$OpenIDConnectNameSpace.TokenResponse($this, local_1_Ref);
    local_2_Ref := $tmp6;
    goto IL_002a;

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



const {:value "C:\Users\Daniel Song\Desktop\RP_constructTokenRequest.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$RP_constructTokenRequest.txt_3: Ref;

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

  anon0:
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
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$RP_constructTokenRequest.txt_3;
    call $tmp6 := System.IO.File.Exists$System.String(local_2_Ref);
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} !$tmp6;
    assume {:breadcrumb 17} true;
    call $tmp7 := System.IO.File.CreateText$System.String(local_2_Ref);
    local_3_Ref := $tmp7;
    call $tmp8 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
    call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp8);
    goto anon3;

  anon4_Else:
    assume {:partition} $tmp6;
    assume {:breadcrumb 18} true;
    call $tmp9 := System.IO.File.AppendText$System.String(local_2_Ref);
    local_3_Ref := $tmp9;
    call $tmp10 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
    call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp10);
    goto anon3;

  anon3:
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

  anon0:
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
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} local_2_Ref != null;
    assume {:breadcrumb 20} true;
    call $tmp4 := Alloc();
    call System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($tmp4, T$OpenIDConnectNameSpace.JsonDataStrcuture());
    assume $DynamicType($tmp4) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer();
    assume $TypeConstructor($DynamicType($tmp4)) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;
    call $tmp5 := System.Net.WebResponse.GetResponseStream(local_2_Ref);
    call $tmp6 := System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream($tmp4, $tmp5);
    local_0_Ref := $As($tmp6, T$OpenIDConnectNameSpace.JsonDataStrcuture());
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} local_0_Ref != null;
    assume {:breadcrumb 22} true;
    call $tmp7 := Alloc();
    call OpenIDConnectNameSpace.TokenResponse.#ctor($tmp7);
    assume $DynamicType($tmp7) == T$OpenIDConnectNameSpace.TokenResponse();
    assume $TypeConstructor($DynamicType($tmp7)) == T$OpenIDConnectNameSpace.TokenResponse;
    local_4_Ref := $tmp7;
    assume $this != null;
    call $tmp8 := OpenIDConnectNameSpace.TokenResponse.parseJasonDataStructure$OpenIDConnectNameSpace.JsonDataStrcuture$System.String(local_4_Ref, local_0_Ref, F$OAuth20NameSpace.Client.client_secret[$this]);
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $tmp8;
    assume {:breadcrumb 24} true;
    local_5_Ref := local_4_Ref;
    goto IL_00e1;

  anon11_Else:
    assume {:partition} !$tmp8;
    assume {:breadcrumb 25} true;
    goto anon5;

  anon5:
    local_5_Ref := null;
    goto IL_00e1;

  anon10_Else:
    assume {:partition} local_0_Ref == null;
    assume {:breadcrumb 23} true;
    goto anon8;

  anon9_Else:
    assume {:partition} local_2_Ref == null;
    assume {:breadcrumb 21} true;
    goto anon8;

  anon8:
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



const {:value "C:\Users\Daniel Song\Desktop\RP_conclude.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$RP_conclude.txt_6: Ref;

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

  anon0:
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
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$RP_conclude.txt_6;
    call $tmp6 := System.IO.File.Exists$System.String(local_2_Ref);
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} !$tmp6;
    assume {:breadcrumb 27} true;
    call $tmp7 := System.IO.File.CreateText$System.String(local_2_Ref);
    local_3_Ref := $tmp7;
    call $tmp8 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
    call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp8);
    goto anon3;

  anon15_Else:
    assume {:partition} $tmp6;
    assume {:breadcrumb 28} true;
    call $tmp9 := System.IO.File.AppendText$System.String(local_2_Ref);
    local_3_Ref := $tmp9;
    call $tmp10 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
    call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp10);
    goto anon3;

  anon3:
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram;
    call $tmp11 := LiveIDNameSpace.LiveID_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
    goto anon12;

  anon16_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_RP_For_vProgram;
    goto anon17_Then, anon17_Else;

  anon17_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP;
    call $tmp12 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
    goto anon12;

  anon17_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_RP;
    goto anon18_Then, anon18_Else;

  anon18_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.RelyingParty;
    call $tmp13 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
    goto anon12;

  anon18_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.RelyingParty;
    goto anon19_Then, anon19_Else;

  anon19_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.Client;
    call $tmp14 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
    goto anon12;

  anon19_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OAuth20NameSpace.Client;
    call $tmp15 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
    goto anon12;

  anon12:
    goto anon20_Then, anon20_Else;

  anon20_Then:
    assume {:partition} (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram then $tmp11 else (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP then $tmp12 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.RelyingParty then $tmp13 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.Client then $tmp14 else $tmp15))));
    assume {:breadcrumb 29} true;
    local_4_Ref := local_0_Ref;
    goto IL_00c4;

  anon20_Else:
    assume {:partition} !(if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram then $tmp11 else (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP then $tmp12 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.RelyingParty then $tmp13 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.Client then $tmp14 else $tmp15))));
    assume {:breadcrumb 30} true;
    local_4_Ref := null;
    goto IL_00c4;

  IL_00c4:
    $result := local_4_Ref;
    return;
}



procedure T$OpenIDConnectNameSpace.RelyingParty.#cctor();



implementation T$OpenIDConnectNameSpace.RelyingParty.#cctor()
{

  anon0:
    return;
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

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 32} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AccessToken$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_AuthenticationToken($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_AuthenticationToken($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 34} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AuthenticationToken$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_RefreshToken($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_RefreshToken($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 36} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$RefreshToken$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_ExpiresIn($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_ExpiresIn($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 38} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$ExpiresIn$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_Scope($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_Scope($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 40} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$Scope$k__BackingField[$this] := value;
    return;
}



implementation OpenIDConnectNameSpace.JsonDataStrcuture.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AccessToken$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AuthenticationToken$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$RefreshToken$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$ExpiresIn$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$Scope$k__BackingField[$this] := null;
    assume {:breadcrumb 41} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.JsonDataStrcuture.#cctor();



implementation T$OpenIDConnectNameSpace.JsonDataStrcuture.#cctor()
{

  anon0:
    return;
}



procedure {:extern} OAuth20NameSpace.AccessTokenRequest.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.TokenRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 42} true;
    call OAuth20NameSpace.AccessTokenRequest.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.TokenRequest.#cctor();



implementation T$OpenIDConnectNameSpace.TokenRequest.#cctor()
{

  anon0:
    return;
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

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 44} true;
    F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 46} true;
    F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.get_Signature($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.get_Signature($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 48} true;
    F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField[$this] := value;
    return;
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

  anon0:
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

  anon0:
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
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} $Exception != null;
    return;

  anon13_Else:
    assume {:partition} $Exception == null;
    goto anon2;

  anon2:
    local_0_Ref := $tmp0;
    assume local_0_Ref != null;
    F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this] := $ArrayContents[local_0_Ref][1];
    assume $this != null;
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.GetClaimsFromTokenSegment$System.String($this, F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this]);
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} $Exception != null;
    return;

  anon14_Else:
    assume {:partition} $Exception == null;
    goto anon4;

  anon4:
    call OpenIDConnectNameSpace.JsonWebToken.set_Claims$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims($this, $tmp1);
    assume local_0_Ref != null;
    F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this] := $ArrayContents[local_0_Ref][0];
    assume $this != null;
    call $tmp2 := OpenIDConnectNameSpace.JsonWebToken.GetEnvelopeFromTokenSegment$System.String($this, F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this]);
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} $Exception != null;
    return;

  anon15_Else:
    assume {:partition} $Exception == null;
    goto anon6;

  anon6:
    call OpenIDConnectNameSpace.JsonWebToken.set_Envelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this, $tmp2);
    assume local_0_Ref != null;
    call OpenIDConnectNameSpace.JsonWebToken.set_Signature$System.String($this, $ArrayContents[local_0_Ref][2]);
    call $tmp3 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
    call $tmp4 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($tmp3);
    assume Union2Int(Int2Union($tmp4)) == $tmp4;
    call $tmp5 := System.Collections.Generic.Dictionary`2.ContainsKey$`0(keyIdsKeys, Int2Union($tmp4));
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} !$tmp5;
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

  anon16_Else:
    assume {:partition} $tmp5;
    assume {:breadcrumb 52} true;
    goto anon9;

  anon9:
    call $tmp11 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
    call OpenIDConnectNameSpace.JsonWebToken.ValidateEnvelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this, $tmp11);
    goto anon17_Then, anon17_Else;

  anon17_Then:
    assume {:partition} $Exception != null;
    return;

  anon17_Else:
    assume {:partition} $Exception == null;
    goto anon11;

  anon11:
    call $tmp12 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
    call $tmp13 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($tmp12);
    assume Union2Int(Int2Union($tmp13)) == $tmp13;
    call $tmp15 := System.Collections.Generic.Dictionary`2.get_Item$`0(keyIdsKeys, Int2Union($tmp13));
    $tmp14 := $tmp15;
    call OpenIDConnectNameSpace.JsonWebToken.ValidateSignature$System.String($this, $tmp14);
    goto anon18_Then, anon18_Else;

  anon18_Then:
    assume {:partition} $Exception != null;
    return;

  anon18_Else:
    assume {:partition} $Exception == null;
    return;
}



procedure OpenIDConnectNameSpace.JsonWebToken.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField[$this] := null;
    assume {:breadcrumb 53} true;
    call System.Object.#ctor($this);
    return;
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

  anon0:
    claimsTokenSegment := claimsTokenSegment$in;
    assume {:breadcrumb 54} true;
    call $tmp0 := Alloc();
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.Base64UrlDecode$System.String($this, claimsTokenSegment);
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} $Exception != null;
    return;

  anon3_Else:
    assume {:partition} $Exception == null;
    goto anon2;

  anon2:
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

  anon0:
    envelopeTokenSegment := envelopeTokenSegment$in;
    assume {:breadcrumb 55} true;
    call $tmp0 := Alloc();
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.Base64UrlDecode$System.String($this, envelopeTokenSegment);
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} $Exception != null;
    return;

  anon3_Else:
    assume {:partition} $Exception == null;
    goto anon2;

  anon2:
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

  anon0:
    token := token$in;
    assume {:breadcrumb 56} true;
    call $tmp0 := System.String.IsNullOrEmpty$System.String(token);
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} $tmp0;
    assume {:breadcrumb 57} true;
    call $tmp1 := Alloc();
    call System.Exception.#ctor$System.String($tmp1, $string_literal_Token$is$empty$or$null._8);
    assume $DynamicType($tmp1) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Exception;
    $Exception := $tmp1;
    return;

  anon16_Else:
    assume {:partition} !$tmp0;
    assume {:breadcrumb 58} true;
    goto anon3;

  anon3:
    call $tmp2 := Alloc();
    assume $ArrayLength($tmp2) == 1 * 1;
    call $tmp3 := System.String.Split$System.Chararray(token, $tmp2);
    local_0_Ref := $tmp3;
    goto anon17_Then, anon17_Else;

  anon17_Then:
    assume {:partition} $ArrayLength(local_0_Ref) != 3;
    assume {:breadcrumb 59} true;
    call $tmp4 := Alloc();
    call System.Exception.#ctor$System.String($tmp4, $string_literal_Invalid$token$format.$Expected$Envelope.Claims.Signature_9);
    assume $DynamicType($tmp4) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp4)) == T$System.Exception;
    $Exception := $tmp4;
    return;

  anon17_Else:
    assume {:partition} $ArrayLength(local_0_Ref) == 3;
    assume {:breadcrumb 60} true;
    goto anon6;

  anon6:
    assume local_0_Ref != null;
    call $tmp5 := System.String.IsNullOrEmpty$System.String($ArrayContents[local_0_Ref][0]);
    goto anon18_Then, anon18_Else;

  anon18_Then:
    assume {:partition} $tmp5;
    assume {:breadcrumb 61} true;
    call $tmp6 := Alloc();
    call System.Exception.#ctor$System.String($tmp6, $string_literal_Invalid$token$format.$Envelope$must$not$be$empty_10);
    assume $DynamicType($tmp6) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp6)) == T$System.Exception;
    $Exception := $tmp6;
    return;

  anon18_Else:
    assume {:partition} !$tmp5;
    assume {:breadcrumb 62} true;
    goto anon9;

  anon9:
    assume local_0_Ref != null;
    call $tmp7 := System.String.IsNullOrEmpty$System.String($ArrayContents[local_0_Ref][1]);
    goto anon19_Then, anon19_Else;

  anon19_Then:
    assume {:partition} $tmp7;
    assume {:breadcrumb 63} true;
    call $tmp8 := Alloc();
    call System.Exception.#ctor$System.String($tmp8, $string_literal_Invalid$token$format.$Claims$must$not$be$empty_11);
    assume $DynamicType($tmp8) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp8)) == T$System.Exception;
    $Exception := $tmp8;
    return;

  anon19_Else:
    assume {:partition} !$tmp7;
    assume {:breadcrumb 64} true;
    goto anon12;

  anon12:
    assume local_0_Ref != null;
    call $tmp9 := System.String.IsNullOrEmpty$System.String($ArrayContents[local_0_Ref][2]);
    goto anon20_Then, anon20_Else;

  anon20_Then:
    assume {:partition} $tmp9;
    assume {:breadcrumb 65} true;
    call $tmp10 := Alloc();
    call System.Exception.#ctor$System.String($tmp10, $string_literal_Invalid$token$format.$Signature$must$not$be$empty_12);
    assume $DynamicType($tmp10) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp10)) == T$System.Exception;
    $Exception := $tmp10;
    return;

  anon20_Else:
    assume {:partition} !$tmp9;
    assume {:breadcrumb 66} true;
    goto anon15;

  anon15:
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

  anon0:
    envelope := envelope$in;
    assume {:breadcrumb 67} true;
    call $tmp0 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Type(envelope);
    call $tmp1 := System.String.op_Inequality$System.String$System.String($tmp0, $string_literal_JWT_13);
    goto anon6_Then, anon6_Else;

  anon6_Then:
    assume {:partition} $tmp1;
    assume {:breadcrumb 68} true;
    call $tmp2 := Alloc();
    call System.Exception.#ctor$System.String($tmp2, $string_literal_Unsupported$token$type_14);
    assume $DynamicType($tmp2) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp2)) == T$System.Exception;
    $Exception := $tmp2;
    return;

  anon6_Else:
    assume {:partition} !$tmp1;
    assume {:breadcrumb 69} true;
    goto anon3;

  anon3:
    call $tmp3 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Algorithm(envelope);
    call $tmp4 := System.String.op_Inequality$System.String$System.String($tmp3, $string_literal_HS256_15);
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} $tmp4;
    assume {:breadcrumb 70} true;
    call $tmp5 := Alloc();
    call System.Exception.#ctor$System.String($tmp5, $string_literal_Unsupported$crypto$algorithm_16);
    assume $DynamicType($tmp5) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp5)) == T$System.Exception;
    $Exception := $tmp5;
    return;

  anon7_Else:
    assume {:partition} !$tmp4;
    assume {:breadcrumb 71} true;
    return;
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

  anon0:
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
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} $tmp9;
    assume {:breadcrumb 73} true;
    call $tmp10 := Alloc();
    call System.Exception.#ctor$System.String($tmp10, $string_literal_Signature$does$not$match._19);
    assume $DynamicType($tmp10) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp10)) == T$System.Exception;
    $Exception := $tmp10;
    return;

  anon3_Else:
    assume {:partition} !$tmp9;
    assume {:breadcrumb 74} true;
    return;
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

  anon0:
    encodedSegment := encodedSegment$in;
    assume {:breadcrumb 75} true;
    local_0_Ref := encodedSegment;
    call $tmp0 := System.String.Replace$System.Char$System.Char(local_0_Ref, 45, 43);
    local_0_Ref := $tmp0;
    call $tmp1 := System.String.Replace$System.Char$System.Char(local_0_Ref, 95, 47);
    local_0_Ref := $tmp1;
    call $tmp2 := System.String.get_Length(local_0_Ref);
    goto anon6_Then, anon6_Else;

  anon6_Then:
    assume {:partition} $tmp2 mod 4 == 0;
    goto IL_003a;

  anon6_Else:
    assume {:partition} $tmp2 mod 4 != 0;
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} $tmp2 mod 4 == 1;
    goto IL_0058;

  anon7_Else:
    assume {:partition} $tmp2 mod 4 != 1;
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} $tmp2 mod 4 == 2;
    goto IL_003c;

  anon8_Else:
    assume {:partition} $tmp2 mod 4 != 2;
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} $tmp2 mod 4 == 3;
    goto IL_004a;

  anon9_Else:
    assume {:partition} $tmp2 mod 4 != 3;
    goto anon5;

  anon5:
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

  anon0:
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

  anon0:
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
    return;
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

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 79} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$expUnixTime$k__BackingField[$this] := value;
    return;
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

  anon0:
    assume {:breadcrumb 80} true;
    call $tmp0 := Alloc();
    call System.DateTime.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.DateTime();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.DateTime;
    local_0_Ref := $tmp0;
    assume $this != null;
    $tmp1 := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this];
    call $tmp2 := System.Nullable`1.get_HasValue($tmp1);
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} !$tmp2;
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
    goto anon3;

  anon4_Else:
    assume {:partition} $tmp2;
    assume {:breadcrumb 82} true;
    goto anon3;

  anon3:
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

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 84} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Issuer$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Audience($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Audience($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 86} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Audience$k__BackingField[$this] := value;
    return;
}



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_UserId($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 88} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$UserId$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Version($this: Ref) returns ($result: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Version($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 90} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Version$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_ClientIdentifier($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_ClientIdentifier($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 92} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$ClientIdentifier$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_AppId($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_AppId($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 94} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$AppId$k__BackingField[$this] := value;
    return;
}



procedure OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#ctor($this: Ref);



procedure System.Nullable$System.DateTime$.#default_ctor($this: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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
    return;
}



procedure T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#cctor();



implementation T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#cctor()
{

  anon0:
    return;
}



var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField: [Ref]int;

implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Type($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 97} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField[$this] := value;
    return;
}



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Algorithm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 99} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField[$this] := value;
    return;
}



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 101} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField[$this] := value;
    return;
}



procedure OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField[$this] := 0;
    assume {:breadcrumb 102} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#cctor();



implementation T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#cctor()
{

  anon0:
    return;
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

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 104} true;
    F$GenericAuthNameSpace.AS.IdpAuthRecs[$this] := value;
    return;
}



procedure OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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

  anon0:
    value := value$in;
    assume {:breadcrumb 106} true;
    call OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this, value);
    return;
}



procedure OpenIDConnectNameSpace.OpenIDProvider.init$OAuth20NameSpace.AuthorizationCodeRecs$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, IDTokenAndAccessTokenRecs1$in: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, AccessTokenRecs1$in: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.init$OAuth20NameSpace.AuthorizationCodeRecs$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, IDTokenAndAccessTokenRecs1$in: Ref)
{
  var AuthorizationCodeRecs1: Ref;
  var IDTokenAndAccessTokenRecs1: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    AuthorizationCodeRecs1 := AuthorizationCodeRecs1$in;
    IDTokenAndAccessTokenRecs1 := IDTokenAndAccessTokenRecs1$in;
    assume {:breadcrumb 107} true;
    call OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this, AuthorizationCodeRecs1, IDTokenAndAccessTokenRecs1);
    return;
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

  anon0:
    req := req$in;
    assume {:breadcrumb 108} true;
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    call $tmp0 := OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon7;

  anon8_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    call $tmp1 := OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon7;

  anon9_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer;
    call $tmp2 := OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon7;

  anon10_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OAuth20NameSpace.AuthorizationServer;
    call $tmp3 := GenericAuthNameSpace.AS.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon7;

  anon7:
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

  anon0:
    dest := dest$in;
    claim := claim$in;
    assume {:breadcrumb 109} true;
    local_0_Ref := $As(claim, T$OAuth20NameSpace.AuthorizationCodeEntry());
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} local_0_Ref == null;
    assume {:breadcrumb 110} true;
    local_2_Ref := null;
    goto IL_0044;

  anon3_Else:
    assume {:partition} local_0_Ref != null;
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

  anon0:
    req := req$in;
    assume {:breadcrumb 112} true;
    goto anon34_Then, anon34_Else;

  anon34_Then:
    assume {:partition} req == null;
    assume {:breadcrumb 113} true;
    local_4_Ref := null;
    goto IL_013d;

  anon34_Else:
    assume {:partition} req != null;
    assume {:breadcrumb 114} true;
    $tmp0 := req;
    assume $tmp0 != null;
    local_6_Ref := F$OAuth20NameSpace.AccessTokenRequest.grant_type[$tmp0];
    goto anon35_Then, anon35_Else;

  anon35_Then:
    assume {:partition} local_6_Ref != null;
    assume {:breadcrumb 115} true;
    call $tmp1 := System.String.op_Equality$System.String$System.String(local_6_Ref, $string_literal_authorization_code_2);
    goto anon36_Then, anon36_Else;

  anon36_Then:
    assume {:partition} !$tmp1;
    assume {:breadcrumb 117} true;
    goto IL_0138;

  anon36_Else:
    assume {:partition} $tmp1;
    assume {:breadcrumb 118} true;
    goto anon6;

  anon6:
    call $tmp10 := OpenIDConnectNameSpace.OpenIDProvider.get_AuthorizationCodeRecs($this);
    goto anon37_Then, anon37_Else;

  anon37_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp10)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp2 := OpenIDConnectNameSpace.OpenIDProvider.get_AuthorizationCodeRecs($this);
    $tmp3 := req;
    assume $tmp3 != null;
    $tmp4 := req;
    assume $tmp4 != null;
    call $tmp5 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.findISSByClientIDAndCode$System.String$System.String($tmp2, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp3], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp4]);
    goto anon9;

  anon37_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp10)) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp6 := OpenIDConnectNameSpace.OpenIDProvider.get_AuthorizationCodeRecs($this);
    $tmp7 := req;
    assume $tmp7 != null;
    $tmp8 := req;
    assume $tmp8 != null;
    call $tmp9 := OAuth20NameSpace.AuthorizationCodeRecs.findISSByClientIDAndCode$System.String$System.String($tmp6, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp7], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp8]);
    goto anon9;

  anon9:
    local_2_Ref := (if $TypeConstructor($DynamicType($tmp10)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp5 else $tmp9);
    goto anon38_Then, anon38_Else;

  anon38_Then:
    assume {:partition} local_2_Ref == null;
    assume {:breadcrumb 119} true;
    local_4_Ref := null;
    goto IL_013d;

  anon38_Else:
    assume {:partition} local_2_Ref != null;
    assume {:breadcrumb 120} true;
    call $tmp17 := OpenIDConnectNameSpace.OpenIDProvider.get_AuthorizationCodeRecs($this);
    goto anon39_Then, anon39_Else;

  anon39_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp17)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp11 := OpenIDConnectNameSpace.OpenIDProvider.get_AuthorizationCodeRecs($this);
    $tmp12 := req;
    assume $tmp12 != null;
    call $tmp13 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp11, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp12]);
    goto anon14;

  anon39_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp17)) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp14 := OpenIDConnectNameSpace.OpenIDProvider.get_AuthorizationCodeRecs($this);
    $tmp15 := req;
    assume $tmp15 != null;
    call $tmp16 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp14, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp15]);
    goto anon14;

  anon14:
    local_3_Ref := (if $TypeConstructor($DynamicType($tmp17)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp13 else $tmp16);
    goto anon40_Then, anon40_Else;

  anon40_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_3_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp18 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_3_Ref);
    goto anon17;

  anon40_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_3_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp19 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_3_Ref);
    goto anon17;

  anon17:
    $tmp20 := req;
    assume $tmp20 != null;
    call $tmp21 := System.String.op_Inequality$System.String$System.String((if $TypeConstructor($DynamicType(local_3_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp18 else $tmp19), F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[$tmp20]);
    goto anon41_Then, anon41_Else;

  anon41_Then:
    assume {:partition} $tmp21;
    assume {:breadcrumb 121} true;
    local_4_Ref := null;
    goto IL_013d;

  anon41_Else:
    assume {:partition} !$tmp21;
    assume {:breadcrumb 122} true;
    goto anon42_Then, anon42_Else;

  anon42_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    $tmp22 := local_3_Ref;
    assume $tmp22 != null;
    $tmp23 := local_3_Ref;
    assume $tmp23 != null;
    $tmp24 := local_3_Ref;
    assume $tmp24 != null;
    call $tmp25 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp22], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp23], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp24]);
    goto anon24;

  anon42_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon43_Then, anon43_Else;

  anon43_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp26 := local_3_Ref;
    assume $tmp26 != null;
    $tmp27 := local_3_Ref;
    assume $tmp27 != null;
    $tmp28 := local_3_Ref;
    assume $tmp28 != null;
    call $tmp29 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp26], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp27], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp28]);
    goto anon24;

  anon43_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp30 := local_3_Ref;
    assume $tmp30 != null;
    $tmp31 := local_3_Ref;
    assume $tmp31 != null;
    $tmp32 := local_3_Ref;
    assume $tmp32 != null;
    call $tmp33 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp30], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp31], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp32]);
    goto anon24;

  anon24:
    local_0_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp25 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp29 else $tmp33));
    call $tmp44 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
    goto anon44_Then, anon44_Else;

  anon44_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp34 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
    $tmp35 := req;
    assume $tmp35 != null;
    $tmp36 := req;
    assume $tmp36 != null;
    $tmp37 := req;
    assume $tmp37 != null;
    call $tmp38 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp34, F$OAuth20NameSpace.AccessTokenRequest.access_token[$tmp35], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp36], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp37], local_0_Ref);
    goto anon27;

  anon44_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp44)) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp39 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
    $tmp40 := req;
    assume $tmp40 != null;
    $tmp41 := req;
    assume $tmp41 != null;
    $tmp42 := req;
    assume $tmp42 != null;
    call $tmp43 := GenericAuthNameSpace.ASAuthTicketRecords_Base.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp39, F$OAuth20NameSpace.AccessTokenRequest.access_token[$tmp40], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp41], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp42], local_0_Ref);
    goto anon27;

  anon27:
    goto anon45_Then, anon45_Else;

  anon45_Then:
    assume {:partition} !(if $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp38 else $tmp43);
    assume {:breadcrumb 123} true;
    local_4_Ref := null;
    goto IL_013d;

  anon45_Else:
    assume {:partition} (if $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp38 else $tmp43);
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
    goto anon46_Then, anon46_Else;

  anon46_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_3_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp53 := OAuth20NameSpace.AuthorizationCodeEntry.get_UserID(local_3_Ref);
    goto anon32;

  anon46_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_3_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp54 := GenericAuthNameSpace.ID_Claim.get_UserID(local_3_Ref);
    goto anon32;

  anon32:
    call OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_UserId$System.String($tmp52, (if $TypeConstructor($DynamicType(local_3_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp53 else $tmp54));
    local_4_Ref := local_1_Ref;
    goto IL_013d;

  anon35_Else:
    assume {:partition} local_6_Ref == null;
    assume {:breadcrumb 116} true;
    goto IL_0138;

  IL_0138:
    local_4_Ref := null;
    goto IL_013d;

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

  anon0:
    assume {:breadcrumb 125} true;
    call OAuth20NameSpace.AuthorizationServer.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.OpenIDProvider.#cctor();



implementation T$OpenIDConnectNameSpace.OpenIDProvider.#cctor()
{

  anon0:
    return;
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

  anon0:
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

  anon0:
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

  anon0:
    F$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.id_token[$this] := null;
    assume {:breadcrumb 128} true;
    call OAuth20NameSpace.AccessTokenEntry.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#cctor();



implementation T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#cctor()
{

  anon0:
    return;
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

  anon0:
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
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} F$OpenIDConnectNameSpace.TokenResponse.id_token[$this] != null;
    assume {:breadcrumb 130} true;
    local_2_bool := true;
    goto anon3;

  anon10_Else:
    assume {:partition} F$OpenIDConnectNameSpace.TokenResponse.id_token[$this] == null;
    assume {:breadcrumb 131} true;
    goto anon3;

  anon3:
    local_2_bool := false;
    $label := -1;
    goto finally0;

  catch0:
    $localExc := $Exception;
    $Exception := null;
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $Subtype($DynamicType($localExc), T$System.Exception());
    local_1_Ref := $localExc;
    call System.Console.Write$System.Object(local_1_Ref);
    local_2_bool := false;
    $label := -1;
    goto finally0;

  anon11_Else:
    assume {:partition} !$Subtype($DynamicType($localExc), T$System.Exception());
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} false;
    return;

  anon12_Else:
    assume {:partition} !false;
    goto anon6;

  anon6:
    $Exception := $localExc;
    $label := -1;
    goto finally0;

  finally0:
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} true;
    goto continuation0;

  anon13_Else:
    assume {:partition} !true;
    goto continuation0;

  continuation0:
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} $Exception != null;
    return;

  anon14_Else:
    assume {:partition} $Exception == null;
    goto anon9;

  anon9:
    $result := local_2_bool;
    return;
}



procedure {:extern} OAuth20NameSpace.AccessTokenResponse.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.TokenResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OpenIDConnectNameSpace.TokenResponse.id_token[$this] := null;
    assume {:breadcrumb 132} true;
    call OAuth20NameSpace.AccessTokenResponse.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.TokenResponse.#cctor();



implementation T$OpenIDConnectNameSpace.TokenResponse.#cctor()
{

  anon0:
    return;
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

  anon0:
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
    return;
}



procedure T$OpenIDConnectNameSpace.AuthenticationRequest.#cctor();



implementation T$OpenIDConnectNameSpace.AuthenticationRequest.#cctor()
{

  anon0:
    return;
}



procedure {:extern} OAuth20NameSpace.AuthorizationResponse.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.AuthenticationResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 134} true;
    call OAuth20NameSpace.AuthorizationResponse.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.AuthenticationResponse.#cctor();



implementation T$OpenIDConnectNameSpace.AuthenticationResponse.#cctor()
{

  anon0:
    return;
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

  anon0:
    F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$this] := null;
    assume {:breadcrumb 135} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.SignInIdP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Req.#cctor()
{

  anon0:
    return;
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

  anon0:
    conclusion := conclusion$in;
    assume {:breadcrumb 136} true;
    $tmp10 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
    assume $tmp10 != null;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$tmp10])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
    assume $tmp0 != null;
    $tmp1 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$tmp0];
    $tmp2 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
    assume $tmp2 != null;
    $tmp3 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp3 != null;
    call $tmp4 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp1, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp2], F$GenericAuthNameSpace.RP.Realm[$tmp3]);
    goto anon3;

  anon13_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$tmp10])) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    $tmp5 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
    assume $tmp5 != null;
    $tmp6 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$tmp5];
    $tmp7 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
    assume $tmp7 != null;
    $tmp8 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp8 != null;
    call $tmp9 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp6, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp7], F$GenericAuthNameSpace.RP.Realm[$tmp8]);
    goto anon3;

  anon3:
    local_0_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$tmp10])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp4 else $tmp9);
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp15 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
    goto anon6;

  anon14_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp16 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
    goto anon6;

  anon6:
    $tmp17 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp17 != null;
    call $tmp18 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp15 else $tmp16), F$GenericAuthNameSpace.RP.Domain[$tmp17]);
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} $tmp18;
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp11 := OAuth20NameSpace.AuthorizationCodeEntry.get_UserID(local_0_Ref);
    goto anon10;

  anon16_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp12 := GenericAuthNameSpace.ID_Claim.get_UserID(local_0_Ref);
    goto anon10;

  anon10:
    $tmp13 := conclusion;
    assume $tmp13 != null;
    call $tmp14 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp11 else $tmp12), F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp13]);
    goto anon12;

  anon15_Else:
    assume {:partition} !$tmp18;
    goto anon12;

  anon12:
    assert (if $tmp18 then $tmp14 else false);
    return;
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

  anon0:
    conclusion := conclusion$in;
    assume {:breadcrumb 137} true;
    $tmp16 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
    assume $tmp16 != null;
    goto anon37_Then, anon37_Else;

  anon37_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.ASAuthRecs[$tmp16])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
    assume $tmp0 != null;
    $tmp1 := F$GenericAuthNameSpace.AS.ASAuthRecs[$tmp0];
    goto anon38_Then, anon38_Else;

  anon38_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp2 := OAuth20NameSpace.ValidateTokenRequest.get_ticket(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
    goto anon4;

  anon38_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) != T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp3 := GenericAuthNameSpace.ValidateTicket_Req.get_ticket(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
    goto anon4;

  anon4:
    $tmp4 := F$GenericAuthNameSpace.GlobalObjects_base.RS;
    assume $tmp4 != null;
    goto anon39_Then, anon39_Else;

  anon39_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp5 := OAuth20NameSpace.ValidateTokenRequest.get_UserID(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
    goto anon7;

  anon39_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) != T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp6 := GenericAuthNameSpace.ValidateTicket_Req.get_UserID(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
    goto anon7;

  anon7:
    call $tmp7 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp1, (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp2 else $tmp3), F$GenericAuthNameSpace.RS.Realm[$tmp4], (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp5 else $tmp6));
    goto anon15;

  anon37_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.ASAuthRecs[$tmp16])) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    $tmp8 := F$GenericAuthNameSpace.GlobalObjects_base.AS;
    assume $tmp8 != null;
    $tmp9 := F$GenericAuthNameSpace.AS.ASAuthRecs[$tmp8];
    goto anon40_Then, anon40_Else;

  anon40_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp10 := OAuth20NameSpace.ValidateTokenRequest.get_ticket(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
    goto anon11;

  anon40_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) != T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp11 := GenericAuthNameSpace.ValidateTicket_Req.get_ticket(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
    goto anon11;

  anon11:
    $tmp12 := F$GenericAuthNameSpace.GlobalObjects_base.RS;
    assume $tmp12 != null;
    goto anon41_Then, anon41_Else;

  anon41_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp13 := OAuth20NameSpace.ValidateTokenRequest.get_UserID(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
    goto anon14;

  anon41_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) != T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp14 := GenericAuthNameSpace.ValidateTicket_Req.get_UserID(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req);
    goto anon14;

  anon14:
    call $tmp15 := GenericAuthNameSpace.ASAuthTicketRecords_Base.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp9, (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp10 else $tmp11), F$GenericAuthNameSpace.RS.Realm[$tmp12], (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp13 else $tmp14));
    goto anon15;

  anon15:
    local_0_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.ASAuthRecs[$tmp16])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp7 else $tmp15);
    goto anon42_Then, anon42_Else;

  anon42_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp27 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
    goto anon20;

  anon42_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon43_Then, anon43_Else;

  anon43_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp28 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
    goto anon20;

  anon43_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp29 := GenericAuthNameSpace.Permission_Claim.get_permissions(local_0_Ref);
    goto anon20;

  anon20:
    assume (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp27 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp28 else $tmp29)) != null;
    $tmp30 := conclusion;
    assume $tmp30 != null;
    $tmp31 := F$GenericAuthNameSpace.RS.AuthorizationConclusion.permissions[$tmp30];
    assume $tmp31 != null;
    goto anon44_Then, anon44_Else;

  anon44_Then:
    assume {:partition} !(F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp27 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp28 else $tmp29))] != F$GenericAuthNameSpace.Permissions.permissionSet[$tmp31]);
    goto anon45_Then, anon45_Else;

  anon45_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp22 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
    goto anon26;

  anon45_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon46_Then, anon46_Else;

  anon46_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp23 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
    goto anon26;

  anon46_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp24 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
    goto anon26;

  anon26:
    $tmp25 := F$GenericAuthNameSpace.GlobalObjects_base.RS;
    assume $tmp25 != null;
    call $tmp26 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp22 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp23 else $tmp24)), F$GenericAuthNameSpace.RS.Realm[$tmp25]);
    goto anon28;

  anon44_Else:
    assume {:partition} F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp27 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp28 else $tmp29))] != F$GenericAuthNameSpace.Permissions.permissionSet[$tmp31];
    goto anon28;

  anon28:
    goto anon47_Then, anon47_Else;

  anon47_Then:
    assume {:partition} (if !(F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp27 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp28 else $tmp29))] != F$GenericAuthNameSpace.Permissions.permissionSet[$tmp31]) then $tmp26 else false);
    goto anon48_Then, anon48_Else;

  anon48_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp17 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID(local_0_Ref);
    goto anon34;

  anon48_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon49_Then, anon49_Else;

  anon49_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp18 := OAuth20NameSpace.AccessTokenEntry.get_UserID(local_0_Ref);
    goto anon34;

  anon49_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp19 := GenericAuthNameSpace.Permission_Claim.get_UserID(local_0_Ref);
    goto anon34;

  anon34:
    $tmp20 := conclusion;
    assume $tmp20 != null;
    call $tmp21 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp17 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp18 else $tmp19)), F$GenericAuthNameSpace.RS.AuthorizationConclusion.UserID[$tmp20]);
    goto anon36;

  anon47_Else:
    assume {:partition} !(if !(F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp27 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp28 else $tmp29))] != F$GenericAuthNameSpace.Permissions.permissionSet[$tmp31]) then $tmp26 else false);
    goto anon36;

  anon36:
    assert (if (if !(F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp27 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp28 else $tmp29))] != F$GenericAuthNameSpace.Permissions.permissionSet[$tmp31]) then $tmp26 else false) then $tmp21 else false);
    return;
}



implementation GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 138} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.GlobalObjects_base.#cctor();



implementation T$GenericAuthNameSpace.GlobalObjects_base.#cctor()
{

  anon0:
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := null;
    F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req := null;
    F$GenericAuthNameSpace.GlobalObjects_base.AS := null;
    F$GenericAuthNameSpace.GlobalObjects_base.RP := null;
    F$GenericAuthNameSpace.GlobalObjects_base.RS := null;
    return;
}



function T$GenericAuthNameSpace.Permissions() : Ref;

const unique T$GenericAuthNameSpace.Permissions: int;

procedure GenericAuthNameSpace.Permissions.#ctor($this: Ref);



implementation GenericAuthNameSpace.Permissions.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$GenericAuthNameSpace.Permissions.permissionSet[$this] := null;
    assume {:breadcrumb 139} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.Permissions.#cctor();



implementation T$GenericAuthNameSpace.Permissions.#cctor()
{

  anon0:
    return;
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

  anon0:
    F$GenericAuthNameSpace.ReqResourceRS_Req.resource[$this] := null;
    F$GenericAuthNameSpace.ReqResourceRS_Req.UserID[$this] := null;
    assume {:breadcrumb 140} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.ReqResourceRS_Req.#cctor();



implementation T$GenericAuthNameSpace.ReqResourceRS_Req.#cctor()
{

  anon0:
    return;
}



function T$GenericAuthNameSpace.Resources() : Ref;

const unique T$GenericAuthNameSpace.Resources: int;

var F$GenericAuthNameSpace.Resources.resourceSet: [Ref]Ref;

procedure GenericAuthNameSpace.Resources.#ctor($this: Ref);



implementation GenericAuthNameSpace.Resources.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$GenericAuthNameSpace.Resources.resourceSet[$this] := null;
    assume {:breadcrumb 141} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.Resources.#cctor();



implementation T$GenericAuthNameSpace.Resources.#cctor()
{

  anon0:
    return;
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

  anon0:
    req := req$in;
    assume {:breadcrumb 142} true;
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := req;
    goto anon44_Then, anon44_Else;

  anon44_Then:
    assume {:partition} req == null;
    assume {:breadcrumb 143} true;
    local_1_Ref := null;
    goto IL_004e;

  anon44_Else:
    assume {:partition} req != null;
    assume {:breadcrumb 144} true;
    goto anon45_Then, anon45_Else;

  anon45_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    call $tmp0 := OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon9;

  anon45_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon46_Then, anon46_Else;

  anon46_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    call $tmp1 := OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon9;

  anon46_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    goto anon47_Then, anon47_Else;

  anon47_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer;
    call $tmp2 := OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon9;

  anon47_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OAuth20NameSpace.AuthorizationServer;
    call $tmp3 := GenericAuthNameSpace.AS.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon9;

  anon9:
    local_0_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp0 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp1 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp2 else $tmp3)));
    assume $this != null;
    goto anon48_Then, anon48_Else;

  anon48_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp4 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
    $tmp5 := req;
    assume $tmp5 != null;
    goto anon49_Then, anon49_Else;

  anon49_Then:
    assume {:partition} $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest;
    call $tmp6 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
    goto anon15;

  anon49_Else:
    assume {:partition} $TypeConstructor($DynamicType(req)) != T$OpenIDConnectNameSpace.AuthenticationRequest;
    goto anon50_Then, anon50_Else;

  anon50_Then:
    assume {:partition} $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp7 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
    goto anon15;

  anon50_Else:
    assume {:partition} $TypeConstructor($DynamicType(req)) != T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp8 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
    goto anon15;

  anon15:
    call $tmp9 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp4, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp5], (if $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp6 else (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp7 else $tmp8)), local_0_Ref);
    goto anon22;

  anon48_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp10 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
    $tmp11 := req;
    assume $tmp11 != null;
    goto anon51_Then, anon51_Else;

  anon51_Then:
    assume {:partition} $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest;
    call $tmp12 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
    goto anon21;

  anon51_Else:
    assume {:partition} $TypeConstructor($DynamicType(req)) != T$OpenIDConnectNameSpace.AuthenticationRequest;
    goto anon52_Then, anon52_Else;

  anon52_Then:
    assume {:partition} $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp13 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
    goto anon21;

  anon52_Else:
    assume {:partition} $TypeConstructor($DynamicType(req)) != T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp14 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
    goto anon21;

  anon21:
    call $tmp15 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp10, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp11], (if $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp12 else (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp13 else $tmp14)), local_0_Ref);
    goto anon22;

  anon22:
    goto anon53_Then, anon53_Else;

  anon53_Then:
    assume {:partition} !(if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp9 else $tmp15);
    assume {:breadcrumb 145} true;
    local_1_Ref := null;
    goto IL_004e;

  anon53_Else:
    assume {:partition} (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp9 else $tmp15);
    assume {:breadcrumb 146} true;
    goto anon54_Then, anon54_Else;

  anon54_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    goto anon55_Then, anon55_Else;

  anon55_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp16 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
    goto anon28;

  anon55_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp17 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
    goto anon28;

  anon28:
    call $tmp18 := OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp16 else $tmp17), local_0_Ref);
    goto anon43;

  anon54_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon56_Then, anon56_Else;

  anon56_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    goto anon57_Then, anon57_Else;

  anon57_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp19 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
    goto anon33;

  anon57_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp20 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
    goto anon33;

  anon33:
    call $tmp21 := OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp19 else $tmp20), local_0_Ref);
    goto anon43;

  anon56_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    goto anon58_Then, anon58_Else;

  anon58_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer;
    goto anon59_Then, anon59_Else;

  anon59_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp22 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
    goto anon38;

  anon59_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp23 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
    goto anon38;

  anon38:
    call $tmp24 := GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp22 else $tmp23), local_0_Ref);
    goto anon43;

  anon58_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OAuth20NameSpace.AuthorizationServer;
    goto anon60_Then, anon60_Else;

  anon60_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp25 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
    goto anon42;

  anon60_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp26 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
    goto anon42;

  anon42:
    call $tmp27 := GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp25 else $tmp26), local_0_Ref);
    goto anon43;

  anon43:
    local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp18 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp21 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp24 else $tmp27)));
    goto IL_004e;

  IL_004e:
    $result := local_1_Ref;
    return;
}



procedure GenericAuthNameSpace.AS.#ctor($this: Ref);



implementation GenericAuthNameSpace.AS.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$GenericAuthNameSpace.AS.IdpAuthRecs[$this] := null;
    F$GenericAuthNameSpace.AS.ASAuthRecs[$this] := null;
    assume {:breadcrumb 147} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.AS.#cctor();



implementation T$GenericAuthNameSpace.AS.#cctor()
{

  anon0:
    return;
}



function T$GenericAuthNameSpace.SignInRP_Resp() : Ref;

const unique T$GenericAuthNameSpace.SignInRP_Resp: int;

procedure GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref);



implementation GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 148} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.SignInRP_Resp.#cctor();



implementation T$GenericAuthNameSpace.SignInRP_Resp.#cctor()
{

  anon0:
    return;
}



function T$GenericAuthNameSpace.Permission_Claim() : Ref;

const unique T$GenericAuthNameSpace.Permission_Claim: int;

procedure GenericAuthNameSpace.Permission_Claim.get_Redir_dest($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.Permission_Claim.#ctor($this: Ref);



implementation GenericAuthNameSpace.Permission_Claim.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 149} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.Permission_Claim.#cctor();



implementation T$GenericAuthNameSpace.Permission_Claim.#cctor()
{

  anon0:
    return;
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

  anon0:
    assume {:breadcrumb 150} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.Ticket.#cctor();



implementation T$GenericAuthNameSpace.Ticket.#cctor()
{

  anon0:
    return;
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

  anon0:
    obj := obj$in;
    assume {:breadcrumb 151} true;
    goto anon5_Then, anon5_Else;

  anon5_Then:
    assume {:partition} obj == null;
    assume {:breadcrumb 152} true;
    local_1_bool := false;
    goto IL_003a;

  anon5_Else:
    assume {:partition} obj != null;
    assume {:breadcrumb 153} true;
    local_0_Ref := $As(obj, T$GenericAuthNameSpace.Permission());
    goto anon6_Then, anon6_Else;

  anon6_Then:
    assume {:partition} local_0_Ref == null;
    assume {:breadcrumb 154} true;
    local_1_bool := false;
    goto IL_003a;

  anon6_Else:
    assume {:partition} local_0_Ref != null;
    assume {:breadcrumb 155} true;
    assume $this != null;
    $tmp0 := local_0_Ref;
    assume $tmp0 != null;
    call $tmp1 := System.String.op_Equality$System.String$System.String(F$GenericAuthNameSpace.Permission.name[$this], F$GenericAuthNameSpace.Permission.name[$tmp0]);
    local_1_bool := $tmp1;
    goto IL_003a;

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

  anon0:
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

  anon0:
    F$GenericAuthNameSpace.Permission.name[$this] := null;
    assume {:breadcrumb 157} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.Permission.#cctor();



implementation T$GenericAuthNameSpace.Permission.#cctor()
{

  anon0:
    return;
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

  anon0:
    assume {:breadcrumb 158} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#cctor();



implementation T$GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#cctor()
{

  anon0:
    return;
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

  anon0:
    F$GenericAuthNameSpace.Resource.name[$this] := null;
    assume {:breadcrumb 159} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.Resource.#cctor();



implementation T$GenericAuthNameSpace.Resource.#cctor()
{

  anon0:
    return;
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

  anon0:
    assume {:breadcrumb 160} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#cctor();



implementation T$GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#cctor()
{

  anon0:
    return;
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

  anon0:
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
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} !$tmp2;
    assume {:breadcrumb 162} true;
    call $tmp3 := System.IO.File.CreateText$System.String(local_2_Ref);
    local_3_Ref := $tmp3;
    call $tmp4 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
    call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp4);
    goto anon3;

  anon13_Else:
    assume {:partition} $tmp2;
    assume {:breadcrumb 163} true;
    call $tmp5 := System.IO.File.AppendText$System.String(local_2_Ref);
    local_3_Ref := $tmp5;
    call $tmp6 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
    call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp6);
    goto anon3;

  anon3:
    assume $this != null;
    $tmp7 := F$GenericAuthNameSpace.RP.CurrentSession[$this];
    call $tmp8 := System.Web.HttpSessionStateBase.get_Item$System.String($tmp7, $string_literal_UserID_25);
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} $tmp8 != null;
    assume {:breadcrumb 164} true;
    assume $this != null;
    $tmp9 := F$GenericAuthNameSpace.RP.CurrentSession[$this];
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} local_1_bool;
    $tmp10 := conclusion;
    assume $tmp10 != null;
    goto anon7;

  anon15_Else:
    assume {:partition} !local_1_bool;
    goto anon7;

  anon7:
    call System.Web.HttpSessionStateBase.set_Item$System.String$System.Object($tmp9, $string_literal_UserID_25, (if local_1_bool then F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp10] else $string_literal__26));
    goto anon12;

  anon14_Else:
    assume {:partition} $tmp8 == null;
    assume {:breadcrumb 165} true;
    assume $this != null;
    $tmp11 := F$GenericAuthNameSpace.RP.CurrentSession[$this];
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} local_1_bool;
    $tmp12 := conclusion;
    assume $tmp12 != null;
    goto anon11;

  anon16_Else:
    assume {:partition} !local_1_bool;
    goto anon11;

  anon11:
    call System.Web.HttpSessionStateBase.Add$System.String$System.Object($tmp11, $string_literal_UserID_25, (if local_1_bool then F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp12] else $string_literal__26));
    goto anon12;

  anon12:
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

  anon0:
    F$GenericAuthNameSpace.RP.CurrentSession[$this] := null;
    F$GenericAuthNameSpace.RP.Domain[$this] := null;
    F$GenericAuthNameSpace.RP.Realm[$this] := null;
    assume {:breadcrumb 166} true;
    call System.Object.#ctor($this);
    return;
}



implementation GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$this] := null;
    assume {:breadcrumb 167} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.RP.AuthenticationConclusion.#cctor();



implementation T$GenericAuthNameSpace.RP.AuthenticationConclusion.#cctor()
{

  anon0:
    return;
}



procedure T$GenericAuthNameSpace.RP.#cctor();



implementation T$GenericAuthNameSpace.RP.#cctor()
{

  anon0:
    return;
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

  anon0:
    F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.resources[$this] := null;
    F$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.UserID[$this] := null;
    assume {:breadcrumb 168} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#cctor();



implementation T$GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#cctor()
{

  anon0:
    return;
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

  anon0:
    assume {:breadcrumb 169} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.ValidateTicket_Req.#cctor();



implementation T$GenericAuthNameSpace.ValidateTicket_Req.#cctor()
{

  anon0:
    return;
}



function T$GenericAuthNameSpace.ID_Claim() : Ref;

const unique T$GenericAuthNameSpace.ID_Claim: int;

procedure GenericAuthNameSpace.ID_Claim.#ctor($this: Ref);



implementation GenericAuthNameSpace.ID_Claim.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 170} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.ID_Claim.#cctor();



implementation T$GenericAuthNameSpace.ID_Claim.#cctor()
{

  anon0:
    return;
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

  anon0:
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
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} !$tmp2;
    assume {:breadcrumb 172} true;
    call $tmp3 := System.IO.File.CreateText$System.String(local_2_Ref);
    local_3_Ref := $tmp3;
    call $tmp4 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
    call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp4);
    goto anon3;

  anon4_Else:
    assume {:partition} $tmp2;
    assume {:breadcrumb 173} true;
    call $tmp5 := System.IO.File.AppendText$System.String(local_2_Ref);
    local_3_Ref := $tmp5;
    call $tmp6 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_0_Ref);
    call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp6);
    goto anon3;

  anon3:
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

  anon0:
    F$GenericAuthNameSpace.RS.RSResourceRecs[$this] := null;
    F$GenericAuthNameSpace.RS.Domain[$this] := null;
    F$GenericAuthNameSpace.RS.Realm[$this] := null;
    assume {:breadcrumb 174} true;
    call System.Object.#ctor($this);
    return;
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

  anon0:
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.ticket[$this] := null;
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.permissions[$this] := null;
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.Realm[$this] := null;
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.UserID[$this] := null;
    assume {:breadcrumb 175} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.RS.AuthorizationConclusion.#cctor();



implementation T$GenericAuthNameSpace.RS.AuthorizationConclusion.#cctor()
{

  anon0:
    return;
}



procedure T$GenericAuthNameSpace.RS.#cctor();



implementation T$GenericAuthNameSpace.RS.#cctor()
{

  anon0:
    return;
}



function T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req: int;

procedure GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref);



implementation GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 176} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor()
{

  anon0:
    return;
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

  anon0:
    assume {:breadcrumb 177} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.AuthTicketAS_Req.#cctor();



implementation T$GenericAuthNameSpace.AuthTicketAS_Req.#cctor()
{

  anon0:
    return;
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

  anon0:
    assume {:breadcrumb 178} true;
    assume $this != null;
    assume $this != null;
    call OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this, F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary[$this], F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary[$this]);
    return;
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

  anon0:
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

  anon0:
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

  anon0:
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
    return;
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

  anon0:
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

  anon0:
    IdPSessionSecret := IdPSessionSecret$in;
    client_id := client_id$in;
    Entry := Entry$in;
    assume {:breadcrumb 183} true;
    local_0_Ref := Entry;
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} local_0_Ref == null;
    assume {:breadcrumb 184} true;
    local_1_bool := false;
    goto IL_0041;

  anon3_Else:
    assume {:partition} local_0_Ref != null;
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

  anon0:
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
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} $tmp4;
    assume {:breadcrumb 187} true;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenIDConnectNameSpace.AuthenticationRequest;
    call $tmp5 := OAuth20NameSpace.AuthorizationRequest.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
    goto anon6;

  anon13_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) != T$OpenIDConnectNameSpace.AuthenticationRequest;
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp6 := OAuth20NameSpace.AuthorizationRequest.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
    goto anon6;

  anon14_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) != T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp7 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
    goto anon6;

  anon6:
    call $tmp8 := System.String.op_Equality$System.String$System.String(client_id, (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp5 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp6 else $tmp7)));
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} $tmp8;
    assume {:breadcrumb 189} true;
    goto anon9;

  anon15_Else:
    assume {:partition} !$tmp8;
    assume {:breadcrumb 190} true;
    goto IL_0062;

  anon9:
    $tmp9 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp9 != null;
    call $tmp10 := System.String.op_Equality$System.String$System.String(client_id, F$GenericAuthNameSpace.RP.Realm[$tmp9]);
    stack_0_System_Boolean_bool := $tmp10;
    goto anon11;

  anon12_Else:
    assume {:partition} !$tmp4;
    assume {:breadcrumb 188} true;
    goto IL_0062;

  IL_0062:
    stack_0_System_Boolean_bool := false;
    goto anon11;

  anon11:
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

  anon0:
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
    return;
}



procedure T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#cctor();



implementation T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#cctor()
{

  anon0:
    return;
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

  anon0:
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

  anon0:
    ticket := ticket$in;
    Realm := Realm$in;
    UserID := UserID$in;
    claim := claim$in;
    assume {:breadcrumb 193} true;
    local_0_Ref := ticket;
    local_1_Ref := claim;
    goto anon6_Then, anon6_Else;

  anon6_Then:
    assume {:partition} local_0_Ref == null;
    goto anon3;

  anon6_Else:
    assume {:partition} local_0_Ref != null;
    goto anon3;

  anon3:
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} (if local_0_Ref == null then claim == null else false);
    assume {:breadcrumb 194} true;
    local_2_bool := false;
    goto IL_006f;

  anon7_Else:
    assume {:partition} !(if local_0_Ref == null then claim == null else false);
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

  anon0:
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

  anon0:
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

  anon0:
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
    return;
}



procedure T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#cctor();



implementation T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#cctor()
{

  anon0:
    return;
}



procedure T$LiveIDNameSpace.LiveID_IdP.#cctor();



implementation T$LiveIDNameSpace.LiveID_IdP.#cctor()
{

  anon0:
    F$LiveIDNameSpace.LiveID_IdP.Nondet := null;
    return;
}



procedure LiveIDNameSpace.LiveID_RP.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id$in: Ref, return_uri$in: Ref, client_secret$in: Ref, TokenEndpointUrl$in: Ref);



implementation LiveIDNameSpace.LiveID_RP.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id$in: Ref, return_uri$in: Ref, client_secret$in: Ref, TokenEndpointUrl$in: Ref)
{
  var client_id: Ref;
  var return_uri: Ref;
  var client_secret: Ref;
  var TokenEndpointUrl: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    client_id := client_id$in;
    return_uri := return_uri$in;
    client_secret := client_secret$in;
    TokenEndpointUrl := TokenEndpointUrl$in;
    assume {:breadcrumb 199} true;
    call OpenIDConnectNameSpace.RelyingParty.#ctor$System.String$System.String$System.String$System.String($this, client_id, return_uri, client_secret, TokenEndpointUrl);
    return;
}



const {:value "0000000044159E9D"} unique $string_literal_0000000044159E9D_27: Ref;

const {:value "http://mydomain2.com:8700/Account/MSLoginCallback"} unique $string_literal_http$$$mydomain2.com$8700$Account$MSLoginCallback_28: Ref;

const {:value "pQZPJYxVuzaF7zk3-0cfuA6lWoW3GHkf"} unique $string_literal_pQZPJYxVuzaF7zk3$0cfuA6lWoW3GHkf_29: Ref;

const {:value "https://login.live.com/oauth20_token.srf"} unique $string_literal_https$$$login.live.com$oauth20_token.srf_30: Ref;

implementation LiveIDNameSpace.LiveID_RP.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 200} true;
    call LiveIDNameSpace.LiveID_RP.#ctor$System.String$System.String$System.String$System.String($this, $string_literal_0000000044159E9D_27, $string_literal_http$$$mydomain2.com$8700$Account$MSLoginCallback_28, $string_literal_pQZPJYxVuzaF7zk3$0cfuA6lWoW3GHkf_29, $string_literal_https$$$login.live.com$oauth20_token.srf_30);
    return;
}



procedure LiveIDNameSpace.LiveID_RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



implementation LiveIDNameSpace.LiveID_RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var local_2_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    req := req$in;
    assume {:breadcrumb 201} true;
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



const {:value "C:\Users\Daniel Song\Desktop\IdP_TokenRequest.txt"} unique $string_literal_C$$Users$Daniel$Song$Desktop$IdP_TokenRequest.txt_33: Ref;

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

  anon0:
    req := req$in;
    assume {:breadcrumb 202} true;
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
    local_2_Ref := $string_literal_C$$Users$Daniel$Song$Desktop$IdP_TokenRequest.txt_33;
    call $tmp5 := System.IO.File.Exists$System.String(local_2_Ref);
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} !$tmp5;
    assume {:breadcrumb 203} true;
    call $tmp6 := System.IO.File.CreateText$System.String(local_2_Ref);
    local_3_Ref := $tmp6;
    call $tmp7 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
    call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp7);
    goto anon3;

  anon4_Else:
    assume {:partition} $tmp5;
    assume {:breadcrumb 204} true;
    call $tmp8 := System.IO.File.AppendText$System.String(local_2_Ref);
    local_3_Ref := $tmp8;
    call $tmp9 := System.Diagnostics.Stopwatch.get_ElapsedMilliseconds(local_1_Ref);
    call System.IO.TextWriter.WriteLine$System.Int64(local_3_Ref, $tmp9);
    goto anon3;

  anon3:
    local_4_Ref := local_0_Ref;
    goto IL_00b8;

  IL_00b8:
    $result := local_4_Ref;
    return;
}



procedure LiveIDNameSpace.LiveID_RP.GetUserID($this: Ref) returns ($result: Ref);



implementation LiveIDNameSpace.LiveID_RP.GetUserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 205} true;
    assume $this != null;
    $tmp0 := F$GenericAuthNameSpace.RP.CurrentSession[$this];
    call $tmp1 := System.Web.HttpSessionStateBase.get_Item$System.String($tmp0, $string_literal_UserID_25);
    local_0_Ref := $tmp1;
    goto IL_0019;

  IL_0019:
    $result := local_0_Ref;
    return;
}



procedure LiveIDNameSpace.LiveID_RP.IsVerified($this: Ref) returns ($result: bool);



implementation LiveIDNameSpace.LiveID_RP.IsVerified($this: Ref) returns ($result: bool)
{
  var local_0_bool: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 206} true;
    local_0_bool := true;
    goto IL_0005;

  IL_0005:
    $result := local_0_bool;
    return;
}



procedure T$LiveIDNameSpace.LiveID_RP.#cctor();



implementation T$LiveIDNameSpace.LiveID_RP.#cctor()
{

  anon0:
    return;
}



function $Message$j__TPar$T$$$f__AnonymousType1`1(parent: Ref) : Ref;

function T$$$f__AnonymousType1`1($Message$j__TPar: Ref) : Ref;

const unique T$$$f__AnonymousType1`1: int;

var F$$$f__AnonymousType1`1.$Message$i__Field: [Ref]Ref;

procedure {:System.Diagnostics.DebuggerHidden} $$f__AnonymousType1`1.#ctor$`0($this: Ref, Message$in: Ref);



implementation $$f__AnonymousType1`1.#ctor$`0($this: Ref, Message$in: Ref)
{
  var Message: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    Message := Message$in;
    F$$$f__AnonymousType1`1.$Message$i__Field[$this] := null;
    assume {:breadcrumb 207} true;
    call System.Object.#ctor($this);
    F$$$f__AnonymousType1`1.$Message$i__Field[$this] := Message;
    return;
}



procedure $$f__AnonymousType1`1.get_Message($this: Ref) returns ($result: Ref);



implementation $$f__AnonymousType1`1.get_Message($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 208} true;
    assume $this != null;
    local_0_Ref := F$$$f__AnonymousType1`1.$Message$i__Field[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Diagnostics.DebuggerHidden} $$f__AnonymousType1`1.ToString($this: Ref) returns ($result: Ref);



procedure {:extern} System.Text.StringBuilder.#ctor($this: Ref);



function {:extern} T$System.Text.StringBuilder() : Ref;

const {:extern} unique T$System.Text.StringBuilder: int;

axiom $TypeConstructor(T$System.Text.StringBuilder()) == T$System.Text.StringBuilder;

const {:value "{ Message = "} unique $string_literal_$$Message$$$_34: Ref;

procedure {:extern} System.Text.StringBuilder.Append$System.String($this: Ref, value$in: Ref) returns ($result: Ref);



procedure {:extern} System.Text.StringBuilder.Append$System.Object($this: Ref, value$in: Ref) returns ($result: Ref);



const {:value " }"} unique $string_literal_$$_35: Ref;

procedure {:extern} System.Object.ToString($this: Ref) returns ($result: Ref);



implementation $$f__AnonymousType1`1.ToString($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_1_Ref: Ref;
  var $tmp5: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 209} true;
    call $tmp0 := Alloc();
    call System.Text.StringBuilder.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Text.StringBuilder();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Text.StringBuilder;
    local_0_Ref := $tmp0;
    call $tmp1 := System.Text.StringBuilder.Append$System.String(local_0_Ref, $string_literal_$$Message$$$_34);
    assume $this != null;
    call $tmp2 := $BoxFromUnion(F$$$f__AnonymousType1`1.$Message$i__Field[$this]);
    call $tmp3 := System.Text.StringBuilder.Append$System.Object(local_0_Ref, $tmp2);
    call $tmp4 := System.Text.StringBuilder.Append$System.String(local_0_Ref, $string_literal_$$_35);
    call $tmp5 := System.Object.ToString(local_0_Ref);
    local_1_Ref := $tmp5;
    goto IL_0039;

  IL_0039:
    $result := local_1_Ref;
    return;
}



procedure {:System.Diagnostics.DebuggerHidden} $$f__AnonymousType1`1.Equals$System.Object($this: Ref, value$in: Ref) returns ($result: bool);



procedure {:extern} System.Collections.Generic.EqualityComparer`1.get_Default(T: Ref) returns ($result: Ref);



procedure {:extern} System.Collections.Generic.EqualityComparer`1.Equals$`0$`0($this: Ref, x$in: Ref, y$in: Ref) returns ($result: bool);



implementation $$f__AnonymousType1`1.Equals$System.Object($this: Ref, value$in: Ref) returns ($result: bool)
{
  var value: Ref;
  var local_0_Ref: Ref;
  var local_1_bool: bool;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 210} true;
    local_0_Ref := $As(value, T$$$f__AnonymousType1`1($Message$j__TPar$T$$$f__AnonymousType1`1($DynamicType($this))));
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} local_0_Ref != null;
    call $tmp0 := System.Collections.Generic.EqualityComparer`1.get_Default($Message$j__TPar$T$$$f__AnonymousType1`1($DynamicType($this)));
    assume $this != null;
    $tmp1 := local_0_Ref;
    assume $tmp1 != null;
    call $tmp2 := System.Collections.Generic.EqualityComparer`1.Equals$`0$`0($tmp0, F$$$f__AnonymousType1`1.$Message$i__Field[$this], F$$$f__AnonymousType1`1.$Message$i__Field[$tmp1]);
    goto anon3;

  anon4_Else:
    assume {:partition} local_0_Ref == null;
    goto anon3;

  anon3:
    local_1_bool := (if local_0_Ref != null then $tmp2 else false);
    goto IL_0027;

  IL_0027:
    $result := local_1_bool;
    return;
}



procedure {:System.Diagnostics.DebuggerHidden} $$f__AnonymousType1`1.GetHashCode($this: Ref) returns ($result: int);



procedure {:extern} System.Collections.Generic.EqualityComparer`1.GetHashCode$`0($this: Ref, obj$in: Ref) returns ($result: int);



implementation $$f__AnonymousType1`1.GetHashCode($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $tmp0: Ref;
  var $tmp1: int;
  var local_1_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 211} true;
    local_0_int := -942505740;
    call $tmp0 := System.Collections.Generic.EqualityComparer`1.get_Default($Message$j__TPar$T$$$f__AnonymousType1`1($DynamicType($this)));
    assume $this != null;
    call $tmp1 := System.Collections.Generic.EqualityComparer`1.GetHashCode$`0($tmp0, F$$$f__AnonymousType1`1.$Message$i__Field[$this]);
    local_0_int := -1521134295 * local_0_int + $tmp1;
    local_1_int := local_0_int;
    goto IL_0023;

  IL_0023:
    $result := local_1_int;
    return;
}



procedure T$$$f__AnonymousType1`1.#cctor();



implementation T$$$f__AnonymousType1`1.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.Models.ManageUserViewModel() : Ref;

const unique T$CILRepository.Models.ManageUserViewModel: int;

procedure CILRepository.Models.ManageUserViewModel.#ctor($this: Ref);



implementation CILRepository.Models.ManageUserViewModel.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 212} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$CILRepository.Models.ManageUserViewModel.#cctor();



implementation T$CILRepository.Models.ManageUserViewModel.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.Models.MSLoginViewModel() : Ref;

const unique T$CILRepository.Models.MSLoginViewModel: int;

var F$CILRepository.Models.MSLoginViewModel.$isIdP$k__BackingField: [Ref]bool;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Models.MSLoginViewModel.get_isIdP($this: Ref) returns ($result: bool);



implementation CILRepository.Models.MSLoginViewModel.get_isIdP($this: Ref) returns ($result: bool)
{
  var local_0_bool: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 213} true;
    assume $this != null;
    local_0_bool := F$CILRepository.Models.MSLoginViewModel.$isIdP$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_bool;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Models.MSLoginViewModel.set_isIdP$System.Boolean($this: Ref, value$in: bool);



implementation CILRepository.Models.MSLoginViewModel.set_isIdP$System.Boolean($this: Ref, value$in: bool)
{
  var value: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 214} true;
    F$CILRepository.Models.MSLoginViewModel.$isIdP$k__BackingField[$this] := value;
    return;
}



procedure CILRepository.Models.MSLoginViewModel.#ctor($this: Ref);



implementation CILRepository.Models.MSLoginViewModel.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$CILRepository.Models.MSLoginViewModel.$isIdP$k__BackingField[$this] := false;
    assume {:breadcrumb 215} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$CILRepository.Models.MSLoginViewModel.#cctor();



implementation T$CILRepository.Models.MSLoginViewModel.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.Models.RegisterViewModel() : Ref;

const unique T$CILRepository.Models.RegisterViewModel: int;

var F$CILRepository.Models.RegisterViewModel.$UserName$k__BackingField: [Ref]Ref;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Models.RegisterViewModel.get_UserName($this: Ref) returns ($result: Ref);



implementation CILRepository.Models.RegisterViewModel.get_UserName($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 216} true;
    assume $this != null;
    local_0_Ref := F$CILRepository.Models.RegisterViewModel.$UserName$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Models.RegisterViewModel.set_UserName$System.String($this: Ref, value$in: Ref);



implementation CILRepository.Models.RegisterViewModel.set_UserName$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 217} true;
    F$CILRepository.Models.RegisterViewModel.$UserName$k__BackingField[$this] := value;
    return;
}



procedure CILRepository.Models.RegisterViewModel.#ctor($this: Ref);



implementation CILRepository.Models.RegisterViewModel.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$CILRepository.Models.RegisterViewModel.$UserName$k__BackingField[$this] := null;
    assume {:breadcrumb 218} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$CILRepository.Models.RegisterViewModel.#cctor();



implementation T$CILRepository.Models.RegisterViewModel.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.Models.LoginViewModel() : Ref;

const unique T$CILRepository.Models.LoginViewModel: int;

var F$CILRepository.Models.LoginViewModel.$UserName$k__BackingField: [Ref]Ref;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Models.LoginViewModel.get_UserName($this: Ref) returns ($result: Ref);



implementation CILRepository.Models.LoginViewModel.get_UserName($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 219} true;
    assume $this != null;
    local_0_Ref := F$CILRepository.Models.LoginViewModel.$UserName$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Models.LoginViewModel.set_UserName$System.String($this: Ref, value$in: Ref);



implementation CILRepository.Models.LoginViewModel.set_UserName$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 220} true;
    F$CILRepository.Models.LoginViewModel.$UserName$k__BackingField[$this] := value;
    return;
}



procedure CILRepository.Models.LoginViewModel.#ctor($this: Ref);



implementation CILRepository.Models.LoginViewModel.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$CILRepository.Models.LoginViewModel.$UserName$k__BackingField[$this] := null;
    assume {:breadcrumb 221} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$CILRepository.Models.LoginViewModel.#cctor();



implementation T$CILRepository.Models.LoginViewModel.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.Models.ApplicationUser() : Ref;

const unique T$CILRepository.Models.ApplicationUser: int;

var F$CILRepository.Models.ApplicationUser.isIdP: [Ref]bool;

procedure CILRepository.Models.ApplicationUser.#ctor($this: Ref);



procedure T$CILRepository.Models.ApplicationUser.#cctor();



implementation T$CILRepository.Models.ApplicationUser.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.Models.ExternalLoginConfirmationViewModel() : Ref;

const unique T$CILRepository.Models.ExternalLoginConfirmationViewModel: int;

var F$CILRepository.Models.ExternalLoginConfirmationViewModel.$UserName$k__BackingField: [Ref]Ref;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Models.ExternalLoginConfirmationViewModel.get_UserName($this: Ref) returns ($result: Ref);



implementation CILRepository.Models.ExternalLoginConfirmationViewModel.get_UserName($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 223} true;
    assume $this != null;
    local_0_Ref := F$CILRepository.Models.ExternalLoginConfirmationViewModel.$UserName$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Models.ExternalLoginConfirmationViewModel.set_UserName$System.String($this: Ref, value$in: Ref);



implementation CILRepository.Models.ExternalLoginConfirmationViewModel.set_UserName$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 224} true;
    F$CILRepository.Models.ExternalLoginConfirmationViewModel.$UserName$k__BackingField[$this] := value;
    return;
}



procedure CILRepository.Models.ExternalLoginConfirmationViewModel.#ctor($this: Ref);



implementation CILRepository.Models.ExternalLoginConfirmationViewModel.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$CILRepository.Models.ExternalLoginConfirmationViewModel.$UserName$k__BackingField[$this] := null;
    assume {:breadcrumb 225} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$CILRepository.Models.ExternalLoginConfirmationViewModel.#cctor();



implementation T$CILRepository.Models.ExternalLoginConfirmationViewModel.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.Models.ApplicationDbContext() : Ref;

const unique T$CILRepository.Models.ApplicationDbContext: int;

procedure CILRepository.Models.ApplicationDbContext.#ctor($this: Ref);



procedure T$CILRepository.Models.ApplicationDbContext.#cctor();



implementation T$CILRepository.Models.ApplicationDbContext.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.Controllers.CILController() : Ref;

const unique T$CILRepository.Controllers.CILController: int;

procedure CILRepository.Controllers.CILController.Index($this: Ref) returns ($result: Ref);



procedure {:System.Web.Mvc.AllowAnonymous} {:System.Web.Mvc.HttpPost} CILRepository.Controllers.CILController.DLLHandle$System.String$System.String($this: Ref, sha$in: Ref, token$in: Ref) returns ($result: Ref);



procedure CILRepository.Controllers.CILController.#ctor($this: Ref);



procedure T$CILRepository.Controllers.CILController.#cctor();



implementation T$CILRepository.Controllers.CILController.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.Controllers.AccountController() : Ref;

const unique T$CILRepository.Controllers.AccountController: int;

var F$CILRepository.Controllers.AccountController.XsrfKey: Ref;

var F$CILRepository.Controllers.AccountController.hasher: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.RP: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$UserManager$k__BackingField: [Ref]bool;

procedure CILRepository.Controllers.AccountController.#ctor($this: Ref);



procedure CILRepository.Controllers.AccountController.#ctor$Microsoft.AspNet.Identity.UserManager$CILRepository.Models.ApplicationUser$($this: Ref, userManager$in: Ref);



procedure {:extern} CST.DLLHasher.#ctor($this: Ref);



function {:extern} T$CST.DLLHasher() : Ref;

const {:extern} unique T$CST.DLLHasher: int;

axiom $TypeConstructor(T$CST.DLLHasher()) == T$CST.DLLHasher;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Controllers.AccountController.get_UserManager($this: Ref) returns ($result: Ref);



implementation CILRepository.Controllers.AccountController.get_UserManager($this: Ref) returns ($result: Ref)
{
  var local_0_bool: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 232} true;
    assume $this != null;
    local_0_bool := F$CILRepository.Controllers.AccountController.$UserManager$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_bool;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Controllers.AccountController.set_UserManager$Microsoft.AspNet.Identity.UserManager$CILRepository.Models.ApplicationUser$($this: Ref, value$in: Ref);



implementation CILRepository.Controllers.AccountController.set_UserManager$Microsoft.AspNet.Identity.UserManager$CILRepository.Models.ApplicationUser$($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 233} true;
    F$CILRepository.Controllers.AccountController.$UserManager$k__BackingField[$this] := value;
    return;
}



procedure CILRepository.Controllers.AccountController.DownloadToken($this: Ref) returns ($result: Ref);



procedure {:System.Web.Mvc.AllowAnonymous} CILRepository.Controllers.AccountController.DllHandle$System.String$System.String($this: Ref, user_sha$in: Ref, token$in: Ref) returns ($result: Ref);



var F$CILRepository.Controllers.AccountController.$DllHandle$o__SiteContainer0.$$p__Site1: Ref;

const {:value "Message"} unique $string_literal_Message_36: Ref;

procedure {:extern} Microsoft.CSharp.RuntimeBinder.Binder.SetMember$Microsoft.CSharp.RuntimeBinder.CSharpBinderFlags$System.String$System.Type$System.Collections.Generic.IEnumerable$Microsoft.CSharp.RuntimeBinder.CSharpArgumentInfo$(flags$in: int, name$in: Ref, context$in: Ref, argumentInfo$in: Ref) returns ($result: Ref);



function {:extern} T1$T$System.Func`4(parent: Ref) : Ref;

function {:extern} T2$T$System.Func`4(parent: Ref) : Ref;

function {:extern} T3$T$System.Func`4(parent: Ref) : Ref;

function {:extern} TResult$T$System.Func`4(parent: Ref) : Ref;

function {:extern} T$System.Func`4(T1: Ref, T2: Ref, T3: Ref, TResult: Ref) : Ref;

const {:extern} unique T$System.Func`4: int;

function {:extern} T$System.Runtime.CompilerServices.CallSite() : Ref;

const {:extern} unique T$System.Runtime.CompilerServices.CallSite: int;

axiom $TypeConstructor(T$System.Runtime.CompilerServices.CallSite()) == T$System.Runtime.CompilerServices.CallSite;

function {:extern} T$System.Object() : Ref;

const {:extern} unique T$System.Object: int;

axiom $TypeConstructor(T$System.Object()) == T$System.Object;

procedure {:extern} System.Runtime.CompilerServices.CallSite`1.Create$System.Runtime.CompilerServices.CallSiteBinder(binder$in: Ref, T: Ref) returns ($result: Ref);



var {:extern} F$System.Runtime.CompilerServices.CallSite`1.Target: [Ref]Ref;

procedure {:System.Web.Mvc.AllowAnonymous} CILRepository.Controllers.AccountController.DepHandle$System.String$System.String($this: Ref, user_sha$in: Ref, token$in: Ref) returns ($result: Ref);



var F$CILRepository.Controllers.AccountController.$DepHandle$o__SiteContainer2.$$p__Site3: Ref;

procedure {:System.Web.Mvc.AllowAnonymous} CILRepository.Controllers.AccountController.DownloadMethodRecord$System.String$System.String($this: Ref, user_sha$in: Ref, token$in: Ref) returns ($result: Ref);



var F$CILRepository.Controllers.AccountController.$DownloadMethodRecord$o__SiteContainer4.$$p__Site5: Ref;

procedure {:System.Web.Mvc.AllowAnonymous} CILRepository.Controllers.AccountController.Verify$System.String$System.String($this: Ref, SymT$in: Ref, token$in: Ref) returns ($result: Ref);



procedure {:System.Web.Mvc.AllowAnonymous} CILRepository.Controllers.AccountController.UploadMethodRecord$System.String$System.String($this: Ref, user_sha$in: Ref, token$in: Ref) returns ($result: Ref);



procedure {:System.Web.Mvc.AllowAnonymous} CILRepository.Controllers.AccountController.UploadDll$System.String$System.String($this: Ref, user_sha$in: Ref, token$in: Ref) returns ($result: Ref);



procedure {:extern} System.String.Trim($this: Ref) returns ($result: Ref);



procedure {:System.Web.Mvc.AllowAnonymous} CILRepository.Controllers.AccountController.Login$System.String($this: Ref, returnUrl$in: Ref) returns ($result: Ref);



var F$CILRepository.Controllers.AccountController.$Login$o__SiteContainer6.$$p__Site7: Ref;

const {:value "ReturnUrl"} unique $string_literal_ReturnUrl_37: Ref;

procedure {:System.Web.Mvc.ValidateAntiForgeryToken} {:System.Web.Mvc.AllowAnonymous} {:System.Web.Mvc.HttpPost} CILRepository.Controllers.AccountController.MSLogin$System.String$System.String($this: Ref, provider$in: Ref, returnUrl$in: Ref) returns ($result: Ref);



procedure {:System.Web.Mvc.AllowAnonymous} {:System.Runtime.CompilerServices.AsyncStateMachine} {:System.Diagnostics.DebuggerStepThrough} CILRepository.Controllers.AccountController.MSLoginCallback$System.String($this: Ref, code$in: Ref) returns ($result: Ref);



procedure CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.#default_ctor($this: Ref);



function T$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b() : Ref;

const unique T$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b: int;

var F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$4__this: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.code: [Ref]Ref;

procedure System.Runtime.CompilerServices.AsyncTaskMethodBuilder.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



function {:extern} Microsoft.Cci.DummyTypeReference() : Ref;

const {:extern} unique Microsoft.Cci.DummyTypeReference: int;

axiom $TypeConstructor(Microsoft.Cci.DummyTypeReference()) == Microsoft.Cci.DummyTypeReference;

procedure {:extern} System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Create(TResult: Ref) returns ($result: Ref);



var F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$t__builder: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$1__state: [Ref]int;

procedure {:extern} System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Start``1$``0$($this: Ref, stateMachine$in: Ref, TStateMachine: Ref) returns (stateMachine$out: Ref);



procedure {:extern} System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.get_Task($this: Ref) returns ($result: Ref);



implementation CILRepository.Controllers.AccountController.MSLoginCallback$System.String($this: Ref, code$in: Ref) returns ($result: Ref)
{
  var code: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_1_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    code := code$in;
    assume {:breadcrumb 255} true;
    call $tmp0 := Alloc();
    call CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b;
    local_0_Ref := $tmp0;
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$4__this[local_0_Ref] := $this;
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.code[local_0_Ref] := code;
    call $tmp1 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Create(Microsoft.Cci.DummyTypeReference());
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$t__builder[local_0_Ref] := $tmp1;
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$1__state[local_0_Ref] := -1;
    assume local_0_Ref != null;
    $tmp2 := F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$t__builder[local_0_Ref];
    call local_0_Ref := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Start``1$``0$($tmp2, local_0_Ref, T$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b());
    assume local_0_Ref != null;
    $tmp3 := F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$t__builder[local_0_Ref];
    call $tmp4 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.get_Task($tmp3);
    local_1_Ref := $tmp4;
    goto IL_0044;

  IL_0044:
    $result := local_1_Ref;
    return;
}



procedure {:System.Diagnostics.DebuggerStepThrough} {:System.Web.Mvc.AllowAnonymous} {:System.Web.Mvc.HttpPost} {:System.Runtime.CompilerServices.AsyncStateMachine} CILRepository.Controllers.AccountController.MSLoginConfirmation$CILRepository.Models.MSLoginViewModel$System.String$System.String($this: Ref, model$in: Ref, name$in: Ref, token$in: Ref) returns ($result: Ref);



procedure CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.#default_ctor($this: Ref);



function T$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13() : Ref;

const unique T$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13: int;

var F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$4__this: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.model: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.name: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.token: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$t__builder: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$1__state: [Ref]int;

implementation CILRepository.Controllers.AccountController.MSLoginConfirmation$CILRepository.Models.MSLoginViewModel$System.String$System.String($this: Ref, model$in: Ref, name$in: Ref, token$in: Ref) returns ($result: Ref)
{
  var model: Ref;
  var name: Ref;
  var token: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_1_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    model := model$in;
    name := name$in;
    token := token$in;
    assume {:breadcrumb 256} true;
    call $tmp0 := Alloc();
    call CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13;
    local_0_Ref := $tmp0;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$4__this[local_0_Ref] := $this;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.model[local_0_Ref] := model;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.name[local_0_Ref] := name;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.token[local_0_Ref] := token;
    call $tmp1 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Create(Microsoft.Cci.DummyTypeReference());
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$t__builder[local_0_Ref] := $tmp1;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$1__state[local_0_Ref] := -1;
    assume local_0_Ref != null;
    $tmp2 := F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$t__builder[local_0_Ref];
    call local_0_Ref := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Start``1$``0$($tmp2, local_0_Ref, T$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13());
    assume local_0_Ref != null;
    $tmp3 := F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$t__builder[local_0_Ref];
    call $tmp4 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.get_Task($tmp3);
    local_1_Ref := $tmp4;
    goto IL_0054;

  IL_0054:
    $result := local_1_Ref;
    return;
}



procedure {:System.Web.Mvc.ValidateAntiForgeryToken} {:System.Web.Mvc.AllowAnonymous} {:System.Web.Mvc.HttpPost} {:System.Runtime.CompilerServices.AsyncStateMachine} {:System.Diagnostics.DebuggerStepThrough} CILRepository.Controllers.AccountController.Login$CILRepository.Models.LoginViewModel$System.String($this: Ref, model$in: Ref, returnUrl$in: Ref) returns ($result: Ref);



procedure CILRepository.Controllers.AccountController.$Login$d__19.#default_ctor($this: Ref);



function T$CILRepository.Controllers.AccountController.$Login$d__19() : Ref;

const unique T$CILRepository.Controllers.AccountController.$Login$d__19: int;

var F$CILRepository.Controllers.AccountController.$Login$d__19.$$4__this: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Login$d__19.model: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Login$d__19.returnUrl: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Login$d__19.$$t__builder: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Login$d__19.$$1__state: [Ref]int;

implementation CILRepository.Controllers.AccountController.Login$CILRepository.Models.LoginViewModel$System.String($this: Ref, model$in: Ref, returnUrl$in: Ref) returns ($result: Ref)
{
  var model: Ref;
  var returnUrl: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_1_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    model := model$in;
    returnUrl := returnUrl$in;
    assume {:breadcrumb 257} true;
    call $tmp0 := Alloc();
    call CILRepository.Controllers.AccountController.$Login$d__19.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$CILRepository.Controllers.AccountController.$Login$d__19();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CILRepository.Controllers.AccountController.$Login$d__19;
    local_0_Ref := $tmp0;
    F$CILRepository.Controllers.AccountController.$Login$d__19.$$4__this[local_0_Ref] := $this;
    F$CILRepository.Controllers.AccountController.$Login$d__19.model[local_0_Ref] := model;
    F$CILRepository.Controllers.AccountController.$Login$d__19.returnUrl[local_0_Ref] := returnUrl;
    call $tmp1 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Create(Microsoft.Cci.DummyTypeReference());
    F$CILRepository.Controllers.AccountController.$Login$d__19.$$t__builder[local_0_Ref] := $tmp1;
    F$CILRepository.Controllers.AccountController.$Login$d__19.$$1__state[local_0_Ref] := -1;
    assume local_0_Ref != null;
    $tmp2 := F$CILRepository.Controllers.AccountController.$Login$d__19.$$t__builder[local_0_Ref];
    call local_0_Ref := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Start``1$``0$($tmp2, local_0_Ref, T$CILRepository.Controllers.AccountController.$Login$d__19());
    assume local_0_Ref != null;
    $tmp3 := F$CILRepository.Controllers.AccountController.$Login$d__19.$$t__builder[local_0_Ref];
    call $tmp4 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.get_Task($tmp3);
    local_1_Ref := $tmp4;
    goto IL_004c;

  IL_004c:
    $result := local_1_Ref;
    return;
}



procedure {:System.Web.Mvc.AllowAnonymous} CILRepository.Controllers.AccountController.Register($this: Ref) returns ($result: Ref);



procedure {:System.Runtime.CompilerServices.AsyncStateMachine} {:System.Diagnostics.DebuggerStepThrough} {:System.Web.Mvc.AllowAnonymous} {:System.Web.Mvc.HttpPost} {:System.Web.Mvc.ValidateAntiForgeryToken} CILRepository.Controllers.AccountController.Register$CILRepository.Models.RegisterViewModel($this: Ref, model$in: Ref) returns ($result: Ref);



procedure CILRepository.Controllers.AccountController.$Register$d__1c.#default_ctor($this: Ref);



function T$CILRepository.Controllers.AccountController.$Register$d__1c() : Ref;

const unique T$CILRepository.Controllers.AccountController.$Register$d__1c: int;

var F$CILRepository.Controllers.AccountController.$Register$d__1c.$$4__this: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Register$d__1c.model: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Register$d__1c.$$t__builder: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Register$d__1c.$$1__state: [Ref]int;

implementation CILRepository.Controllers.AccountController.Register$CILRepository.Models.RegisterViewModel($this: Ref, model$in: Ref) returns ($result: Ref)
{
  var model: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_1_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    model := model$in;
    assume {:breadcrumb 259} true;
    call $tmp0 := Alloc();
    call CILRepository.Controllers.AccountController.$Register$d__1c.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$CILRepository.Controllers.AccountController.$Register$d__1c();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CILRepository.Controllers.AccountController.$Register$d__1c;
    local_0_Ref := $tmp0;
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$4__this[local_0_Ref] := $this;
    F$CILRepository.Controllers.AccountController.$Register$d__1c.model[local_0_Ref] := model;
    call $tmp1 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Create(Microsoft.Cci.DummyTypeReference());
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$t__builder[local_0_Ref] := $tmp1;
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$1__state[local_0_Ref] := -1;
    assume local_0_Ref != null;
    $tmp2 := F$CILRepository.Controllers.AccountController.$Register$d__1c.$$t__builder[local_0_Ref];
    call local_0_Ref := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Start``1$``0$($tmp2, local_0_Ref, T$CILRepository.Controllers.AccountController.$Register$d__1c());
    assume local_0_Ref != null;
    $tmp3 := F$CILRepository.Controllers.AccountController.$Register$d__1c.$$t__builder[local_0_Ref];
    call $tmp4 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.get_Task($tmp3);
    local_1_Ref := $tmp4;
    goto IL_0044;

  IL_0044:
    $result := local_1_Ref;
    return;
}



procedure {:System.Diagnostics.DebuggerStepThrough} {:System.Web.Mvc.HttpPost} {:System.Web.Mvc.ValidateAntiForgeryToken} {:System.Runtime.CompilerServices.AsyncStateMachine} CILRepository.Controllers.AccountController.Disassociate$System.String$System.String($this: Ref, loginProvider$in: Ref, providerKey$in: Ref) returns ($result: Ref);



procedure CILRepository.Controllers.AccountController.$Disassociate$d__22.#default_ctor($this: Ref);



function T$CILRepository.Controllers.AccountController.$Disassociate$d__22() : Ref;

const unique T$CILRepository.Controllers.AccountController.$Disassociate$d__22: int;

var F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$4__this: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Disassociate$d__22.loginProvider: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Disassociate$d__22.providerKey: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$t__builder: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$1__state: [Ref]int;

implementation CILRepository.Controllers.AccountController.Disassociate$System.String$System.String($this: Ref, loginProvider$in: Ref, providerKey$in: Ref) returns ($result: Ref)
{
  var loginProvider: Ref;
  var providerKey: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_1_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    loginProvider := loginProvider$in;
    providerKey := providerKey$in;
    assume {:breadcrumb 260} true;
    call $tmp0 := Alloc();
    call CILRepository.Controllers.AccountController.$Disassociate$d__22.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$CILRepository.Controllers.AccountController.$Disassociate$d__22();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CILRepository.Controllers.AccountController.$Disassociate$d__22;
    local_0_Ref := $tmp0;
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$4__this[local_0_Ref] := $this;
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.loginProvider[local_0_Ref] := loginProvider;
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.providerKey[local_0_Ref] := providerKey;
    call $tmp1 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Create(Microsoft.Cci.DummyTypeReference());
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$t__builder[local_0_Ref] := $tmp1;
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$1__state[local_0_Ref] := -1;
    assume local_0_Ref != null;
    $tmp2 := F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$t__builder[local_0_Ref];
    call local_0_Ref := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Start``1$``0$($tmp2, local_0_Ref, T$CILRepository.Controllers.AccountController.$Disassociate$d__22());
    assume local_0_Ref != null;
    $tmp3 := F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$t__builder[local_0_Ref];
    call $tmp4 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.get_Task($tmp3);
    local_1_Ref := $tmp4;
    goto IL_004c;

  IL_004c:
    $result := local_1_Ref;
    return;
}



procedure CILRepository.Controllers.AccountController.Manage$System.Nullable$CILRepository.Controllers.AccountController.ManageMessageId$($this: Ref, message$in: Ref) returns ($result: Ref);



procedure System.Nullable$CILRepository.Controllers.AccountController.ManageMessageId$.#default_ctor($this: Ref);



function T$CILRepository.Controllers.AccountController.ManageMessageId() : Ref;

const unique T$CILRepository.Controllers.AccountController.ManageMessageId: int;

var F$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer27.$$p__Site28: Ref;

const {:value "StatusMessage"} unique $string_literal_StatusMessage_38: Ref;

procedure {:System.Runtime.CompilerServices.AsyncStateMachine} {:System.Web.Mvc.ValidateAntiForgeryToken} {:System.Web.Mvc.HttpPost} {:System.Diagnostics.DebuggerStepThrough} CILRepository.Controllers.AccountController.Manage$CILRepository.Models.ManageUserViewModel($this: Ref, model$in: Ref) returns ($result: Ref);



procedure CILRepository.Controllers.AccountController.$Manage$d__2e.#default_ctor($this: Ref);



function T$CILRepository.Controllers.AccountController.$Manage$d__2e() : Ref;

const unique T$CILRepository.Controllers.AccountController.$Manage$d__2e: int;

var F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$4__this: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Manage$d__2e.model: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$t__builder: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$1__state: [Ref]int;

implementation CILRepository.Controllers.AccountController.Manage$CILRepository.Models.ManageUserViewModel($this: Ref, model$in: Ref) returns ($result: Ref)
{
  var model: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_1_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    model := model$in;
    assume {:breadcrumb 264} true;
    call $tmp0 := Alloc();
    call CILRepository.Controllers.AccountController.$Manage$d__2e.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$CILRepository.Controllers.AccountController.$Manage$d__2e();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CILRepository.Controllers.AccountController.$Manage$d__2e;
    local_0_Ref := $tmp0;
    F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$4__this[local_0_Ref] := $this;
    F$CILRepository.Controllers.AccountController.$Manage$d__2e.model[local_0_Ref] := model;
    call $tmp1 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Create(Microsoft.Cci.DummyTypeReference());
    F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$t__builder[local_0_Ref] := $tmp1;
    F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$1__state[local_0_Ref] := -1;
    assume local_0_Ref != null;
    $tmp2 := F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$t__builder[local_0_Ref];
    call local_0_Ref := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Start``1$``0$($tmp2, local_0_Ref, T$CILRepository.Controllers.AccountController.$Manage$d__2e());
    assume local_0_Ref != null;
    $tmp3 := F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$t__builder[local_0_Ref];
    call $tmp4 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.get_Task($tmp3);
    local_1_Ref := $tmp4;
    goto IL_0044;

  IL_0044:
    $result := local_1_Ref;
    return;
}



procedure {:System.Web.Mvc.HttpPost} {:System.Web.Mvc.ValidateAntiForgeryToken} {:System.Web.Mvc.AllowAnonymous} CILRepository.Controllers.AccountController.ExternalLogin$System.String$System.String($this: Ref, provider$in: Ref, returnUrl$in: Ref) returns ($result: Ref);



procedure {:System.Runtime.CompilerServices.AsyncStateMachine} {:System.Diagnostics.DebuggerStepThrough} {:System.Web.Mvc.AllowAnonymous} CILRepository.Controllers.AccountController.ExternalLoginCallback$System.String($this: Ref, returnUrl$in: Ref) returns ($result: Ref);



procedure CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.#default_ctor($this: Ref);



function T$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34() : Ref;

const unique T$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34: int;

var F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$4__this: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.returnUrl: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$t__builder: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$1__state: [Ref]int;

implementation CILRepository.Controllers.AccountController.ExternalLoginCallback$System.String($this: Ref, returnUrl$in: Ref) returns ($result: Ref)
{
  var returnUrl: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_1_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    returnUrl := returnUrl$in;
    assume {:breadcrumb 266} true;
    call $tmp0 := Alloc();
    call CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34;
    local_0_Ref := $tmp0;
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$4__this[local_0_Ref] := $this;
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.returnUrl[local_0_Ref] := returnUrl;
    call $tmp1 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Create(Microsoft.Cci.DummyTypeReference());
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$t__builder[local_0_Ref] := $tmp1;
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$1__state[local_0_Ref] := -1;
    assume local_0_Ref != null;
    $tmp2 := F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$t__builder[local_0_Ref];
    call local_0_Ref := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Start``1$``0$($tmp2, local_0_Ref, T$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34());
    assume local_0_Ref != null;
    $tmp3 := F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$t__builder[local_0_Ref];
    call $tmp4 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.get_Task($tmp3);
    local_1_Ref := $tmp4;
    goto IL_0044;

  IL_0044:
    $result := local_1_Ref;
    return;
}



procedure {:System.Web.Mvc.HttpPost} {:System.Web.Mvc.ValidateAntiForgeryToken} CILRepository.Controllers.AccountController.LinkLogin$System.String($this: Ref, provider$in: Ref) returns ($result: Ref);



procedure {:System.Runtime.CompilerServices.AsyncStateMachine} {:System.Diagnostics.DebuggerStepThrough} CILRepository.Controllers.AccountController.LinkLoginCallback($this: Ref) returns ($result: Ref);



procedure CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.#default_ctor($this: Ref);



function T$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b() : Ref;

const unique T$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b: int;

var F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$4__this: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$t__builder: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$1__state: [Ref]int;

implementation CILRepository.Controllers.AccountController.LinkLoginCallback($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_1_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 268} true;
    call $tmp0 := Alloc();
    call CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b;
    local_0_Ref := $tmp0;
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$4__this[local_0_Ref] := $this;
    call $tmp1 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Create(Microsoft.Cci.DummyTypeReference());
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$t__builder[local_0_Ref] := $tmp1;
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$1__state[local_0_Ref] := -1;
    assume local_0_Ref != null;
    $tmp2 := F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$t__builder[local_0_Ref];
    call local_0_Ref := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Start``1$``0$($tmp2, local_0_Ref, T$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b());
    assume local_0_Ref != null;
    $tmp3 := F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$t__builder[local_0_Ref];
    call $tmp4 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.get_Task($tmp3);
    local_1_Ref := $tmp4;
    goto IL_003c;

  IL_003c:
    $result := local_1_Ref;
    return;
}



procedure {:System.Web.Mvc.AllowAnonymous} {:System.Web.Mvc.HttpPost} {:System.Diagnostics.DebuggerStepThrough} {:System.Web.Mvc.ValidateAntiForgeryToken} {:System.Runtime.CompilerServices.AsyncStateMachine} CILRepository.Controllers.AccountController.ExternalLoginConfirmation$CILRepository.Models.ExternalLoginConfirmationViewModel$System.String($this: Ref, model$in: Ref, returnUrl$in: Ref) returns ($result: Ref);



procedure CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.#default_ctor($this: Ref);



function T$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44() : Ref;

const unique T$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44: int;

var F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$4__this: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.model: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.returnUrl: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$t__builder: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$1__state: [Ref]int;

implementation CILRepository.Controllers.AccountController.ExternalLoginConfirmation$CILRepository.Models.ExternalLoginConfirmationViewModel$System.String($this: Ref, model$in: Ref, returnUrl$in: Ref) returns ($result: Ref)
{
  var model: Ref;
  var returnUrl: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_1_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    model := model$in;
    returnUrl := returnUrl$in;
    assume {:breadcrumb 269} true;
    call $tmp0 := Alloc();
    call CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44;
    local_0_Ref := $tmp0;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$4__this[local_0_Ref] := $this;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.model[local_0_Ref] := model;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.returnUrl[local_0_Ref] := returnUrl;
    call $tmp1 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Create(Microsoft.Cci.DummyTypeReference());
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$t__builder[local_0_Ref] := $tmp1;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$1__state[local_0_Ref] := -1;
    assume local_0_Ref != null;
    $tmp2 := F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$t__builder[local_0_Ref];
    call local_0_Ref := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.Start``1$``0$($tmp2, local_0_Ref, T$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44());
    assume local_0_Ref != null;
    $tmp3 := F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$t__builder[local_0_Ref];
    call $tmp4 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.get_Task($tmp3);
    local_1_Ref := $tmp4;
    goto IL_004c;

  IL_004c:
    $result := local_1_Ref;
    return;
}



procedure {:System.Web.Mvc.ValidateAntiForgeryToken} {:System.Web.Mvc.HttpPost} CILRepository.Controllers.AccountController.LogOff($this: Ref) returns ($result: Ref);



procedure {:System.Web.Mvc.AllowAnonymous} CILRepository.Controllers.AccountController.ExternalLoginFailure($this: Ref) returns ($result: Ref);



procedure {:System.Web.Mvc.ChildActionOnly} CILRepository.Controllers.AccountController.RemoveAccountList($this: Ref) returns ($result: Ref);



procedure CILRepository.Controllers.AccountController.Dispose$System.Boolean($this: Ref, disposing$in: bool);



procedure CILRepository.Controllers.AccountController.get_AuthenticationManager($this: Ref) returns ($result: Ref);



procedure {:System.Runtime.CompilerServices.AsyncStateMachine} {:System.Diagnostics.DebuggerStepThrough} CILRepository.Controllers.AccountController.SignInAsync$CILRepository.Models.ApplicationUser$System.Boolean($this: Ref, user$in: Ref, isPersistent$in: bool) returns ($result: Ref);



procedure CILRepository.Controllers.AccountController.$SignInAsync$d__4f.#default_ctor($this: Ref);



function T$CILRepository.Controllers.AccountController.$SignInAsync$d__4f() : Ref;

const unique T$CILRepository.Controllers.AccountController.$SignInAsync$d__4f: int;

var F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$4__this: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.user: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.isPersistent: [Ref]bool;

procedure {:extern} System.Runtime.CompilerServices.AsyncTaskMethodBuilder.Create() returns ($result: Ref);



var F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$t__builder: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$1__state: [Ref]int;

procedure {:extern} System.Runtime.CompilerServices.AsyncTaskMethodBuilder.Start``1$``0$($this: Ref, stateMachine$in: Ref, TStateMachine: Ref) returns (stateMachine$out: Ref);



procedure {:extern} System.Runtime.CompilerServices.AsyncTaskMethodBuilder.get_Task($this: Ref) returns ($result: Ref);



implementation CILRepository.Controllers.AccountController.SignInAsync$CILRepository.Models.ApplicationUser$System.Boolean($this: Ref, user$in: Ref, isPersistent$in: bool) returns ($result: Ref)
{
  var user: Ref;
  var isPersistent: bool;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_1_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    user := user$in;
    isPersistent := isPersistent$in;
    assume {:breadcrumb 277} true;
    call $tmp0 := Alloc();
    call CILRepository.Controllers.AccountController.$SignInAsync$d__4f.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$CILRepository.Controllers.AccountController.$SignInAsync$d__4f();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CILRepository.Controllers.AccountController.$SignInAsync$d__4f;
    local_0_Ref := $tmp0;
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$4__this[local_0_Ref] := $this;
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.user[local_0_Ref] := user;
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.isPersistent[local_0_Ref] := isPersistent;
    call $tmp1 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder.Create();
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$t__builder[local_0_Ref] := $tmp1;
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$1__state[local_0_Ref] := -1;
    assume local_0_Ref != null;
    $tmp2 := F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$t__builder[local_0_Ref];
    call local_0_Ref := System.Runtime.CompilerServices.AsyncTaskMethodBuilder.Start``1$``0$($tmp2, local_0_Ref, T$CILRepository.Controllers.AccountController.$SignInAsync$d__4f());
    assume local_0_Ref != null;
    $tmp3 := F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$t__builder[local_0_Ref];
    call $tmp4 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder.get_Task($tmp3);
    local_1_Ref := $tmp4;
    goto IL_004c;

  IL_004c:
    $result := local_1_Ref;
    return;
}



procedure CILRepository.Controllers.AccountController.AddErrors$Microsoft.AspNet.Identity.IdentityResult($this: Ref, result$in: Ref);



procedure CILRepository.Controllers.AccountController.HasPassword($this: Ref) returns ($result: bool);



procedure CILRepository.Controllers.AccountController.RedirectToLocal$System.String($this: Ref, returnUrl$in: Ref) returns ($result: Ref);



function T$CILRepository.Controllers.AccountController.ChallengeResult() : Ref;

const unique T$CILRepository.Controllers.AccountController.ChallengeResult: int;

var F$CILRepository.Controllers.AccountController.ChallengeResult.$LoginProvider$k__BackingField: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.ChallengeResult.$RedirectUri$k__BackingField: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.ChallengeResult.$UserId$k__BackingField: [Ref]Ref;

procedure CILRepository.Controllers.AccountController.ChallengeResult.#ctor$System.String$System.String($this: Ref, provider$in: Ref, redirectUri$in: Ref);



procedure CILRepository.Controllers.AccountController.ChallengeResult.#ctor$System.String$System.String$System.String($this: Ref, provider$in: Ref, redirectUri$in: Ref, userId$in: Ref);



implementation CILRepository.Controllers.AccountController.ChallengeResult.#ctor$System.String$System.String($this: Ref, provider$in: Ref, redirectUri$in: Ref)
{
  var provider: Ref;
  var redirectUri: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    provider := provider$in;
    redirectUri := redirectUri$in;
    assume {:breadcrumb 283} true;
    call CILRepository.Controllers.AccountController.ChallengeResult.#ctor$System.String$System.String$System.String($this, provider, redirectUri, null);
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Controllers.AccountController.ChallengeResult.get_LoginProvider($this: Ref) returns ($result: Ref);



implementation CILRepository.Controllers.AccountController.ChallengeResult.get_LoginProvider($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 285} true;
    assume $this != null;
    local_0_Ref := F$CILRepository.Controllers.AccountController.ChallengeResult.$LoginProvider$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Controllers.AccountController.ChallengeResult.set_LoginProvider$System.String($this: Ref, value$in: Ref);



implementation CILRepository.Controllers.AccountController.ChallengeResult.set_LoginProvider$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 286} true;
    F$CILRepository.Controllers.AccountController.ChallengeResult.$LoginProvider$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Controllers.AccountController.ChallengeResult.get_RedirectUri($this: Ref) returns ($result: Ref);



implementation CILRepository.Controllers.AccountController.ChallengeResult.get_RedirectUri($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 287} true;
    assume $this != null;
    local_0_Ref := F$CILRepository.Controllers.AccountController.ChallengeResult.$RedirectUri$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Controllers.AccountController.ChallengeResult.set_RedirectUri$System.String($this: Ref, value$in: Ref);



implementation CILRepository.Controllers.AccountController.ChallengeResult.set_RedirectUri$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 288} true;
    F$CILRepository.Controllers.AccountController.ChallengeResult.$RedirectUri$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Controllers.AccountController.ChallengeResult.get_UserId($this: Ref) returns ($result: Ref);



implementation CILRepository.Controllers.AccountController.ChallengeResult.get_UserId($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 289} true;
    assume $this != null;
    local_0_Ref := F$CILRepository.Controllers.AccountController.ChallengeResult.$UserId$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} CILRepository.Controllers.AccountController.ChallengeResult.set_UserId$System.String($this: Ref, value$in: Ref);



implementation CILRepository.Controllers.AccountController.ChallengeResult.set_UserId$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 290} true;
    F$CILRepository.Controllers.AccountController.ChallengeResult.$UserId$k__BackingField[$this] := value;
    return;
}



procedure CILRepository.Controllers.AccountController.ChallengeResult.ExecuteResult$System.Web.Mvc.ControllerContext($this: Ref, context$in: Ref);



procedure T$CILRepository.Controllers.AccountController.ChallengeResult.#cctor();



implementation T$CILRepository.Controllers.AccountController.ChallengeResult.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.Controllers.AccountController.$DllHandle$o__SiteContainer0() : Ref;

const unique T$CILRepository.Controllers.AccountController.$DllHandle$o__SiteContainer0: int;

procedure T$CILRepository.Controllers.AccountController.$DllHandle$o__SiteContainer0.#cctor();



implementation T$CILRepository.Controllers.AccountController.$DllHandle$o__SiteContainer0.#cctor()
{

  anon0:
    F$CILRepository.Controllers.AccountController.$DllHandle$o__SiteContainer0.$$p__Site1 := null;
    return;
}



function T$CILRepository.Controllers.AccountController.$DepHandle$o__SiteContainer2() : Ref;

const unique T$CILRepository.Controllers.AccountController.$DepHandle$o__SiteContainer2: int;

procedure T$CILRepository.Controllers.AccountController.$DepHandle$o__SiteContainer2.#cctor();



implementation T$CILRepository.Controllers.AccountController.$DepHandle$o__SiteContainer2.#cctor()
{

  anon0:
    F$CILRepository.Controllers.AccountController.$DepHandle$o__SiteContainer2.$$p__Site3 := null;
    return;
}



function T$CILRepository.Controllers.AccountController.$DownloadMethodRecord$o__SiteContainer4() : Ref;

const unique T$CILRepository.Controllers.AccountController.$DownloadMethodRecord$o__SiteContainer4: int;

procedure T$CILRepository.Controllers.AccountController.$DownloadMethodRecord$o__SiteContainer4.#cctor();



implementation T$CILRepository.Controllers.AccountController.$DownloadMethodRecord$o__SiteContainer4.#cctor()
{

  anon0:
    F$CILRepository.Controllers.AccountController.$DownloadMethodRecord$o__SiteContainer4.$$p__Site5 := null;
    return;
}



function T$CILRepository.Controllers.AccountController.$Login$o__SiteContainer6() : Ref;

const unique T$CILRepository.Controllers.AccountController.$Login$o__SiteContainer6: int;

procedure T$CILRepository.Controllers.AccountController.$Login$o__SiteContainer6.#cctor();



implementation T$CILRepository.Controllers.AccountController.$Login$o__SiteContainer6.#cctor()
{

  anon0:
    F$CILRepository.Controllers.AccountController.$Login$o__SiteContainer6.$$p__Site7 := null;
    return;
}



function T$CILRepository.Controllers.AccountController.$MSLoginCallback$o__SiteContainer8() : Ref;

const unique T$CILRepository.Controllers.AccountController.$MSLoginCallback$o__SiteContainer8: int;

var F$CILRepository.Controllers.AccountController.$MSLoginCallback$o__SiteContainer8.$$p__Site9: Ref;

var F$CILRepository.Controllers.AccountController.$MSLoginCallback$o__SiteContainer8.$$p__Sitea: Ref;

procedure T$CILRepository.Controllers.AccountController.$MSLoginCallback$o__SiteContainer8.#cctor();



implementation T$CILRepository.Controllers.AccountController.$MSLoginCallback$o__SiteContainer8.#cctor()
{

  anon0:
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$o__SiteContainer8.$$p__Site9 := null;
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$o__SiteContainer8.$$p__Sitea := null;
    return;
}



procedure System.Runtime.CompilerServices.AsyncTaskMethodBuilder$System.Web.Mvc.ActionResult$.#default_ctor($this: Ref);



function {:extern} TResult$T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1(parent: Ref) : Ref;

function {:extern} T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1(TResult: Ref) : Ref;

const {:extern} unique T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1: int;

var F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$r$5__c: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$userID$5__d: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$user$5__e: [Ref]Ref;

procedure System.Runtime.CompilerServices.TaskAwaiter$CILRepository.Models.ApplicationUser$.#default_ctor($this: Ref);



function {:extern} TResult$T$System.Runtime.CompilerServices.TaskAwaiter`1(parent: Ref) : Ref;

function {:extern} T$System.Runtime.CompilerServices.TaskAwaiter`1(TResult: Ref) : Ref;

const {:extern} unique T$System.Runtime.CompilerServices.TaskAwaiter`1: int;

var F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$u__$awaiterf: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$t__stack: [Ref]Ref;

procedure System.Runtime.CompilerServices.TaskAwaiter.#default_ctor($this: Ref);



function {:extern} T$System.Runtime.CompilerServices.TaskAwaiter() : Ref;

const {:extern} unique T$System.Runtime.CompilerServices.TaskAwaiter: int;

axiom $TypeConstructor(T$System.Runtime.CompilerServices.TaskAwaiter()) == T$System.Runtime.CompilerServices.TaskAwaiter;

var F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$u__$awaiter10: [Ref]Ref;

implementation {:inline 1} CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.#default_ctor($this: Ref)
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;

  anon0:
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$1__state[$this] := 0;
    call $tmp0 := Alloc();
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder$System.Web.Mvc.ActionResult$.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1;
    assume TResult$T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1($DynamicType($tmp0)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$t__builder[$this] := $tmp0;
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$4__this[$this] := null;
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.code[$this] := null;
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$r$5__c[$this] := null;
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$userID$5__d[$this] := null;
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$user$5__e[$this] := null;
    call $tmp1 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter$CILRepository.Models.ApplicationUser$.#default_ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Runtime.CompilerServices.TaskAwaiter`1(T$CILRepository.Models.ApplicationUser());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Runtime.CompilerServices.TaskAwaiter`1;
    assume TResult$T$System.Runtime.CompilerServices.TaskAwaiter`1($DynamicType($tmp1)) == T$CILRepository.Models.ApplicationUser();
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$u__$awaiterf[$this] := $tmp1;
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$t__stack[$this] := null;
    call $tmp2 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter.#default_ctor($tmp2);
    assume $DynamicType($tmp2) == T$System.Runtime.CompilerServices.TaskAwaiter();
    assume $TypeConstructor($DynamicType($tmp2)) == T$System.Runtime.CompilerServices.TaskAwaiter;
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$u__$awaiter10[$this] := $tmp2;
    return;
}



procedure CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



procedure System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



implementation {:inline 1} CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.#copy_ctor(this: Ref) returns (other: Ref)
{
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;

  anon0:
    call other := Alloc();
    assume $DynamicType(other) == $DynamicType(this);
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$1__state[other] := F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$1__state[this];
    call $tmp3 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder.#copy_ctor(F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$t__builder[this]);
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$t__builder[other] := $tmp3;
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$4__this[other] := F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$4__this[this];
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.code[other] := F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.code[this];
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$r$5__c[other] := F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$r$5__c[this];
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$userID$5__d[other] := F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$userID$5__d[this];
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$user$5__e[other] := F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$user$5__e[this];
    call $tmp4 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$u__$awaiterf[this]);
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$u__$awaiterf[other] := $tmp4;
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$t__stack[other] := F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$t__stack[this];
    call $tmp5 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$u__$awaiter10[this]);
    F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$u__$awaiter10[other] := $tmp5;
    return;
}



procedure CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.MoveNext($this: Ref);



procedure {:System.Diagnostics.DebuggerHidden} CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref);



procedure {:extern} System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, stateMachine$in: Ref);



implementation CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref)
{
  var param0: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    param0 := param0$in;
    assume {:breadcrumb 295} true;
    assume $this != null;
    $tmp0 := F$CILRepository.Controllers.AccountController.$MSLoginCallback$d__b.$$t__builder[$this];
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($tmp0, param0);
    return;
}



var F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$user$5__14: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$result$5__15: [Ref]bool;

var F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$g__initLocal12: [Ref]Ref;

procedure System.Runtime.CompilerServices.TaskAwaiter$Microsoft.AspNet.Identity.IdentityResult$.#default_ctor($this: Ref);



var F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$u__$awaiter16: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$t__stack: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$u__$awaiter17: [Ref]Ref;

implementation {:inline 1} CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.#default_ctor($this: Ref)
{
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;

  anon0:
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$1__state[$this] := 0;
    call $tmp1 := Alloc();
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder$System.Web.Mvc.ActionResult$.#default_ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1;
    assume TResult$T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1($DynamicType($tmp1)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$t__builder[$this] := $tmp1;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$4__this[$this] := null;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.model[$this] := null;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.name[$this] := null;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.token[$this] := null;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$user$5__14[$this] := null;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$result$5__15[$this] := null;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$g__initLocal12[$this] := null;
    call $tmp2 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter$Microsoft.AspNet.Identity.IdentityResult$.#default_ctor($tmp2);
    assume $DynamicType($tmp2) == T$System.Runtime.CompilerServices.TaskAwaiter`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp2)) == T$System.Runtime.CompilerServices.TaskAwaiter`1;
    assume TResult$T$System.Runtime.CompilerServices.TaskAwaiter`1($DynamicType($tmp2)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$u__$awaiter16[$this] := $tmp2;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$t__stack[$this] := null;
    call $tmp3 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter.#default_ctor($tmp3);
    assume $DynamicType($tmp3) == T$System.Runtime.CompilerServices.TaskAwaiter();
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Runtime.CompilerServices.TaskAwaiter;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$u__$awaiter17[$this] := $tmp3;
    return;
}



procedure CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



implementation {:inline 1} CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.#copy_ctor(this: Ref) returns (other: Ref)
{
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;

  anon0:
    call other := Alloc();
    assume $DynamicType(other) == $DynamicType(this);
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$1__state[other] := F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$1__state[this];
    call $tmp4 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder.#copy_ctor(F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$t__builder[this]);
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$t__builder[other] := $tmp4;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$4__this[other] := F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$4__this[this];
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.model[other] := F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.model[this];
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.name[other] := F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.name[this];
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.token[other] := F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.token[this];
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$user$5__14[other] := F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$user$5__14[this];
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$result$5__15[other] := F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$result$5__15[this];
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$g__initLocal12[other] := F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$g__initLocal12[this];
    call $tmp5 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$u__$awaiter16[this]);
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$u__$awaiter16[other] := $tmp5;
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$t__stack[other] := F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$t__stack[this];
    call $tmp6 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$u__$awaiter17[this]);
    F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$u__$awaiter17[other] := $tmp6;
    return;
}



procedure CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.MoveNext($this: Ref);



procedure {:System.Diagnostics.DebuggerHidden} CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref);



implementation CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref)
{
  var param0: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    param0 := param0$in;
    assume {:breadcrumb 297} true;
    assume $this != null;
    $tmp0 := F$CILRepository.Controllers.AccountController.$MSLoginConfirmation$d__13.$$t__builder[$this];
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($tmp0, param0);
    return;
}



implementation {:inline 1} CILRepository.Controllers.AccountController.$Login$d__19.#default_ctor($this: Ref)
{
  var $tmp1: Ref;

  anon0:
    F$CILRepository.Controllers.AccountController.$Login$d__19.$$1__state[$this] := 0;
    call $tmp1 := Alloc();
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder$System.Web.Mvc.ActionResult$.#default_ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1;
    assume TResult$T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1($DynamicType($tmp1)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$Login$d__19.$$t__builder[$this] := $tmp1;
    F$CILRepository.Controllers.AccountController.$Login$d__19.$$4__this[$this] := null;
    F$CILRepository.Controllers.AccountController.$Login$d__19.model[$this] := null;
    F$CILRepository.Controllers.AccountController.$Login$d__19.returnUrl[$this] := null;
    return;
}



procedure CILRepository.Controllers.AccountController.$Login$d__19.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



implementation {:inline 1} CILRepository.Controllers.AccountController.$Login$d__19.#copy_ctor(this: Ref) returns (other: Ref)
{
  var $tmp2: Ref;

  anon0:
    call other := Alloc();
    assume $DynamicType(other) == $DynamicType(this);
    F$CILRepository.Controllers.AccountController.$Login$d__19.$$1__state[other] := F$CILRepository.Controllers.AccountController.$Login$d__19.$$1__state[this];
    call $tmp2 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder.#copy_ctor(F$CILRepository.Controllers.AccountController.$Login$d__19.$$t__builder[this]);
    F$CILRepository.Controllers.AccountController.$Login$d__19.$$t__builder[other] := $tmp2;
    F$CILRepository.Controllers.AccountController.$Login$d__19.$$4__this[other] := F$CILRepository.Controllers.AccountController.$Login$d__19.$$4__this[this];
    F$CILRepository.Controllers.AccountController.$Login$d__19.model[other] := F$CILRepository.Controllers.AccountController.$Login$d__19.model[this];
    F$CILRepository.Controllers.AccountController.$Login$d__19.returnUrl[other] := F$CILRepository.Controllers.AccountController.$Login$d__19.returnUrl[this];
    return;
}



procedure CILRepository.Controllers.AccountController.$Login$d__19.MoveNext($this: Ref);



procedure {:System.Diagnostics.DebuggerHidden} CILRepository.Controllers.AccountController.$Login$d__19.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref);



implementation CILRepository.Controllers.AccountController.$Login$d__19.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref)
{
  var param0: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    param0 := param0$in;
    assume {:breadcrumb 301} true;
    assume $this != null;
    $tmp0 := F$CILRepository.Controllers.AccountController.$Login$d__19.$$t__builder[$this];
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($tmp0, param0);
    return;
}



var F$CILRepository.Controllers.AccountController.$Register$d__1c.$user$5__1d: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Register$d__1c.$result$5__1e: [Ref]bool;

var F$CILRepository.Controllers.AccountController.$Register$d__1c.$$g__initLocal1b: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Register$d__1c.$$u__$awaiter1f: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Register$d__1c.$$t__stack: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Register$d__1c.$$u__$awaiter20: [Ref]Ref;

implementation {:inline 1} CILRepository.Controllers.AccountController.$Register$d__1c.#default_ctor($this: Ref)
{
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;

  anon0:
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$1__state[$this] := 0;
    call $tmp1 := Alloc();
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder$System.Web.Mvc.ActionResult$.#default_ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1;
    assume TResult$T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1($DynamicType($tmp1)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$t__builder[$this] := $tmp1;
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$4__this[$this] := null;
    F$CILRepository.Controllers.AccountController.$Register$d__1c.model[$this] := null;
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$user$5__1d[$this] := null;
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$result$5__1e[$this] := null;
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$g__initLocal1b[$this] := null;
    call $tmp2 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter$Microsoft.AspNet.Identity.IdentityResult$.#default_ctor($tmp2);
    assume $DynamicType($tmp2) == T$System.Runtime.CompilerServices.TaskAwaiter`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp2)) == T$System.Runtime.CompilerServices.TaskAwaiter`1;
    assume TResult$T$System.Runtime.CompilerServices.TaskAwaiter`1($DynamicType($tmp2)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$u__$awaiter1f[$this] := $tmp2;
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$t__stack[$this] := null;
    call $tmp3 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter.#default_ctor($tmp3);
    assume $DynamicType($tmp3) == T$System.Runtime.CompilerServices.TaskAwaiter();
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Runtime.CompilerServices.TaskAwaiter;
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$u__$awaiter20[$this] := $tmp3;
    return;
}



procedure CILRepository.Controllers.AccountController.$Register$d__1c.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



implementation {:inline 1} CILRepository.Controllers.AccountController.$Register$d__1c.#copy_ctor(this: Ref) returns (other: Ref)
{
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;

  anon0:
    call other := Alloc();
    assume $DynamicType(other) == $DynamicType(this);
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$1__state[other] := F$CILRepository.Controllers.AccountController.$Register$d__1c.$$1__state[this];
    call $tmp4 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder.#copy_ctor(F$CILRepository.Controllers.AccountController.$Register$d__1c.$$t__builder[this]);
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$t__builder[other] := $tmp4;
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$4__this[other] := F$CILRepository.Controllers.AccountController.$Register$d__1c.$$4__this[this];
    F$CILRepository.Controllers.AccountController.$Register$d__1c.model[other] := F$CILRepository.Controllers.AccountController.$Register$d__1c.model[this];
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$user$5__1d[other] := F$CILRepository.Controllers.AccountController.$Register$d__1c.$user$5__1d[this];
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$result$5__1e[other] := F$CILRepository.Controllers.AccountController.$Register$d__1c.$result$5__1e[this];
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$g__initLocal1b[other] := F$CILRepository.Controllers.AccountController.$Register$d__1c.$$g__initLocal1b[this];
    call $tmp5 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$Register$d__1c.$$u__$awaiter1f[this]);
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$u__$awaiter1f[other] := $tmp5;
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$t__stack[other] := F$CILRepository.Controllers.AccountController.$Register$d__1c.$$t__stack[this];
    call $tmp6 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$Register$d__1c.$$u__$awaiter20[this]);
    F$CILRepository.Controllers.AccountController.$Register$d__1c.$$u__$awaiter20[other] := $tmp6;
    return;
}



procedure CILRepository.Controllers.AccountController.$Register$d__1c.MoveNext($this: Ref);



procedure {:System.Diagnostics.DebuggerHidden} CILRepository.Controllers.AccountController.$Register$d__1c.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref);



implementation CILRepository.Controllers.AccountController.$Register$d__1c.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref)
{
  var param0: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    param0 := param0$in;
    assume {:breadcrumb 305} true;
    assume $this != null;
    $tmp0 := F$CILRepository.Controllers.AccountController.$Register$d__1c.$$t__builder[$this];
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($tmp0, param0);
    return;
}



var F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$message$5__23: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$result$5__24: [Ref]bool;

var F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$u__$awaiter25: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$t__stack: [Ref]Ref;

implementation {:inline 1} CILRepository.Controllers.AccountController.$Disassociate$d__22.#default_ctor($this: Ref)
{
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;

  anon0:
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$1__state[$this] := 0;
    call $tmp1 := Alloc();
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder$System.Web.Mvc.ActionResult$.#default_ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1;
    assume TResult$T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1($DynamicType($tmp1)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$t__builder[$this] := $tmp1;
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$4__this[$this] := null;
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.loginProvider[$this] := null;
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.providerKey[$this] := null;
    call $tmp2 := Alloc();
    call System.Nullable$CILRepository.Controllers.AccountController.ManageMessageId$.#default_ctor($tmp2);
    assume $DynamicType($tmp2) == T$System.Nullable`1(T$CILRepository.Controllers.AccountController.ManageMessageId());
    assume $TypeConstructor($DynamicType($tmp2)) == T$System.Nullable`1;
    assume T$T$System.Nullable`1($DynamicType($tmp2)) == T$CILRepository.Controllers.AccountController.ManageMessageId();
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$message$5__23[$this] := $tmp2;
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$result$5__24[$this] := null;
    call $tmp3 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter$Microsoft.AspNet.Identity.IdentityResult$.#default_ctor($tmp3);
    assume $DynamicType($tmp3) == T$System.Runtime.CompilerServices.TaskAwaiter`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Runtime.CompilerServices.TaskAwaiter`1;
    assume TResult$T$System.Runtime.CompilerServices.TaskAwaiter`1($DynamicType($tmp3)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$u__$awaiter25[$this] := $tmp3;
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$t__stack[$this] := null;
    return;
}



procedure CILRepository.Controllers.AccountController.$Disassociate$d__22.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



implementation {:inline 1} CILRepository.Controllers.AccountController.$Disassociate$d__22.#copy_ctor(this: Ref) returns (other: Ref)
{
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;

  anon0:
    call other := Alloc();
    assume $DynamicType(other) == $DynamicType(this);
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$1__state[other] := F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$1__state[this];
    call $tmp4 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder.#copy_ctor(F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$t__builder[this]);
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$t__builder[other] := $tmp4;
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$4__this[other] := F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$4__this[this];
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.loginProvider[other] := F$CILRepository.Controllers.AccountController.$Disassociate$d__22.loginProvider[this];
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.providerKey[other] := F$CILRepository.Controllers.AccountController.$Disassociate$d__22.providerKey[this];
    call $tmp5 := System.Nullable.#copy_ctor(F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$message$5__23[this]);
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$message$5__23[other] := $tmp5;
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$result$5__24[other] := F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$result$5__24[this];
    call $tmp6 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$u__$awaiter25[this]);
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$u__$awaiter25[other] := $tmp6;
    F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$t__stack[other] := F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$t__stack[this];
    return;
}



procedure CILRepository.Controllers.AccountController.$Disassociate$d__22.MoveNext($this: Ref);



procedure {:System.Diagnostics.DebuggerHidden} CILRepository.Controllers.AccountController.$Disassociate$d__22.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref);



implementation CILRepository.Controllers.AccountController.$Disassociate$d__22.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref)
{
  var param0: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    param0 := param0$in;
    assume {:breadcrumb 311} true;
    assume $this != null;
    $tmp0 := F$CILRepository.Controllers.AccountController.$Disassociate$d__22.$$t__builder[$this];
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($tmp0, param0);
    return;
}



function T$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer27() : Ref;

const unique T$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer27: int;

var F$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer27.$$p__Site29: Ref;

var F$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer27.$$p__Site2a: Ref;

procedure T$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer27.#cctor();



implementation T$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer27.#cctor()
{

  anon0:
    F$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer27.$$p__Site28 := null;
    F$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer27.$$p__Site29 := null;
    F$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer27.$$p__Site2a := null;
    return;
}



function T$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer2b() : Ref;

const unique T$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer2b: int;

var F$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer2b.$$p__Site2c: Ref;

var F$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer2b.$$p__Site2d: Ref;

procedure T$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer2b.#cctor();



implementation T$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer2b.#cctor()
{

  anon0:
    F$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer2b.$$p__Site2c := null;
    F$CILRepository.Controllers.AccountController.$Manage$o__SiteContainer2b.$$p__Site2d := null;
    return;
}



implementation {:inline 1} CILRepository.Controllers.AccountController.$Manage$d__2e.#default_ctor($this: Ref)
{
  var $tmp1: Ref;

  anon0:
    F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$1__state[$this] := 0;
    call $tmp1 := Alloc();
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder$System.Web.Mvc.ActionResult$.#default_ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1;
    assume TResult$T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1($DynamicType($tmp1)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$t__builder[$this] := $tmp1;
    F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$4__this[$this] := null;
    F$CILRepository.Controllers.AccountController.$Manage$d__2e.model[$this] := null;
    return;
}



procedure CILRepository.Controllers.AccountController.$Manage$d__2e.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



implementation {:inline 1} CILRepository.Controllers.AccountController.$Manage$d__2e.#copy_ctor(this: Ref) returns (other: Ref)
{
  var $tmp2: Ref;

  anon0:
    call other := Alloc();
    assume $DynamicType(other) == $DynamicType(this);
    F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$1__state[other] := F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$1__state[this];
    call $tmp2 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder.#copy_ctor(F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$t__builder[this]);
    F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$t__builder[other] := $tmp2;
    F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$4__this[other] := F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$4__this[this];
    F$CILRepository.Controllers.AccountController.$Manage$d__2e.model[other] := F$CILRepository.Controllers.AccountController.$Manage$d__2e.model[this];
    return;
}



procedure CILRepository.Controllers.AccountController.$Manage$d__2e.MoveNext($this: Ref);



const {:value "HasLocalPassword"} unique $string_literal_HasLocalPassword_39: Ref;

function {:extern} T$System.Boolean() : Ref;

const {:extern} unique T$System.Boolean: int;

axiom $TypeConstructor(T$System.Boolean()) == T$System.Boolean;

procedure {:System.Diagnostics.DebuggerHidden} CILRepository.Controllers.AccountController.$Manage$d__2e.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref);



implementation CILRepository.Controllers.AccountController.$Manage$d__2e.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref)
{
  var param0: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    param0 := param0$in;
    assume {:breadcrumb 317} true;
    assume $this != null;
    $tmp0 := F$CILRepository.Controllers.AccountController.$Manage$d__2e.$$t__builder[$this];
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($tmp0, param0);
    return;
}



function T$CILRepository.Controllers.AccountController.$ExternalLoginCallback$o__SiteContainer31() : Ref;

const unique T$CILRepository.Controllers.AccountController.$ExternalLoginCallback$o__SiteContainer31: int;

var F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$o__SiteContainer31.$$p__Site32: Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$o__SiteContainer31.$$p__Site33: Ref;

procedure T$CILRepository.Controllers.AccountController.$ExternalLoginCallback$o__SiteContainer31.#cctor();



implementation T$CILRepository.Controllers.AccountController.$ExternalLoginCallback$o__SiteContainer31.#cctor()
{

  anon0:
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$o__SiteContainer31.$$p__Site32 := null;
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$o__SiteContainer31.$$p__Site33 := null;
    return;
}



var F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$loginInfo$5__35: [Ref]bool;

var F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$user$5__36: [Ref]Ref;

procedure System.Runtime.CompilerServices.TaskAwaiter$Microsoft.AspNet.Identity.Owin.ExternalLoginInfo$.#default_ctor($this: Ref);



var F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$u__$awaiter37: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$t__stack: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$u__$awaiter38: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$u__$awaiter39: [Ref]Ref;

implementation {:inline 1} CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.#default_ctor($this: Ref)
{
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;

  anon0:
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$1__state[$this] := 0;
    call $tmp1 := Alloc();
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder$System.Web.Mvc.ActionResult$.#default_ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1;
    assume TResult$T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1($DynamicType($tmp1)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$t__builder[$this] := $tmp1;
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$4__this[$this] := null;
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.returnUrl[$this] := null;
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$loginInfo$5__35[$this] := null;
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$user$5__36[$this] := null;
    call $tmp2 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter$Microsoft.AspNet.Identity.Owin.ExternalLoginInfo$.#default_ctor($tmp2);
    assume $DynamicType($tmp2) == T$System.Runtime.CompilerServices.TaskAwaiter`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp2)) == T$System.Runtime.CompilerServices.TaskAwaiter`1;
    assume TResult$T$System.Runtime.CompilerServices.TaskAwaiter`1($DynamicType($tmp2)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$u__$awaiter37[$this] := $tmp2;
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$t__stack[$this] := null;
    call $tmp3 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter$CILRepository.Models.ApplicationUser$.#default_ctor($tmp3);
    assume $DynamicType($tmp3) == T$System.Runtime.CompilerServices.TaskAwaiter`1(T$CILRepository.Models.ApplicationUser());
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Runtime.CompilerServices.TaskAwaiter`1;
    assume TResult$T$System.Runtime.CompilerServices.TaskAwaiter`1($DynamicType($tmp3)) == T$CILRepository.Models.ApplicationUser();
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$u__$awaiter38[$this] := $tmp3;
    call $tmp4 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter.#default_ctor($tmp4);
    assume $DynamicType($tmp4) == T$System.Runtime.CompilerServices.TaskAwaiter();
    assume $TypeConstructor($DynamicType($tmp4)) == T$System.Runtime.CompilerServices.TaskAwaiter;
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$u__$awaiter39[$this] := $tmp4;
    return;
}



procedure CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



implementation {:inline 1} CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.#copy_ctor(this: Ref) returns (other: Ref)
{
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;

  anon0:
    call other := Alloc();
    assume $DynamicType(other) == $DynamicType(this);
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$1__state[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$1__state[this];
    call $tmp5 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder.#copy_ctor(F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$t__builder[this]);
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$t__builder[other] := $tmp5;
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$4__this[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$4__this[this];
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.returnUrl[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.returnUrl[this];
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$loginInfo$5__35[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$loginInfo$5__35[this];
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$user$5__36[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$user$5__36[this];
    call $tmp6 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$u__$awaiter37[this]);
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$u__$awaiter37[other] := $tmp6;
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$t__stack[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$t__stack[this];
    call $tmp7 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$u__$awaiter38[this]);
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$u__$awaiter38[other] := $tmp7;
    call $tmp8 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$u__$awaiter39[this]);
    F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$u__$awaiter39[other] := $tmp8;
    return;
}



procedure CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.MoveNext($this: Ref);



procedure {:System.Diagnostics.DebuggerHidden} CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref);



implementation CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref)
{
  var param0: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    param0 := param0$in;
    assume {:breadcrumb 319} true;
    assume $this != null;
    $tmp0 := F$CILRepository.Controllers.AccountController.$ExternalLoginCallback$d__34.$$t__builder[$this];
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($tmp0, param0);
    return;
}



var F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$loginInfo$5__3c: [Ref]bool;

var F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$result$5__3d: [Ref]bool;

var F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$u__$awaiter3e: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$t__stack: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$u__$awaiter3f: [Ref]Ref;

implementation {:inline 1} CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.#default_ctor($this: Ref)
{
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;

  anon0:
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$1__state[$this] := 0;
    call $tmp1 := Alloc();
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder$System.Web.Mvc.ActionResult$.#default_ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1;
    assume TResult$T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1($DynamicType($tmp1)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$t__builder[$this] := $tmp1;
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$4__this[$this] := null;
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$loginInfo$5__3c[$this] := null;
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$result$5__3d[$this] := null;
    call $tmp2 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter$Microsoft.AspNet.Identity.Owin.ExternalLoginInfo$.#default_ctor($tmp2);
    assume $DynamicType($tmp2) == T$System.Runtime.CompilerServices.TaskAwaiter`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp2)) == T$System.Runtime.CompilerServices.TaskAwaiter`1;
    assume TResult$T$System.Runtime.CompilerServices.TaskAwaiter`1($DynamicType($tmp2)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$u__$awaiter3e[$this] := $tmp2;
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$t__stack[$this] := null;
    call $tmp3 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter$Microsoft.AspNet.Identity.IdentityResult$.#default_ctor($tmp3);
    assume $DynamicType($tmp3) == T$System.Runtime.CompilerServices.TaskAwaiter`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Runtime.CompilerServices.TaskAwaiter`1;
    assume TResult$T$System.Runtime.CompilerServices.TaskAwaiter`1($DynamicType($tmp3)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$u__$awaiter3f[$this] := $tmp3;
    return;
}



procedure CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



implementation {:inline 1} CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.#copy_ctor(this: Ref) returns (other: Ref)
{
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;

  anon0:
    call other := Alloc();
    assume $DynamicType(other) == $DynamicType(this);
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$1__state[other] := F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$1__state[this];
    call $tmp4 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder.#copy_ctor(F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$t__builder[this]);
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$t__builder[other] := $tmp4;
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$4__this[other] := F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$4__this[this];
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$loginInfo$5__3c[other] := F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$loginInfo$5__3c[this];
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$result$5__3d[other] := F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$result$5__3d[this];
    call $tmp5 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$u__$awaiter3e[this]);
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$u__$awaiter3e[other] := $tmp5;
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$t__stack[other] := F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$t__stack[this];
    call $tmp6 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$u__$awaiter3f[this]);
    F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$u__$awaiter3f[other] := $tmp6;
    return;
}



procedure CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.MoveNext($this: Ref);



procedure {:System.Diagnostics.DebuggerHidden} CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref);



implementation CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref)
{
  var param0: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    param0 := param0$in;
    assume {:breadcrumb 321} true;
    assume $this != null;
    $tmp0 := F$CILRepository.Controllers.AccountController.$LinkLoginCallback$d__3b.$$t__builder[$this];
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($tmp0, param0);
    return;
}



function T$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$o__SiteContainer42() : Ref;

const unique T$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$o__SiteContainer42: int;

var F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$o__SiteContainer42.$$p__Site43: Ref;

procedure T$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$o__SiteContainer42.#cctor();



implementation T$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$o__SiteContainer42.#cctor()
{

  anon0:
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$o__SiteContainer42.$$p__Site43 := null;
    return;
}



var F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$info$5__45: [Ref]bool;

var F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$user$5__46: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$result$5__47: [Ref]bool;

var F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$g__initLocal41: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$u__$awaiter48: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$t__stack: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$u__$awaiter49: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$u__$awaiter4a: [Ref]Ref;

implementation {:inline 1} CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.#default_ctor($this: Ref)
{
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;

  anon0:
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$1__state[$this] := 0;
    call $tmp1 := Alloc();
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder$System.Web.Mvc.ActionResult$.#default_ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1;
    assume TResult$T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1($DynamicType($tmp1)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$t__builder[$this] := $tmp1;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$4__this[$this] := null;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.model[$this] := null;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.returnUrl[$this] := null;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$info$5__45[$this] := null;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$user$5__46[$this] := null;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$result$5__47[$this] := null;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$g__initLocal41[$this] := null;
    call $tmp2 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter$Microsoft.AspNet.Identity.Owin.ExternalLoginInfo$.#default_ctor($tmp2);
    assume $DynamicType($tmp2) == T$System.Runtime.CompilerServices.TaskAwaiter`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp2)) == T$System.Runtime.CompilerServices.TaskAwaiter`1;
    assume TResult$T$System.Runtime.CompilerServices.TaskAwaiter`1($DynamicType($tmp2)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$u__$awaiter48[$this] := $tmp2;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$t__stack[$this] := null;
    call $tmp3 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter$Microsoft.AspNet.Identity.IdentityResult$.#default_ctor($tmp3);
    assume $DynamicType($tmp3) == T$System.Runtime.CompilerServices.TaskAwaiter`1(Microsoft.Cci.DummyTypeReference());
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Runtime.CompilerServices.TaskAwaiter`1;
    assume TResult$T$System.Runtime.CompilerServices.TaskAwaiter`1($DynamicType($tmp3)) == Microsoft.Cci.DummyTypeReference();
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$u__$awaiter49[$this] := $tmp3;
    call $tmp4 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter.#default_ctor($tmp4);
    assume $DynamicType($tmp4) == T$System.Runtime.CompilerServices.TaskAwaiter();
    assume $TypeConstructor($DynamicType($tmp4)) == T$System.Runtime.CompilerServices.TaskAwaiter;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$u__$awaiter4a[$this] := $tmp4;
    return;
}



procedure CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



implementation {:inline 1} CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.#copy_ctor(this: Ref) returns (other: Ref)
{
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;

  anon0:
    call other := Alloc();
    assume $DynamicType(other) == $DynamicType(this);
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$1__state[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$1__state[this];
    call $tmp5 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder.#copy_ctor(F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$t__builder[this]);
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$t__builder[other] := $tmp5;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$4__this[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$4__this[this];
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.model[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.model[this];
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.returnUrl[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.returnUrl[this];
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$info$5__45[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$info$5__45[this];
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$user$5__46[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$user$5__46[this];
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$result$5__47[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$result$5__47[this];
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$g__initLocal41[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$g__initLocal41[this];
    call $tmp6 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$u__$awaiter48[this]);
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$u__$awaiter48[other] := $tmp6;
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$t__stack[other] := F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$t__stack[this];
    call $tmp7 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$u__$awaiter49[this]);
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$u__$awaiter49[other] := $tmp7;
    call $tmp8 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$u__$awaiter4a[this]);
    F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$u__$awaiter4a[other] := $tmp8;
    return;
}



procedure CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.MoveNext($this: Ref);



procedure {:System.Diagnostics.DebuggerHidden} CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref);



implementation CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref)
{
  var param0: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    param0 := param0$in;
    assume {:breadcrumb 325} true;
    assume $this != null;
    $tmp0 := F$CILRepository.Controllers.AccountController.$ExternalLoginConfirmation$d__44.$$t__builder[$this];
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder`1.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($tmp0, param0);
    return;
}



function T$CILRepository.Controllers.AccountController.$RemoveAccountList$o__SiteContainer4c() : Ref;

const unique T$CILRepository.Controllers.AccountController.$RemoveAccountList$o__SiteContainer4c: int;

var F$CILRepository.Controllers.AccountController.$RemoveAccountList$o__SiteContainer4c.$$p__Site4d: Ref;

procedure T$CILRepository.Controllers.AccountController.$RemoveAccountList$o__SiteContainer4c.#cctor();



implementation T$CILRepository.Controllers.AccountController.$RemoveAccountList$o__SiteContainer4c.#cctor()
{

  anon0:
    F$CILRepository.Controllers.AccountController.$RemoveAccountList$o__SiteContainer4c.$$p__Site4d := null;
    return;
}



procedure System.Runtime.CompilerServices.AsyncTaskMethodBuilder.#default_ctor($this: Ref);



function {:extern} T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder() : Ref;

const {:extern} unique T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder: int;

axiom $TypeConstructor(T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder()) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder;

var F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$identity$5__50: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$g__initLocal4e: [Ref]bool;

procedure System.Runtime.CompilerServices.TaskAwaiter$System.Security.Claims.ClaimsIdentity$.#default_ctor($this: Ref);



function {:extern} T$System.Security.Claims.ClaimsIdentity() : Ref;

const {:extern} unique T$System.Security.Claims.ClaimsIdentity: int;

axiom $TypeConstructor(T$System.Security.Claims.ClaimsIdentity()) == T$System.Security.Claims.ClaimsIdentity;

var F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$u__$awaiter51: [Ref]Ref;

var F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$t__stack: [Ref]Ref;

implementation {:inline 1} CILRepository.Controllers.AccountController.$SignInAsync$d__4f.#default_ctor($this: Ref)
{
  var $tmp1: Ref;
  var $tmp2: Ref;

  anon0:
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$1__state[$this] := 0;
    call $tmp1 := Alloc();
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder.#default_ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder();
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Runtime.CompilerServices.AsyncTaskMethodBuilder;
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$t__builder[$this] := $tmp1;
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$4__this[$this] := null;
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.user[$this] := null;
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.isPersistent[$this] := false;
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$identity$5__50[$this] := null;
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$g__initLocal4e[$this] := null;
    call $tmp2 := Alloc();
    call System.Runtime.CompilerServices.TaskAwaiter$System.Security.Claims.ClaimsIdentity$.#default_ctor($tmp2);
    assume $DynamicType($tmp2) == T$System.Runtime.CompilerServices.TaskAwaiter`1(T$System.Security.Claims.ClaimsIdentity());
    assume $TypeConstructor($DynamicType($tmp2)) == T$System.Runtime.CompilerServices.TaskAwaiter`1;
    assume TResult$T$System.Runtime.CompilerServices.TaskAwaiter`1($DynamicType($tmp2)) == T$System.Security.Claims.ClaimsIdentity();
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$u__$awaiter51[$this] := $tmp2;
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$t__stack[$this] := null;
    return;
}



procedure CILRepository.Controllers.AccountController.$SignInAsync$d__4f.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



implementation {:inline 1} CILRepository.Controllers.AccountController.$SignInAsync$d__4f.#copy_ctor(this: Ref) returns (other: Ref)
{
  var $tmp3: Ref;
  var $tmp4: Ref;

  anon0:
    call other := Alloc();
    assume $DynamicType(other) == $DynamicType(this);
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$1__state[other] := F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$1__state[this];
    call $tmp3 := System.Runtime.CompilerServices.AsyncTaskMethodBuilder.#copy_ctor(F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$t__builder[this]);
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$t__builder[other] := $tmp3;
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$4__this[other] := F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$4__this[this];
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.user[other] := F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.user[this];
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.isPersistent[other] := F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.isPersistent[this];
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$identity$5__50[other] := F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$identity$5__50[this];
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$g__initLocal4e[other] := F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$g__initLocal4e[this];
    call $tmp4 := System.Runtime.CompilerServices.TaskAwaiter.#copy_ctor(F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$u__$awaiter51[this]);
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$u__$awaiter51[other] := $tmp4;
    F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$t__stack[other] := F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$t__stack[this];
    return;
}



procedure CILRepository.Controllers.AccountController.$SignInAsync$d__4f.MoveNext($this: Ref);



procedure {:System.Diagnostics.DebuggerHidden} CILRepository.Controllers.AccountController.$SignInAsync$d__4f.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref);



procedure {:extern} System.Runtime.CompilerServices.AsyncTaskMethodBuilder.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, stateMachine$in: Ref);



implementation CILRepository.Controllers.AccountController.$SignInAsync$d__4f.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($this: Ref, param0$in: Ref)
{
  var param0: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    param0 := param0$in;
    assume {:breadcrumb 331} true;
    assume $this != null;
    $tmp0 := F$CILRepository.Controllers.AccountController.$SignInAsync$d__4f.$$t__builder[$this];
    call System.Runtime.CompilerServices.AsyncTaskMethodBuilder.SetStateMachine$System.Runtime.CompilerServices.IAsyncStateMachine($tmp0, param0);
    return;
}



procedure T$CILRepository.Controllers.AccountController.#cctor();



implementation T$CILRepository.Controllers.AccountController.#cctor()
{

  anon0:
    F$CILRepository.Controllers.AccountController.XsrfKey := null;
    return;
}



function T$CILRepository.Controllers.HomeController() : Ref;

const unique T$CILRepository.Controllers.HomeController: int;

procedure CILRepository.Controllers.HomeController.Index($this: Ref) returns ($result: Ref);



procedure CILRepository.Controllers.HomeController.About($this: Ref) returns ($result: Ref);



var F$CILRepository.Controllers.HomeController.$About$o__SiteContainer0.$$p__Site1: Ref;

procedure CILRepository.Controllers.HomeController.Contact($this: Ref) returns ($result: Ref);



var F$CILRepository.Controllers.HomeController.$Contact$o__SiteContainer2.$$p__Site3: Ref;

procedure {:System.Web.Mvc.Authorize} CILRepository.Controllers.HomeController.Upload($this: Ref) returns ($result: Ref);



var F$CILRepository.Controllers.HomeController.$Upload$o__SiteContainer4.$$p__Site5: Ref;

procedure {:System.Web.Mvc.Authorize} CILRepository.Controllers.HomeController.Download($this: Ref) returns ($result: Ref);



var F$CILRepository.Controllers.HomeController.$Download$o__SiteContainer6.$$p__Site7: Ref;

procedure {:System.Web.Mvc.Authorize} CILRepository.Controllers.HomeController.DownloadToken($this: Ref) returns ($result: Ref);



var F$CILRepository.Controllers.HomeController.$DownloadToken$o__SiteContainer8.$$p__Site9: Ref;

procedure {:System.Web.Mvc.AllowAnonymous} CILRepository.Controllers.HomeController.DLLHandle$System.String$System.String($this: Ref, sha$in: Ref, token$in: Ref) returns ($result: Ref);



var F$CILRepository.Controllers.HomeController.$DLLHandle$o__SiteContainera.$$p__Siteb: Ref;

procedure {:System.Web.Mvc.AllowAnonymous} CILRepository.Controllers.HomeController.UploadDll$System.String$System.String($this: Ref, sha$in: Ref, token$in: Ref) returns ($result: Ref);



var F$CILRepository.Controllers.HomeController.$UploadDll$o__SiteContainerc.$$p__Sited: Ref;

procedure CILRepository.Controllers.HomeController.#ctor($this: Ref);



function T$CILRepository.Controllers.HomeController.$About$o__SiteContainer0() : Ref;

const unique T$CILRepository.Controllers.HomeController.$About$o__SiteContainer0: int;

procedure T$CILRepository.Controllers.HomeController.$About$o__SiteContainer0.#cctor();



implementation T$CILRepository.Controllers.HomeController.$About$o__SiteContainer0.#cctor()
{

  anon0:
    F$CILRepository.Controllers.HomeController.$About$o__SiteContainer0.$$p__Site1 := null;
    return;
}



function T$CILRepository.Controllers.HomeController.$Contact$o__SiteContainer2() : Ref;

const unique T$CILRepository.Controllers.HomeController.$Contact$o__SiteContainer2: int;

procedure T$CILRepository.Controllers.HomeController.$Contact$o__SiteContainer2.#cctor();



implementation T$CILRepository.Controllers.HomeController.$Contact$o__SiteContainer2.#cctor()
{

  anon0:
    F$CILRepository.Controllers.HomeController.$Contact$o__SiteContainer2.$$p__Site3 := null;
    return;
}



function T$CILRepository.Controllers.HomeController.$Upload$o__SiteContainer4() : Ref;

const unique T$CILRepository.Controllers.HomeController.$Upload$o__SiteContainer4: int;

procedure T$CILRepository.Controllers.HomeController.$Upload$o__SiteContainer4.#cctor();



implementation T$CILRepository.Controllers.HomeController.$Upload$o__SiteContainer4.#cctor()
{

  anon0:
    F$CILRepository.Controllers.HomeController.$Upload$o__SiteContainer4.$$p__Site5 := null;
    return;
}



function T$CILRepository.Controllers.HomeController.$Download$o__SiteContainer6() : Ref;

const unique T$CILRepository.Controllers.HomeController.$Download$o__SiteContainer6: int;

procedure T$CILRepository.Controllers.HomeController.$Download$o__SiteContainer6.#cctor();



implementation T$CILRepository.Controllers.HomeController.$Download$o__SiteContainer6.#cctor()
{

  anon0:
    F$CILRepository.Controllers.HomeController.$Download$o__SiteContainer6.$$p__Site7 := null;
    return;
}



function T$CILRepository.Controllers.HomeController.$DownloadToken$o__SiteContainer8() : Ref;

const unique T$CILRepository.Controllers.HomeController.$DownloadToken$o__SiteContainer8: int;

procedure T$CILRepository.Controllers.HomeController.$DownloadToken$o__SiteContainer8.#cctor();



implementation T$CILRepository.Controllers.HomeController.$DownloadToken$o__SiteContainer8.#cctor()
{

  anon0:
    F$CILRepository.Controllers.HomeController.$DownloadToken$o__SiteContainer8.$$p__Site9 := null;
    return;
}



function T$CILRepository.Controllers.HomeController.$DLLHandle$o__SiteContainera() : Ref;

const unique T$CILRepository.Controllers.HomeController.$DLLHandle$o__SiteContainera: int;

procedure T$CILRepository.Controllers.HomeController.$DLLHandle$o__SiteContainera.#cctor();



implementation T$CILRepository.Controllers.HomeController.$DLLHandle$o__SiteContainera.#cctor()
{

  anon0:
    F$CILRepository.Controllers.HomeController.$DLLHandle$o__SiteContainera.$$p__Siteb := null;
    return;
}



function T$CILRepository.Controllers.HomeController.$UploadDll$o__SiteContainerc() : Ref;

const unique T$CILRepository.Controllers.HomeController.$UploadDll$o__SiteContainerc: int;

procedure T$CILRepository.Controllers.HomeController.$UploadDll$o__SiteContainerc.#cctor();



implementation T$CILRepository.Controllers.HomeController.$UploadDll$o__SiteContainerc.#cctor()
{

  anon0:
    F$CILRepository.Controllers.HomeController.$UploadDll$o__SiteContainerc.$$p__Sited := null;
    return;
}



procedure T$CILRepository.Controllers.HomeController.#cctor();



implementation T$CILRepository.Controllers.HomeController.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.RouteConfig() : Ref;

const unique T$CILRepository.RouteConfig: int;

procedure CILRepository.RouteConfig.RegisterRoutes$System.Web.Routing.RouteCollection(routes$in: Ref);



procedure CILRepository.RouteConfig.#ctor($this: Ref);



implementation CILRepository.RouteConfig.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 356} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$CILRepository.RouteConfig.#cctor();



implementation T$CILRepository.RouteConfig.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.Startup() : Ref;

const unique T$CILRepository.Startup: int;

procedure CILRepository.Startup.ConfigureAuth$Owin.IAppBuilder($this: Ref, app$in: Ref);



procedure CILRepository.Startup.Configuration$Owin.IAppBuilder($this: Ref, app$in: Ref);



implementation CILRepository.Startup.Configuration$Owin.IAppBuilder($this: Ref, app$in: Ref)
{
  var app: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    app := app$in;
    assume {:breadcrumb 358} true;
    call CILRepository.Startup.ConfigureAuth$Owin.IAppBuilder($this, app);
    return;
}



procedure CILRepository.Startup.#ctor($this: Ref);



implementation CILRepository.Startup.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 359} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$CILRepository.Startup.#cctor();



implementation T$CILRepository.Startup.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.FilterConfig() : Ref;

const unique T$CILRepository.FilterConfig: int;

procedure CILRepository.FilterConfig.RegisterGlobalFilters$System.Web.Mvc.GlobalFilterCollection(filters$in: Ref);



procedure CILRepository.FilterConfig.#ctor($this: Ref);



implementation CILRepository.FilterConfig.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 361} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$CILRepository.FilterConfig.#cctor();



implementation T$CILRepository.FilterConfig.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.BundleConfig() : Ref;

const unique T$CILRepository.BundleConfig: int;

procedure CILRepository.BundleConfig.RegisterBundles$System.Web.Optimization.BundleCollection(bundles$in: Ref);



procedure CILRepository.BundleConfig.#ctor($this: Ref);



implementation CILRepository.BundleConfig.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 363} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$CILRepository.BundleConfig.#cctor();



implementation T$CILRepository.BundleConfig.#cctor()
{

  anon0:
    return;
}



function T$CILRepository.MvcApplication() : Ref;

const unique T$CILRepository.MvcApplication: int;

procedure CILRepository.MvcApplication.Application_Start($this: Ref);



procedure CILRepository.MvcApplication.#ctor($this: Ref);



procedure {:extern} System.Web.HttpApplication.#ctor($this: Ref);



implementation CILRepository.MvcApplication.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 365} true;
    call System.Web.HttpApplication.#ctor($this);
    return;
}



procedure T$CILRepository.MvcApplication.#cctor();



implementation T$CILRepository.MvcApplication.#cctor()
{

  anon0:
    return;
}



function $controller$j__TPar$T$$$f__AnonymousType0`3(parent: Ref) : Ref;

function $action$j__TPar$T$$$f__AnonymousType0`3(parent: Ref) : Ref;

function $id$j__TPar$T$$$f__AnonymousType0`3(parent: Ref) : Ref;

function T$$$f__AnonymousType0`3($controller$j__TPar: Ref, $action$j__TPar: Ref, $id$j__TPar: Ref) : Ref;

const unique T$$$f__AnonymousType0`3: int;

var F$$$f__AnonymousType0`3.$controller$i__Field: [Ref]Ref;

var F$$$f__AnonymousType0`3.$action$i__Field: [Ref]Ref;

var F$$$f__AnonymousType0`3.$id$i__Field: [Ref]Ref;

procedure {:System.Diagnostics.DebuggerHidden} $$f__AnonymousType0`3.#ctor$`0$`1$`2($this: Ref, controller$in: Ref, action$in: Ref, id$in: Ref);



implementation $$f__AnonymousType0`3.#ctor$`0$`1$`2($this: Ref, controller$in: Ref, action$in: Ref, id$in: Ref)
{
  var controller: Ref;
  var action: Ref;
  var id: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    controller := controller$in;
    action := action$in;
    id := id$in;
    F$$$f__AnonymousType0`3.$controller$i__Field[$this] := null;
    F$$$f__AnonymousType0`3.$action$i__Field[$this] := null;
    F$$$f__AnonymousType0`3.$id$i__Field[$this] := null;
    assume {:breadcrumb 366} true;
    call System.Object.#ctor($this);
    F$$$f__AnonymousType0`3.$controller$i__Field[$this] := controller;
    F$$$f__AnonymousType0`3.$action$i__Field[$this] := action;
    F$$$f__AnonymousType0`3.$id$i__Field[$this] := id;
    return;
}



procedure $$f__AnonymousType0`3.get_controller($this: Ref) returns ($result: Ref);



implementation $$f__AnonymousType0`3.get_controller($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 367} true;
    assume $this != null;
    local_0_Ref := F$$$f__AnonymousType0`3.$controller$i__Field[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure $$f__AnonymousType0`3.get_action($this: Ref) returns ($result: Ref);



implementation $$f__AnonymousType0`3.get_action($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 368} true;
    assume $this != null;
    local_0_Ref := F$$$f__AnonymousType0`3.$action$i__Field[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure $$f__AnonymousType0`3.get_id($this: Ref) returns ($result: Ref);



implementation $$f__AnonymousType0`3.get_id($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 369} true;
    assume $this != null;
    local_0_Ref := F$$$f__AnonymousType0`3.$id$i__Field[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Diagnostics.DebuggerHidden} $$f__AnonymousType0`3.ToString($this: Ref) returns ($result: Ref);



const {:value "{ controller = "} unique $string_literal_$$controller$$$_40: Ref;

const {:value ", action = "} unique $string_literal_$$action$$$_41: Ref;

const {:value ", id = "} unique $string_literal_$$id$$$_42: Ref;

implementation $$f__AnonymousType0`3.ToString($this: Ref) returns ($result: Ref)
{
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
  var local_1_Ref: Ref;
  var $tmp11: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 370} true;
    call $tmp0 := Alloc();
    call System.Text.StringBuilder.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Text.StringBuilder();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Text.StringBuilder;
    local_0_Ref := $tmp0;
    call $tmp1 := System.Text.StringBuilder.Append$System.String(local_0_Ref, $string_literal_$$controller$$$_40);
    assume $this != null;
    call $tmp2 := $BoxFromUnion(F$$$f__AnonymousType0`3.$controller$i__Field[$this]);
    call $tmp3 := System.Text.StringBuilder.Append$System.Object(local_0_Ref, $tmp2);
    call $tmp4 := System.Text.StringBuilder.Append$System.String(local_0_Ref, $string_literal_$$action$$$_41);
    assume $this != null;
    call $tmp5 := $BoxFromUnion(F$$$f__AnonymousType0`3.$action$i__Field[$this]);
    call $tmp6 := System.Text.StringBuilder.Append$System.Object(local_0_Ref, $tmp5);
    call $tmp7 := System.Text.StringBuilder.Append$System.String(local_0_Ref, $string_literal_$$id$$$_42);
    assume $this != null;
    call $tmp8 := $BoxFromUnion(F$$$f__AnonymousType0`3.$id$i__Field[$this]);
    call $tmp9 := System.Text.StringBuilder.Append$System.Object(local_0_Ref, $tmp8);
    call $tmp10 := System.Text.StringBuilder.Append$System.String(local_0_Ref, $string_literal_$$_35);
    call $tmp11 := System.Object.ToString(local_0_Ref);
    local_1_Ref := $tmp11;
    goto IL_0075;

  IL_0075:
    $result := local_1_Ref;
    return;
}



procedure {:System.Diagnostics.DebuggerHidden} $$f__AnonymousType0`3.Equals$System.Object($this: Ref, value$in: Ref) returns ($result: bool);



implementation $$f__AnonymousType0`3.Equals$System.Object($this: Ref, value$in: Ref) returns ($result: bool)
{
  var value: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: bool;
  var stack_0_System_Boolean_bool: bool;
  var local_1_bool: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 371} true;
    local_0_Ref := $As(value, T$$$f__AnonymousType0`3($controller$j__TPar$T$$$f__AnonymousType0`3($DynamicType($this)), $action$j__TPar$T$$$f__AnonymousType0`3($DynamicType($this)), $id$j__TPar$T$$$f__AnonymousType0`3($DynamicType($this))));
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} local_0_Ref != null;
    assume {:breadcrumb 372} true;
    call $tmp0 := System.Collections.Generic.EqualityComparer`1.get_Default($controller$j__TPar$T$$$f__AnonymousType0`3($DynamicType($this)));
    assume $this != null;
    $tmp1 := local_0_Ref;
    assume $tmp1 != null;
    call $tmp2 := System.Collections.Generic.EqualityComparer`1.Equals$`0$`0($tmp0, F$$$f__AnonymousType0`3.$controller$i__Field[$this], F$$$f__AnonymousType0`3.$controller$i__Field[$tmp1]);
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $tmp2;
    assume {:breadcrumb 374} true;
    goto anon4;

  anon11_Else:
    assume {:partition} !$tmp2;
    assume {:breadcrumb 375} true;
    goto IL_0052;

  anon4:
    call $tmp3 := System.Collections.Generic.EqualityComparer`1.get_Default($action$j__TPar$T$$$f__AnonymousType0`3($DynamicType($this)));
    assume $this != null;
    $tmp4 := local_0_Ref;
    assume $tmp4 != null;
    call $tmp5 := System.Collections.Generic.EqualityComparer`1.Equals$`0$`0($tmp3, F$$$f__AnonymousType0`3.$action$i__Field[$this], F$$$f__AnonymousType0`3.$action$i__Field[$tmp4]);
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} $tmp5;
    assume {:breadcrumb 376} true;
    goto anon7;

  anon12_Else:
    assume {:partition} !$tmp5;
    assume {:breadcrumb 377} true;
    goto IL_0052;

  anon7:
    call $tmp6 := System.Collections.Generic.EqualityComparer`1.get_Default($id$j__TPar$T$$$f__AnonymousType0`3($DynamicType($this)));
    assume $this != null;
    $tmp7 := local_0_Ref;
    assume $tmp7 != null;
    call $tmp8 := System.Collections.Generic.EqualityComparer`1.Equals$`0$`0($tmp6, F$$$f__AnonymousType0`3.$id$i__Field[$this], F$$$f__AnonymousType0`3.$id$i__Field[$tmp7]);
    stack_0_System_Boolean_bool := $tmp8;
    goto anon9;

  anon10_Else:
    assume {:partition} local_0_Ref == null;
    assume {:breadcrumb 373} true;
    goto IL_0052;

  IL_0052:
    stack_0_System_Boolean_bool := false;
    goto anon9;

  anon9:
    local_1_bool := stack_0_System_Boolean_bool != false;
    goto IL_0057;

  IL_0057:
    $result := local_1_bool;
    return;
}



procedure {:System.Diagnostics.DebuggerHidden} $$f__AnonymousType0`3.GetHashCode($this: Ref) returns ($result: int);



implementation $$f__AnonymousType0`3.GetHashCode($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $tmp0: Ref;
  var $tmp1: int;
  var $tmp2: Ref;
  var $tmp3: int;
  var $tmp4: Ref;
  var $tmp5: int;
  var local_1_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 378} true;
    local_0_int := -1187228425;
    call $tmp0 := System.Collections.Generic.EqualityComparer`1.get_Default($controller$j__TPar$T$$$f__AnonymousType0`3($DynamicType($this)));
    assume $this != null;
    call $tmp1 := System.Collections.Generic.EqualityComparer`1.GetHashCode$`0($tmp0, F$$$f__AnonymousType0`3.$controller$i__Field[$this]);
    local_0_int := -1521134295 * local_0_int + $tmp1;
    call $tmp2 := System.Collections.Generic.EqualityComparer`1.get_Default($action$j__TPar$T$$$f__AnonymousType0`3($DynamicType($this)));
    assume $this != null;
    call $tmp3 := System.Collections.Generic.EqualityComparer`1.GetHashCode$`0($tmp2, F$$$f__AnonymousType0`3.$action$i__Field[$this]);
    local_0_int := -1521134295 * local_0_int + $tmp3;
    call $tmp4 := System.Collections.Generic.EqualityComparer`1.get_Default($id$j__TPar$T$$$f__AnonymousType0`3($DynamicType($this)));
    assume $this != null;
    call $tmp5 := System.Collections.Generic.EqualityComparer`1.GetHashCode$`0($tmp4, F$$$f__AnonymousType0`3.$id$i__Field[$this]);
    local_0_int := -1521134295 * local_0_int + $tmp5;
    local_1_int := local_0_int;
    goto IL_0055;

  IL_0055:
    $result := local_1_int;
    return;
}



procedure T$$$f__AnonymousType0`3.#cctor();



implementation T$$$f__AnonymousType0`3.#cctor()
{

  anon0:
    return;
}



function $ReturnUrl$j__TPar$T$$$f__AnonymousType2`1(parent: Ref) : Ref;

function T$$$f__AnonymousType2`1($ReturnUrl$j__TPar: Ref) : Ref;

const unique T$$$f__AnonymousType2`1: int;

var F$$$f__AnonymousType2`1.$ReturnUrl$i__Field: [Ref]Ref;

procedure {:System.Diagnostics.DebuggerHidden} $$f__AnonymousType2`1.#ctor$`0($this: Ref, ReturnUrl$in: Ref);



implementation $$f__AnonymousType2`1.#ctor$`0($this: Ref, ReturnUrl$in: Ref)
{
  var ReturnUrl: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    ReturnUrl := ReturnUrl$in;
    F$$$f__AnonymousType2`1.$ReturnUrl$i__Field[$this] := null;
    assume {:breadcrumb 379} true;
    call System.Object.#ctor($this);
    F$$$f__AnonymousType2`1.$ReturnUrl$i__Field[$this] := ReturnUrl;
    return;
}



procedure $$f__AnonymousType2`1.get_ReturnUrl($this: Ref) returns ($result: Ref);



implementation $$f__AnonymousType2`1.get_ReturnUrl($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 380} true;
    assume $this != null;
    local_0_Ref := F$$$f__AnonymousType2`1.$ReturnUrl$i__Field[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Diagnostics.DebuggerHidden} $$f__AnonymousType2`1.ToString($this: Ref) returns ($result: Ref);



const {:value "{ ReturnUrl = "} unique $string_literal_$$ReturnUrl$$$_43: Ref;

implementation $$f__AnonymousType2`1.ToString($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_1_Ref: Ref;
  var $tmp5: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 381} true;
    call $tmp0 := Alloc();
    call System.Text.StringBuilder.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Text.StringBuilder();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Text.StringBuilder;
    local_0_Ref := $tmp0;
    call $tmp1 := System.Text.StringBuilder.Append$System.String(local_0_Ref, $string_literal_$$ReturnUrl$$$_43);
    assume $this != null;
    call $tmp2 := $BoxFromUnion(F$$$f__AnonymousType2`1.$ReturnUrl$i__Field[$this]);
    call $tmp3 := System.Text.StringBuilder.Append$System.Object(local_0_Ref, $tmp2);
    call $tmp4 := System.Text.StringBuilder.Append$System.String(local_0_Ref, $string_literal_$$_35);
    call $tmp5 := System.Object.ToString(local_0_Ref);
    local_1_Ref := $tmp5;
    goto IL_0039;

  IL_0039:
    $result := local_1_Ref;
    return;
}



procedure {:System.Diagnostics.DebuggerHidden} $$f__AnonymousType2`1.Equals$System.Object($this: Ref, value$in: Ref) returns ($result: bool);



implementation $$f__AnonymousType2`1.Equals$System.Object($this: Ref, value$in: Ref) returns ($result: bool)
{
  var value: Ref;
  var local_0_Ref: Ref;
  var local_1_bool: bool;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 382} true;
    local_0_Ref := $As(value, T$$$f__AnonymousType2`1($ReturnUrl$j__TPar$T$$$f__AnonymousType2`1($DynamicType($this))));
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} local_0_Ref != null;
    call $tmp0 := System.Collections.Generic.EqualityComparer`1.get_Default($ReturnUrl$j__TPar$T$$$f__AnonymousType2`1($DynamicType($this)));
    assume $this != null;
    $tmp1 := local_0_Ref;
    assume $tmp1 != null;
    call $tmp2 := System.Collections.Generic.EqualityComparer`1.Equals$`0$`0($tmp0, F$$$f__AnonymousType2`1.$ReturnUrl$i__Field[$this], F$$$f__AnonymousType2`1.$ReturnUrl$i__Field[$tmp1]);
    goto anon3;

  anon4_Else:
    assume {:partition} local_0_Ref == null;
    goto anon3;

  anon3:
    local_1_bool := (if local_0_Ref != null then $tmp2 else false);
    goto IL_0027;

  IL_0027:
    $result := local_1_bool;
    return;
}



procedure {:System.Diagnostics.DebuggerHidden} $$f__AnonymousType2`1.GetHashCode($this: Ref) returns ($result: int);



implementation $$f__AnonymousType2`1.GetHashCode($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $tmp0: Ref;
  var $tmp1: int;
  var local_1_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 383} true;
    local_0_int := -1822758514;
    call $tmp0 := System.Collections.Generic.EqualityComparer`1.get_Default($ReturnUrl$j__TPar$T$$$f__AnonymousType2`1($DynamicType($this)));
    assume $this != null;
    call $tmp1 := System.Collections.Generic.EqualityComparer`1.GetHashCode$`0($tmp0, F$$$f__AnonymousType2`1.$ReturnUrl$i__Field[$this]);
    local_0_int := -1521134295 * local_0_int + $tmp1;
    local_1_int := local_0_int;
    goto IL_0023;

  IL_0023:
    $result := local_1_int;
    return;
}



procedure T$$$f__AnonymousType2`1.#cctor();



implementation T$$$f__AnonymousType2`1.#cctor()
{

  anon0:
    return;
}



procedure OAuth20NameSpace.AccessToken.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessToken.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 384} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 385} true;
    F$OAuth20NameSpace.AccessToken.token[$this] := value;
    return;
}



procedure OAuth20NameSpace.AccessToken.GetHashCode($this: Ref) returns ($result: int);



implementation OAuth20NameSpace.AccessToken.GetHashCode($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $tmp0: Ref;
  var $tmp1: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 386} true;
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

  anon0:
    F$OAuth20NameSpace.AccessToken.token[$this] := null;
    assume {:breadcrumb 387} true;
    call GenericAuthNameSpace.Ticket.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AccessToken.#cctor();



implementation T$OAuth20NameSpace.AccessToken.#cctor()
{

  anon0:
    return;
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

  anon0:
    assume {:breadcrumb 388} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 389} true;
    F$OAuth20NameSpace.ResourceRequest.access_token[$this] := value;
    return;
}



procedure OAuth20NameSpace.ResourceRequest.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 390} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 391} true;
    F$OAuth20NameSpace.ResourceRequest.client_id[$this] := value;
    return;
}



procedure OAuth20NameSpace.ResourceRequest.#ctor($this: Ref);



implementation OAuth20NameSpace.ResourceRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.ResourceRequest.access_token[$this] := null;
    F$OAuth20NameSpace.ResourceRequest.client_id[$this] := null;
    F$OAuth20NameSpace.ResourceRequest.scope[$this] := null;
    assume {:breadcrumb 392} true;
    call GenericAuthNameSpace.ReqResourceRS_Req.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.ResourceRequest.#cctor();



implementation T$OAuth20NameSpace.ResourceRequest.#cctor()
{

  anon0:
    return;
}



function T$OAuth20NameSpace.AuthorizationResponse() : Ref;

const unique T$OAuth20NameSpace.AuthorizationResponse: int;

implementation OAuth20NameSpace.AuthorizationResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.AuthorizationResponse.code[$this] := null;
    F$OAuth20NameSpace.AuthorizationResponse.state[$this] := null;
    assume {:breadcrumb 393} true;
    F$OAuth20NameSpace.AuthorizationResponse.state[$this] := null;
    call GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AuthorizationResponse.#cctor();



implementation T$OAuth20NameSpace.AuthorizationResponse.#cctor()
{

  anon0:
    return;
}



function T$OAuth20NameSpace.ResourceRecs() : Ref;

const unique T$OAuth20NameSpace.ResourceRecs: int;

function T$OAuth20NameSpace.ResourceServer() : Ref;

const unique T$OAuth20NameSpace.ResourceServer: int;

var F$OAuth20NameSpace.ResourceServer.TokenEndpointUrl: [Ref]Ref;

procedure OAuth20NameSpace.ResourceServer.get_ResourceRecs($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceServer.get_ResourceRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 394} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 395} true;
    F$GenericAuthNameSpace.RS.RSResourceRecs[$this] := value;
    return;
}



procedure OAuth20NameSpace.ResourceServer.init$OAuth20NameSpace.ResourceRecs($this: Ref, recs$in: Ref);



implementation OAuth20NameSpace.ResourceServer.init$OAuth20NameSpace.ResourceRecs($this: Ref, recs$in: Ref)
{
  var recs: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    recs := recs$in;
    assume {:breadcrumb 396} true;
    call OAuth20NameSpace.ResourceServer.set_ResourceRecs$OAuth20NameSpace.ResourceRecs($this, recs);
    return;
}



procedure OAuth20NameSpace.ResourceServer.createValidateTokenRequest$OAuth20NameSpace.ResourceRequest($this: Ref, res_req$in: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.ValidateTokenRequest.#ctor($this: Ref);



var F$OAuth20NameSpace.ValidateTokenRequest.access_token: [Ref]Ref;

var F$OAuth20NameSpace.ValidateTokenRequest.scope: [Ref]Ref;

procedure OAuth20NameSpace.ValidateTokenRequest.set_UserID$System.String($this: Ref, value$in: Ref);



var F$OAuth20NameSpace.ValidateTokenRequest.client_id: [Ref]Ref;

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

  anon0:
    res_req := res_req$in;
    assume {:breadcrumb 397} true;
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
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.ValidateTokenRequest;
    assume {:breadcrumb 398} true;
    $tmp3 := res_req;
    assume $tmp3 != null;
    call OAuth20NameSpace.ValidateTokenRequest.set_UserID$System.String(local_0_Ref, F$GenericAuthNameSpace.ReqResourceRS_Req.UserID[$tmp3]);
    goto anon3;

  anon4_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.ValidateTokenRequest;
    assume {:breadcrumb 399} true;
    $tmp4 := res_req;
    assume $tmp4 != null;
    call GenericAuthNameSpace.ValidateTicket_Req.set_UserID$System.String(local_0_Ref, F$GenericAuthNameSpace.ReqResourceRS_Req.UserID[$tmp4]);
    goto anon3;

  anon3:
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



function {:extern} T$T$System.Collections.Generic.HashSet`1(parent: Ref) : Ref;

function {:extern} T$System.Collections.Generic.HashSet`1(T: Ref) : Ref;

const {:extern} unique T$System.Collections.Generic.HashSet`1: int;

procedure System.Collections.Generic.HashSet.Enumerator.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



procedure {:extern} System.Collections.Generic.HashSet`1.GetEnumerator($this: Ref) returns ($result: Ref);



procedure {:extern} System.Collections.Generic.HashSet`1.Enumerator.get_Current($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.ValidateTokenResponse.get_UserID($this: Ref) returns ($result: Ref);



function T$OAuth20NameSpace.ValidateTokenResponse() : Ref;

const unique T$OAuth20NameSpace.ValidateTokenResponse: int;

procedure {:extern} System.Collections.Generic.HashSet`1.Enumerator.MoveNext($this: Ref) returns ($result: bool);



procedure OAuth20NameSpace.ResourceResponse.#ctor($this: Ref);



function T$OAuth20NameSpace.ResourceResponse() : Ref;

const unique T$OAuth20NameSpace.ResourceResponse: int;

var F$OAuth20NameSpace.ValidateTokenResponse.client_id: [Ref]Ref;

var F$OAuth20NameSpace.ResourceResponse.client_id: [Ref]Ref;

var F$OAuth20NameSpace.ValidateTokenResponse.access_token: [Ref]Ref;

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

  anon0:
    req := req$in;
    assume {:breadcrumb 400} true;
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
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} $tmp3;
    assume {:breadcrumb 401} true;
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
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse;
    call $tmp15 := OAuth20NameSpace.ValidateTokenResponse.get_UserID(local_1_Ref);
    goto anon4;

  anon10_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$OAuth20NameSpace.ValidateTokenResponse;
    call $tmp16 := GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_UserID(local_1_Ref);
    goto anon4;

  anon4:
    call $tmp17 := GenericAuthNameSpace.RSResourceRecords_Base.getEntry$System.String$GenericAuthNameSpace.Permission($tmp14, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse then $tmp15 else $tmp16), local_3_Ref);
    call $tmp18 := System.Collections.Generic.HashSet`1.Add$`0($tmp13, $tmp17);
    goto IL_0073;

  IL_0073:
    call $tmp19 := System.Collections.Generic.HashSet`1.Enumerator.MoveNext(local_7_Ref);
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $tmp19;
    assume {:breadcrumb 403} true;
    goto IL_004b;

  anon11_Else:
    assume {:partition} !$tmp19;
    assume {:breadcrumb 404} true;
    goto anon7;

  anon7:
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
    goto IL_00d3;

  anon9_Else:
    assume {:partition} !$tmp3;
    assume {:breadcrumb 402} true;
    local_5_Ref := null;
    goto IL_00d3;

  IL_00d3:
    $result := local_5_Ref;
    return;
}



var F$OAuth20NameSpace.ValidateTokenResponse.scope: [Ref]Ref;

procedure OAuth20NameSpace.ValidateTokenResponse.get_Realm($this: Ref) returns ($result: Ref);



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

  anon0:
    tresq := tresq$in;
    assume {:breadcrumb 405} true;
    call $tmp0 := Alloc();
    call GenericAuthNameSpace.RS.AuthorizationConclusion.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$GenericAuthNameSpace.RS.AuthorizationConclusion();
    assume $TypeConstructor($DynamicType($tmp0)) == T$GenericAuthNameSpace.RS.AuthorizationConclusion;
    local_0_Ref := $tmp0;
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} $TypeConstructor($DynamicType(tresq)) == T$OAuth20NameSpace.ValidateTokenResponse;
    call $tmp1 := OAuth20NameSpace.ValidateTokenResponse.get_UserID(tresq);
    goto anon3;

  anon7_Else:
    assume {:partition} $TypeConstructor($DynamicType(tresq)) != T$OAuth20NameSpace.ValidateTokenResponse;
    call $tmp2 := GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_UserID(tresq);
    goto anon3;

  anon3:
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.UserID[local_0_Ref] := (if $TypeConstructor($DynamicType(tresq)) == T$OAuth20NameSpace.ValidateTokenResponse then $tmp1 else $tmp2);
    $tmp3 := tresq;
    assume $tmp3 != null;
    F$GenericAuthNameSpace.RS.AuthorizationConclusion.permissions[local_0_Ref] := F$OAuth20NameSpace.ValidateTokenResponse.scope[$tmp3];
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} $TypeConstructor($DynamicType(tresq)) == T$OAuth20NameSpace.ValidateTokenResponse;
    call $tmp4 := OAuth20NameSpace.ValidateTokenResponse.get_Realm(tresq);
    goto anon6;

  anon8_Else:
    assume {:partition} $TypeConstructor($DynamicType(tresq)) != T$OAuth20NameSpace.ValidateTokenResponse;
    call $tmp5 := GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.get_Realm(tresq);
    goto anon6;

  anon6:
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

  anon0:
    F$OAuth20NameSpace.ResourceServer.TokenEndpointUrl[$this] := null;
    assume {:breadcrumb 406} true;
    call GenericAuthNameSpace.RS.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.ResourceServer.#cctor();



implementation T$OAuth20NameSpace.ResourceServer.#cctor()
{

  anon0:
    return;
}



var F$OAuth20NameSpace.AccessTokenEntry.user: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenEntry.client_id: [Ref]Ref;

implementation OAuth20NameSpace.AccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 407} true;
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

  anon0:
    assume {:breadcrumb 408} true;
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

  anon0:
    assume {:breadcrumb 409} true;
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

  anon0:
    assume {:breadcrumb 410} true;
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

  anon0:
    F$OAuth20NameSpace.AccessTokenEntry.access_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.user[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.scope[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.state[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.client_id[$this] := null;
    assume {:breadcrumb 411} true;
    call GenericAuthNameSpace.Permission_Claim.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AccessTokenEntry.#cctor();



implementation T$OAuth20NameSpace.AccessTokenEntry.#cctor()
{

  anon0:
    return;
}



function T$OAuth20NameSpace.AccessTokenRecs() : Ref;

const unique T$OAuth20NameSpace.AccessTokenRecs: int;

procedure OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndAccessToken$System.String$System.String$System.String($this: Ref, client_id$in: Ref, UserID$in: Ref, access_token$in: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndRefreshToken$System.String$System.String$System.String($this: Ref, client_id$in: Ref, UserID$in: Ref, refresh_token$in: Ref) returns ($result: Ref);



var F$OAuth20NameSpace.ValidateTokenResponse.user: [Ref]Ref;

procedure OAuth20NameSpace.ValidateTokenResponse.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 412} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 413} true;
    F$OAuth20NameSpace.ValidateTokenResponse.access_token[$this] := value;
    return;
}



procedure OAuth20NameSpace.ValidateTokenResponse.get_permissions($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.get_permissions($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 414} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 415} true;
    F$OAuth20NameSpace.ValidateTokenResponse.scope[$this] := value;
    return;
}



implementation OAuth20NameSpace.ValidateTokenResponse.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 416} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 417} true;
    F$OAuth20NameSpace.ValidateTokenResponse.client_id[$this] := value;
    return;
}



implementation OAuth20NameSpace.ValidateTokenResponse.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 418} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 419} true;
    F$OAuth20NameSpace.ValidateTokenResponse.user[$this] := value;
    return;
}



procedure OAuth20NameSpace.ValidateTokenResponse.#ctor($this: Ref);



implementation OAuth20NameSpace.ValidateTokenResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.ValidateTokenResponse.access_token[$this] := null;
    F$OAuth20NameSpace.ValidateTokenResponse.scope[$this] := null;
    F$OAuth20NameSpace.ValidateTokenResponse.client_id[$this] := null;
    F$OAuth20NameSpace.ValidateTokenResponse.user[$this] := null;
    assume {:breadcrumb 420} true;
    call GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.ValidateTokenResponse.#cctor();



implementation T$OAuth20NameSpace.ValidateTokenResponse.#cctor()
{

  anon0:
    return;
}



function T$OAuth20NameSpace.AuthorizationCodeRecs() : Ref;

const unique T$OAuth20NameSpace.AuthorizationCodeRecs: int;

function T$OAuth20NameSpace.AccessTokenResponse() : Ref;

const unique T$OAuth20NameSpace.AccessTokenResponse: int;

var F$OAuth20NameSpace.AccessTokenResponse.token_type: [Ref]Ref;

var F$OAuth20NameSpace.AccessTokenResponse.client_id: [Ref]Ref;

procedure OAuth20NameSpace.AccessTokenResponse.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessTokenResponse.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 421} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 422} true;
    F$OAuth20NameSpace.AccessTokenResponse.access_token[$this] := value;
    return;
}



procedure OAuth20NameSpace.AccessTokenResponse.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessTokenResponse.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 423} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 424} true;
    F$OAuth20NameSpace.AccessTokenResponse.client_id[$this] := value;
    return;
}



implementation OAuth20NameSpace.AccessTokenResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.AccessTokenResponse.access_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.token_type[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.expires_in[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.client_id[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.scope[$this] := null;
    assume {:breadcrumb 425} true;
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[$this] := null;
    call GenericAuthNameSpace.AuthTicketAS_Resp_ReqResourceRS_Req.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AccessTokenResponse.#cctor();



implementation T$OAuth20NameSpace.AccessTokenResponse.#cctor()
{

  anon0:
    return;
}



var F$OAuth20NameSpace.ValidateTokenRequest.user: [Ref]Ref;

implementation OAuth20NameSpace.ValidateTokenRequest.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 426} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 427} true;
    F$OAuth20NameSpace.ValidateTokenRequest.access_token[$this] := value;
    return;
}



procedure OAuth20NameSpace.ValidateTokenRequest.get_permissions($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ValidateTokenRequest.get_permissions($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 428} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 429} true;
    F$OAuth20NameSpace.ValidateTokenRequest.scope[$this] := value;
    return;
}



procedure OAuth20NameSpace.ValidateTokenRequest.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ValidateTokenRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 430} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 431} true;
    F$OAuth20NameSpace.ValidateTokenRequest.client_id[$this] := value;
    return;
}



implementation OAuth20NameSpace.ValidateTokenRequest.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 432} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.ValidateTokenRequest.user[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



implementation OAuth20NameSpace.ValidateTokenRequest.set_UserID$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 433} true;
    F$OAuth20NameSpace.ValidateTokenRequest.user[$this] := value;
    return;
}



implementation OAuth20NameSpace.ValidateTokenRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.ValidateTokenRequest.access_token[$this] := null;
    F$OAuth20NameSpace.ValidateTokenRequest.scope[$this] := null;
    F$OAuth20NameSpace.ValidateTokenRequest.client_id[$this] := null;
    F$OAuth20NameSpace.ValidateTokenRequest.user[$this] := null;
    assume {:breadcrumb 434} true;
    call GenericAuthNameSpace.ValidateTicket_Req.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.ValidateTokenRequest.#cctor();



implementation T$OAuth20NameSpace.ValidateTokenRequest.#cctor()
{

  anon0:
    return;
}



var F$OAuth20NameSpace.AuthorizationRequest.response_type: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationRequest.client_id: [Ref]Ref;

implementation OAuth20NameSpace.AuthorizationRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 435} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 436} true;
    F$OAuth20NameSpace.AuthorizationRequest.client_id[$this] := value;
    return;
}



implementation OAuth20NameSpace.AuthorizationRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.AuthorizationRequest.response_type[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.client_id[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.scope[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.state[$this] := null;
    assume {:breadcrumb 437} true;
    F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.state[$this] := null;
    call GenericAuthNameSpace.SignInIdP_Req.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AuthorizationRequest.#cctor();



implementation T$OAuth20NameSpace.AuthorizationRequest.#cctor()
{

  anon0:
    return;
}



implementation OAuth20NameSpace.Client.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.Client.client_secret[$this] := null;
    F$OAuth20NameSpace.Client.TokenEndpointUrl[$this] := null;
    assume {:breadcrumb 438} true;
    call GenericAuthNameSpace.RP.#ctor($this);
    return;
}



implementation OAuth20NameSpace.Client.get_client_id($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 439} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 440} true;
    F$GenericAuthNameSpace.RP.Realm[$this] := value;
    return;
}



implementation OAuth20NameSpace.Client.get_return_uri($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 441} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 442} true;
    F$GenericAuthNameSpace.RP.Domain[$this] := value;
    return;
}



implementation OAuth20NameSpace.Client.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id1$in: Ref, return_uri1$in: Ref, client_secret1$in: Ref, TokenEndpointUrl1$in: Ref)
{
  var client_id1: Ref;
  var return_uri1: Ref;
  var client_secret1: Ref;
  var TokenEndpointUrl1: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    client_id1 := client_id1$in;
    return_uri1 := return_uri1$in;
    client_secret1 := client_secret1$in;
    TokenEndpointUrl1 := TokenEndpointUrl1$in;
    F$OAuth20NameSpace.Client.client_secret[$this] := null;
    F$OAuth20NameSpace.Client.TokenEndpointUrl[$this] := null;
    assume {:breadcrumb 443} true;
    call GenericAuthNameSpace.RP.#ctor($this);
    call OAuth20NameSpace.Client.set_client_id$System.String($this, client_id1);
    call OAuth20NameSpace.Client.set_return_uri$System.String($this, return_uri1);
    F$OAuth20NameSpace.Client.client_secret[$this] := client_secret1;
    F$OAuth20NameSpace.Client.TokenEndpointUrl[$this] := TokenEndpointUrl1;
    return;
}



procedure T$OAuth20NameSpace.Client.#cctor();



implementation T$OAuth20NameSpace.Client.#cctor()
{

  anon0:
    return;
}



function T$OAuth20NameSpace.NondetOAuth20() : Ref;

const unique T$OAuth20NameSpace.NondetOAuth20: int;

procedure OAuth20NameSpace.NondetOAuth20.ValidateTicket_Req($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.NondetOAuth20.ValidateTokenRequest($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.NondetOAuth20.ResourceRequest($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.NondetOAuth20.ResourceResponse($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.NondetOAuth20.AccessTokenDictionary($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.NondetOAuth20.AccessTokenEntry($this: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.ResourceResponse.get_ticket($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceResponse.get_ticket($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 444} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 445} true;
    F$OAuth20NameSpace.ResourceResponse.access_token[$this] := value;
    return;
}



procedure OAuth20NameSpace.ResourceResponse.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.ResourceResponse.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 446} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 447} true;
    F$OAuth20NameSpace.ResourceResponse.client_id[$this] := value;
    return;
}



implementation OAuth20NameSpace.ResourceResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.ResourceResponse.access_token[$this] := null;
    F$OAuth20NameSpace.ResourceResponse.client_id[$this] := null;
    assume {:breadcrumb 448} true;
    call GenericAuthNameSpace.ReqResourceRS_Resp_ReqResourceRS_Req.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.ResourceResponse.#cctor();



implementation T$OAuth20NameSpace.ResourceResponse.#cctor()
{

  anon0:
    return;
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

  anon0:
    F$OAuth20NameSpace.AuthorizationErrorResponse.error[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_description[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.state[$this] := null;
    assume {:breadcrumb 449} true;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_description[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.state[$this] := null;
    call GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AuthorizationErrorResponse.#cctor();



implementation T$OAuth20NameSpace.AuthorizationErrorResponse.#cctor()
{

  anon0:
    return;
}



var F$OAuth20NameSpace.AuthorizationCodeEntry.user: [Ref]Ref;

implementation OAuth20NameSpace.AuthorizationCodeEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 450} true;
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

  anon0:
    assume {:breadcrumb 451} true;
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

  anon0:
    F$OAuth20NameSpace.AuthorizationCodeEntry.code[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.user[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.state[$this] := null;
    assume {:breadcrumb 452} true;
    call GenericAuthNameSpace.ID_Claim.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AuthorizationCodeEntry.#cctor();



implementation T$OAuth20NameSpace.AuthorizationCodeEntry.#cctor()
{

  anon0:
    return;
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

  anon0:
    assume {:breadcrumb 453} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 454} true;
    F$OAuth20NameSpace.AccessTokenRequest.access_token[$this] := value;
    return;
}



procedure OAuth20NameSpace.AccessTokenRequest.get_Realm($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AccessTokenRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 455} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 456} true;
    F$OAuth20NameSpace.AccessTokenRequest.client_id[$this] := value;
    return;
}



implementation OAuth20NameSpace.AccessTokenRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.AccessTokenRequest.access_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.UserID[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.grant_type[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.code[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.client_id[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.refresh_token[$this] := null;
    assume {:breadcrumb 457} true;
    F$OAuth20NameSpace.AccessTokenRequest.refresh_token[$this] := null;
    call GenericAuthNameSpace.AuthTicketAS_Req.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AccessTokenRequest.#cctor();



implementation T$OAuth20NameSpace.AccessTokenRequest.#cctor()
{

  anon0:
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 458} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 459} true;
    F$GenericAuthNameSpace.AS.IdpAuthRecs[$this] := value;
    return;
}



implementation OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 460} true;
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

  anon0:
    value := value$in;
    assume {:breadcrumb 461} true;
    F$GenericAuthNameSpace.AS.ASAuthRecs[$this] := value;
    return;
}



implementation OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, AccessTokenRecs1$in: Ref)
{
  var AuthorizationCodeRecs1: Ref;
  var AccessTokenRecs1: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    AuthorizationCodeRecs1 := AuthorizationCodeRecs1$in;
    AccessTokenRecs1 := AccessTokenRecs1$in;
    assume {:breadcrumb 462} true;
    call OAuth20NameSpace.AuthorizationServer.set_AuthorizationCodeRecs$OAuth20NameSpace.AuthorizationCodeRecs($this, AuthorizationCodeRecs1);
    call OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this, AccessTokenRecs1);
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AccessTokenRecs($this: Ref, AccessTokenRecs1$in: Ref);



implementation OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AccessTokenRecs($this: Ref, AccessTokenRecs1$in: Ref)
{
  var AccessTokenRecs1: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    AccessTokenRecs1 := AccessTokenRecs1$in;
    assume {:breadcrumb 463} true;
    call OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this, AccessTokenRecs1);
    return;
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

  anon0:
    req := req$in;
    assume {:breadcrumb 464} true;
    assume req == F$GenericAuthNameSpace.GlobalObjects_base.ValidateTicket_Req;
    call $tmp12 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    goto anon80_Then, anon80_Else;

  anon80_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp12)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp0 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp1 := req;
    assume $tmp1 != null;
    $tmp2 := req;
    assume $tmp2 != null;
    goto anon81_Then, anon81_Else;

  anon81_Then:
    assume {:partition} $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp3 := OAuth20NameSpace.ValidateTokenRequest.get_UserID(req);
    goto anon4;

  anon81_Else:
    assume {:partition} $TypeConstructor($DynamicType(req)) != T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp4 := GenericAuthNameSpace.ValidateTicket_Req.get_UserID(req);
    goto anon4;

  anon4:
    call $tmp5 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp0, F$OAuth20NameSpace.ValidateTokenRequest.access_token[$tmp1], F$OAuth20NameSpace.ValidateTokenRequest.client_id[$tmp2], (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp3 else $tmp4));
    goto anon9;

  anon80_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp12)) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp6 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp7 := req;
    assume $tmp7 != null;
    $tmp8 := req;
    assume $tmp8 != null;
    goto anon82_Then, anon82_Else;

  anon82_Then:
    assume {:partition} $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp9 := OAuth20NameSpace.ValidateTokenRequest.get_UserID(req);
    goto anon8;

  anon82_Else:
    assume {:partition} $TypeConstructor($DynamicType(req)) != T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp10 := GenericAuthNameSpace.ValidateTicket_Req.get_UserID(req);
    goto anon8;

  anon8:
    call $tmp11 := GenericAuthNameSpace.ASAuthTicketRecords_Base.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp6, F$OAuth20NameSpace.ValidateTokenRequest.access_token[$tmp7], F$OAuth20NameSpace.ValidateTokenRequest.client_id[$tmp8], (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp9 else $tmp10));
    goto anon9;

  anon9:
    local_0_Ref := (if $TypeConstructor($DynamicType($tmp12)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp5 else $tmp11);
    $tmp13 := req;
    assume $tmp13 != null;
    goto anon83_Then, anon83_Else;

  anon83_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp14 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
    goto anon14;

  anon83_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon84_Then, anon84_Else;

  anon84_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp15 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
    goto anon14;

  anon84_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp16 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
    goto anon14;

  anon14:
    call $tmp17 := System.String.op_Inequality$System.String$System.String(F$OAuth20NameSpace.ValidateTokenRequest.client_id[$tmp13], (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp14 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp15 else $tmp16)));
    goto anon85_Then, anon85_Else;

  anon85_Then:
    assume {:partition} $tmp17;
    assume {:breadcrumb 465} true;
    goto anon86_Then, anon86_Else;

  anon86_Then:
    assume {:partition} $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp18 := OAuth20NameSpace.ValidateTokenRequest.get_UserID(req);
    goto anon18;

  anon86_Else:
    assume {:partition} $TypeConstructor($DynamicType(req)) != T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp19 := GenericAuthNameSpace.ValidateTicket_Req.get_UserID(req);
    goto anon18;

  anon18:
    goto anon87_Then, anon87_Else;

  anon87_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp20 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID(local_0_Ref);
    goto anon23;

  anon87_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon88_Then, anon88_Else;

  anon88_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp21 := OAuth20NameSpace.AccessTokenEntry.get_UserID(local_0_Ref);
    goto anon23;

  anon88_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp22 := GenericAuthNameSpace.Permission_Claim.get_UserID(local_0_Ref);
    goto anon23;

  anon23:
    call $tmp23 := System.String.op_Inequality$System.String$System.String((if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp18 else $tmp19), (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp20 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp21 else $tmp22)));
    goto anon89_Then, anon89_Else;

  anon89_Then:
    assume {:partition} $tmp23;
    assume {:breadcrumb 467} true;
    goto anon26;

  anon89_Else:
    assume {:partition} !$tmp23;
    assume {:breadcrumb 468} true;
    goto IL_0078;

  anon26:
    goto anon90_Then, anon90_Else;

  anon90_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp24 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
    goto anon31;

  anon90_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon91_Then, anon91_Else;

  anon91_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp25 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
    goto anon31;

  anon91_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp26 := GenericAuthNameSpace.Permission_Claim.get_permissions(local_0_Ref);
    goto anon31;

  anon31:
    assume (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp24 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp25 else $tmp26)) != null;
    $tmp27 := F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp24 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp25 else $tmp26))];
    goto anon92_Then, anon92_Else;

  anon92_Then:
    assume {:partition} $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp28 := OAuth20NameSpace.ValidateTokenRequest.get_permissions(req);
    goto anon34;

  anon92_Else:
    assume {:partition} $TypeConstructor($DynamicType(req)) != T$OAuth20NameSpace.ValidateTokenRequest;
    call $tmp29 := GenericAuthNameSpace.ValidateTicket_Req.get_permissions(req);
    goto anon34;

  anon34:
    assume (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp28 else $tmp29) != null;
    call $tmp30 := System.Collections.Generic.HashSet`1.IsSupersetOf$System.Collections.Generic.IEnumerable$`0$($tmp27, F$GenericAuthNameSpace.Permissions.permissionSet[(if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.ValidateTokenRequest then $tmp28 else $tmp29)]);
    stack_0_System_Boolean_bool := !$tmp30;
    goto anon36;

  anon85_Else:
    assume {:partition} !$tmp17;
    assume {:breadcrumb 466} true;
    goto IL_0078;

  IL_0078:
    stack_0_System_Boolean_bool := true;
    goto anon36;

  anon36:
    local_3_bool := stack_0_System_Boolean_bool != false;
    goto anon93_Then, anon93_Else;

  anon93_Then:
    assume {:partition} !local_3_bool;
    assume {:breadcrumb 469} true;
    local_2_Ref := null;
    goto IL_00e5;

  anon93_Else:
    assume {:partition} local_3_bool;
    assume {:breadcrumb 470} true;
    goto anon94_Then, anon94_Else;

  anon94_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp31 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
    goto anon43;

  anon94_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon95_Then, anon95_Else;

  anon95_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp32 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
    goto anon43;

  anon95_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp33 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
    goto anon43;

  anon43:
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
    goto anon96_Then, anon96_Else;

  anon96_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp38 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
    goto anon48;

  anon96_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon97_Then, anon97_Else;

  anon97_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp39 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
    goto anon48;

  anon97_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp40 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
    goto anon48;

  anon48:
    F$OAuth20NameSpace.ValidateTokenResponse.client_id[local_1_prime_Ref] := (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp38 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp39 else $tmp40));
    goto anon98_Then, anon98_Else;

  anon98_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp41 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
    goto anon53;

  anon98_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon99_Then, anon99_Else;

  anon99_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp42 := OAuth20NameSpace.AccessTokenEntry.get_permissions(local_0_Ref);
    goto anon53;

  anon99_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp43 := GenericAuthNameSpace.Permission_Claim.get_permissions(local_0_Ref);
    goto anon53;

  anon53:
    F$OAuth20NameSpace.ValidateTokenResponse.scope[local_1_prime_Ref] := (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp41 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp42 else $tmp43));
    goto anon100_Then, anon100_Else;

  anon100_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_prime_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse;
    assume {:breadcrumb 471} true;
    goto anon101_Then, anon101_Else;

  anon101_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp44 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID(local_0_Ref);
    goto anon59;

  anon101_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon102_Then, anon102_Else;

  anon102_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp45 := OAuth20NameSpace.AccessTokenEntry.get_UserID(local_0_Ref);
    goto anon59;

  anon102_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp46 := GenericAuthNameSpace.Permission_Claim.get_UserID(local_0_Ref);
    goto anon59;

  anon59:
    call OAuth20NameSpace.ValidateTokenResponse.set_UserID$System.String(local_1_prime_Ref, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp44 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp45 else $tmp46)));
    goto anon66;

  anon100_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_prime_Ref)) != T$OAuth20NameSpace.ValidateTokenResponse;
    assume {:breadcrumb 472} true;
    goto anon103_Then, anon103_Else;

  anon103_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp47 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID(local_0_Ref);
    goto anon65;

  anon103_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon104_Then, anon104_Else;

  anon104_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp48 := OAuth20NameSpace.AccessTokenEntry.get_UserID(local_0_Ref);
    goto anon65;

  anon104_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp49 := GenericAuthNameSpace.Permission_Claim.get_UserID(local_0_Ref);
    goto anon65;

  anon65:
    call GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_UserID$System.String(local_1_prime_Ref, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp47 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp48 else $tmp49)));
    goto anon66;

  anon66:
    goto anon105_Then, anon105_Else;

  anon105_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_prime_Ref)) == T$OAuth20NameSpace.ValidateTokenResponse;
    assume {:breadcrumb 473} true;
    goto anon106_Then, anon106_Else;

  anon106_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp50 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
    goto anon72;

  anon106_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon107_Then, anon107_Else;

  anon107_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp51 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
    goto anon72;

  anon107_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp52 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
    goto anon72;

  anon72:
    call OAuth20NameSpace.ValidateTokenResponse.set_Realm$System.String(local_1_prime_Ref, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp50 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp51 else $tmp52)));
    goto anon79;

  anon105_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_prime_Ref)) != T$OAuth20NameSpace.ValidateTokenResponse;
    assume {:breadcrumb 474} true;
    goto anon108_Then, anon108_Else;

  anon108_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp53 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
    goto anon78;

  anon108_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon109_Then, anon109_Else;

  anon109_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp54 := OAuth20NameSpace.AccessTokenEntry.get_Realm(local_0_Ref);
    goto anon78;

  anon109_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp55 := GenericAuthNameSpace.Permission_Claim.get_Realm(local_0_Ref);
    goto anon78;

  anon78:
    call GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req.set_Realm$System.String(local_1_prime_Ref, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp53 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp54 else $tmp55)));
    goto anon79;

  anon79:
    local_2_Ref := local_1_prime_Ref;
    goto IL_00e5;

  IL_00e5:
    $result := local_2_Ref;
    return;
}



const {:value "token"} unique $string_literal_token_44: Ref;

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

  anon0:
    req := req$in;
    assume {:breadcrumb 475} true;
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := req;
    goto anon69_Then, anon69_Else;

  anon69_Then:
    assume {:partition} req == null;
    assume {:breadcrumb 476} true;
    local_3_Ref := null;
    goto IL_00bf;

  anon69_Else:
    assume {:partition} req != null;
    assume {:breadcrumb 477} true;
    local_0_Ref := req;
    $tmp0 := local_0_Ref;
    assume $tmp0 != null;
    local_5_Ref := F$OAuth20NameSpace.AuthorizationRequest.response_type[$tmp0];
    goto anon70_Then, anon70_Else;

  anon70_Then:
    assume {:partition} local_5_Ref != null;
    assume {:breadcrumb 478} true;
    call $tmp1 := System.String.op_Equality$System.String$System.String(local_5_Ref, $string_literal_code_0);
    goto anon71_Then, anon71_Else;

  anon71_Then:
    assume {:partition} !$tmp1;
    assume {:breadcrumb 480} true;
    call $tmp2 := System.String.op_Equality$System.String$System.String(local_5_Ref, $string_literal_token_44);
    goto anon72_Then, anon72_Else;

  anon72_Then:
    assume {:partition} $tmp2;
    assume {:breadcrumb 482} true;
    goto IL_0078;

  anon72_Else:
    assume {:partition} !$tmp2;
    assume {:breadcrumb 483} true;
    goto anon7;

  anon7:
    goto IL_00ab;

  anon71_Else:
    assume {:partition} $tmp1;
    assume {:breadcrumb 481} true;
    goto anon9;

  anon9:
    goto anon73_Then, anon73_Else;

  anon73_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    call $tmp3 := LiveIDNameSpace.LiveID_IdP.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
    goto anon14;

  anon73_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon74_Then, anon74_Else;

  anon74_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    call $tmp4 := OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
    goto anon14;

  anon74_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    call $tmp5 := OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
    goto anon14;

  anon14:
    local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp3 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp4 else $tmp5));
    assume $this != null;
    goto anon75_Then, anon75_Else;

  anon75_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp6 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
    $tmp7 := local_0_Ref;
    assume $tmp7 != null;
    goto anon76_Then, anon76_Else;

  anon76_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest;
    call $tmp8 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
    goto anon20;

  anon76_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.AuthenticationRequest;
    goto anon77_Then, anon77_Else;

  anon77_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp9 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
    goto anon20;

  anon77_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp10 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(local_0_Ref);
    goto anon20;

  anon20:
    call $tmp11 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp6, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp7], (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp8 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp9 else $tmp10)), local_1_Ref);
    goto anon27;

  anon75_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp12 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
    $tmp13 := local_0_Ref;
    assume $tmp13 != null;
    goto anon78_Then, anon78_Else;

  anon78_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest;
    call $tmp14 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
    goto anon26;

  anon78_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.AuthenticationRequest;
    goto anon79_Then, anon79_Else;

  anon79_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp15 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
    goto anon26;

  anon79_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp16 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(local_0_Ref);
    goto anon26;

  anon26:
    call $tmp17 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp12, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp13], (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp14 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp15 else $tmp16)), local_1_Ref);
    goto anon27;

  anon27:
    goto anon80_Then, anon80_Else;

  anon80_Then:
    assume {:partition} !(if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp11 else $tmp17);
    assume {:breadcrumb 484} true;
    local_3_Ref := null;
    goto IL_00bf;

  anon80_Else:
    assume {:partition} (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp11 else $tmp17);
    assume {:breadcrumb 485} true;
    goto anon30;

  anon30:
    goto IL_00af;

  IL_0078:
    goto anon81_Then, anon81_Else;

  anon81_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    $tmp18 := local_0_Ref;
    assume $tmp18 != null;
    $tmp19 := local_0_Ref;
    assume $tmp19 != null;
    $tmp20 := local_0_Ref;
    assume $tmp20 != null;
    call $tmp21 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp18], F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp19], F$OAuth20NameSpace.AuthorizationRequest.state[$tmp20]);
    goto anon35;

  anon81_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon82_Then, anon82_Else;

  anon82_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp22 := local_0_Ref;
    assume $tmp22 != null;
    $tmp23 := local_0_Ref;
    assume $tmp23 != null;
    $tmp24 := local_0_Ref;
    assume $tmp24 != null;
    call $tmp25 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp22], F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp23], F$OAuth20NameSpace.AuthorizationRequest.state[$tmp24]);
    goto anon35;

  anon82_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp26 := local_0_Ref;
    assume $tmp26 != null;
    $tmp27 := local_0_Ref;
    assume $tmp27 != null;
    $tmp28 := local_0_Ref;
    assume $tmp28 != null;
    call $tmp29 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp26], F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp27], F$OAuth20NameSpace.AuthorizationRequest.state[$tmp28]);
    goto anon35;

  anon35:
    local_2_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp21 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp25 else $tmp29));
    assume $this != null;
    goto anon83_Then, anon83_Else;

  anon83_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp30 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
    $tmp31 := local_0_Ref;
    assume $tmp31 != null;
    goto anon84_Then, anon84_Else;

  anon84_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest;
    call $tmp32 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
    goto anon41;

  anon84_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.AuthenticationRequest;
    goto anon85_Then, anon85_Else;

  anon85_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp33 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
    goto anon41;

  anon85_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp34 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(local_0_Ref);
    goto anon41;

  anon41:
    call $tmp35 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp30, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp31], (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp32 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp33 else $tmp34)));
    goto anon48;

  anon83_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp36 := F$GenericAuthNameSpace.AS.IdpAuthRecs[$this];
    $tmp37 := local_0_Ref;
    assume $tmp37 != null;
    goto anon86_Then, anon86_Else;

  anon86_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest;
    call $tmp38 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
    goto anon47;

  anon86_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.AuthenticationRequest;
    goto anon87_Then, anon87_Else;

  anon87_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp39 := OAuth20NameSpace.AuthorizationRequest.get_Realm(local_0_Ref);
    goto anon47;

  anon87_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp40 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(local_0_Ref);
    goto anon47;

  anon47:
    call $tmp41 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp36, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp37], (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp38 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp39 else $tmp40)));
    goto anon48;

  anon48:
    local_1_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.AS.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp35 else $tmp41);
    goto IL_00af;

  anon70_Else:
    assume {:partition} local_5_Ref == null;
    assume {:breadcrumb 479} true;
    goto IL_00ab;

  IL_00ab:
    local_3_Ref := null;
    goto IL_00bf;

  IL_00af:
    goto anon88_Then, anon88_Else;

  anon88_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    goto anon89_Then, anon89_Else;

  anon89_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp42 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_1_Ref);
    goto anon53;

  anon89_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp43 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
    goto anon53;

  anon53:
    call $tmp44 := OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp42 else $tmp43), local_1_Ref);
    goto anon68;

  anon88_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon90_Then, anon90_Else;

  anon90_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    goto anon91_Then, anon91_Else;

  anon91_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp45 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_1_Ref);
    goto anon58;

  anon91_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp46 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
    goto anon58;

  anon58:
    call $tmp47 := OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp45 else $tmp46), local_1_Ref);
    goto anon68;

  anon90_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    goto anon92_Then, anon92_Else;

  anon92_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer;
    goto anon93_Then, anon93_Else;

  anon93_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp48 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_1_Ref);
    goto anon63;

  anon93_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp49 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
    goto anon63;

  anon63:
    call $tmp50 := GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp48 else $tmp49), local_1_Ref);
    goto anon68;

  anon92_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OAuth20NameSpace.AuthorizationServer;
    goto anon94_Then, anon94_Else;

  anon94_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp51 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_1_Ref);
    goto anon67;

  anon94_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp52 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_1_Ref);
    goto anon67;

  anon67:
    call $tmp53 := GenericAuthNameSpace.AS.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp51 else $tmp52), local_1_Ref);
    goto anon68;

  anon68:
    local_3_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp44 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp47 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp50 else $tmp53)));
    goto IL_00bf;

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

  anon0:
    req1 := req1$in;
    assume {:breadcrumb 486} true;
    local_0_Ref := req1;
    $tmp0 := local_0_Ref;
    assume $tmp0 != null;
    local_2_Ref := F$OAuth20NameSpace.AuthorizationRequest.response_type[$tmp0];
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} local_2_Ref != null;
    assume {:breadcrumb 487} true;
    call $tmp1 := System.String.op_Equality$System.String$System.String(local_2_Ref, $string_literal_code_0);
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} !$tmp1;
    assume {:breadcrumb 489} true;
    call $tmp2 := System.String.op_Equality$System.String$System.String(local_2_Ref, $string_literal_token_44);
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} $tmp2;
    assume {:breadcrumb 491} true;
    goto IL_0038;

  anon16_Else:
    assume {:partition} !$tmp2;
    assume {:breadcrumb 492} true;
    goto anon5;

  anon5:
    goto IL_0038;

  anon15_Else:
    assume {:partition} $tmp1;
    assume {:breadcrumb 490} true;
    goto anon7;

  anon7:
    goto anon17_Then, anon17_Else;

  anon17_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    call $tmp3 := LiveIDNameSpace.LiveID_IdP.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
    goto anon12;

  anon17_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon18_Then, anon18_Else;

  anon18_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    call $tmp4 := OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
    goto anon12;

  anon18_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    call $tmp5 := OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
    goto anon12;

  anon12:
    local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp3 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp4 else $tmp5));
    goto IL_003c;

  anon14_Else:
    assume {:partition} local_2_Ref == null;
    assume {:breadcrumb 488} true;
    goto IL_0038;

  IL_0038:
    local_1_Ref := null;
    goto IL_003c;

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

  anon0:
    req := req$in;
    assume {:breadcrumb 493} true;
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    call $tmp0 := OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon7;

  anon8_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    call $tmp1 := OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon7;

  anon9_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer;
    call $tmp2 := OAuth20NameSpace.AuthorizationServer.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon7;

  anon10_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OAuth20NameSpace.AuthorizationServer;
    call $tmp3 := GenericAuthNameSpace.AS.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon7;

  anon7:
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

  anon0:
    resp := resp$in;
    assume {:breadcrumb 494} true;
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.TokenEndpoint$OAuth20NameSpace.AccessTokenRequest($this: Ref, req$in: Ref) returns ($result: Ref);



const {:value "refresh_token"} unique $string_literal_refresh_token_45: Ref;

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

  anon0:
    req := req$in;
    assume {:breadcrumb 495} true;
    goto anon49_Then, anon49_Else;

  anon49_Then:
    assume {:partition} req == null;
    assume {:breadcrumb 496} true;
    local_5_Ref := null;
    goto IL_01f6;

  anon49_Else:
    assume {:partition} req != null;
    assume {:breadcrumb 497} true;
    $tmp0 := req;
    assume $tmp0 != null;
    local_7_Ref := F$OAuth20NameSpace.AccessTokenRequest.grant_type[$tmp0];
    goto anon50_Then, anon50_Else;

  anon50_Then:
    assume {:partition} local_7_Ref != null;
    assume {:breadcrumb 498} true;
    call $tmp1 := System.String.op_Equality$System.String$System.String(local_7_Ref, $string_literal_authorization_code_2);
    goto anon51_Then, anon51_Else;

  anon51_Then:
    assume {:partition} !$tmp1;
    assume {:breadcrumb 500} true;
    call $tmp2 := System.String.op_Equality$System.String$System.String(local_7_Ref, $string_literal_refresh_token_45);
    goto anon52_Then, anon52_Else;

  anon52_Then:
    assume {:partition} $tmp2;
    assume {:breadcrumb 502} true;
    goto IL_0127;

  anon52_Else:
    assume {:partition} !$tmp2;
    assume {:breadcrumb 503} true;
    goto anon7;

  anon7:
    goto IL_01f1;

  anon51_Else:
    assume {:partition} $tmp1;
    assume {:breadcrumb 501} true;
    goto anon9;

  anon9:
    call $tmp11 := OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this);
    goto anon53_Then, anon53_Else;

  anon53_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp11)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp3 := OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this);
    $tmp4 := req;
    assume $tmp4 != null;
    $tmp5 := req;
    assume $tmp5 != null;
    call $tmp6 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.findISSByClientIDAndCode$System.String$System.String($tmp3, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp4], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp5]);
    goto anon12;

  anon53_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp11)) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp7 := OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this);
    $tmp8 := req;
    assume $tmp8 != null;
    $tmp9 := req;
    assume $tmp9 != null;
    call $tmp10 := OAuth20NameSpace.AuthorizationCodeRecs.findISSByClientIDAndCode$System.String$System.String($tmp7, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp8], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp9]);
    goto anon12;

  anon12:
    local_2_Ref := (if $TypeConstructor($DynamicType($tmp11)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp6 else $tmp10);
    goto anon54_Then, anon54_Else;

  anon54_Then:
    assume {:partition} local_2_Ref == null;
    assume {:breadcrumb 504} true;
    local_5_Ref := null;
    goto IL_01f6;

  anon54_Else:
    assume {:partition} local_2_Ref != null;
    assume {:breadcrumb 505} true;
    call $tmp18 := OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this);
    goto anon55_Then, anon55_Else;

  anon55_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp18)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp12 := OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this);
    $tmp13 := req;
    assume $tmp13 != null;
    call $tmp14 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp12, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp13]);
    goto anon17;

  anon55_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp18)) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp15 := OAuth20NameSpace.AuthorizationServer.get_AuthorizationCodeRecs($this);
    $tmp16 := req;
    assume $tmp16 != null;
    call $tmp17 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp15, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp16]);
    goto anon17;

  anon17:
    local_3_Ref := (if $TypeConstructor($DynamicType($tmp18)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp14 else $tmp17);
    $tmp19 := local_3_Ref;
    assume $tmp19 != null;
    $tmp20 := req;
    assume $tmp20 != null;
    call $tmp21 := System.String.op_Inequality$System.String$System.String(F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp19], F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[$tmp20]);
    goto anon56_Then, anon56_Else;

  anon56_Then:
    assume {:partition} $tmp21;
    assume {:breadcrumb 506} true;
    local_5_Ref := null;
    goto IL_01f6;

  anon56_Else:
    assume {:partition} !$tmp21;
    assume {:breadcrumb 507} true;
    goto anon57_Then, anon57_Else;

  anon57_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    $tmp22 := local_3_Ref;
    assume $tmp22 != null;
    $tmp23 := local_3_Ref;
    assume $tmp23 != null;
    $tmp24 := local_3_Ref;
    assume $tmp24 != null;
    call $tmp25 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp22], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp23], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp24]);
    goto anon24;

  anon57_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon58_Then, anon58_Else;

  anon58_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp26 := local_3_Ref;
    assume $tmp26 != null;
    $tmp27 := local_3_Ref;
    assume $tmp27 != null;
    $tmp28 := local_3_Ref;
    assume $tmp28 != null;
    call $tmp29 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp26], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp27], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp28]);
    goto anon24;

  anon58_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp30 := local_3_Ref;
    assume $tmp30 != null;
    $tmp31 := local_3_Ref;
    assume $tmp31 != null;
    $tmp32 := local_3_Ref;
    assume $tmp32 != null;
    call $tmp33 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp30], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp31], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp32]);
    goto anon24;

  anon24:
    local_0_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp25 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp29 else $tmp33));
    call $tmp44 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    goto anon59_Then, anon59_Else;

  anon59_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp34 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp35 := local_0_Ref;
    assume $tmp35 != null;
    $tmp36 := req;
    assume $tmp36 != null;
    $tmp37 := req;
    assume $tmp37 != null;
    call $tmp38 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp34, F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp35], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp36], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp37], local_0_Ref);
    goto anon27;

  anon59_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp44)) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp39 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp40 := local_0_Ref;
    assume $tmp40 != null;
    $tmp41 := req;
    assume $tmp41 != null;
    $tmp42 := req;
    assume $tmp42 != null;
    call $tmp43 := GenericAuthNameSpace.ASAuthTicketRecords_Base.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp39, F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp40], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp41], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp42], local_0_Ref);
    goto anon27;

  anon27:
    goto anon60_Then, anon60_Else;

  anon60_Then:
    assume {:partition} !(if $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp38 else $tmp43);
    assume {:breadcrumb 508} true;
    local_5_Ref := null;
    goto IL_01f6;

  anon60_Else:
    assume {:partition} (if $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp38 else $tmp43);
    assume {:breadcrumb 509} true;
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
    goto anon61_Then, anon61_Else;

  anon61_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp59)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp49 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp50 := req;
    assume $tmp50 != null;
    $tmp51 := req;
    assume $tmp51 != null;
    $tmp52 := req;
    assume $tmp52 != null;
    call $tmp53 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.findISSByClientIDAndRefreshToken$System.String$System.String$System.String($tmp49, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp50], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp51], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp52]);
    goto anon32;

  anon61_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp59)) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp54 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp55 := req;
    assume $tmp55 != null;
    $tmp56 := req;
    assume $tmp56 != null;
    $tmp57 := req;
    assume $tmp57 != null;
    call $tmp58 := OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndRefreshToken$System.String$System.String$System.String($tmp54, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp55], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp56], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp57]);
    goto anon32;

  anon32:
    goto anon62_Then, anon62_Else;

  anon62_Then:
    assume {:partition} (if $TypeConstructor($DynamicType($tmp59)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp53 else $tmp58) == null;
    assume {:breadcrumb 510} true;
    local_5_Ref := null;
    goto IL_01f6;

  anon62_Else:
    assume {:partition} (if $TypeConstructor($DynamicType($tmp59)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp53 else $tmp58) != null;
    assume {:breadcrumb 511} true;
    call $tmp70 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    goto anon63_Then, anon63_Else;

  anon63_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp70)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp60 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp61 := req;
    assume $tmp61 != null;
    $tmp62 := req;
    assume $tmp62 != null;
    $tmp63 := req;
    assume $tmp63 != null;
    call $tmp64 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp60, F$OAuth20NameSpace.AccessTokenRequest.access_token[$tmp61], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp62], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp63]);
    goto anon37;

  anon63_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp70)) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp65 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp66 := req;
    assume $tmp66 != null;
    $tmp67 := req;
    assume $tmp67 != null;
    $tmp68 := req;
    assume $tmp68 != null;
    call $tmp69 := GenericAuthNameSpace.ASAuthTicketRecords_Base.getEntry$GenericAuthNameSpace.Ticket$System.String$System.String($tmp65, F$OAuth20NameSpace.AccessTokenRequest.access_token[$tmp66], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp67], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp68]);
    goto anon37;

  anon37:
    local_0_Ref := (if $TypeConstructor($DynamicType($tmp70)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp64 else $tmp69);
    goto anon64_Then, anon64_Else;

  anon64_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    $tmp71 := local_0_Ref;
    assume $tmp71 != null;
    $tmp72 := local_0_Ref;
    assume $tmp72 != null;
    $tmp73 := local_0_Ref;
    assume $tmp73 != null;
    call $tmp74 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$tmp71], F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp72], F$OAuth20NameSpace.AccessTokenEntry.state[$tmp73]);
    goto anon42;

  anon64_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon65_Then, anon65_Else;

  anon65_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp75 := local_0_Ref;
    assume $tmp75 != null;
    $tmp76 := local_0_Ref;
    assume $tmp76 != null;
    $tmp77 := local_0_Ref;
    assume $tmp77 != null;
    call $tmp78 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$tmp75], F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp76], F$OAuth20NameSpace.AccessTokenEntry.state[$tmp77]);
    goto anon42;

  anon65_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp79 := local_0_Ref;
    assume $tmp79 != null;
    $tmp80 := local_0_Ref;
    assume $tmp80 != null;
    $tmp81 := local_0_Ref;
    assume $tmp81 != null;
    call $tmp82 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$GenericAuthNameSpace.Permissions$System.String($this, F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$tmp79], F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp80], F$OAuth20NameSpace.AccessTokenEntry.state[$tmp81]);
    goto anon42;

  anon42:
    local_4_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp74 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp78 else $tmp82));
    call $tmp93 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    goto anon66_Then, anon66_Else;

  anon66_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp93)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp83 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp84 := local_4_Ref;
    assume $tmp84 != null;
    $tmp85 := req;
    assume $tmp85 != null;
    $tmp86 := req;
    assume $tmp86 != null;
    call $tmp87 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp83, F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp84], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp85], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp86], local_4_Ref);
    goto anon45;

  anon66_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp93)) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp88 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp89 := local_4_Ref;
    assume $tmp89 != null;
    $tmp90 := req;
    assume $tmp90 != null;
    $tmp91 := req;
    assume $tmp91 != null;
    call $tmp92 := GenericAuthNameSpace.ASAuthTicketRecords_Base.setEntry$GenericAuthNameSpace.Ticket$System.String$System.String$GenericAuthNameSpace.Permission_Claim($tmp88, F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp89], F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp90], F$OAuth20NameSpace.AccessTokenRequest.UserID[$tmp91], local_4_Ref);
    goto anon45;

  anon45:
    goto anon67_Then, anon67_Else;

  anon67_Then:
    assume {:partition} !(if $TypeConstructor($DynamicType($tmp93)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp87 else $tmp92);
    assume {:breadcrumb 512} true;
    local_5_Ref := null;
    goto IL_01f6;

  anon67_Else:
    assume {:partition} (if $TypeConstructor($DynamicType($tmp93)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp87 else $tmp92);
    assume {:breadcrumb 513} true;
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
    goto IL_01f6;

  anon50_Else:
    assume {:partition} local_7_Ref == null;
    assume {:breadcrumb 499} true;
    goto IL_01f1;

  IL_01f1:
    local_5_Ref := null;
    goto IL_01f6;

  IL_01f6:
    $result := local_5_Ref;
    return;
}



implementation OAuth20NameSpace.AuthorizationServer.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 514} true;
    call GenericAuthNameSpace.AS.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AuthorizationServer.#cctor();



implementation T$OAuth20NameSpace.AuthorizationServer.#cctor()
{

  anon0:
    return;
}



function T$CST.CST_Struct() : Ref;

const unique T$CST.CST_Struct: int;

var F$CST.CST_Struct.SignedBy: [Ref]Ref;

implementation CST.CST_Struct.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$CST.CST_Struct.SymT[$this] := null;
    F$CST.CST_Struct.SignedBy[$this] := null;
    assume {:breadcrumb 515} true;
    F$CST.CST_Struct.SymT[$this] := $string_literal__26;
    F$CST.CST_Struct.SignedBy[$this] := $string_literal__26;
    call System.Object.#ctor($this);
    return;
}



procedure T$CST.CST_Struct.#cctor();



implementation T$CST.CST_Struct.#cctor()
{

  anon0:
    return;
}



function T$CST.Debug() : Ref;

const unique T$CST.Debug: int;

procedure CST.Debug.reached();



implementation CST.Debug.reached()
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 516} true;
    assert false;
    return;
}



procedure CST.Debug.#ctor($this: Ref);



implementation CST.Debug.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 517} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$CST.Debug.#cctor();



implementation T$CST.Debug.#cctor()
{

  anon0:
    return;
}



function T$CST.Nondet_Base() : Ref;

const unique T$CST.Nondet_Base: int;

procedure CST.Nondet_Base.Int($this: Ref) returns ($result: int);



procedure CST.Nondet_Base.Bool($this: Ref) returns ($result: bool);



procedure corral_atomic_begin();



procedure corral_atomic_end();



procedure corral_getThreadID() returns (id: int);



var $GetMeHereTracker: int;
