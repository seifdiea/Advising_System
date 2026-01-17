<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="view_all_requests_page.aspx.cs" Inherits="Milestone3.view_all_requests_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Advisor Requests</title>
    <style type="text/css">
    .grid-container {
        width: 100%;
        text-align: center;
        margin-top: 20px;
    }
    .grid-view {
        margin: auto;
        border-collapse: collapse;
        width: 90%;
        background: white;
    }
    .grid-view th {
        font-weight: bold;
        background-color: #4c7cd7;
        color: white;
        padding: 8px;
        border: 1px solid #ccd6dd;
    }
    .grid-view td {
        padding: 8px;
        border: 1px solid #ccd6dd;
    }
    .grid-view tr:nth-child(odd) {
        background-color: #e6ecf5;
    }
    .submit-button {
        width: 100%;
        padding: 10px;
        background-color: #4c7cd7;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .submit-button:hover {
        background-color: #395ba8;
    }
    </style>
</head>
<body>
    <div class="grid-container">
        <button class="submit-button" onclick="window.location.href='Advisor_data.aspx';">Back to Advisor Data Page</button>
        <form id="form1" runat="server">
            <asp:GridView ID="RequestsGridView" runat="server" AutoGenerateColumns="True"
                        CssClass="grid-view" GridLines="None" EmptyDataText="No requests found.">
            </asp:GridView>
        </form>
    </div>
</body>
</html>
