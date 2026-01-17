using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace m3
{
    public partial class studentsadvisorsAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    allstuadv();
                }
                catch (Exception ex)
                {
                    Response.Write("An error occurred: " + ex.Message);
                }
            }
        }

        protected void allstuadv()
        {
            try
            {
                DataTable dataTable = new DataTable();
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand allstuadpro = new SqlCommand("AdminListStudentsWithAdvisors", conn);
                    conn.Open();

                    SqlDataAdapter dataad = new SqlDataAdapter(allstuadpro);
                    dataad.Fill(dataTable);
                }

                studadv.DataSource = dataTable;
                studadv.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("An error occurred: " + ex.Message);
            }
        }
    }
}
    

