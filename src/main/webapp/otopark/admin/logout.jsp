<%-- 
    Document   : logout
    Created on : 4 Ara 2023, 18:29:32
    Author     : yetun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
    <%
        //HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // Oturumu sonlandır
        }
        response.sendRedirect("../home-page.jsp"); // Çıkış yapıldıktan sonra yönlendirme yapabilirsiniz
    %>
</body>
</html>
