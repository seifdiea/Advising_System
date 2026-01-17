<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_Login.aspx.cs" Inherits="Milestone3.Student_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Label ID="Label1" runat="server" Text="StudentID"></asp:Label>
        <p>
            <asp:TextBox ID="sid" runat="server" Height="21px" Width="229px" OnTextChanged="sid_TextChanged"></asp:TextBox>
        </p>
        <asp:Label ID="Label2" runat="server" Text="Password"></asp:Label>
        <p>
            <asp:TextBox ID="password" runat="server" Height="21px" Width="234px" TextMode="Password" OnTextChanged="password_TextChanged"></asp:TextBox>
        </p>
        <asp:Button ID="Login" runat="server" Text="Login" OnClick="Login_Click" Height="36px" Width="59px" />
        <asp:Button ID="Register" runat="server" Text="Register" style="margin-left: 13px" Height="34px" OnClick="Register_Click" Width="78px" />
        <asp:Button ID="back" runat="server" Text="Back to home page" style="margin-left: 16px" Height="34px" OnClick="back_Click" Width="135px" />
    </form>
</body>
</html>
