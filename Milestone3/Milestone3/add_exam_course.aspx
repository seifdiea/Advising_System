<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="add_exam_course.aspx.cs" Inherits="Milestone3.add_exam_course" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Label ID="Label1" runat="server" Text="CourseID"></asp:Label>
        <p>
            <asp:TextBox ID="cid" runat="server" Width="177px"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Date"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="date" runat="server" Width="172px"></asp:TextBox>
        </p>
        <asp:Button ID="firstMakeUp" runat="server" Text="Add First Makeup" Width="121px" Height="42px" OnClick="firstMakeup_Click" />
        <asp:Button ID="secondMakeUp" runat="server" style="margin-left: 18px" Text="Add Second Makeup" Width="142px" Height="41px" OnClick="SecondMakeup_Click" />
        <p>
        <asp:Button ID="back" runat="server" style="margin-left: 0px" Text="Back to previous page" Width="142px" OnClick="back_Click" />
        </p>
    </form>
</body>
</html>
