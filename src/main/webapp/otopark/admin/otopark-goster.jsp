<%-- 
    Document   : otopark-goster
    Created on : 4 Ara 2023, 19:13:46
    Author     : yetun
--%>


<%@page import="com.mycompany.otopark.otomasyon.admindb"%>
<%@page import="com.mycompany.otopark.otomasyon.parkYeri"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>

<%@page import="java.sql.Connection"%>
<%
    ArrayList<parkYeri> parkYerleri = new ArrayList<>();

    try {
        // Veritabanı bağlantısı
        admindb obj = new admindb();

        // Park yerlerini al
        parkYerleri = obj.getOtoparkDurumu(); // Veritabanından park yerlerini al
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <title>Otopark Durumu</title>
    <!-- Stil dosyalarını veya CSS kütüphanelerini buraya ekleyebilirsiniz -->
    <style>
    .table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 8px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #f2f2f2;
        font-weight: bold;
    }

    </style>
</head>
<body>
    <%@include file="admin-menu.jsp" %>
    <%
        String kontrol = (String) session.getAttribute("isAdmin");
        if (kontrol == null || !kontrol.equals("true")) {
            response.sendRedirect("admin-loginpage.jsp");
        }
    %>
<div class="container-lg">
    <h1>Otopark Durumu: <% admindb obj = new admindb(); out.println(obj.getDoluluk()); %>/10</h1>
    <table class="table">
        <thead>
            <tr>
                <th scope="col">Park Yeri ID</th>
                <th scope="col">Plaka</th>
                <th scope="col">Giriş Saati</th>
                <th scope="col">Tutar</th>
                <th scope="col">Durumu</th>
            </tr>
        </thead>
        <tbody>
            <% for (parkYeri parkYer : parkYerleri) { %>
                <tr>
                    <td><%= parkYer.getId() %></td>
                    <td><%= parkYer.getPlaka() != null ? parkYer.getPlaka() : "Boş" %></td>
                    <td><%= parkYer.getGiris_saati() != null ? parkYer.getGiris_saati() : "Boş" %></td>
                    <td><%= parkYer.getGiris_saati() != null ? parkYer.mevcutTutar(parkYer.getGiris_saati()) : "Boş" %></td>
                    <td><%= parkYer.getBosDolu() == 1 ? "Dolu" : "Boş" %></td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>

</body>
</html>