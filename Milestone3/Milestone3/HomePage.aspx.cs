using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        
        protected void Student_Click(object sender, EventArgs e)
        {
            Response.Redirect("Student_Login.aspx");
        }

        protected void Advisor_Click(object sender, EventArgs e)
        {
            Response.Redirect("Advisor_Login.aspx");
        }

        protected void Admin_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginAdmin.aspx");
        }
    }
}