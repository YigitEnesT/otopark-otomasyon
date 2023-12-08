<%-- 
    Document   : aracsil
    Created on : 29 Kas 2023, 21:41:38
    Author     : yetun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="uname" class="com.mycompany.otopark.otomasyon.nameSession" scope="session" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                text-align: center;
                margin: 50px;
             
            }

            h1 {
                color: #333;
                text-align: center;
            }

            form {
                width: 300px;
                margin: auto;
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }

            input {
                width: calc(33.333% - 10px);
                padding: 8px;
                margin-top: 5px;
                box-sizing: border-box;
            }

            input[type="number"] {
                margin-left: 1px;
            }

            small {
                display: block;
                margin-top: 5px;
                color: #666;
                width: 100%;
            }

            input[type="submit"] {
                width: 100%;
                margin-top: 10px;
                background-color: #428bca;
                color: #fff;
                border: none;
                padding: 10px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #3071a9;
            }
        </style>
    <script>
            function harfKontrolu(event) {
                var enteredChar = event.data.toUpperCase();

                // Z, Ğ, İ, Ç, Ö, Ü, Ş harfleri kontrolü
                var invalidChars = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "Ğ", "ğ", "İ", "i", "Ç", "ç", "Ö", "ö","Ü", "ü","Ş", "ş", "Q", "q", "W", "w", "i"];

                if (invalidChars.includes(enteredChar)) {
                    alert("Geçerli Plaka Giriniz!");
                    event.target.value = event.target.value.slice(0, -1);
                }
            }
        </script>
</head>
<body>
    <%@include file="kullanici-menu.jsp" %>
    <%
        String kontrol = (String)session.getAttribute("isLogin");
        // İSİMİ DE KONTROL ET , BOŞ İSE EKRAN AÇILMASIN
        if( kontrol == null || !kontrol.equals("true") || username.getName() == null ){
            response.sendRedirect("kullanici-loginpage.jsp");
        }
    %>
    <h1>ARAÇ SORGULA</h1>
    <form action="arac-goster.jsp" method="POST">
        <input type="number" id="numberPlaka" name="numberPlaka" min="1" max="81" required>

        <input type="text" id="textPlaka" name="textPlaka" oninput="harfKontrolu(event)" maxlength="3" required>

        <input type="number" id="formattedPlaka" name="formattedPlaka" min="1" max="999" required>
            <small>Örnek Format: 34-AB-123</small>

        <input type="submit" value="Plaka Sorgula">
        
    </form>
   
</body>
</html>
