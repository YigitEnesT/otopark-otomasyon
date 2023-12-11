<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="tr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Giriş</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;

            }

            body {
                height: 100vh;
                margin: 0;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .form-box {
                width: 400px;
                padding: 20px;
                border-radius: 50px;
                box-shadow: 0 0 30px 10px #d6be9e;
                background: #f6f0e8;
            }

            h1 {
                text-align: center;
                color: #333;
                margin: 20px;
            }

            .input-container {
                width: 90%;
                padding: 12px;
                margin: 8px 8px;
                border: 1px solid #846b4b;
                border-radius: 30px;
                outline: none;
                background: transparent;
                transition: border-color 0.3s;
            }

            .input-container:focus {
                border-color: #846b4b;
            }

            .submit-container,
            .back-container {
                width: 100%;
                padding: 12px;
                margin: 10px 0;
                cursor: pointer;
                border: 0;
                outline: none;
                border-radius: 30px;
                color: #fff;
                font-weight: bold;
                transition: background-color 0.3s;

            }

            .submit-container {
                background: #BBAB8C;
                border: 1px solid #BBAB8C;
            }

            .back-container {
                border: 1px solid #BBAB8C;
                background: #BBAB8C;
            }

            .submit-container:hover,
            .back-container:hover {
                background: #6c675a;
                color: wheat;
                transition: background-color 0.5s;
                transition: color 0.5s;

            }
        </style>
    </head>
    <body>
        <div class="form-box">
            <h1>Admin Giriş Sayfası</h1>
            <form action="admin-loginislem.jsp" method="POST" id="login-form" class="form-container" >
                <input type="email" class="input-container" placeholder="Eposta adresini giriniz" name="eposta" required>
                <input type="password" class="input-container" placeholder="Şifrenizi girin" name="sifre" required>
                <input type="submit" class="submit-container" value="Giriş Yap">
                <button type="button" class="back-container" onclick="goBack()">Geri Dön</button>
            </form>
        </div>
        <script>
            function goBack() {
                window.location.href = '../home-page.jsp';
            }
        </script>
    </body>
</html>