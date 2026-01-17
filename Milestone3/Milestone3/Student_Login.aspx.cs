using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class Student_Login : System.Web.UI.Page
    {


        protected void Login_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            int student_id;

            // Check if sid.Text is not null or empty before parsing
            if (!string.IsNullOrEmpty(sid.Text) && int.TryParse(sid.Text, out student_id))
            {
                string pass = password.Text;
                if (!string.IsNullOrEmpty(pass))
                {
                    string sqlQuery = "SELECT dbo.FN_StudentLogin(@Student_id, @password)";

                    SqlCommand cmd = new SqlCommand(sqlQuery, conn);
                    cmd.Parameters.AddWithValue("@Student_id", student_id);
                    cmd.Parameters.AddWithValue("@password", pass);

                    conn.Open();

                    object result = cmd.ExecuteScalar();

                    bool isSuccess = (result != null) && (bool)result;

                    conn.Close();

                    if (isSuccess)
                    {
                        Session["current_semester_code"] = "W23";
                        Session["student_id"] = student_id;
                        Response.Redirect("Student_Data.aspx");
                    }
                    else
                    {
                        Response.Write("No matching student account or incorrect password. If you are confident that your credentials are correct, consult an admin to check your financial status.");
                    }
                }
                else
                {
                    Response.Write("Please enter your password before proceeding!");
                }
            }
            else
            {
                Response.Write("Student ID must be a number.");
            }
        }

        protected void Register_Click(object sender, EventArgs e)
        {
            Response.Redirect("Student_Register.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void sid_TextChanged(object sender, EventArgs e)
        {

        }

        protected void password_TextChanged(object sender, EventArgs e)
        {

        }

        protected void back_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }
    }
}