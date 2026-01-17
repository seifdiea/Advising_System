using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;

namespace Milestone3
{
    public partial class Student_Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("Procedures_StudentRegistration", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            int sem;

            if (!string.IsNullOrWhiteSpace(first_name.Text) && !string.IsNullOrWhiteSpace(last_name.Text) && !string.IsNullOrWhiteSpace(password.Text) 
                && !string.IsNullOrWhiteSpace(faculty.Text) && !string.IsNullOrWhiteSpace(email.Text) && !string.IsNullOrWhiteSpace(major.Text)
                && !string.IsNullOrWhiteSpace(semester.Text))
            {
                if (int.TryParse(semester.Text, out sem)) 
                {
                    cmd.Parameters.AddWithValue("@first_name", first_name.Text);
                    cmd.Parameters.AddWithValue("@last_name", last_name.Text);
                    cmd.Parameters.AddWithValue("@password", password.Text);
                    cmd.Parameters.AddWithValue("@faculty", faculty.Text);
                    cmd.Parameters.AddWithValue("@email", email.Text);
                    cmd.Parameters.AddWithValue("@major", major.Text);
                    cmd.Parameters.AddWithValue("@Semester", sem);

                    
                    SqlParameter outputParam = new SqlParameter("@Student_id", SqlDbType.Int);
                    outputParam.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(outputParam);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                    catch(SqlException ex)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Student registration failed.');", true);
                        return;
                    }
                    int studentId = (int)outputParam.Value;

                    Response.Write("Student registered with ID: " + studentId);
                    
                    
                }
                else { ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Semester consists of integers only!');", true); }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('All fields are required.');", true);
            }
        }

        protected void login_click(object sender, EventArgs e)
        {
            Response.Redirect("Student_Login.aspx");
        }
    }
}