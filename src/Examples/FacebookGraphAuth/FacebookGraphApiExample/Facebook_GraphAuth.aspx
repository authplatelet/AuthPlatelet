<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Facebook_GraphAuth.aspx.cs" Inherits="FacebookGraphApiExample.Facebook_GraphAuth" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="notLoggedIn" runat="server">
            <asp:Button id="Login" Text="Get John's Email" OnClick="LoginBtn_Click" runat="server"/>
        </div>
        <div id="LoggedIn" runat="server">
        	<label id="email" runat="server"/>
            <asp:Button id="Logout" Text="Log Out" OnClick="LogoutBtn_Click" runat="server"/>
        </div>
    </form>
</body>
</html>
