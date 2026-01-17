<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="secondMakeup_registration.aspx.cs" Inherits="Milestone3.secondMakeup_registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
         <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Text="Course ID"></asp:Label>
        <p>
            <asp:TextBox ID="ci" runat="server" Width="258px"></asp:TextBox>
        </p>
        <asp:Label ID="Label2" runat="server" Text="Current Semester"></asp:Label>
        <p>
            <asp:TextBox ID="cs" runat="server" Width="258px"></asp:TextBox>
        </p>
        <asp:Button ID="RegisterCourse" runat="server" Text="Register" OnClick="registerSecondMakeup_Click" Width="100px" />
        <asp:Button ID="back" runat="server" Text="Back to previous page" OnClick="back_click" style="margin-left: 22px" Width="145px" />
    </div>
</form>
</body>
</html>
