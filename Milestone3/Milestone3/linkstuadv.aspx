<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="linkstuadv.aspx.cs" Inherits="m3.linkstuadv" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
                                    Student ID: <br />
<asp:TextBox ID="sID" runat="server"></asp:TextBox> <br />
 Advisor ID: <br />
 <asp:TextBox ID="aID" runat="server"></asp:TextBox> <br />
            <asp:Button ID="Submit" runat="server" OnClick="linkedstuadv" Text="Submit" />
            <br />
<asp:Button ID="B1" runat="server" Text="Back"  PostBackUrl="HomeAdmin.aspx" /> &nbsp;
        </div>
    </form>
</body>
</html>
