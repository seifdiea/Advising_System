<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="instdetails.aspx.cs" Inherits="m3.instdetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
                        <asp:GridView ID="instd" runat="server" AutoGenerateColumns="true">
</asp:GridView>
            <br />
<asp:Button ID="B1" runat="server" Text="Back"  PostBackUrl="HomeAdmin.aspx" /> &nbsp;
        </div>
    </form>
</body>
</html>
