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
    public partial class linkinst : System.Web.UI.Page
    {
        protected void linkedinst(object sender, EventArgs e)
        {
            string slID = sID.Text;
            string couID = cID.Text;
            string insID = iID.Text;
            try
            {
                if (string.IsNullOrEmpty(slID) || string.IsNullOrEmpty(couID) || string.IsNullOrEmpty(insID))
                {
                    Response.Write("please fill in all fields");
                    return;
                }
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
                SqlConnection conn = new SqlConnection(connStr);
                int soID = Int16.Parse(sID.Text);
                int coID = Int16.Parse(cID.Text);
                int inID = Int16.Parse(iID.Text);
                SqlCommand linkinstproc = new SqlCommand("Procedures_AdminLinkInstructor", conn);
                linkinstproc.CommandType = CommandType.StoredProcedure;
                linkinstproc.Parameters.Add(new SqlParameter("@cours_id", coID));
                linkinstproc.Parameters.Add(new SqlParameter("@instructor_id", inID));
                linkinstproc.Parameters.Add(new SqlParameter("@slot_id", soID));
                conn.Open();
                linkinstproc.ExecuteNonQuery();
                conn.Close();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Exception: " + ex.Message);
            }
        }
    }
}