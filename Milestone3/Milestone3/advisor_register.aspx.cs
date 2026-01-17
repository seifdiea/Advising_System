using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace Milestone3
{
    public partial class advisor_register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void name_TextChanged(object sender, EventArgs e)
        {

        }

        protected void password_TextChanged(object sender, EventArgs e)
        {

        }


        protected void email_TextChanged(object sender, EventArgs e)
        {

        }

        protected void office_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Register_Click(object sender, EventArgs e)
        {
            // First, reset the error message for each click.
            resultLabel.Text = String.Empty;

            // Check if all fields are filled.
            if (string.IsNullOrWhiteSpace(name.Text) || string.IsNullOrWhiteSpace(password.Text)|| string.IsNullOrWhiteSpace(email.Text) 
                || string.IsNullOrWhiteSpace(office.Text))
    {
                resultLabel.Text = "All fields are required and cannot be empty.";
                resultLabel.CssClass = "result-label failure";
                resultLabel.Visible = true;
                return;
            }

            // Check for correct email formatting.
            var emailRegex = new Regex(@"^[^\s@]+@[^\s@]+\.[^\s@]+$");
            if (!emailRegex.IsMatch(email.Text))
            {
                resultLabel.Text = "Email format should be Text@Domain.com.";
                resultLabel.CssClass = "result-label failure";
                resultLabel.Visible = true;
                return;
            }

            // Proceed to the database checks
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    using (SqlCommand checkUser = new SqlCommand("SELECT COUNT(*) FROM Advisor WHERE email = @Email", conn))
                    {
                        checkUser.Parameters.AddWithValue("@Email", email.Text);
                        int emailExists = (int)checkUser.ExecuteScalar();
                        if (emailExists > 0)
                        {
                            string message = "This Email has already been registered. Would you like to log in instead?";
                            ClientScript.RegisterStartupScript(this.GetType(), "alreadyRegistered", "alert('" + message + "'); window.location = 'Advisor_Login.aspx';", true);
                            return;
                        }
                    }

                    using (SqlCommand cmd = new SqlCommand("Procedures_AdvisorRegistration", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@advisor_name", name.Text);
                        cmd.Parameters.AddWithValue("@password", password.Text);
                        cmd.Parameters.AddWithValue("@email", email.Text);
                        cmd.Parameters.AddWithValue("@office", office.Text);

                        SqlParameter outputParam = new SqlParameter("@Advisor_id", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outputParam);

                        cmd.ExecuteNonQuery();

                        int advisorId = (int)outputParam.Value;

                        if (advisorId > 0)
                        {
                            resultLabel.Text = "Advisor registered with ID: " + advisorId;
                            resultLabel.CssClass = "result-label success";
                        }
                        else
                        {
                            resultLabel.Text = "Advisor registration failed.";
                            resultLabel.CssClass = "result-label failure";
                        }
                    }
                }
                catch (Exception ex)
                {
                    resultLabel.Text = "An error occurred: " + ex.Message;
                    resultLabel.CssClass = "result-label failure";
                }
                finally
                {
                    resultLabel.Visible = true;
                    conn.Close();
                }
            }
        }
    }
}