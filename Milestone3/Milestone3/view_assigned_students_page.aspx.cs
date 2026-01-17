using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace Milestone3
{
    public partial class view_assigned_students_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdvisorID"] == null)
            {
                Response.Redirect("Advisor_Login.aspx");
            }
            if (!IsPostBack)
            {
                string connectionString = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT DISTINCT major FROM Student";
                    SqlCommand cmd = new SqlCommand(query, connection);
                    connection.Open();
                    MajorDropDown.DataSource = cmd.ExecuteReader();
                    MajorDropDown.DataTextField = "major";
                    MajorDropDown.DataValueField = "major";
                    MajorDropDown.DataBind();
                    connection.Close();
                }

                MajorDropDown.Items.Insert(0, new ListItem("-- Select Major --", ""));
            }
        }

        protected void AdvisorIdTextBox_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Major_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ViewButton_Click(object sender, EventArgs e)
        {
            if (Session["AdvisorID"] != null)
            {
                string connectionString = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ConnectionString;
                SqlConnection connection = new SqlConnection(connectionString);

                using (SqlCommand cmd = new SqlCommand("Procedures_AdvisorViewAssignedStudents", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@AdvisorID", (int)Session["AdvisorID"]);
                    cmd.Parameters.AddWithValue("@major", MajorDropDown.SelectedValue);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        StudentsGridView.DataSource = dt;
                        StudentsGridView.DataBind();
                    }
                }
            }
            else
            {
                Response.Redirect("advisor_login.aspx");
            }
        }
    }
}
