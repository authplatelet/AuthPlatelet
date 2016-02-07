using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CILRepository.Controllers
{
    public class CILController : Controller
    {
        //
        // GET: /CIL/
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult DLLHandle(string sha, string token)
        {
            return View();
        }
	}
}