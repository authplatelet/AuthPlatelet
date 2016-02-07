using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CILRepository.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "";

            return View();
        }

        [Authorize]
        public ActionResult Upload()
        {
            ViewBag.Message = "";

            return View();
        }

        [Authorize]
        public ActionResult Download()
        {
            ViewBag.Message = "";

            return View();
        }

        [Authorize]
        public ActionResult DownloadToken()
        {
            ViewBag.Message = "";

            return View();
        }

        [AllowAnonymous]
        public ActionResult DLLHandle(string sha, string token)
        {
            ViewBag.Message = "";

            return View();
        }

        [AllowAnonymous]
        public ActionResult UploadDll(string sha, string token)
        {
            ViewBag.Message = "";

            return View();
        }
    }
}