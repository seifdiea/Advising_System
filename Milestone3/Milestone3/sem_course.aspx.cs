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
    public partial class sem_course : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    semc();
                }
                catch (Exception ex)
                {
                    Response.Write("An error occurred: " + ex.Message);
                }
            }
        }

        protected void semc()
        {
            try
            {
                DataTable dataTable = new DataTable();
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand sem_cou = new SqlCommand("select * from Semster_offered_Courses", conn);
                    conn.Open();

                    SqlDataAdapter dataad = new SqlDataAdapter(sem_cou);
                    dataad.Fill(dataTable);
                }

                semco.DataSource = dataTable;
                semco.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("An error occurred: " + ex.Message);
            }
        }
    }
}