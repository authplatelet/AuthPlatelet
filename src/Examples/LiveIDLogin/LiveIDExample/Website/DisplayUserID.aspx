<%@ Page Language="C#"  %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    Session["UserID"]=<%:Session["UserID"]%> <br />
    <% if (Session["UserID"] != null)
           Response.Write("<h1>Authenticated!</h1>"); %>
</body>
</html>
