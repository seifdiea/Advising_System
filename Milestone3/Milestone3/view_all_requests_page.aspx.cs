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
    public partial class view_all_requests_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdvisorID"] == null)
            {
                Response.Redirect("Advisor_Login.aspx");
            }
            if (!IsPostBack)
            {
                    // Cast the Session variable to the appropriate data type
                    int advisorId = Convert.ToInt32(Session["AdvisorID"]);
                    string connectionString = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ConnectionString;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        // Use the function FN_Advisors_Requests
                        string sqlQuery = "SELECT * FROM FN_Advisors_Requests(@advisorId)";

                        using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                        {
                            command.Parameters.AddWithValue("@advisorId", advisorId);

                            using (SqlDataAdapter da = new SqlDataAdapter(command))
                            {
                                DataTable dt = new DataTable();
                                da.Fill(dt);
                                RequestsGridView.DataSource = dt;
                                RequestsGridView.DataBind();
                            }
                        }
                    }
            }
        }
    }
}