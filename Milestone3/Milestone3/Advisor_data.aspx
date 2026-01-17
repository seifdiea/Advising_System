<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Advisor_data.aspx.cs" Inherits="Milestone3.Advisor_Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Advisor Data</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            color: #333;
        }
        .form-container {
            max-width: 400px;
            padding: 20px;
            margin: 50px auto;
            background: #e6ecf5;
            box-shadow: 0 1px 6px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
        }
        .button {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            background-color: #4c7cd7;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: block;
            font-size: 16px;
            box-sizing: border-box;
        }
        .button:hover {
            background-color: #395ba8;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2 style="text-align:center; color:#0366d6">Advisor Dashboard</h2>
        <button class="button" onclick="window.location.href='view_advising_students.aspx';">View all advising students</button>
        <button class="button" onclick="window.location.href='insert_graduation_plan_page.aspx';">Insert graduation plan for a student</button>
        <button class="button" onclick="window.location.href='insert_courses_page.aspx';">Insert courses for a graduation plan</button>
        <button class="button" onclick="window.location.href='update_expected_graduation_date_page.aspx';">Update expected graduation date</button>
        <button class="button" onclick="window.location.href='delete_course_page.aspx';">Delete course from a graduation plan</button>
        <button class="button" onclick="window.location.href='view_assigned_students_page.aspx';">View assigned students and courses</button>
        <button class="button" onclick="window.location.href='view_all_requests_page.aspx';">View all requests</button>
        <button class="button" onclick="window.location.href='view_pending_requests_page.aspx';">View pending requests</button>
        <button class="button" onclick="window.location.href='approve_reject_extra_credit_request.aspx';">Approve/reject extra credit request</button>
        <button class="button" onclick="window.location.href='approve_reject_extra_courses_request.aspx';">Approve/reject extra courses request</button>
        <br />
        <button class="button" onclick="window.location.href='Advisor_Login.aspx';">Back To Login</button>
    </div>
</body>
</html>