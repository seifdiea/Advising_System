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
    public partial class newsemAdmin : System.Web.UI.Page
    {
        protected void newsem(object sender, EventArgs e)
        {
            String stdate = sdate.Text;
            String endate = edate.Text;
            String semestercode = semcode.Text;
            try
            {
                if (string.IsNullOrEmpty(stdate) || string.IsNullOrEmpty(endate) || string.IsNullOrEmpty(semestercode))
                {
                    Response.Write("please fill in all fields");
                    return;
                }
                DateTime startdate = DateTime.Parse(sdate.Text);
                DateTime enddatedate = DateTime.Parse(sdate.Text);


                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                

                SqlCommand newsemproc = new SqlCommand("AdminAddingSemester", conn);
                newsemproc.CommandType = CommandType.StoredProcedure;
                newsemproc.Parameters.Add(new SqlParameter("@start_date", stdate));
                newsemproc.Parameters.Add(new SqlParameter("@end_date", endate));
                newsemproc.Parameters.Add(new SqlParameter("@semester_code", semestercode));

                conn.Open();
                newsemproc.ExecuteNonQuery();
                conn.Close();
            }
            catch (Exception ex)
            {
                Response.Write("An error occurred: " + ex.Message);
            }
        }
    }
}