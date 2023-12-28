<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="tr">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Kullanıcı Giriş Ekranı</title>
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
            border-radius: 50px;
            overflow: hidden;
            background: #f6f0e8;
            box-shadow: 0 0 30px 10px #d6be9e;

        }

        .button-box {
            font-size: bold;
            width: 221.5px;
            margin: 40px auto;
            position: relative;
            border: 1px solid #BBAB8C;
            border-radius: 30px;
            display: flex;
            justify-content: space-between; /* Simetrik olması için ekledim */
        }

        .bttn {
            padding: 10px 20px 10px 20px;
            cursor: pointer;
            background: transparent;
            border: 0;
            outline: none;
            position: relative;
            margin: auto;
            font-weight: bold;
            text-align: center;
        }

        #btn {
            top: 0;
            left: 0;
            position: absolute;
            width: 115px;
            height: 100%;
            background: #BBAB8C;
            border-radius: 30px;
            transition: .5s;
        }

        .form-container {
            top: 160px;
            position: absolute;
            width: 300px;
            transition: .5s;
        }

        .input-container {
            width: 100%;
            padding: 10px 0;
            margin: 5px 0;
            border: 1px solid #807a69;
            border-radius: 30px;
            background: transparent;
            text-align: center;
        }

        .submit-container {
            width: 85%;
            padding: 10px 30px;
            cursor: pointer;
            display: block;
            margin-left: 30px;
            margin-top: 50px;
            background: #BBAB8C;
            border: 1px;
            outline: none;
            border-radius: 30px;
                color: white;
                font-weight: bold;   
        }
        
        .submit-container:hover{
            background: #6c675a;
            color: wheat;
            transition: background-color 0.5s; 
            transition: color 0.5s; 
        }
        
        a:hover{
            color: #876f35;
            transition: .5s;
        }

        #login-form {
            left: 50px;
        }

        #register-form {
            left: 450px;
        }

        a {
            margin-left: 100px;
            color: #BBAB8C;
        }

        button {
            margin-top: 10px !important;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="form-box">
            <div class="button-box">
                <div id="btn"></div>
                <button type="button" class="bttn" onclick="login()">Giriş yap</button>
                <button type="button" class="bttn" onclick="register()">Kayıt ol</button>
            </div>
            <form action="login-islem.jsp" method="POST" id="login-form" class="form-container">
                <input type="email" class="input-container" placeholder="Eposta adresini giriniz" name="eposta" required>
                <input type="password" class="input-container" placeholder="Şifrenizi giriniz" name="sifre" required>
                <a href="reset-password.jsp"> Şifremi Unuttum </a>
                <input type="submit" class="submit-container" value="Giriş Yap">
                <button type="button" class="submit-container" onclick="goBack()">Geri Dön</button>
            </form>
            <form action="register-islem.jsp" method="POST" id="register-form" class="form-container">
                <input type="text" class="input-container" placeholder="İsminizi giriniz" maxlength="20" name="isim" required>
                <input type="text" class="input-container" placeholder="Soyadınızı giriniz" maxlength="20" name="soyisim" required>
                <input type="email" class="input-container" placeholder="Eposta adresini giriniz" name="eposta" required>
                <input type="password" class="input-container" placeholder="Şifrenizi giriniz" name="sifre" required>
                <input type="submit" class="submit-container" value="Kayıt Ol">
                <button type="button" class="submit-container" onclick="goBack()">Geri Dön</button>
            </form>
        </div>
    </div>
    <script>
        var loginForm = document.getElementById("login-form");
        var registerForm = document.getElementById("register-form");
        var btn = document.getElementById("btn");

        function register() {
            loginForm.style.left = "-400px";
            registerForm.style.left = "50px";
            btn.style.left = "110px";
        }

        function login() {
            loginForm.style.left = "50px";
            registerForm.style.left = "450px";
            btn.style.left = "0px";
        }

        function goBack() {
            window.location.href = '../home-page.jsp';
        }
    </script>
</body>

</html>