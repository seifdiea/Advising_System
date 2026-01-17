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
    public partial class add_telephone_number_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void confirm_Click(object sender, EventArgs e)
        {
           

            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("Procedures_StudentaddMobile", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            if(Session["student_id"]==null)
            {
                Response.Redirect("Student_Login.aspx");
                return;
            }
            
            
            int student_id = (int)Session["student_id"];

            if (String.IsNullOrEmpty(number.Text) || (number.Text).Length > 40)
            {
                Response.Write("Mobile number must not be empty and must be less than or equal to 40 characters.");
                return; 
            }

            cmd.Parameters.AddWithValue("@StudentID", student_id);
            cmd.Parameters.AddWithValue("@mobile_number", number.Text);
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Number added successfully!');", true);
            }
            catch(SqlException ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('You already registered this number before!');", true);   
            }
            finally { conn.Close(); }
            


           
        }

        protected void data_click(object sender, EventArgs e)
        {
            Response.Redirect("Student_Data.aspx");
        }
    }
}