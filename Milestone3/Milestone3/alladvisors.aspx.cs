using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace m3
{
    public partial class alladvisors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                   
                    getallad();
                }
                catch (Exception ex)
                {
                    Response.Write("An error occurred: " + ex.Message);   
                }
            }
        }

        protected void getallad()
        {
            try
            {
                DataTable dataTable = new DataTable();
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand alladproc = new SqlCommand("Procedures_AdminListAdvisors", conn);
                    conn.Open();

                    SqlDataAdapter dataad = new SqlDataAdapter(alladproc);
                    dataad.Fill(dataTable);
                }

                allad.DataSource = dataTable;
                allad.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("An error occurred: " + ex.Message);
                
            }
        }

    }
}