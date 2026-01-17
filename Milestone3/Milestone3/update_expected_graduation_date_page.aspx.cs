using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace Milestone3
{
    public partial class update_expected_graduation_date_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdvisorID"] == null)
            {
                Response.Redirect("Advisor_Login.aspx");
            }
        }

        protected void StudentIdTextBox_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ExpectedGraduationDateTextBox_TextChanged(object sender, EventArgs e)
        {

        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            ResultLabel.Visible = true;

            if (string.IsNullOrWhiteSpace(StudentIdTextBox.Text)|| string.IsNullOrWhiteSpace(ExpectedGraduationDateTextBox.Text))
    {
                ResultLabel.Text = "All fields are required and cannot be empty.";
                ResultLabel.CssClass = "result-label failure";
                return;
            }

            if (!DateTime.TryParse(ExpectedGraduationDateTextBox.Text, out DateTime expectedGradDate) || expectedGradDate < DateTime.Today)
    {
                ResultLabel.Text = "The expected graduation date should be a future date.";
                ResultLabel.CssClass = "result-label failure";
                return;
            }

            if (!int.TryParse(StudentIdTextBox.Text, out int studentId))
            {
                ResultLabel.Text = "Invalid student ID.";
                ResultLabel.CssClass = "result-label failure";
                return;
            }

                string connectionString = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand checkStudentCmd = new SqlCommand("SELECT advisor_id FROM Student WHERE student_id = @student_id", connection))
                    {
                        connection.Open();
                        checkStudentCmd.Parameters.AddWithValue("@student_id", studentId);
                        SqlDataReader reader = checkStudentCmd.ExecuteReader();

                        if (reader.Read())
                        {
                            int advisorId = (int)reader["advisor_id"];
                            int sessionAdvisorID = (int)Session["AdvisorID"];
                            if (advisorId != sessionAdvisorID)
                            {
                                ResultLabel.Text = "The student isn't under your jurisdiction.";
                                ResultLabel.CssClass = "result-label failure";
                                return;
                            }
                        }
                        else
                        {
                            ResultLabel.Text = "Student ID not found.";
                            ResultLabel.CssClass = "result-label failure";
                            return;
                        }
                        reader.Close();
                    }

                    SqlCommand command = new SqlCommand("Procedures_AdvisorUpdateGP", connection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    command.Parameters.AddWithValue("@studentID", studentId);
                    command.Parameters.AddWithValue("@expected_grad_date", expectedGradDate);

                    try
                    {
                        command.ExecuteNonQuery();
                        ResultLabel.Text = "Graduation Plan updated successfully.";
                        ResultLabel.CssClass = "result-label success";
                    }
                    catch (Exception ex)
                    {
                        ResultLabel.Text = $"An error occurred: {ex.Message}";
                        ResultLabel.CssClass = "result-label failure";
                    }
                    finally
                    {
                        connection.Close();
                    }
                }
        }
    }
}