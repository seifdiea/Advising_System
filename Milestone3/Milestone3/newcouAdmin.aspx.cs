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
    public partial class newcouAdmin : System.Web.UI.Page
    {
        protected void newcourse(object sender, EventArgs e)
        {
            String majo = major.Text;
            String semse = sem.Text;
            String credhours = chours.Text;
            String corname = name.Text;
            String isoffe = isoffered.Text;
            try
            {
                if(string.IsNullOrEmpty(majo) || string.IsNullOrEmpty(semse) || string.IsNullOrEmpty(credhours) || string.IsNullOrEmpty(corname) || string.IsNullOrEmpty(isoffe))
                {
                    Response.Write("please fill in all fields");
                    return;
                }
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                int sems = Int16.Parse(sem.Text);
                int crehours = Int16.Parse(chours.Text);
                bool isoff;

                if (bool.TryParse(isoffered.Text, out isoff))
                {
                    // Parsing successful, use the 'isoff' variable
                }
                else
                {
                    isoff = false;
                }

                SqlCommand newcouproc = new SqlCommand("Procedures_AdminAddingCourse", conn);
                newcouproc.CommandType = CommandType.StoredProcedure;
                newcouproc.Parameters.Add(new SqlParameter("@major", majo));
                newcouproc.Parameters.Add(new SqlParameter("@semester", sems));
                newcouproc.Parameters.Add(new SqlParameter("@credit_hours", crehours));
                newcouproc.Parameters.Add(new SqlParameter("@name", corname));
                newcouproc.Parameters.Add(new SqlParameter("@is_offered", isoff));

                conn.Open();
                newcouproc.ExecuteNonQuery();
                conn.Close();
            }
            catch (Exception ex)
            {
                Response.Write("An error occurred: " + ex.Message);
            }
        }
    }
}