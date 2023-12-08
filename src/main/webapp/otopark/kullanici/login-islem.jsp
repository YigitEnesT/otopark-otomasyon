<%-- 
    Document   : login-deneme
    Created on : 2 Ara 2023, 22:57:31
    Author     : yetun
--%>

<%@page import="com.mycompany.otopark.otomasyon.logindb"%>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
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
        session.setAttribute("eposta", eposta);
        
        if((obj.checkUser(eposta, sifre, request))){
            session.setAttribute("isLogin", "true");
            response.sendRedirect("kullanici-homepage.jsp");
            
        }
        else{
            out.println("GİRİŞ BAŞARISIZ");
        }
            
        %>
</body>
</html>
