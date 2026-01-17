using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class view_courseSlots_taughtBy_instructor : System.Web.UI.Page
    {
        StringBuilder table = new StringBuilder();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
                SqlConnection conn = new SqlConnection(connStr);


                string sqlQuery = "SELECT * FROM dbo.FN_StudentViewSlot(@CourseID, @InstructorID)";

                SqlCommand cmd = new SqlCommand(sqlQuery, conn);

                if (Session["course_id"] == null)
                {
                    Response.Redirect("Student_Login.aspx");
                    return;
                }

                if (Session["instructor_id"] == null)
                {
                    Response.Redirect("Student_Login.aspx");
                    return;
                }

                int ci = (int)Session["course_id"];
                int ii = (int)Session["instructor_id"];

                
                 cmd.Parameters.AddWithValue("@CourseID", ci);
                 cmd.Parameters.AddWithValue("@InstructorID", ii);
                


                 conn.Open();

                 SqlDataReader dr = cmd.ExecuteReader();


                table.Append("<table border='1'>");
                table.Append("<tr><th>Course ID</th><th>Course</th><th>Slot ID</th><th>Day</th><th>Time</th><th>Location</th><th>Course ID</th><th>Instructor ID</th><th>Instructor Name</th></tr>");
                //table.Append("</tr>");

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        table.Append("<tr>");
                        table.Append("<td>" + dr[0] + "</td>");
                        table.Append("<td>" + dr[1] + "</td>");
                        table.Append("<td>" + dr[2] + "</td>");
                        table.Append("<td>" + dr[3] + "</td>");
                        table.Append("<td>" + dr[4] + "</td>");
                        table.Append("<td>" + dr[5] + "</td>");
                        table.Append("<td>" + dr[6] + "</td>");
                        table.Append("<td>" + dr[7] + "</td>");
                        table.Append("<td>" + dr[8] + "</td>");
                        table.Append("</tr>");
                    }
                }
                table.Append("</table>");
                PlaceHolder1.Controls.Add(new Literal { Text = table.ToString() });

                dr.Close();

                conn.Close();
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Session["course_id"] = null;
            Session["instructor_id"] = null;
            Response.Redirect("view_courseSlots_taughtBy_instructor_redirect.aspx");
        }
    }
}