<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="advisor_register.aspx.cs" Inherits="Milestone3.advisor_register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Advisor Registration</title>
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
        input[type=text], input[type=password], input[type=email], input[type=number] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccd6dd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        select {
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
        <button class="submit-button" runat="server" onclick="window.location.href='Advisor_Login.aspx';">Back to Login Page</button>
        <h2 style="text-align:center; color:#0366d6">Advisor Registration</h2>
        <form id="form1" runat="server">
            <label for="name">Name:</label>
            <asp:TextBox ID="name" runat="server" OnTextChanged="name_TextChanged"></asp:TextBox>

            <label for="password">Password:</label>
            <asp:TextBox ID="password" runat="server" TextMode="Password" OnTextChanged="password_TextChanged"></asp:TextBox>

            <label for="email">Email:</label>
            <asp:TextBox ID="email" runat="server" TextMode="Email" OnTextChanged="email_TextChanged"></asp:TextBox>
          
            <label for="office">Office:</label>
            <asp:TextBox ID="office" runat="server" OnTextChanged="office_TextChanged"></asp:TextBox>
            <asp:Label ID="resultLabel" runat="server" CssClass="result-label" Visible="false"></asp:Label>
            <asp:Button ID="Register" runat="server" CssClass="submit-button" Text="Register" OnClick="Register_Click" />
        </form>
    </div>
</body>
</html>
