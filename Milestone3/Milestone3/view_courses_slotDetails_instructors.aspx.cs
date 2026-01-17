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
    public partial class view_courses_slotDetails_instructors : System.Web.UI.Page
    {
        StringBuilder table = new StringBuilder();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
                SqlConnection conn = new SqlConnection(connStr);


                string sqlQuery = "SELECT * FROM dbo. Courses_Slots_Instructor";

                SqlCommand cmd = new SqlCommand(sqlQuery, conn);

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
                PlaceHolder4.Controls.Add(new Literal { Text = table.ToString() });

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