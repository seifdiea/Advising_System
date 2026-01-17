<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_Data.aspx.cs" Inherits="Milestone3.Student_Data" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        .container {
            text-align: center;
            margin-top: 12vh;
        }

        .button {
            display: block;
            margin: 10px auto;
            width: 80%;
            padding: 10px;
            text-align: center;
            background-color: #1DA1F2;
            border: none;
            color: white;
            text-decoration: none;
            font-size: 16px;
            cursor: pointer;
            border-radius: 25px;
            box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.2);
            transition: background-color 0.3s;
            white-space: normal;
        }

        .button:hover {
            background-color: #0F81E7;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container">
    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="button" PostBackUrl="add_telephone_number_page.aspx">Add my telephone number(s) as a student</asp:LinkButton>
    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="button" PostBackUrl="view_optional_courses_page.aspx">View all optional courses in the current semester</asp:LinkButton>
    <asp:LinkButton ID="LinkButton3" runat="server" CssClass="button" PostBackUrl="view_available_courses_page.aspx">View all available courses in the current semester</asp:LinkButton>
    <asp:LinkButton ID="LinkButton4" runat="server" CssClass="button" PostBackUrl="view_required_courses_page.aspx">View the required courses within the current semester</asp:LinkButton>
    <asp:LinkButton ID="LinkButton5" runat="server" CssClass="button" PostBackUrl="view_missing_courses_page.aspx">View the missing courses</asp:LinkButton>
    <asp:LinkButton ID="LinkButton6" runat="server" CssClass="button" PostBackUrl="send_course_request_page.aspx">Sending a course request</asp:LinkButton>
    <asp:LinkButton ID="LinkButton7" runat="server" CssClass="button" PostBackUrl="send_credit_hour_request_page.aspx">Sending a credit hour request</asp:LinkButton>
    <asp:LinkButton ID="LinkButton8" runat="server" CssClass="button" PostBackUrl="view_gradPlan_assignedCourses.aspx">View his/her graduation plan along with his/her assigned courses</asp:LinkButton>
    <asp:LinkButton ID="LinkButton9" runat="server" CssClass="button" PostBackUrl="view_upcoming_notPaid_installment.aspx">View the upcoming not paid installment</asp:LinkButton>
    <asp:LinkButton ID="LinkButton10" runat="server" CssClass="button" PostBackUrl="view_courses_examDetails.aspx">View all courses along with their exams details</asp:LinkButton>
    <asp:LinkButton ID="LinkButton11" runat="server" CssClass="button" PostBackUrl="firstMakeup_registration.aspx">Register for first makeup exam</asp:LinkButton>
    <asp:LinkButton ID="LinkButton12" runat="server" CssClass="button" PostBackUrl="secondMakeup_registration.aspx">Register for second makeup exam</asp:LinkButton>
    <asp:LinkButton ID="LinkButton13" runat="server" CssClass="button" PostBackUrl="view_courses_slotDetails_instructors.aspx">View all courses along with their corresponding slots details and instructors</asp:LinkButton>
    <asp:LinkButton ID="LinkButton14" runat="server" CssClass="button" PostBackUrl="view_courseSlots_taughtBy_instructor_redirect.aspx">View the slots of a certain course that is taught by a certain instructor</asp:LinkButton>
    <asp:LinkButton ID="LinkButton15" runat="server" CssClass="button" PostBackUrl="choose_course_instructor.aspx">Choose the instructor for a certain course</asp:LinkButton>
    <asp:LinkButton ID="LinkButton16" runat="server" CssClass="button" PostBackUrl="view_course_prerequisites.aspx">View all details of all courses with their prerequisites</asp:LinkButton>
</div>
    <div>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="logout" runat="server" Text="Log out" OnClick="logout_Click" Width="97px" />
        </p>
    </div>
    </form>
</body>
</html>
