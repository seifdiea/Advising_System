using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class Advisor_Login1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void aid_TextChanged(object sender, EventArgs e)
        {

        }

        protected void password_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Login_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            loginResultLabel.Visible = true;

            if (string.IsNullOrWhiteSpace(aid.Text) || !int.TryParse(aid.Text, out int advisor_id) || string.IsNullOrWhiteSpace(password.Text))
            {
                loginResultLabel.Text = "All fields are required and cannot be empty.";
                loginResultLabel.CssClass = "result-label failure";
                return;
            }

            string pass = password.Text;

            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT dbo.FN_AdvisorLogin(@advisor_Id, @password)", conn);
                cmd.Parameters.AddWithValue("@advisor_Id", advisor_id);
                cmd.Parameters.AddWithValue("@password", pass);

                bool isSuccess = (bool)cmd.ExecuteScalar();

                if (isSuccess)
                {
                    Session["AdvisorID"] = advisor_id;
                    Response.Redirect("Advisor_Data.aspx");
                }
                else
                {
                    SqlCommand checkIdCmd = new SqlCommand("SELECT COUNT(*) FROM Advisor WHERE advisor_id = @advisor_Id", conn);
                    checkIdCmd.Parameters.AddWithValue("@advisor_Id", advisor_id);
                    int idExists = (int)checkIdCmd.ExecuteScalar();

                    if (idExists == 0)
                    {
                        string noIdMessage = "No record found for this ID. Would you like to Register?";
                        ClientScript.RegisterStartupScript(this.GetType(), "noAdvisorId", "if(confirm('" + noIdMessage + "')) { window.location = 'advisor_register.aspx'; }", true);
                    }
                    else
                    {
                        loginResultLabel.Text = "Wrong password. Please try again.";
                        loginResultLabel.CssClass = "result-label failure";
                    }
                }
            }
            catch (Exception ex)
            {
                loginResultLabel.Text = "An error occurred: " + ex.Message;
                loginResultLabel.CssClass = "result-label failure";
            }
            finally
            {
                if (conn != null && conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
            }
        }
    }
}