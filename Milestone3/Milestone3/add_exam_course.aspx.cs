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
    public partial class add_exam_course : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void firstMakeup_Click(object sender, EventArgs e)
        {
            string s = "First MakeUp";
            helper(s);
        }

        protected void SecondMakeup_Click(object sender, EventArgs e)
        {
            string s = "Second MakeUp";
            helper(s);
        }


        private void helper(string type)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("Procedures_AdminAddExam", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            int courseid;
            DateTime datetime;

            if (!string.IsNullOrWhiteSpace(cid.Text) && !string.IsNullOrWhiteSpace(date.Text) )
            {
                if (int.TryParse(cid.Text, out courseid))
                {
                    if (DateTime.TryParse(date.Text, out datetime)) {
                        cmd.Parameters.AddWithValue("@Type", type);
                        cmd.Parameters.AddWithValue("@date", datetime);
                        cmd.Parameters.AddWithValue("@courseID", courseid);
                        
                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            conn.Close();
                        }
                        catch (SqlException ex)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Adding Exam Failed.');", true);
                            return;
                        }
                        

                    
                    }
                    else { ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please check the format of the datetime (MM/DD/YYYY)');", true);  }

                }
                else { ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Course id must be a number');", true); }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Fill the fields before choosing the exam type!');", true);
            }
        }


        protected void back_Click(object sender, EventArgs e)
        {
            Response.Redirect("");
        }
    }
}