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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <title>Otopark Durumu</title>
    <!-- Stil dosyalarını veya CSS kütüphanelerini buraya ekleyebilirsiniz -->
    <link rel="stylesheet" href="style.css" />

</head>
<body>
    <%@include file="admin-menu.jsp" %>
    <%
        String kontrol = (String) session.getAttribute("isAdmin");
        if (kontrol == null || !kontrol.equals("true")) {
            response.sendRedirect("admin-loginpage.jsp");
        }
    %>
    <%
        ArrayList<parkYeri> parkYerleri = new ArrayList<>();

        try {
            admindb obj = new admindb();

            // Park yerlerini al
            parkYerleri = obj.getOtoparkDurumu(); // Veritabanından park yerlerini al

    %>
<div class="container-lg">
    <div class="product-page">
        -<!-- deneme -->
        <div class="div">
            <% for (parkYeri parkYer : parkYerleri) {%>
            <div class="tomato-2">  
                <div class="plakaya-ait-kullan-c-2"><%
                    if (parkYer.getBosDolu() == 1) {
                        out.print("Dolu");
                    } else {
                        out.print("Boş");
                    }
                    %></div>
                    <div class="text-wrapper-7"><%= parkYer.mevcutTutar(parkYer.getGiris_saati()) %> TL</div>
                <div class="overlap-3">
                    <div class="overlap-group-2">
                        <div class="text-wrapper-3"><%= parkYer.getPlakaSon() %></div>
                        <div class="overlap-4"><div class="text-wrapper-4">TR</div></div>
                        <div class="text-wrapper-5"><%= parkYer.getPlakaBas()  %></div>
                        <div class="text-wrapper-6"><%= parkYer.getPlakaOrta() %></div>
                        
                    </div>
                    <img class="screenshot" src="araba.png" />
                </div>
                <div class="text-wrapper-8"><%= parkYer.getParkTime() %></div>
            </div>          
            
            <% }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>

</div>

</body>
</html>