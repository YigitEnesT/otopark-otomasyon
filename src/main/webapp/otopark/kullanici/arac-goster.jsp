<%-- 
    Document   : aracsil2
    Created on : 29 Kas 2023, 21:47:36
    Author     : yetun
--%>


<%@page import="java.util.Arrays"%>
<%@page import="com.mycompany.otopark.otomasyon.parkYeri"%>
<%@page import="com.mycompany.otopark.otomasyon.kullanicidb"%>
<%@page import="com.mycompany.otopark.otomasyon.logindb"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Araç Göster</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

        <style>
            table {
                border-collapse: collapse;
                width: 100%;
                margin-bottom: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center !important;
            }
            th {
                background-color: #f2f2f2;

            }
            .veri {
                font-weight: bold;
                color: blue;
            }
            .hata{
                font-weight: bold;
                color: red;
            }
            h2{
                text-align: center;
            }

        </style>
    </head>
    <body>
        <%
            String kontrol = (String) session.getAttribute("isLogin");
            if (kontrol == null || !kontrol.equals("true")) {
                response.sendRedirect("kullanici-loginpage.jsp");
            } else {
                String numberPlaka = request.getParameter("numberPlaka");
                String textPlaka = request.getParameter("textPlaka");
                String formattedPlaka = request.getParameter("formattedPlaka");
                if (numberPlaka != null && textPlaka != null && formattedPlaka != null) {
                    String birlesikPlaka = numberPlaka + "-" + textPlaka.toUpperCase() + "-" + formattedPlaka;
                    try {
                        Cookie[] cookies = request.getCookies();
                        Cookie plakaCookie = null;
                        if (cookies != null) {
                            for (Cookie cookie : cookies) {
                                if (cookie.getName().equals("plakaCookie")) {
                                    plakaCookie = cookie;
                                    break;
                                }
                            }
                        }
                        if (plakaCookie == null) {
                            plakaCookie = new Cookie("plakaCookie", birlesikPlaka);
                        } else {
                            String[] values = plakaCookie.getValue().split("\\|");
                            ArrayList<String> plakaList = new ArrayList<>(Arrays.asList(values));
                            plakaList.add(birlesikPlaka);
                            plakaCookie.setValue(String.join("|", plakaList));
                        }

                        // Cookie'nin ömrünü ayarla ve tarayıcıya gönder
                        plakaCookie.setMaxAge(24 * 60 * 60); // Örnek olarak 1 gün
                        response.addCookie(plakaCookie);
                    } catch (Exception e) {
                        System.out.println("Cookie oluşturulurken bir hata oluştu: zort " + e.getMessage());
                    }
                    try {
                        // Cookie Kısımları:

                        // Veritabanı kısımları
                        kullanicidb aracSorgu = new kullanicidb();
                        parkYeri aracBilgisi = new parkYeri();
                        aracBilgisi = aracSorgu.getMevcutArac(birlesikPlaka);
        %>
        <%@include file="kullanici-menu.jsp" %>
    <div class="container-lg">

        <h2>Mevcut Araçlar</h2>
        <table>
            <tr>
                <th>Park Yeri ID</th>
                <th>Plaka</th>
                <th>Giriş Saati</th>
                <th>Tutar</th>
            </tr>
            <% if (aracBilgisi.getId() == 0) {%>
            <td class="hata" colspan="4">Girilen plakaya ait araç otoparkta bulunamadı.</td>
            <%} else {
            %>
            <tr>
                <td class="veri"><%= aracBilgisi.getId()%></td>
                <td class="veri"><%= aracBilgisi.getPlaka()%></td>
                <td class="veri"><%= aracBilgisi.getFormattedGiris_saati()%></td>
                <td class="veri"><%= aracBilgisi.mevcutTutar(aracBilgisi.getGiris_saati()) + " TL"%></td>

            </tr>
            <% }%>
        </table>
        <%
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

        <!-- Çıkış yapmış araçların son etkinliklerini gösteren tablo -->
        <%
            try {

                logindb obj = new logindb();
                ArrayList<String> gecmisAraclar = obj.getAracVerileri(birlesikPlaka); // Çıkış yapmış araçların son etkinliklerini al

        %>
        <h2>Çıkış Yapmış Araçlar</h2>
        <table>
            <tr>
                <th>Park Yeri ID</th>
                <th>Plaka</th>
                <th>Giriş Saati</th>
                <th>Çıkış Saati</th>
                <th>Tutar</th>
            </tr>
            <% if (gecmisAraclar.isEmpty()) { %>
            <tr>
                <td class="hata" colspan="5">Böyle bir kayıt bulunamadı.</td>
            </tr>
            <% } else { %>
            <% for (String veri : gecmisAraclar) {%>
            <tr>
                <td class="veri"><%= veri.split(", ")[0].split(": ")[1]%></td>
                <td class="veri"><%= veri.split(", ")[1].split(": ")[1]%></td>
                <td class="veri"><%= veri.split(", ")[2].split(": ")[1]%></td>
                <td class="veri"><%= veri.split(", ")[3].split(": ")[1]%></td>
                <td class="veri"><%= veri.split(", ")[4].split(": ")[1] + " TL"%></td>
            </tr>
            <% } %>
            <% } %>

        </table>
        <%

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div>
    <!-- Bootstrap JS ve popper.js ve jQuery (isteğe bağlı) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-MVE9EqkpG3rbwS2udF7G5KtGAs6m7U34R4JmwE+Ygsqqj7A9ZB9JL2rUvZv6O5G5" crossorigin="anonymous"></script>

</body>

</html>
