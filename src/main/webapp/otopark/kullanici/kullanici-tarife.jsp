<%-- 
    Document   : tarife
    Created on : 3 Ara 2023, 22:10:00
    Author     : yetun
--%>


<%@page import="com.mycompany.otopark.otomasyon.kullanicidb"%>
<%@page import="com.mycompany.otopark.otomasyon.tarife"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
    <title>Tarife Ekranı</title>
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
                kullanicidb db = new kullanicidb();
                ArrayList<tarife> myList = db.getTarife();
        %>
        <h1 class="text-center mb-4">Tarife Ekranı</h1>
        <table class="table table-bordered table-hover mx-auto">
            <thead class="table-dark text-center">
                <tr>
                    <th scope="col">Saat Aralığı</th>
                    <th scope="col">Saatlik Ücret</th>
                </tr>
            </thead>
            <tbody class="text-center">
                <% for (tarife veri : myList) {%>
                <tr>
                    <td><%
                        if (veri.getBitis_saati() != null) {
                            out.println(veri.getBaslangic_saati() + " - " + veri.getBitis_saati());
                        }else{
                            out.println(veri.getBaslangic_saati() + "+");
                        }
                        %></td>
                    <td><%= veri.getUcret()%> TL </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% }%>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
