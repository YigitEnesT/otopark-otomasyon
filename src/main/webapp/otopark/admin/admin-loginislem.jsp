<%-- 
    Document   : admin-login2
    Created on : 5 Ara 2023, 18:01:55
    Author     : yetun
--%>


<%@page import="com.mycompany.otopark.otomasyon.logindb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
    <%
        String eposta = request.getParameter("eposta");
        String sifre = request.getParameter("sifre");

        logindb obj = new logindb();

        if ((obj.checkAdmin(eposta, sifre, request))) {
            session.setAttribute("isAdmin", "true");
            response.sendRedirect("admin-homepage.jsp");

        } else {
            out.println("GİRİŞ BAŞARISIZ");
        }

    %>
</body>
</html>
