using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.DynamicData;

namespace m3
{
    public partial class penreq : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand req = new SqlCommand("SELECT * FROM all_Pending_Requests", conn);
                    req.CommandType = CommandType.Text;

                    conn.Open();

                    DataTable dataTable = new DataTable();

                    using (SqlDataAdapter penr = new SqlDataAdapter(req))
                    {
                        penr.Fill(dataTable);
                    }

                    preq.DataSource = dataTable;
                    preq.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("An error occurred: " + ex.Message);
            }
        }

    }
}