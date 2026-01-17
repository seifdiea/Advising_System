<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_Register.aspx.cs" Inherits="Milestone3.Student_Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="First Name"></asp:Label>
            <p>
                <asp:TextBox ID="first_name" runat="server"></asp:TextBox>
            </p>
            <asp:Label ID="Label2" runat="server" Text="Last Name"></asp:Label>
            <p>
                <asp:TextBox ID="last_name" runat="server"></asp:TextBox>
            </p>
            <asp:Label ID="Label3" runat="server" Text="Password"></asp:Label>
            <p>
                <asp:TextBox ID="password" runat="server" TextMode="Password"></asp:TextBox>
            </p>
            <asp:Label ID="Label4" runat="server" Text="Faculty"></asp:Label>
            <p>
                <asp:TextBox ID="faculty" runat="server"></asp:TextBox>
            </p>
            <asp:Label ID="Label5" runat="server" Text="Email"></asp:Label>
            <p>
                <asp:TextBox ID="email" runat="server"></asp:TextBox>
            </p>
            <asp:Label ID="Label6" runat="server" Text="Major"></asp:Label>
            <p>
                <asp:TextBox ID="major" runat="server"></asp:TextBox>
            </p>
            <asp:Label ID="Label7" runat="server" Text="Semester"></asp:Label>
            <p>
                <asp:TextBox ID="semester" runat="server"></asp:TextBox>
            </p>
            <asp:Button ID="RegisterButton" runat="server" Text="Register" OnClick="Register_Click" Width="66px" />
            <asp:Button ID="Login" runat="server" Text="Back to Login Page" OnClick="login_click" style="margin-left: 31px" />
        </div>
    </form>
</body>
</html>
