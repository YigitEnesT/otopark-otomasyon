<%-- 
    Document   : user-login
    Created on : 8 Ara 2023, 14:08:25
    Author     : yetun
--%>


<%@page import="com.mycompany.otopark.otomasyon.logindb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Şifremi Yenile</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            font-family: sans-serif;
        }

        .container {
            height: 100%;
            width: 100%;
            background-position: center;
            background-size: cover;
            position: absolute;
        }

        .form-box {
            width: 400px;
            height: 500px;
            position: relative;
            margin: 8% auto;
            padding: 5px;
            overflow: hidden;
        }

        .button-box {
            width: 250px;
            margin: 40px auto;
            position: relative;
            box-shadow: 0 0 30px 10px #FDF7E4;
            border-radius: 40px;
        }
         h1 {
            text-align: center;
            color: #333;
        }

        .bttn {
            padding: 10px 30px;
            cursor: pointer;
            background: transparent;
            border: 0;
            outline: none;
            position: relative;
        }

        #btn {
            top: 0;
            left: 0;
            position: absolute;
            width: 110px;
            height: 100%;
            background: linear-gradient(to right,#BBAB8C, #FAEED1);
            border-radius: 30px;
            transition: .5s;
        }

        .form-container {
            top: 180px;
            position: absolute;
            width: 280px;
            transition: .5s;
        }

        .input-container {
            width: 100%;
            padding: 10px 0;
            margin: 5px 0;
            border-left: 0;
            border-top: 0;
            border-right: 0;
            border-bottom: 1px solid #FAEED1;
            outline: none;
            background: transparent;
        }

        .submit-container {
            width: 85%;
            padding: 10px 30px;
            cursor: pointer;
            display: block;
            margin: auto;
            background: linear-gradient(to right, #BBAB8C, #FAEED1);
            border: 0;
            outline: none;
            border-radius: 30px
        }
        button{
            margin-top: 10px !important ;
        }

    </style>
</head>
<body>
    <div class="container">
        <div class="form-box">
            <h1>Kullanıcı Şifremi Unuttum</h1>
            <form action="" method="POST" id="login-form" class="form-container" >
                <input type="email" class="input-container" placeholder="Eposta adresini giriniz" name="eposta" required>
                <input type="password" class="input-container" placeholder="Şifrenizi girin" name="sifre" required>
                <input type="submit" class="submit-container" value="Şifremi Yenile">
                <button type="button" class="submit-container" onclick="goBack()">Geri Dön</button>
            </form>
            
        </div>
    </div>

<%
            String eposta = request.getParameter("eposta");
            String sifre = request.getParameter("sifre");

            if (eposta != null && sifre != null) {
                logindb obj = new logindb();
                if (obj.resetPass(eposta, sifre)) {
                    response.sendRedirect("kullanici-loginpage.jsp");
                }
            }

        %>
        <script>
            function goBack() {
                window.history.back();
            }
        </script>
</body>
</html>
