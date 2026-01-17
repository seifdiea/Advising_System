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
    public partial class approve_reject_extra_courses_request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdvisorID"] == null)
            {
                Response.Redirect("Advisor_Login.aspx");
            }
        }
        protected void EvaluateButton_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(RequestIDTextBox.Text.Trim()) || string.IsNullOrEmpty(CurrentSemCodeTextBox.Text.Trim()))
            {
                DisplayResult("All fields are required and can't be empty.", "failure");
                return;
            }

            if (!int.TryParse(RequestIDTextBox.Text.Trim(), out int requestId))
            {
                DisplayResult("The RequestID must be an integer.", "failure");
                return;
            }

            string currentSemesterCode = CurrentSemCodeTextBox.Text.Trim();
            string connectionString = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("SELECT advisor_id, status, type FROM Request WHERE request_id = @requestID", connection);
                command.Parameters.AddWithValue("@requestID", requestId);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    if (!reader.HasRows)
                    {
                        DisplayResult("The following Request isn't recorded.", "failure");
                        return;
                    }

                    while (reader.Read())
                    {
                        int advisorId = reader.GetInt32(reader.GetOrdinal("advisor_id"));
                        string status = reader.GetString(reader.GetOrdinal("status"));
                        string type = reader.GetString(reader.GetOrdinal("type"));

                        if ((int)Session["advisorid"] != advisorId)
                        {
                            DisplayResult("This request isn't under your jurisdiction.", "failure");
                            return;
                        }

                        if (status.ToLower() != "pending")
                        {
                            DisplayResult("You can only evaluate pending requests.", "failure");
                            return;
                        }

                        if (type.ToLower() != "course")
                        {
                            DisplayResult("This Page isn't for Evaluating Credit Hours Requests! ", "failure");
                            return;
                        }

                    }

                    reader.Close();

                    // Execute the stored procedure only if the status is "Pending"
                    command = new SqlCommand("Procedures_AdvisorApproveRejectCourseRequest", connection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    command.Parameters.AddWithValue("@requestID", requestId);
                    command.Parameters.AddWithValue("@current_semester_code", currentSemesterCode);

                    int affectedRows = command.ExecuteNonQuery();
                    if (affectedRows > 0)
                    {
                        DisplayResult("Evaluation successful.", "success");
                    }
                    else
                    {
                        DisplayResult("Evaluation unsuccessful.", "failure");
                    }
                }
                catch (SqlException ex)
                {
                    DisplayResult("A database error has occurred: " + ex.Message, "failure");
                }
                catch (Exception ex)
                {
                    DisplayResult("An error occurred: " + ex.Message, "failure");
                }
                finally
                {
                    connection.Close();
                }
            }
        }

        private void DisplayResult(string message, string cssClass)
        {
            ResultLabel.Text = message;
            ResultLabel.CssClass = cssClass;
            ResultLabel.Visible = true;
        }
    }
}