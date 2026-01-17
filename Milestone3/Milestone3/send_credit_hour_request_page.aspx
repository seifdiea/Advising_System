<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="send_credit_hour_request_page.aspx.cs" Inherits="Milestone3.send_credit_hour_request_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Credit Hours"></asp:Label>
        <p>
            <asp:TextBox ID="ch" runat="server" Width="258px"></asp:TextBox>
        </p>
        <asp:Label ID="Label2" runat="server" Text="Comment"></asp:Label>
        <p>
            <asp:TextBox ID="comment" runat="server" Width="258px"></asp:TextBox>
        </p>
        <asp:Button ID="sendCredit" runat="server" Text="Send Request" OnClick="sendCredit_Click" Width="100px" />
        <asp:Button ID="back" runat="server" Text="Back to previous page" OnClick="back_click" style="margin-left: 22px" Width="145px" />
        </div>
    </form>
</body>
</html>
