<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="linkinst.aspx.cs" Inherits="m3.linkinst" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
                        Course Id: <br />
<asp:TextBox ID="cID" runat="server"></asp:TextBox> <br />
 Instructor Id: <br />
 <asp:TextBox ID="iID" runat="server"></asp:TextBox> <br />
Slot Id: <br />
 <asp:TextBox ID="sID" runat="server"></asp:TextBox> <br />
            <asp:Button ID="Submit" runat="server" OnClick="linkedinst" Text="Submit" />
            <br />
<asp:Button ID="B1" runat="server" Text="Back"  PostBackUrl="HomeAdmin.aspx" /> &nbsp;
        </div>
    </form>
</body>
</html>
