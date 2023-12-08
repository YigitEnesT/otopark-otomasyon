<%-- 
    Document   : homepage
    Created on : 8 Ara 2023, 16:05:55
    Author     : yetun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giriş Ekranı</title>

        <style>

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                text-align: center;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
                margin: 0;
                background: rgb(172,160,116);
                background: radial-gradient(circle, rgba(172,160,116,1) 0%, rgba(197,187,153,1) 100%);
            }

            h1 {
                color: #fff;
                font-weight: bolder;
                text-decoration: underline;
                text-underline-offset: 10px;

            }

            .form-container {
                display: flex;
                justify-content: space-around;
                margin-top: 20px;
                max-width: 800px;
                width: 100%;
            }

            form {
                width: 45%;
                margin: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
                border-radius: 50px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                background-color: rgba(9,67,121,1);
            }

            input[type="submit"] {
                width: 100%;
                padding: 20px;
                font-size: 16px;
                cursor: pointer;
                background-color: #4a483f; /* Daha koyu bir renk */
                color: #fff;
                font-weight: bold;
                border: none;
                border-radius: 50px;
                transition: background-color 0.5s ease;
            }

            input[type="submit"]:hover {
                background-color: #ede5ca; /* Hover rengi */
                color: #13304d;
                transition: color 0.5s ease;
                transition: background-color 0.5s ease;


            }
        </style>
    </head>
    <body>
        <h1>OtoparkOtomasyon</h1>

        <div class="form-container">
            <form action="moduleScreen.jsp" method="post">
                <input type="hidden" name="userType" value="admin">
                <input type="submit" value="Admin Girişi">            
            </form>

            <form action="moduleScreen.jsp" method="post">
                <input type="hidden" name="userType" value="kullanici"> 
                <input type="submit" value="Kullanıcı Girişi">            
            </form>
        </div>
    </body>
</html>
