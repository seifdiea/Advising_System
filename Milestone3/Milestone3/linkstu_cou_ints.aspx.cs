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
    public partial class linkstu_cou_ints : System.Web.UI.Page
    {
        protected void st_co_ins(object sender, EventArgs e)
        {
            string couID = cID.Text;
            string insID = iID.Text;
            string soID = stID.Text;
            string semcode = scode.Text;
            try
            {
                if (string.IsNullOrEmpty(couID) || string.IsNullOrEmpty(insID) || string.IsNullOrEmpty(soID) || string.IsNullOrEmpty(semcode))
                {
                    Response.Write("please fill in all fields");
                    return;
                }
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                int coID = Int16.Parse(cID.Text);
                int inID = Int16.Parse(iID.Text);
                int sID = Int16.Parse(stID.Text);

                SqlCommand linkstu_cou_insproc = new SqlCommand("Procedures_AdminLinkStudent", conn);
                linkstu_cou_insproc.CommandType = CommandType.StoredProcedure;
                linkstu_cou_insproc.Parameters.Add(new SqlParameter("@cours_id", coID));
                linkstu_cou_insproc.Parameters.Add(new SqlParameter("@instructor_id", inID));
                linkstu_cou_insproc.Parameters.Add(new SqlParameter("@studentID", sID));
                linkstu_cou_insproc.Parameters.Add(new SqlParameter("@semester_code", semcode));

                conn.Open();
                linkstu_cou_insproc.ExecuteNonQuery();
                conn.Close();
            }
            catch (Exception ex)
            {
                Response.Write("An error occurred: " + ex.Message);
            }
        }
    }
}