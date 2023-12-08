<%-- 
    Document   : moduleScreen
    Created on : 8 Ara 2023, 16:07:28
    Author     : yetun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Modül Sayfası</title>
</head>
<body>
    <%
        // Formdan gelen parametreyi kontrol et
        String userType = request.getParameter("userType");

        if (userType != null && !userType.isEmpty()) {
            if (userType.equals("admin")) {
                response.sendRedirect("admin/admin-loginpage.jsp");
            } else if (userType.equals("kullanici")) {
                response.sendRedirect("kullanici/kullanici-loginpage.jsp");
            } else {
                // Belirli bir kullanıcı tipi belirtilmemişse, bir hata mesajı gösterilebilir.

                response.sendRedirect("home-page.jsp");

            }
        } else {

            response.sendRedirect("home-page.jsp");

        }
    %>

</body>
</html>
