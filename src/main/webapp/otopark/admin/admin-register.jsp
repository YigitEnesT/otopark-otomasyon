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
    <title>Kayıt Ekranı</title>
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
        }

        form {
            width: 300px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        input[type="text"], input[type="email"],
        input[type="password"] {
            display: block;
            width: calc(100% - 20px);
            padding: 8px;
            margin: 10px auto;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        input[type="submit"] {
            display: block;
            width: calc(100% - 20px);
            padding: 8px;
            margin: 10px auto;
            border: 1px solid #ccc;
            border-radius: 3px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <%@include file="admin-menu.jsp" %>
    <%
        String kontrol = (String) session.getAttribute("isAdmin");
        if (kontrol == null || !kontrol.equals("true")) {
            response.sendRedirect("admin-login.jsp");
        }
    %>
    <h1>Kayıt Ekranı!</h1>
    <form action="register-islem.jsp" method="POST">
        İsim: <input type="text" name="isim">
        Soyisim: <input type="text" name="soyisim">
        E-posta: <input type="email" name="eposta">
        Şifre: <input type="password" name="sifre">
        <input type="submit" value="Kayıt Ol">
    </form>
    
</body>
</html>
