using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class send_credit_hour_request_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void sendCredit_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("Procedures_StudentSendingCHRequest", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            int credits;
            if (Session["student_id"] == null)
            {
                Response.Redirect("Student_Login.aspx");
                return;
            }
            int student_id = (int)Session["student_id"];

            if (!string.IsNullOrWhiteSpace(ch.Text) && int.TryParse(ch.Text, out credits))
            {
                cmd.Parameters.AddWithValue("@StudentID", student_id);
                cmd.Parameters.AddWithValue("@credit_hours", credits);
                cmd.Parameters.AddWithValue("@type", "credit_hours");
                cmd.Parameters.AddWithValue("@comment", comment.Text);
                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Request sent successfully!');", true);
                }
                catch (SqlException ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error has occured. Try again later!');", true);
                }
                finally { conn.Close(); }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Credit hours must be a number and can not be empty!');", true);
            }
        }

        protected void back_click(object sender, EventArgs e)
        {

        }
    }
}