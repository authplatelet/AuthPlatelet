using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.IO;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using CILRepository.Models;
using OpenIDConnectNameSpace;
using System.Collections;
using System.Data.Entity.Validation;
using CST;

namespace CILRepository.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        public AccountController()
            : this(new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(new ApplicationDbContext())))
        {
        }

        public AccountController(UserManager<ApplicationUser> userManager)
        {
            UserManager = userManager;
        }

        public UserManager<ApplicationUser> UserManager { get; private set; }


        public FileResult DownloadToken()
        {
            string token = User.Identity.GetUserId();

            return File(System.Text.Encoding.UTF8.GetBytes(token), "application/octet-stream", "CIL_Server_token");
        }

        
        //test token: C43v4byi0khUXP9ynfyXSZj/e2tHrK0p
        [AllowAnonymous]
        public FileResult DllHandle(string user_sha, string token)
        {
            ViewBag.Message = "";

            token = token.Trim();
            var user = UserManager.FindById(token);

            if (user != null)
            {
                string sha_folder = Path.Combine(@"C:\CST\dlls\", user_sha);

                if (System.IO.Directory.Exists(sha_folder))
                {
                    var owner_path = Path.Combine(sha_folder, user.UserName + ".txt");
                    var isPublic = Path.Combine(sha_folder, "public.txt");

                    if (System.IO.File.Exists(isPublic) || System.IO.File.Exists(owner_path))
                    {
                        IEnumerable files = System.IO.Directory.EnumerateFiles(sha_folder);

                        foreach (string file in files)
                        {
                            if (file.EndsWith(".dll"))
                            {
                                string name = System.IO.Path.GetFileName(file);
                                return File(file, "application/octet-stream", name);
                            }
                        }
                    }
                }
            }


            return null;
        }


        [AllowAnonymous]
        public FileResult DepHandle(string user_sha, string token)
        {
            ViewBag.Message = "";

            token = token.Trim();
            var user = UserManager.FindById(token);

            if (user != null)
            {
                string sha_folder = Path.Combine(@"C:\CST\dlls\", user_sha);

                if (System.IO.Directory.Exists(sha_folder))
                {
                    var owner_path = Path.Combine(sha_folder, user.UserName + ".txt");
                    var isPublic = Path.Combine(sha_folder, "public.txt");

                    if (System.IO.File.Exists(isPublic) || System.IO.File.Exists(owner_path))
                    {
                        IEnumerable files = System.IO.Directory.EnumerateFiles(sha_folder);

                        foreach (string file in files)
                        {
                            if (file.EndsWith(".dep"))
                            {
                                string name = System.IO.Path.GetFileName(file);
                                return File(file, "application/octet-stream", name);
                            }
                        }
                    }
                }
            }


            return null;
        }

        [AllowAnonymous]
        public FileResult DownloadMethodRecord(string user_sha, string token)
        {
            ViewBag.Message = "";

            if (token == null || user_sha == null)
                return null;

            token = token.Trim();
            var user = UserManager.FindById(token);

            if (user != null)
            {
                string method_file = @"C:\CST\methods\" + user_sha + ".txt";

                if (System.IO.File.Exists(method_file))
                {
                    return File(method_file, "application/octet-stream", user_sha + ".txt");
                }
            }

            return null;
        }

        [AllowAnonymous]
        public FileResult Verify(string SymT, string token)
        {
            var user = UserManager.FindById(token);

            if (user != null)
            {
                string vfolder = @"C:\CST\vprogram\";

                if (Request.Files.Count > 0)
                {
                    HttpPostedFileBase assertionFile = null, programFile = null;
                    string assertionFileName = "Assertion.cs", programFileName = "Program.cs";
                    for (int i = 0; i < Request.Files.Count; i++)
                    {
                        HttpPostedFileBase file = Request.Files[i];

                        if (file != null && file.ContentLength > 0)
                        {
                            var fileName = Path.GetFileName(file.FileName);
                            if (file.FileName.Equals(assertionFileName))
                            {
                                assertionFile = file;
                            }
                            else if (file.FileName.Equals(programFileName))
                            {
                                programFile = file;
                            }

                        }
                    }

                    if (assertionFile != null && programFile != null)
                    {
                        byte[] time = BitConverter.GetBytes(DateTime.UtcNow.ToBinary());
                        byte[] key = Guid.NewGuid().ToByteArray();
                        string rand_folder = Convert.ToBase64String(time.Concat(key).ToArray());

                        string vpath = Path.Combine(vfolder, rand_folder);
                        Directory.CreateDirectory(vpath);

                        VProgramGenerator.CreateTempVFolder(vpath);
                        vpath = Path.Combine(vpath, "VProgram");

                        string assertionPath = Path.Combine(vpath, assertionFileName);
                        string programPath = Path.Combine(vpath, programFileName);

                        var assertionFileOutStream = System.IO.File.Create(assertionPath);
                        assertionFile.InputStream.CopyTo(assertionFileOutStream);
                        assertionFileOutStream.Close();

                        var programFileOutStream = System.IO.File.Create(programPath);
                        programFile.InputStream.CopyTo(programFileOutStream);
                        programFileOutStream.Close();

                        bool result = CST_Ops.Certify(SymT, vpath);

                        if (result)
                        {
                            return File(new byte[1], "application/octet-stream", "verified.txt");
                        }
                        else
                        {
                            return File(new byte[1], "application/octet-stream", "not_verified.txt");
                        }

                    }
                }
            }
            return null;
        }

        [AllowAnonymous]
        public ActionResult UploadMethodRecord(string user_sha, string token)
        {
            var user = UserManager.FindById(token);

            if (user != null)
            {
                string method_file = @"C:\CST\methods\" + user_sha + ".txt";
                if (Request.Files.Count > 0)
                {
                   var file = Request.Files[0];

                    if (file != null && file.ContentLength > 0)
                    {
                        StreamReader sr = new StreamReader(file.InputStream);

                        string mrStr = sr.ReadToEnd();
                        string cal_sha = MethodHasher.CalculateSHAFromMRText(mrStr);
                        string[] tr_sha = user_sha.Split(new char[] { '.' });
                        string trimmed_sha = tr_sha[tr_sha.Length - 1];

                        if (cal_sha == trimmed_sha)
                        {
                            var fileName = Path.GetFileName(file.FileName);

                            file.SaveAs(method_file);
                        }
                    }

                }
            }

            return RedirectToAction("Index", "Home");
        }

        DLLHasher hasher = new DLLHasher();

        [AllowAnonymous]
        public ActionResult UploadDll(string user_sha, string token)
        {
            token = token.Trim();
            var user = UserManager.FindById(token);

            if (user != null)
            {
                string sha_folder = @"C:\CST\dlls\" + user_sha;
                if (Request.Files.Count > 0)
                {
                    HttpPostedFileBase depFile = null, dllFile = null;
                    string depFileName = "", dllFileName = "";
                    for (int i = 0; i < Request.Files.Count; i++)
                    {
                        HttpPostedFileBase file = Request.Files[i];

                        if (file != null && file.ContentLength > 0)
                        {
                            var fileName = Path.GetFileName(file.FileName);
                            if (file.FileName.EndsWith(".dep"))
                            {
                                depFile = file;
                                depFileName = file.FileName;
                            }
                            else if (file.FileName.EndsWith(".dll"))
                            {
                                dllFile = file;
                                dllFileName = file.FileName;
                            }

                        }
                    }

                    if (depFile != null && dllFile != null)
                    {
                        byte[] depFileData = new byte[depFile.InputStream.Length];
                        depFile.InputStream.Read(depFileData, 0, depFileData.Length);
                        byte[] dllFileData = new byte[dllFile.InputStream.Length];
                        dllFile.InputStream.Read(dllFileData, 0, dllFileData.Length);


                        string[] tr_sha = user_sha.Split(new char[] { '.' });
                        string trimmed_sha = tr_sha[tr_sha.Length - 1];

                        hasher.RemoveHashInDLLByte(dllFileData, trimmed_sha);

                        string calculated_sha = hasher.GenerateHashInHexStr(depFileData, dllFileData);
                        if (calculated_sha.Equals(trimmed_sha))
                        {
                            if (!Directory.Exists(sha_folder))
                                Directory.CreateDirectory(sha_folder);

                            hasher.saveToCSTFolder(depFileName, depFileData, dllFileName, dllFileData, trimmed_sha);

                            if (user.isIdP)
                            {
                                var owner_path = Path.Combine(sha_folder, user.UserName + ".txt");
                                System.IO.File.WriteAllText(owner_path, "");
                            }
                        }
                    }

                    //                    var path = Path.Combine(sha_folder, fileName);
                    //                    file.SaveAs(path);

                }
            }

            return RedirectToAction("Index", "Home");
        }
        //
        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        private RelyingPartyImpl RP = new RelyingPartyImpl();

        // POST: /Account/MSLogin
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult MSLogin(string provider, string returnUrl)
        {
            // Request a redirect to the external login provider
            RP.CurrentSession = HttpContext.Session;
            //HttpSessionStateBase sessionBase = new HttpSessionStateWrapper(HttpContext.Session);

            //RP.CurrentSession = HttpContext.Session;
            string callback = Url.Action("MSLoginCallback", "Account", null, Request.Url.Scheme);

            string url = "https://login.live.com/oauth20_authorize.srf?client_id=0000000044159E9D&scope=wl.signin%20wl.basic%20wl.offline_access&response_type=code&redirect_uri=" + callback;
//            string url = "https://login.live.com/oauth20_authorize.srf?client_id=0000000044114C32&scope=wl.signin%20wl.basic%20wl.offline_access&response_type=code&redirect_uri=" + callback;
            return Redirect(url);
        }

        //
        // GET: /Account/ExternalLoginCallback
//        string name = "2672633b99598c2b366a437dc797ae4d";
        [AllowAnonymous]
        public async Task<ActionResult> MSLoginCallback(string code)
        {
            if (!string.IsNullOrEmpty(code))
            {
                AuthenticationResponse r = new AuthenticationResponse();
                r.code = code;
                RP.CurrentSession = HttpContext.Session;
                /* verify the logic */
                RP.SignInRP(r);
                if (RP.IsVerified())
                {
                    string userID = RP.GetUserID();
                   // string userID = "2672633b99598c2b366a437dc797ae4d";
                    var user = await UserManager.FindByNameAsync(userID);

                    if (user == null)
                    {

                        byte[] time = BitConverter.GetBytes(DateTime.UtcNow.ToBinary());
                        byte[] key = Guid.NewGuid().ToByteArray();
                        string token = Convert.ToBase64String(time.Concat(key).ToArray());

                        string name = userID;

                        ViewBag.name = name;
                        ViewBag.token = token;
                        return View("MSLoginConfirmation");
                    }
                    else
                    {
                        await SignInAsync(user, isPersistent: false);
                        return RedirectToAction("Index", "Home");
                    }
                }
            }

            return RedirectToAction("Index", "Home");
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<ActionResult> MSLoginConfirmation(MSLoginViewModel model, string name, string token)
        {
            // Get the information about the user from the external login provider
            var user = new ApplicationUser() { UserName = name, Id = token, isIdP = model.isIdP };
            try
            {
                var result = await UserManager.CreateAsync(user);
                if (result.Succeeded)
                {
                    await SignInAsync(user, isPersistent: false);
                    return RedirectToAction("Index", "Home");
                }
            }
            catch (DbEntityValidationException dbEx)
            {
                foreach (var validationErrors in dbEx.EntityValidationErrors)
                {
                    foreach (var validationError in validationErrors.ValidationErrors)
                    {
                        System.Console.WriteLine("Property: {0} Error: {1}", validationError.PropertyName, validationError.ErrorMessage);
                    }
                }
            }
            return RedirectToAction("Index", "Home");
        }


        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Login(LoginViewModel model, string returnUrl)
        {
            /*
                    public ActionResult ExternalLogin(string provider, string returnUrl)
        {
            // Request a redirect to the external login provider
            return new ChallengeResult(provider, Url.Action("ExternalLoginCallback", "Account", new { ReturnUrl = returnUrl }));
        }*/


            /*
            if (ModelState.IsValid)
            {
                var user = await UserManager.FindAsync(model.UserName, model.Password);
                if (user != null)
                {
                    await SignInAsync(user, model.RememberMe);
                    return RedirectToLocal(returnUrl);
                }
                else
                {
                    ModelState.AddModelError("", "Invalid username or password.");
                }
            }
                         */

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/Register
        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Register(RegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = new ApplicationUser() { UserName = model.UserName };
                //                var result = await UserManager.CreateAsync(user, model.Password);
                var result = await UserManager.CreateAsync(user);
                if (result.Succeeded)
                {
                    await SignInAsync(user, isPersistent: false);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    AddErrors(result);
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // POST: /Account/Disassociate
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Disassociate(string loginProvider, string providerKey)
        {
            ManageMessageId? message = null;
            IdentityResult result = await UserManager.RemoveLoginAsync(User.Identity.GetUserId(), new UserLoginInfo(loginProvider, providerKey));
            if (result.Succeeded)
            {
                message = ManageMessageId.RemoveLoginSuccess;
            }
            else
            {
                message = ManageMessageId.Error;
            }
            return RedirectToAction("Manage", new { Message = message });
        }

        //
        // GET: /Account/Manage
        public ActionResult Manage(ManageMessageId? message)
        {
            ViewBag.StatusMessage =
                message == ManageMessageId.ChangePasswordSuccess ? "Your password has been changed."
                : message == ManageMessageId.SetPasswordSuccess ? "Your password has been set."
                : message == ManageMessageId.RemoveLoginSuccess ? "The external login was removed."
                : message == ManageMessageId.Error ? "An error has occurred."
                : "";
            ViewBag.HasLocalPassword = HasPassword();
            ViewBag.ReturnUrl = Url.Action("Manage");
            return View();
        }

        //
        // POST: /Account/Manage
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Manage(ManageUserViewModel model)
        {
            bool hasPassword = HasPassword();
            ViewBag.HasLocalPassword = hasPassword;
            ViewBag.ReturnUrl = Url.Action("Manage");
            if (hasPassword)
            {
                if (ModelState.IsValid)
                {
                    /*
                    IdentityResult result = await UserManager.ChangePasswordAsync(User.Identity.GetUserId(), model.OldPassword, model.NewPassword);
                    if (result.Succeeded)
                    {
                        return RedirectToAction("Manage", new { Message = ManageMessageId.ChangePasswordSuccess });
                    }
                    else
                    {
                        AddErrors(result);
                    }
                     */
                }
            }
            else
            {
                // User does not have a password so remove any validation errors caused by a missing OldPassword field
                ModelState state = ModelState["OldPassword"];
                if (state != null)
                {
                    state.Errors.Clear();
                }

                if (ModelState.IsValid)
                {
                    /*
                    IdentityResult result = await UserManager.AddPasswordAsync(User.Identity.GetUserId(), model.NewPassword);
                    if (result.Succeeded)
                    {
                        return RedirectToAction("Manage", new { Message = ManageMessageId.SetPasswordSuccess });
                    }
                    else
                    {
                        AddErrors(result);
                    }*/
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // POST: /Account/ExternalLogin
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult ExternalLogin(string provider, string returnUrl)
        {
            // Request a redirect to the external login provider
            return new ChallengeResult(provider, Url.Action("ExternalLoginCallback", "Account", new { ReturnUrl = returnUrl }));
        }

        //
        // GET: /Account/ExternalLoginCallback
        [AllowAnonymous]
        public async Task<ActionResult> ExternalLoginCallback(string returnUrl)
        {
            var loginInfo = await AuthenticationManager.GetExternalLoginInfoAsync();
            if (loginInfo == null)
            {
                return RedirectToAction("Login");
            }

            // Sign in the user with this external login provider if the user already has a login
            var user = await UserManager.FindAsync(loginInfo.Login);
            if (user != null)
            {
                await SignInAsync(user, isPersistent: false);
                return RedirectToLocal(returnUrl);
            }
            else
            {
                // If the user does not have an account, then prompt the user to create an account
                ViewBag.ReturnUrl = returnUrl;
                ViewBag.LoginProvider = loginInfo.Login.LoginProvider;
                return View("ExternalLoginConfirmation", new ExternalLoginConfirmationViewModel { UserName = loginInfo.DefaultUserName });
            }
        }

        //
        // POST: /Account/LinkLogin
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LinkLogin(string provider)
        {
            // Request a redirect to the external login provider to link a login for the current user
            return new ChallengeResult(provider, Url.Action("LinkLoginCallback", "Account"), User.Identity.GetUserId());
        }

        //
        // GET: /Account/LinkLoginCallback
        public async Task<ActionResult> LinkLoginCallback()
        {
            var loginInfo = await AuthenticationManager.GetExternalLoginInfoAsync(XsrfKey, User.Identity.GetUserId());
            if (loginInfo == null)
            {
                return RedirectToAction("Manage", new { Message = ManageMessageId.Error });
            }
            var result = await UserManager.AddLoginAsync(User.Identity.GetUserId(), loginInfo.Login);
            if (result.Succeeded)
            {
                return RedirectToAction("Manage");
            }
            return RedirectToAction("Manage", new { Message = ManageMessageId.Error });
        }



        //
        // POST: /Account/ExternalLoginConfirmation
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ExternalLoginConfirmation(ExternalLoginConfirmationViewModel model, string returnUrl)
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Manage");
            }

            if (ModelState.IsValid)
            {
                // Get the information about the user from the external login provider
                var info = await AuthenticationManager.GetExternalLoginInfoAsync();
                if (info == null)
                {
                    return View("ExternalLoginFailure");
                }
                var user = new ApplicationUser() { UserName = model.UserName };
                var result = await UserManager.CreateAsync(user);
                if (result.Succeeded)
                {
                    result = await UserManager.AddLoginAsync(user.Id, info.Login);
                    if (result.Succeeded)
                    {
                        await SignInAsync(user, isPersistent: false);
                        return RedirectToLocal(returnUrl);
                    }
                }
                AddErrors(result);
            }

            ViewBag.ReturnUrl = returnUrl;
            return View(model);
        }

        //
        // POST: /Account/LogOff
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            AuthenticationManager.SignOut();
            return RedirectToAction("Index", "Home");
        }

        //
        // GET: /Account/ExternalLoginFailure
        [AllowAnonymous]
        public ActionResult ExternalLoginFailure()
        {
            return View();
        }

        [ChildActionOnly]
        public ActionResult RemoveAccountList()
        {
            var linkedAccounts = UserManager.GetLogins(User.Identity.GetUserId());
            ViewBag.ShowRemoveButton = HasPassword() || linkedAccounts.Count > 1;
            return (ActionResult)PartialView("_RemoveAccountPartial", linkedAccounts);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing && UserManager != null)
            {
                UserManager.Dispose();
                UserManager = null;
            }
            base.Dispose(disposing);
        }

        #region Helpers
        // Used for XSRF protection when adding external logins
        private const string XsrfKey = "XsrfId";

        private IAuthenticationManager AuthenticationManager
        {
            get
            {
                return HttpContext.GetOwinContext().Authentication;
            }
        }

        private async Task SignInAsync(ApplicationUser user, bool isPersistent)
        {
            AuthenticationManager.SignOut(DefaultAuthenticationTypes.ExternalCookie);
            var identity = await UserManager.CreateIdentityAsync(user, DefaultAuthenticationTypes.ApplicationCookie);
            AuthenticationManager.SignIn(new AuthenticationProperties() { IsPersistent = isPersistent }, identity);
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        private bool HasPassword()
        {
            var user = UserManager.FindById(User.Identity.GetUserId());
            if (user != null)
            {
                return user.PasswordHash != null;
            }
            return false;
        }

        public enum ManageMessageId
        {
            ChangePasswordSuccess,
            SetPasswordSuccess,
            RemoveLoginSuccess,
            Error
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        private class ChallengeResult : HttpUnauthorizedResult
        {
            public ChallengeResult(string provider, string redirectUri) : this(provider, redirectUri, null)
            {
            }

            public ChallengeResult(string provider, string redirectUri, string userId)
            {
                LoginProvider = provider;
                RedirectUri = redirectUri;
                UserId = userId;
            }

            public string LoginProvider { get; set; }
            public string RedirectUri { get; set; }
            public string UserId { get; set; }

            public override void ExecuteResult(ControllerContext context)
            {
                var properties = new AuthenticationProperties() { RedirectUri = RedirectUri };
                if (UserId != null)
                {
                    properties.Dictionary[XsrfKey] = UserId;
                }
                context.HttpContext.GetOwinContext().Authentication.Challenge(properties, LoginProvider);
            }
        }
        #endregion
    }
}