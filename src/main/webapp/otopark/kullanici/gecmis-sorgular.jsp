<%-- 
    Document   : gecmis-sorgular
    Created on : 11 Ara 2023, 00:05:06
    Author     : yetun
--%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
    <title>Geçmiş Sorgular</title>
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="kullanici-menu.jsp" %>
    <div class="container mt-4">
        <%
            String kontrol = (String) session.getAttribute("isLogin");
            if (kontrol == null || !kontrol.equals("true")) {
                response.sendRedirect("kullanici-loginpage.jsp");
            } else {
        %>
        <h1 class="text-center mb-4">Geçmiş Sorgular</h1>
        <table class="table table-bordered table-hover mx-auto">
            <thead class="table-dark text-center">
                <tr>
                    <th scope="col">Sıra</th>
                    <th scope="col">Araç Plakası</th>
                </tr>
            </thead>
            <tbody class="text-center">
                <% Cookie[] cookies = request.getCookies();
                    if (cookies != null) {
                        int count = 1;
                        for (Cookie cookie : cookies) {
                            if (cookie.getName().equals("plakaCookie")) {
                                String[] values = cookie.getValue().split("\\|");
                                for (String value : values) {%>
                <tr>
                    <td><%= count %></td>
                    <td><%= value %></td>
                </tr>
                <% count++; } %>
            </tbody>
        </table>
        <% }}}}%>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>