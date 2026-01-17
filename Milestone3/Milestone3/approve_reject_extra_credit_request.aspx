<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="approve_reject_extra_credit_request.aspx.cs" Inherits="Milestone3.approve_reject_extra_credit_request" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Evaluate Credit Hours Requests</title>
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
        input[type=text], input[type=number] {
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
        .success, .failure {
            display: block;
            margin-top: 20px;
            margin-bottom: 10px;
            text-align: center;
            padding: 10px;
            border-radius: 4px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .failure {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <button class="submit-button" onclick="window.location.href='Advisor_data.aspx';">Back to Advisor Data Page</button>
        <h2 style="text-align:center; color:#0366d6">Evaluate Credit Hours Request</h2>
        <form id="form1" runat="server">
            <label for="RequestIDTextBox">Request ID:</label>
            <asp:TextBox ID="RequestIDTextBox" runat="server" type="number"></asp:TextBox>

            <label for="CurrentSemCodeTextBox">Current Semester Code:</label>
            <asp:TextBox ID="CurrentSemCodeTextBox" runat="server"></asp:TextBox>
            
            <asp:Label ID="ResultLabel" runat="server" CssClass="result-label" Visible="false"></asp:Label>
            
            <asp:Button ID="EvaluateButton" runat="server" CssClass="submit-button" Text="Evaluate" OnClick="EvaluateButton_Click" />
        </form>
    </div>
</body>
</html>