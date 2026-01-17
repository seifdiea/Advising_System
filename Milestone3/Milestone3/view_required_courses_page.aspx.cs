using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class view_required_courses_page : System.Web.UI.Page
    {

        StringBuilder table = new StringBuilder();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
                SqlConnection conn = new SqlConnection(connStr);



                SqlCommand cmd = new SqlCommand("Procedures_ViewRequiredCourses", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                int student_id;
                string sc;

                if (Session["student_id"] == null || Session["current_semester_code"] == null)
                {
                    Response.Redirect("Student_Login.aspx");
                    return;
                }

                student_id = (int)Session["student_id"];
                sc = (string)Session["current_semester_code"];
                
                

                cmd.Parameters.AddWithValue("@StudentID", student_id);
                cmd.Parameters.AddWithValue("@current_semester_code", sc);

                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();


                table.Append("<table border='1'>");
                table.Append("<tr><th>Course ID</th><th>Course Name</th>");
                table.Append("</tr>");

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        table.Append("<tr>");
                        table.Append("<td>" + dr[0] + "</td>");
                        table.Append("<td>" + dr[1] + "</td>");
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
            Response.Redirect("Student_Data.aspx");
        }
    }
}