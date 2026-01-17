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
    public partial class delete_course_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdvisorID"] == null)
            {
                Response.Redirect("Advisor_Login.aspx");
            }
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            ResultLabel.Visible = true;

            if (string.IsNullOrWhiteSpace(StudentIdTextBox.Text) || string.IsNullOrWhiteSpace(SemesterCodeTextBox.Text) ||
                string.IsNullOrWhiteSpace(CourseIDTextBox.Text))
    {
                ResultLabel.Text = "All fields are required and cannot be empty.";
                ResultLabel.CssClass = "result-label failure";
                return;
            }

            if (!int.TryParse(StudentIdTextBox.Text, out int studentId))
            {
                ResultLabel.Text = "Invalid student ID.";
                ResultLabel.CssClass = "result-label failure";
                return;
            }

            if (!int.TryParse(CourseIDTextBox.Text, out int courseId))
            {
                ResultLabel.Text = "Invalid course ID.";
                ResultLabel.CssClass = "result-label failure";
                return;
            }

                int sessionAdvisorId = Convert.ToInt32(Session["AdvisorID"]);
                string connectionString = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    try
                    {
                        connection.Open();

                        // Check if the student exists and if the logged-in advisor is their assigned advisor
                        using (SqlCommand checkStudentCmd = new SqlCommand("SELECT advisor_id FROM Student WHERE student_id = @student_id", connection))
                        {
                            checkStudentCmd.Parameters.AddWithValue("@student_id", studentId);
                            object advisorIdResult = checkStudentCmd.ExecuteScalar();

                            if (advisorIdResult == null)
                            {
                                ResultLabel.Text = "A student with the following ID doesn't exist.";
                                ResultLabel.CssClass = "result-label failure";
                                return;
                            }

                            int advisorId = Convert.ToInt32(advisorIdResult);
                            if (advisorId != sessionAdvisorId)
                            {
                                ResultLabel.Text = "The student isn't under your jurisdiction.";
                                ResultLabel.CssClass = "result-label failure";
                                return;
                            }
                        }

                        // Check if the student has the course in their graduation plan
                        using (SqlCommand checkCourseCmd = new SqlCommand("SELECT COUNT(*) FROM GradPlan_Course JOIN Graduation_Plan ON GradPlan_Course.plan_id = Graduation_Plan.plan_id WHERE student_id = @student_id AND course_id = @course_id", connection))
                        {
                            checkCourseCmd.Parameters.AddWithValue("@student_id", studentId);
                            checkCourseCmd.Parameters.AddWithValue("@course_id", courseId);

                            int isEnrolledInPlan = (int)checkCourseCmd.ExecuteScalar();
                            if (isEnrolledInPlan == 0)
                            {
                                ResultLabel.Text = "Student isn't enrolled in this course within any graduation plan.";
                                ResultLabel.CssClass = "result-label failure";
                                return;
                            }
                        }

                        // Perform deletion as the student is enrolled in the course within a graduation plan
                        using (SqlCommand deleteCmd = new SqlCommand("Procedures_AdvisorDeleteFromGP", connection))
                        {
                            deleteCmd.CommandType = CommandType.StoredProcedure;
                            deleteCmd.Parameters.AddWithValue("@studentID", studentId);
                            deleteCmd.Parameters.AddWithValue("@sem_code", SemesterCodeTextBox.Text.Trim());
                            deleteCmd.Parameters.AddWithValue("@courseID", courseId);

                            int rowsAffected = deleteCmd.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                ResultLabel.Text = "Course successfully deleted from the graduation plan.";
                                ResultLabel.CssClass = "result-label success";
                            }
                            else
                            {
                                ResultLabel.Text = "Semester Code May Be Incorrect";
                                ResultLabel.CssClass = "result-label failure";
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ResultLabel.Text = $"An error occurred: {ex.Message}";
                        ResultLabel.CssClass = "result-label failure";
                    }
                    finally
                    {
                        if (connection.State == System.Data.ConnectionState.Open)
                        {
                            connection.Close();
                        }
                    }
                }
        }         

        protected void CourseIDTextBox_TextChanged(object sender, EventArgs e)
        {

        }

        protected void SemesterCodeTextBox_TextChanged(object sender, EventArgs e)
        {

        }

        protected void StudentIdTextBox_TextChanged(object sender, EventArgs e)
        {

        }
    }
}