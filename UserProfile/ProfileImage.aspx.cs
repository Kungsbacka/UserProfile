using System;
using System.Web;

namespace UserProfile
{
    public partial class ProfileImage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] == null || Session["UserGUID"] == null)
            {
                Response.Redirect("~/Default.aspx", true);
            }
            statusLabel.Text = "";
            if (fileUpload.HasFile)
            {
                string path = String.Format("{0}/{1}.jpg", HttpContext.Current.Server.MapPath("~/Upload"), Session["UserName"]);
                string ext = System.IO.Path.GetExtension(fileUpload.FileName);
                if (ext.ToLower() != ".jpg" && ext.ToLower() != ".jpeg")
                {
                    statusLabel.Text = "<span class=\"text-error\">Bilden måste vara av typen JPEG.</span>";
                }
                else
                {
                    try
                    {
                        fileUpload.SaveAs(path);
                    }
                    catch
                    {
                        statusLabel.Text = "<span class=\"text-error\">Ett fel uppstod när bilden laddades upp. (E2)</span>";
                    }
                }
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            string path = "~/Upload/" + Session["UserName"] + ".jpg";
            string imageUrl = "~/Content/default.upload.png";
            if (System.IO.File.Exists(HttpContext.Current.Server.MapPath(path)))
            {
                imageUrl = path + "?c=" + DateTime.Now.Ticks;
            }
            profileImage.ImageUrl = imageUrl;
            previewImage.ImageUrl = imageUrl;
        }

        protected void saveButton_Click(object sender, EventArgs e)
        {
            if (profileImage.ImageUrl.IndexOf(Session["UserName"].ToString()) == -1)
            {
                statusLabel.Text = "<span class=\"text-error\">Klicka på \"Bläddra...\" och välj en bild, eller \"Avbryt\" för att gå tillbaka.</span>";
                return;
            }
            string sourcePath = HttpContext.Current.Server.MapPath("~/Upload/") + Session["UserName"] + ".jpg";
            string destPath = HttpContext.Current.Server.MapPath("~/Cache/") + Session["UserName"] + ".jpg";
            string commitPath = HttpContext.Current.Server.MapPath("~/Commit/") + Session["UserGUID"] + ".jpg";
            string crop = cropCoordinates.Value;
            string settings;
            if (System.Text.RegularExpressions.Regex.IsMatch(crop, "^\\([\\d]+,[\\d]+,[\\d]+,[\\d]+\\)$"))
            {
                settings = "crop=" + crop + "&maxwidth=96&maxheight=96&mode=pad";
            }
            else
            {
                settings = "maxwidth=96&maxheight=96&mode=pad";
            }
            try
            {
                ImageResizer.ImageBuilder.Current.Build(sourcePath, destPath, new ImageResizer.ResizeSettings(settings));
                System.IO.File.Delete(sourcePath);
                System.IO.File.Copy(destPath, commitPath, true);
                Response.Redirect("~/Default.aspx", true);
                return;
            }
            catch
            {
                statusLabel.Text = "<span class=\"text-error\">Ett fel uppstod. Bilden sparades inte. (E1)</span>";
            }
        }

        protected void cancelButton_Click(object sender, EventArgs e)
        {
            string uploadPath = HttpContext.Current.Server.MapPath("~/Upload/") + Session["UserName"] + ".jpg";
            if (System.IO.File.Exists(uploadPath))
            {
                System.IO.File.Delete(uploadPath);
            }
            Response.Redirect("~/Default.aspx", true);
            return;
        }

        protected void flipHorizontalButton_Click(object sender, EventArgs e)
        {
            string uploadPath = HttpContext.Current.Server.MapPath("~/Upload/") + Session["UserName"] + ".jpg";
            if (System.IO.File.Exists(uploadPath))
            {
                ImageResizer.ImageBuilder.Current.Build(uploadPath, uploadPath, new ImageResizer.ResizeSettings("flip=X"));
            }
        }

        protected void flipVerticalButton_Click(object sender, EventArgs e)
        {
            string uploadPath = HttpContext.Current.Server.MapPath("~/Upload/") + Session["UserName"] + ".jpg";
            if (System.IO.File.Exists(uploadPath))
            {
                ImageResizer.ImageBuilder.Current.Build(uploadPath, uploadPath, new ImageResizer.ResizeSettings("flip=Y"));
            }
        }

        protected void rotateButton_Click(object sender, EventArgs e)
        {
            string uploadPath = HttpContext.Current.Server.MapPath("~/Upload/") + Session["UserName"] + ".jpg";
            if (System.IO.File.Exists(uploadPath))
            {
                ImageResizer.ImageBuilder.Current.Build(uploadPath, uploadPath, new ImageResizer.ResizeSettings("rotate=90"));
            }
        }
    }
}