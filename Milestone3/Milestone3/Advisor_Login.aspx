<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Advisor_Login.aspx.cs" Inherits="Milestone3.Advisor_Login1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Advisor Login</title>
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
        input[type=text], input[type=password] {
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
        .register-button {
            width: 100%;
            padding: 10px;
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }
        .register-button:hover {
            background-color: #565e64;
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
        <button class="submit-button" runat="server" onclick="window.location.href='HomePage.aspx';">Back to Home Page</button>
        <h2 style="text-align:center; color:#0366d6">Advisor Login</h2>
        <form id="form2" runat="server">
            <label for="aid">AdvisorID:</label>
            <asp:TextBox ID="aid" runat="server" CssClass="text-input"></asp:TextBox>
    
            <label for="password">Password:</label>
            <asp:TextBox ID="password" runat="server" TextMode="Password" CssClass="text-input"></asp:TextBox>
            <asp:Label ID="loginResultLabel" runat="server" CssClass="result-label" Visible="false"></asp:Label>
            <asp:Button ID="Login" runat="server" CssClass="submit-button" Text="Login" OnClick="Login_Click" />
            <asp:Button ID="Register" runat="server" CssClass="register-button" Text="Register" PostBackUrl="~/advisor_register.aspx" />
        </form>
</div>
</body>
</html>
