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
    public partial class view_available_courses_page : System.Web.UI.Page
    {
        StringBuilder table = new StringBuilder();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
                SqlConnection conn = new SqlConnection(connStr);


                string sqlQuery = "SELECT * FROM dbo.FN_SemsterAvailableCourses(@semstercode)";

                SqlCommand cmd = new SqlCommand(sqlQuery, conn);

                if (Session["current_semester_code"] == null)
                {
                    Response.Redirect("Student_Login.aspx");
                    return;
                }

                string sc = (string)Session["current_semester_code"];

                cmd.Parameters.AddWithValue("@semstercode", sc);

                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();


                table.Append("<table border='1'>");
                table.Append("<tr><th>Course Name</th><th>Course ID</th></tr>");
                //table.Append("</tr>");

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
