<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="view_assigned_students_page.aspx.cs" Inherits="Milestone3.view_assigned_students_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Assigned Students in a Specific Major</title>
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
     .grid-container {
            width: 100%;
            text-align: center;
            margin-top: 20px;
        }
        .grid-view {
            margin: auto;
            border-collapse: collapse;
            width: 90%;
            background: white;
        }
        .grid-view th {
            font-weight: bold;
            background-color: #4c7cd7;
            color: white;
            padding: 8px;
            border: 1px solid #ccd6dd;
        }
        .grid-view td {
            padding: 8px;
            border: 1px solid #ccd6dd;
        }
        .grid-view tr:nth-child(odd) {
            background-color: #e6ecf5;
        }
        .select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccd6dd;
            border-radius: 4px;
            background-color: white;
            -webkit-appearance: none; /* Removes default chrome and safari style */
            -moz-appearance: none; /* Removes default style Firefox */
            appearance: none; /* Removes default browser style */
            font-family: Arial, sans-serif;
        }
        select:focus {
            outline: none;
        }
</style>
</head>
<body>
    <div class="form-container">
    <button class="submit-button" runat="server" onclick="window.location.href='Advisor_data.aspx';">Back to Advisor Data Page</button>
    <form id="form1" runat="server">   
        <h2 style="text-align:center; color:#0366d6">View Assigned Students in a Specific Major</h2>
            <label for="MajorTextBox">Major:</label>
            <asp:DropDownList ID="MajorDropDown" CssClass="select" runat="server"></asp:DropDownList>
            <asp:Button ID="ViewButton" CssClass="submit-button" runat="server" Text="View" OnClick="ViewButton_Click" />
        </div>
        <div class="grid-container">
             <asp:GridView ID="StudentsGridView" runat="server" AutoGenerateColumns="False"
                            CssClass="grid-view" GridLines="None" EmptyDataText="No records found.">
                 <Columns>
                     <asp:BoundField DataField="student_id" HeaderText="Student ID" />
                     <asp:BoundField DataField="Student_name" HeaderText="Student Name" />
                     <asp:BoundField DataField="major" HeaderText="Major" />
                     <asp:BoundField DataField="Course_name" HeaderText="Course Name" />
                 </Columns>
             </asp:GridView>
        </div>
    </form>
</body>
</html>
