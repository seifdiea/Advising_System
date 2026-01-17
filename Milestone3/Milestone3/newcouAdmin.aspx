<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="newcouAdmin.aspx.cs" Inherits="m3.newcouAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Major: <br />
<asp:TextBox ID="major" runat="server"></asp:TextBox> <br />
 Semester: <br />
 <asp:TextBox ID="sem" runat="server"></asp:TextBox> <br />
Credit Hours: <br />
 <asp:TextBox ID="chours" runat="server"></asp:TextBox> <br />
 Name: <br />
 <asp:TextBox ID="name" runat="server"></asp:TextBox> <br />
is offered: <br />
 <asp:TextBox ID="isoffered" runat="server"></asp:TextBox> <br />
<asp:Button ID="Submit" runat="server" OnClick="newcourse" Text="Add" />
            <br />
<asp:Button ID="B1" runat="server" Text="Back"  PostBackUrl="HomeAdmin.aspx" /> &nbsp;
        </div>
    </form>
</body>
</html>
