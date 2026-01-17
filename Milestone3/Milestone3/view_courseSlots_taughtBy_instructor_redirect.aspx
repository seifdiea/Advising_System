<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="view_courseSlots_taughtBy_instructor_redirect.aspx.cs" Inherits="Milestone3.view_courseSlots_taughtBy_instructor_redirect" %>

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
           <asp:TextBox ID="courseid" runat="server" Width="258px"></asp:TextBox>
        </p>
           <asp:Label ID="Label2" runat="server" Text="Instructor ID"></asp:Label>
        <p>
           <asp:TextBox ID="instructorid" runat="server" Width="258px"></asp:TextBox>
        </p>
        
    
    <p>&nbsp;</p>

    <asp:Button ID="ViewSlots" runat="server" Text="View Slots" OnClick="view_courseSlots_taughtBy_instructor" Width="100px" />
    <asp:Button ID="btnBack" runat="server" Text="Back to the previous page" OnClick="btnBack_Click" />
        </div>
</form>
</body>
</html>
