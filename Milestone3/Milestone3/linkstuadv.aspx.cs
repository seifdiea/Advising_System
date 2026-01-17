using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace m3
{
    public partial class linkstuadv : System.Web.UI.Page
    {
        protected void linkedstuadv(object sender, EventArgs e)
        {
            String stuID = sID.Text;
            string adviID = aID.Text;
            try
            {
                if (string.IsNullOrEmpty(stuID) || string.IsNullOrEmpty(adviID))
                {
                    Response.Write("please fill in all fields");
                    return;
                }
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                int stID = Int16.Parse(sID.Text);
                int advID = Int16.Parse(aID.Text);

                SqlCommand linkstuadvproc = new SqlCommand("Procedures_AdminLinkStudentToAdvisor", conn);
                linkstuadvproc.CommandType = CommandType.StoredProcedure;
                linkstuadvproc.Parameters.Add(new SqlParameter("@studentID", stID));
                linkstuadvproc.Parameters.Add(new SqlParameter("@advisorID", advID));

                conn.Open();
                linkstuadvproc.ExecuteNonQuery();
                conn.Close();
            }
            catch (Exception ex)
            {
                Response.Write("An error occurred: " + ex.Message);
            }
        }
    }
}