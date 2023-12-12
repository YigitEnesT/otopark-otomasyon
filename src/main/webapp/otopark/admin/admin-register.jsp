<%-- 
    Document   : admin-register
    Created on : 5 Ara 2023, 18:47:48
    Author     : yetun
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Kayıt Ekranı</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }

            h1 {
                text-align: center;
                color: #333;
                margin: 10px;
            }

            form {
                width: 400px;
                margin: 100px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 50px;
                box-shadow: 0 0 30px 10px #d6be9e;
                background: #f6f0e8;
            }

            input[type="text"], input[type="email"],
            input[type="password"] {
                display: block;
                width: calc(100% - 20px);
                padding: 8px;
                margin: 20px auto;
                border: 1px solid #ccc;
                border-radius: 30px;
                text-align: center;
            }

            input[type="submit"] {
                display: block;
                width: calc(100% - 20px);
                padding: 8px;
                margin: 10px auto;
                border: 1px solid #ccc;
                background: #BBAB8C;
                border: 1px solid #BBAB8C;
                border-radius: 30px;

                color: #fff;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background: #6c675a;
                color: wheat;
                transition: background-color 0.5s;
                transition: color 0.5s;
            }
        </style>
        <script>
            function validateForm() {
                var isim = document.forms["registerForm"]["isim"].value;
                var soyisim = document.forms["registerForm"]["soyisim"].value;
                var eposta = document.forms["registerForm"]["eposta"].value;
                var sifre = document.forms["registerForm"]["sifre"].value;

                if (isim == "") {
                    alert("İsim alanı boş olamaz!");
                    return false;
                }

                if (soyisim == "") {
                    alert("Soyisim alanı boş olamaz!");
                    return false;
                }

                if (eposta == "") {
                    alert("E-posta alanı boş olamaz!");
                    return false;
                }

                if (sifre == "") {
                    alert("Şifre alanı boş olamaz!");
                    return false;
                }


                return true; // Eğer hiçbir uyarı olmazsa formu gönder.
            }
        </script>

    </head>
    <body>
        <%@include file="admin-menu.jsp" %>
        <%
            String kontrol = (String) session.getAttribute("isAdmin");
            if (kontrol == null || !kontrol.equals("true")) {
                response.sendRedirect("admin-loginpage.jsp");
            }
        %>
        <form name="registerForm" action="register-islem.jsp" method="POST" onsubmit="return validateForm()">
            <h1>Kayıt Ekranı</h1>
            <input type="text" name="isim" placeholder="İsim Giriniz">
            <input type="text" name="soyisim" placeholder="Soyisim Giriniz">
            <input type="email" name="eposta" placeholder="E-posta Giriniz">
            <input type="password" name="sifre" placeholder="Şifre Giriniz">
            <input type="submit" value="Kayıt Ol">
        </form>

    </body>
</html>