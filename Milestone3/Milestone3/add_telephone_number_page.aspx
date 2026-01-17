<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="add_telephone_number_page.aspx.cs" Inherits="Milestone3.add_telephone_number_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Please enter your telephone number</div>
        <p>
            <asp:TextBox ID="number" runat="server" Height="18px" Width="233px"></asp:TextBox>
        </p>
        <asp:Button ID="confirm" runat="server" Text="Confirm" OnClick="confirm_Click" />
        <asp:Button ID="data" runat="server" Text="Back to previous page" OnClick="data_click" style="margin-left: 23px" Width="159px" />
    </form>
</body>
</html>
