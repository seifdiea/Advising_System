x<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomeAdmin.aspx.cs" Inherits="m3.HomeAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="B1" runat="server" Text="All Advisors"  PostBackUrl="alladvisors.aspx" /> &nbsp;&nbsp;
            <asp:Button ID="B2" runat="server" Text="All Students_advisors"  PostBackUrl="studentsadvisorsAdmin.aspx" />&nbsp;&nbsp;
            <asp:Button ID="B3" runat="server" Text="All Pending Requests"  PostBackUrl="penreq.aspx" /> <br />
            <asp:Button ID="B4" runat="server" Text="New Semester"  PostBackUrl="newsemAdmin.aspx" />&nbsp;&nbsp;
            <asp:Button ID="B5" runat="server" Text="New Course"  PostBackUrl="newcouAdmin.aspx" />&nbsp;&nbsp;
            <asp:Button ID="B6" runat="server" Text="Link instructor into slot"  PostBackUrl="linkinst.aspx" /> <br />
            <asp:Button ID="B7" runat="server" Text="Link student to advisor"  PostBackUrl="linkstuadv.aspx" />&nbsp;&nbsp;
            <asp:Button ID="B8" runat="server" Text="Link student to a course"  PostBackUrl="linkstu_cou_ints.aspx" />&nbsp;&nbsp;
            <asp:Button ID="B9" runat="server" Text="Link instructor into slot"  PostBackUrl="linkinst.aspx" /> <br />
            <asp:Button ID="B10" runat="server" Text="View details of instructors"  PostBackUrl="instdetails.aspx" />&nbsp;&nbsp;
            <asp:Button ID="B11" runat="server" Text="Semester offered courses"  PostBackUrl="sem_course.aspx" />&nbsp;&nbsp;

        </div>
    </form>
</body>
</html>
