using System;
using System.Web;
using System.Web.UI;
using System.DirectoryServices;
using System.IO;
using System.Security.Principal;

namespace UserProfile
{
    public partial class _Default : Page
    {
        private DirectoryEntry _adUser;
        private string _manager;
        private string _phoneNumberFormatted;

        protected string UserDisplayName { get { return _adUser.GetStringProperty("displayName"); } }
        protected string UserGivenName { get { return _adUser.GetStringProperty("givenName"); } }
        protected string UserSurname { get { return _adUser.GetStringProperty("sn"); } }
        protected string UserMail { get { return _adUser.GetStringProperty("mail"); } }
        protected string UserOffice { get { return _adUser.GetStringProperty("physicalDeliveryOfficeName"); } }
        protected string UserDepartment { get { return _adUser.GetStringProperty("department"); } }
        protected string UserTitle { get { return _adUser.GetStringProperty("title"); } }
        protected string UserPhone { get { return _adUser.GetStringProperty("telephoneNumber"); } }
        protected string UserPhoneFormatted { get { return _phoneNumberFormatted; } }
        protected string UserManager { get { return _manager; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            WindowsIdentity windowsIdentity = User.Identity as WindowsIdentity;
            if (windowsIdentity == null)
            {
                Response.Redirect("~/Error.aspx", true);
                return;
            }
            _adUser = new DirectoryEntry($"LDAP://<SID={windowsIdentity.User.ToString()}>");
            string[] propertyNames = new string[] {
                "givenName", "sn", "sAMAccountName", "displayName", "department",
                "thumbnailPhoto", "mail", "physicalDeliveryOfficeName", "title",
                "telephoneNumber", "manager"};
            _adUser.RefreshCache(propertyNames);
            string phoneNumber = _adUser.GetStringProperty("telephoneNumber");
            if (System.Text.RegularExpressions.Regex.IsMatch(phoneNumber, "^0300-[0-9]{6}$"))
            {
                _phoneNumberFormatted = string.Format("0300-{0} {1} {2}", phoneNumber.Substring(5, 2), phoneNumber.Substring(7, 2), phoneNumber.Substring(9, 2));
            }
            else
            {
                _phoneNumberFormatted = _adUser.GetStringProperty("telephoneNumber");
            }
            string managerDn = _adUser.GetStringProperty("manager");
            if (managerDn != "")
            {
                using (DirectoryEntry managerEntry = new DirectoryEntry("LDAP://" + managerDn))
                {
                    managerEntry.RefreshCache(new string[] { "displayName" });
                    _manager = managerEntry.GetStringProperty("displayName");
                }
            }
            Session["UserName"] = _adUser.GetStringProperty("sAMAccountName");
            Session["UserGUID"] = _adUser.Guid.ToString();
            string relativePath = $"~/Cache/{_adUser.GetStringProperty("sAMAccountName")}.jpg";
            string mappedPath = HttpContext.Current.Server.MapPath(relativePath);
            if (DateTime.Now - File.GetLastWriteTime(mappedPath) > TimeSpan.FromMinutes(30))
            {
                byte[] imageData = _adUser.Properties["thumbnailPhoto"].Value as byte[];
                if (imageData != null)
                {
                    using (FileStream stream = new FileStream(mappedPath, FileMode.Create))
                    {
                        stream.Write(imageData, 0, imageData.Length);
                    }
                }
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            string path = $"~/Cache/{Session["UserName"]}.jpg";
            if (File.Exists(HttpContext.Current.Server.MapPath(path)))
            {
                profileImage.ImageUrl = path + "?c=" + DateTime.Now.Ticks;
            }
            else
            {
                profileImage.ImageUrl = "~/Content/default.profile.png";
            }
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            if (_adUser != null)
            {
                _adUser.Dispose();
            }
        }

        // Crude, but this app is only for internal purposes
        protected bool IsMobileDevice()
        {
            return Request.Browser.IsMobileDevice ||
                Request.UserAgent.IndexOf("iPad", StringComparison.OrdinalIgnoreCase) > -1 ||
                Request.UserAgent.IndexOf("Android", StringComparison.OrdinalIgnoreCase) > -1;
        }
    }
}