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
    public partial class view_pending_requests_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["AdvisorID"] != null)
                {
                    int advisorId = Convert.ToInt32(Session["AdvisorID"]);
                    string connectionString = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ConnectionString;
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        using (SqlCommand command = new SqlCommand("Procedures_AdvisorViewPendingRequests", connection))
                        {
                            command.CommandType = CommandType.StoredProcedure;
                            command.Parameters.AddWithValue("@Advisor_ID", advisorId);

                            connection.Open();

                            using (SqlDataAdapter da = new SqlDataAdapter(command))
                            {
                                DataTable dt = new DataTable();
                                da.Fill(dt);
                                PendingRequestsGridView.DataSource = dt;
                                PendingRequestsGridView.DataBind();
                            }

                            connection.Close();
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
}