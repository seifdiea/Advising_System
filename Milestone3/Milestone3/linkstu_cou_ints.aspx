<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="linkstu_cou_ints.aspx.cs" Inherits="m3.linkstu_cou_ints" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
                                                Course ID: <br />
<asp:TextBox ID="cID" runat="server"></asp:TextBox> <br />
 Instructor ID: <br />
 <asp:TextBox ID="iID" runat="server"></asp:TextBox> <br />
                                                Student ID: <br />
<asp:TextBox ID="stID" runat="server"></asp:TextBox> <br />
 Semester code: <br />
 <asp:TextBox ID="scode" runat="server"></asp:TextBox> <br />
            <asp:Button ID="Submit" runat="server" OnClick="st_co_ins" Text="Submit" />
            <br />
<asp:Button ID="B1" runat="server" Text="Back"  PostBackUrl="HomeAdmin.aspx" /> &nbsp;
        </div>
    </form>
</body>
</html>
