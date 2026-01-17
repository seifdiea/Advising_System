<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="newsemAdmin.aspx.cs" Inherits="m3.newsemAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Startdate: <br />
            <asp:TextBox ID="sdate" runat="server"></asp:TextBox> <br />
             Enddate: <br />
             <asp:TextBox ID="edate" runat="server"></asp:TextBox> <br />
            semester code: <br />
             <asp:TextBox ID="semcode" runat="server"></asp:TextBox> <br />
            <asp:Button ID="Add" runat="server" OnClick="newsem" Text="Add" />
            <br />
<asp:Button ID="B1" runat="server" Text="Back"  PostBackUrl="HomeAdmin.aspx" /> &nbsp;
        </div>
    </form>
</body>
</html>
