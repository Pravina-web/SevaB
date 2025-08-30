using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Text.RegularExpressions;
using System.Web.Script.Serialization;


namespace Seva_Bureau
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Page.SetFocus(txtName);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            #region captcha
            string token = Request.Form["g-recaptcha-response"];
            string secretKey = "6LfWVzcrAAAAAP8TjJBPdblTSaDd3b1kc8EAyPFu"; // Replace with your reCAPTCHA v3 secret key

            using (var client = new WebClient())
            {
                var result = client.DownloadString(
                    $"https://www.google.com/recaptcha/api/siteverify?secret={secretKey}&response={token}");
                var serializer = new JavaScriptSerializer();
                var captchaResult = serializer.Deserialize<GoogleCaptchaResponse>(result);

                if (!captchaResult.success || captchaResult.score < 0.5)
                {
                    lblMessage.Text = "❌ CAPTCHA verification failed. Please try again.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Visible = true;
                    return;
                }
            }
            # endregion captcha
            // Sanitize and validate inputs
            // Remove unwanted characters
            string name = Regex.Replace(txtName.Text.Trim(), @"[^a-zA-Z\s]", "");
            string mobile = Regex.Replace(txtMobile.Text.Trim(), @"[^\d]", "");
            string email = txtEmail.Text.Trim();
            string message = txtMessage.Text.Trim();

            // Server-side validation
            if (string.IsNullOrWhiteSpace(name))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "NameRequired", "alert('🚫 Name is a required field.');", true);
                return;
            }

            if (string.IsNullOrWhiteSpace(mobile))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "MobileRequired", "alert('🚫 Mobile number is required.');", true);
                return;
            }

            if (mobile.Length != 10)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "MobileLength", "alert('🚫 Mobile number must be 10 digits.');", true);
                return;
            }

            if (!string.IsNullOrWhiteSpace(email))
            {
                string emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
                if (!Regex.IsMatch(email, emailPattern))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "InvalidEmail", "alert('🚫 Enter a valid email address.');", true);
                    return;
                }
            }

            // Prefix +91 after validation
            mobile = "+91" + mobile;

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "INSERT INTO ContactUs (Name, Mobile, Email, Message, CreatedAt) " +
                               "VALUES (@Name, @Mobile, @Email, @Message, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Message", message);

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "SuccessPopup", "alert('✅ Contact details are saved successfully!');", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "ErrorPopup", "alert('❌ Something went wrong. Please try again!');", true);
                    }
                }
            }

            // Clear fields
            txtName.Text = "";
            txtMobile.Text = "";
            txtEmail.Text = "";
            txtMessage.Text = "";
        }
        public class GoogleCaptchaResponse
        {
            public bool success { get; set; }
            public float score { get; set; }
            public string action { get; set; }
            public string challenge_ts { get; set; }
            public string hostname { get; set; }
        }
    }
}
