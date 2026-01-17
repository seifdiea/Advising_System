using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace m3
{
    public partial class LoginAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        protected void login(object sender, EventArgs e)
        {
            string user12 = "1234";
            string pass12 = "pass2";

            string user1 = user.Text;

            string pass1 = pass.Text;
            try
            {
                if (string.IsNullOrEmpty(user1) || string.IsNullOrEmpty(pass1))
                {
                    Response.Write("please fill in all fields");
                    return;
                }
                int user = Int16.Parse(user1);
                    

                if (user1.Equals(user12) && pass1.Equals(pass12))
                {
                    Response.Redirect("HomeAdmin.aspx");
                }
                else
                {
                    Message.Text = "Invalid username or password";
                }
            }
            catch (Exception ex)
            {
                Message.Text = "An error occurred: " + ex.Message;
            }
        }
    }
}