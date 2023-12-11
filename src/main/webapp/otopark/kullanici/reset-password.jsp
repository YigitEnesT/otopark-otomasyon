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
                border-radius: 50px;
                box-shadow: 0 0 30px 10px #d6be9e;
                background: #f6f0e8;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
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
                margin-bottom: 20px;
            }

            .form-container {
                width: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .input-container {
                width: 85%;
                padding: 10px 0;
                margin: 5px 5px;
                border: 1px solid #846b4b;
                border-radius: 30px;
                outline: none;
                background: transparent;
                transition: border-color 0.3s;
                text-align: center;
            }

            .submit-container {
                width: 85%;
                padding: 10px 30px;
                cursor: pointer;
                display: block;
                margin: 30px 20px 0px 20px;
                background: #BBAB8C;
                border: 1px solid #BBAB8C;
                outline: none;
                border-radius: 30px;
                color: #fff;
                font-weight: bold;
                transition: background-color 0.3s;
            }

            .submit-container:hover{
                background: #6c675a;
            color: wheat;
            transition: background-color 0.5s; 
            transition: color 0.5s; 

            }
            
            button {
                margin-top: 10px !important;
            }

        </style>
    </head>

    <body>
    <div class="container">
        <div class="form-box">
            <h1>Şifremi Unuttum</h1>
            <form action="" method="POST" id="login-form" class="form-container">
                <input type="text" class="input-container" placeholder="İsminizi giriniz" name="isim" required> 
                <input type="email" class="input-container" placeholder="Eposta adresini giriniz" name="eposta" required>
                <input type="password" class="input-container" placeholder="Şifrenizi girin" name="sifre" required>
                <input type="submit" class="submit-container" value="Şifremi Yenile">
                <button type="button" class="submit-container" onclick="goBack()">Geri Dön</button>
            </form>
        </div>
    </div>

    <%
        String isim = request.getParameter("isim");
        String eposta = request.getParameter("eposta");
        String sifre = request.getParameter("sifre");

        if (eposta != null && sifre != null) {
            logindb obj = new logindb();
            if (obj.resetPass(isim, eposta, sifre)) {
    %>
                <script>
                    alert("Şifreniz başarıyla yenilendi!");
                    window.location.href = "kullanici-loginpage.jsp";
                </script>
    <%
            }else{
    %>
                <script>
                    alert("Şifreniz yenilenemedi!");
                    window.location.href = "kullanici-loginpage.jsp";
                </script>
    <%
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