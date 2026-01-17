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
    public partial class view_advising_students : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["AdvisorID"] == null)
            {
                Response.Redirect("Advisor_Login.aspx");
            }

            if (!IsPostBack)
            {
                    int advisorId = (int)Session["AdvisorID"];
                    string connectionString = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ConnectionString;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        using (SqlCommand command = new SqlCommand("SELECT * FROM Student WHERE advisor_id = @advisorId", connection))
                        {
                            command.Parameters.AddWithValue("@advisorId", advisorId);
                            using (SqlDataAdapter da = new SqlDataAdapter(command))
                            {
                                DataTable dt = new DataTable();
                                da.Fill(dt);
                                StudentsGridView.DataSource = dt;
                                StudentsGridView.DataBind();
                            }
                        }
                    }
                
            }
        }
    }
}