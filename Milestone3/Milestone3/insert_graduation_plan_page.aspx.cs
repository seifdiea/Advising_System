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
    public partial class insert_graduation_plan_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdvisorID"] == null)
            {
                Response.Redirect("Advisor_Login.aspx");
            }
        }

        protected void InsertButton_Click(object sender, EventArgs e)
        {
            MessageLabel.Visible = true;

            // Validate inputs
            if (string.IsNullOrWhiteSpace(SemesterCodeTextBox.Text) || string.IsNullOrWhiteSpace(ExpectedGraduationDateTextBox.Text) || string.IsNullOrWhiteSpace(SemesterCreditHoursTextBox.Text)
                || string.IsNullOrWhiteSpace(StudentIdTextBox.Text))
            {
                MessageLabel.Text = "All fields are required and cannot be empty.";
                MessageLabel.CssClass = "result-label failure";
                return;
            }

            if (!DateTime.TryParse(ExpectedGraduationDateTextBox.Text, out DateTime expectedGradDate) || expectedGradDate < DateTime.Today)
            {
                MessageLabel.Text = "The expected graduation date should be a future date.";
                MessageLabel.CssClass = "result-label failure";
                return;
            }

            if (!int.TryParse(SemesterCreditHoursTextBox.Text, out int semCreditHours) || semCreditHours <= 0)
            {
                MessageLabel.Text = "Semester credit hours must be a positive integer.";
                MessageLabel.CssClass = "result-label failure";
                return;
            }

            if (!int.TryParse(StudentIdTextBox.Text, out int studentId))
            {
                MessageLabel.Text = "Invalid student ID.";
                MessageLabel.CssClass = "result-label failure";
                return;
            }

                string connectionString = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ConnectionString;
                int sessionAdvisorId = Convert.ToInt32(Session["AdvisorID"]);

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand checkStudentCmd = new SqlCommand("SELECT acquired_hours, advisor_id FROM Student WHERE student_id = @student_id", connection))
                    {
                        checkStudentCmd.Parameters.AddWithValue("@student_id", studentId);
                        SqlDataReader reader = checkStudentCmd.ExecuteReader();

                        if (reader.Read())
                        {
                            int acquiredHours = (int)reader["acquired_hours"];
                            int advisorId = (int)reader["advisor_id"];

                            if (advisorId != sessionAdvisorId)
                            {
                                MessageLabel.Text = "The student isn't under your jurisdiction.";
                                MessageLabel.CssClass = "result-label failure";
                                return;
                            }

                            if (acquiredHours < 157)
                            {
                                MessageLabel.Text = "The student isn't eligible for a graduation plan, less than 157 acquired hours.";
                                MessageLabel.CssClass = "result-label failure";
                                return;
                            }

                        }
                        else
                        {
                            MessageLabel.Text = "Student ID not found.";
                            MessageLabel.CssClass = "result-label failure";
                            return;
                        }
                        reader.Close();
                    }

                    using (SqlCommand command = new SqlCommand("Procedures_AdvisorCreateGP", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.AddWithValue("@Semester_code", SemesterCodeTextBox.Text);
                        command.Parameters.AddWithValue("@expected_graduation_date", expectedGradDate);
                        command.Parameters.AddWithValue("@sem_credit_hours", semCreditHours);
                        command.Parameters.AddWithValue("@advisor_id", sessionAdvisorId);
                        command.Parameters.AddWithValue("@student_id", studentId);

                        command.ExecuteNonQuery();


                     MessageLabel.Text = $"Insertion successful";
                     MessageLabel.CssClass = "result-label success";
                    }

                    connection.Close();
                }
        }
    }
}