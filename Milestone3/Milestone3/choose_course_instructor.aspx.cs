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
    public partial class choose_course_instructor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }
        protected void chooseCourseInstructor_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("Procedures_ChooseInstructor", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            int in_id;
            int c_id;
            
            if (Session["student_id"] == null)
            {
                Response.Redirect("Student_Login.aspx");
                return;
            }
            int student_id = (int)Session["student_id"];
            

            if (!string.IsNullOrWhiteSpace(ci.Text) && !string.IsNullOrWhiteSpace(ii.Text) && !string.IsNullOrWhiteSpace(sc.Text) && int.TryParse(ci.Text, out c_id) && int.TryParse(ii.Text, out in_id))
            {
                cmd.Parameters.AddWithValue("@courseID", c_id);
                cmd.Parameters.AddWithValue("@StudentID", student_id);
                cmd.Parameters.AddWithValue("@SemesterCode",sc.Text);
                cmd.Parameters.AddWithValue("@InstructorID", in_id);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Instructor registered');", true);
                }
                catch (SqlException ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error has occured. Try again later!');", true);
                }
                finally { conn.Close(); }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('CourseID & InstructorID must be a number!');", true);
            }
        }

        protected void back_click(object sender, EventArgs e)
        {
            Response.Redirect("Student_Data.aspx");
        }
    }
}