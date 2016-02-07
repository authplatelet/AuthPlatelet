<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="OpenIDExample.LogIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="notLoggedIn" runat="server">
        	<label for="openid_identifier">OpenID: </label>
	        <input id="openid_identifier" name="openid_identifier" size="40" />
            <asp:Button id="Login" Text="Login" OnClick="LoginBtn_Click" runat="server"/>
        </div>
        <div id="LoggedIn" runat="server">
        	<label id="logged_id" runat="server"/>
            <asp:Button id="Logout" Text="Log Out" OnClick="LogoutBtn_Click" runat="server"/>
        </div>
    </form>
</body>
</html>