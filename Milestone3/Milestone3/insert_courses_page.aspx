<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="insert_courses_page.aspx.cs" Inherits="Milestone3.insert_courses_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <title>Add Course to Graduation Plan</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            color: #333;
        }
        .form-container {
            max-width: 400px;
            margin: 50px auto;
            background: #e6ecf5;
            padding: 20px;
            box-shadow: 0 1px 6px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
        }
        label {
            color: #0366d6;
            display: block;
            padding-bottom: 5px;
            font-weight: bold;
        }
        input[type=text], input[type=date] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccd6dd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .submit-button {
            width: 100%;
            padding: 10px;
            background-color: #4c7cd7;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .submit-button:hover {
            background-color: #395ba8;
        }
        .result-label {
           display: block;
           margin-top: 20px;
           margin-bottom: 10px;
           text-align: center;
           padding: 10px;
           background-color: #d4edda;
           color: #155724;
           border: 1px solid #c3e6cb;
           border-radius: 4px;
        }
        .success {
           background-color: #d4edda;
           color: #155724;
        }           
        .failure {
               background-color: #f8d7da;
               color: #721c24;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <button class="submit-button" onclick="window.location.href='Advisor_data.aspx';">Back to Advisor Data Page</button>
        <h2 style="text-align:center; color:#0366d6">Add Course to Graduation Plan</h2>
        <form id="form1" runat="server">
            <label for="StudentIdTextBox">Student ID:</label>
            <asp:TextBox ID="StudentIdTextBox" runat="server"></asp:TextBox>
            
            <label for="SemesterCodeTextBox">Semester Code:</label>
            <asp:TextBox ID="SemesterCodeTextBox" runat="server"></asp:TextBox>
            
            <label for="CourseNameTextBox">Course Name:</label>
            <asp:TextBox ID="CourseNameTextBox" runat="server"></asp:TextBox>
            <asp:Label ID="MessageLabel" runat="server" Visible="false"></asp:Label>
            <asp:Button ID="AddCourseButton" CssClass="submit-button" runat="server" Text="Add Course" OnClick="AddCourseButton_Click" />
        </form>
    </div>
</body>
</html>
