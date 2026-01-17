using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class view_courseSlots_taughtBy_instructor_redirect : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void view_courseSlots_taughtBy_instructor(object sender, EventArgs e)
        {
            int cid;
            int inid;
            if (int.TryParse(courseid.Text, out cid))
            {
                if (int.TryParse(instructorid.Text, out inid))
                {
                    Session["course_id"] = cid;
                    Session["instructor_id"] = inid;
                    Response.Redirect("view_courseSlots_taughtBy_instructor.aspx");
                }
                else { Response.Write("instructor id must be a number"); }
            }
            else { Response.Write("course id must be a number"); };
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            
            Response.Redirect("Student_Data.aspx");
        }
    }
}