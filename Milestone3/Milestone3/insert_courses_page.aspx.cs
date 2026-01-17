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
    public partial class insert_courses_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdvisorID"] == null)
            {
                Response.Redirect("Advisor_Login.aspx");
            }
        }

        protected void AddCourseButton_Click(object sender, EventArgs e)
        {
            MessageLabel.Visible = true;

            string semesterCode = SemesterCodeTextBox.Text.Trim();
            string courseName = CourseNameTextBox.Text.Trim();

            if (string.IsNullOrWhiteSpace(semesterCode) || string.IsNullOrWhiteSpace(courseName) || string.IsNullOrWhiteSpace(StudentIdTextBox.Text))
            {
                MessageLabel.Text = "All fields are required and cannot be empty.";
                MessageLabel.CssClass = "result-label failure";
                return;
            }

            if (!int.TryParse(StudentIdTextBox.Text, out int studentId))
            {
                MessageLabel.Text = "Invalid student ID.";
                MessageLabel.CssClass = "result-label failure";
                return;
            }

                int advID = (int)Session["AdvisorID"];
                string connectionString = WebConfigurationManager.ConnectionStrings["Advising_System_77"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Check if the student exists and is assigned to the advisor
                    using (SqlCommand checkStudentCmd = new SqlCommand("SELECT COUNT(*) FROM Student WHERE student_id = @student_id AND advisor_id = @advisor_id", connection))
                    {
                        checkStudentCmd.Parameters.AddWithValue("@student_id", studentId);
                        checkStudentCmd.Parameters.AddWithValue("@advisor_id", advID);

                        int studentExists = (int)checkStudentCmd.ExecuteScalar();

                        if (studentExists == 0)
                        {
                            MessageLabel.Text = "Student ID isn't assigned to you or doesn't exist in the database.";
                            MessageLabel.CssClass = "result-label failure";
                            return;
                        }
                    }

                    using (SqlCommand checkCourseCmd = new SqlCommand("SELECT COUNT(*) FROM Course WHERE name = @course_name", connection))
                    {
                        checkCourseCmd.Parameters.AddWithValue("@course_name", courseName);

                        int courseExists = (int)checkCourseCmd.ExecuteScalar();

                        if (courseExists == 0)
                        {
                            MessageLabel.Text = "The following course isn't available.";
                            MessageLabel.CssClass = "result-label failure";
                            return;
                        }
                    }

                    using (SqlCommand command = new SqlCommand("Procedures_AdvisorAddCourseGP", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.AddWithValue("@student_id", studentId);
                        command.Parameters.AddWithValue("@Semester_code", semesterCode);
                        command.Parameters.AddWithValue("@course_name", courseName);

                        try
                        {
                            command.ExecuteNonQuery();
                            MessageLabel.Text = "Course added successfully to Graduation Plan.";
                            MessageLabel.CssClass = "result-label success";
                        }
                        catch (SqlException ex)
                        {
                            if (ex.Number == 2627 || ex.Number == 2601)
                            {
                                MessageLabel.Text = "A duplicate course entry was detected.";
                                MessageLabel.CssClass = "result-label failure";
                            }
                    else
                            {
                                MessageLabel.Text = "Error in adding course: " + ex.Message;
                                MessageLabel.CssClass = "result-label failure";
                            }
                        }
                    }
                    connection.Close();
                }
        }
    }
}