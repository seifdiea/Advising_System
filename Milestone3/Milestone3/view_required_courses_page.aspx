<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="view_required_courses_page.aspx.cs" Inherits="Milestone3.view_required_courses_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>

    table {
        width: 100%;
        border-collapse: collapse; 
    }
    th, td {
        border: 2px solid #000; 
        padding: 8px; 
        text-align: left;
    }
    </style>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
        </div>
        <p>&nbsp;</p>
        
        <asp:Button ID="btnBack" runat="server" Text="Back to the previous page" OnClick="btnBack_Click" />
    </form>
</body>
</html>
