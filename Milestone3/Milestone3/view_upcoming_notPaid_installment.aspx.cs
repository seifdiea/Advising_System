using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class view_upcoming_notPaid_installment : System.Web.UI.Page
    {


       


                    

    protected void Page_Load(object sender, EventArgs e)
                    {
         string connStr = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ToString();
         SqlConnection conn = new SqlConnection(connStr);
         
               if (Session["student_id"] == null)
             {
                Response.Redirect("Student_Login.aspx");
                return;
             }
                int sid = (int)Session["student_id"];



         string sqlQuery = "SELECT dbo.FN_StudentUpcoming_installment(@Student_id)";

         SqlCommand cmd = new SqlCommand(sqlQuery, conn);
         cmd.Parameters.AddWithValue("@Student_id", sid);

         
         conn.Open();

         object result = cmd.ExecuteScalar();

         conn.Close();

         string x = result.ToString();

         Response.Write("Next not paid installment is due on " + x);
                        
          }

                    

         protected void back_Click(object sender, EventArgs e)
            {
                Response.Redirect("HomePage.aspx");
            }
                }
        }