<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginAdmin.aspx.cs" Inherits="m3.LoginAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Please Log In <br />
            UserName: <br />
            <asp:TextBox ID="user" runat="server"></asp:TextBox> <br />
            Password: <br />
            <asp:TextBox ID="pass" runat="server"></asp:TextBox> <br />
            <asp:Button ID="submit" runat="server" OnClick="login" Text="Log In" />
            <asp:Label ID="Message" runat="server"></asp:Label>

        </div>
    </form>
</body>
</html>
