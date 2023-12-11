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
                text-align: center;
                margin: 50px;
            }

            h1 {
                color: #333;
                text-align: center;
            }

            form {
                width: 300px;
                margin: 50px;
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
                font-weight: bold;
            }
            
            .submit-container {
                width: 85%;
                padding: 10px 30px;
                cursor: pointer;
                display: block;
                margin: 10px 0;
                background: #BBAB8C;
                border: 1px solid #BBAB8C;
                outline: none;
                border-radius: 30px;
                color: #fff;
                font-weight: bold;
                transition: background-color 0.3s;
            }

            .submit-container:hover {
                background: #6c675a;
                color: wheat;
                transition: background-color 0.5s;
                transition: color 0.5s;
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

            .button-row {
                display: flex;
                justify-content: space-between;
                width: 100%;
            }

            .small-button {
                width: 30%;
                font-size: 12px;
                padding: 8px;
            }

            .input-container:hover{
                background: #dbba8d;
                transition: background-color 0.5s;
            }
            
        </style>
        <script>
            function harfKontrolu(event) {
                const inputValue = event.target.value.toUpperCase(); // Girilen değeri büyük harfe çevir

                // İngiliz alfabesindeki harfleri kontrol et
                const regex = /^[A-Z]{1,3}$/;
                const isValid = regex.test(inputValue);

                if (!isValid || inputValue.includes('Q') || inputValue.includes('W') || inputValue.includes('X')) {
                  alert('Lütfen geçerli harfler girin! (Q, W, X hariç)');
                  event.target.value = ''; // Geçersiz girişi temizle
                }
            }
            function checkInput() {
                let inputElement = document.getElementById('numberPlaka');
                let inputValue = inputElement.value;

                // İki haneli olup olmadığını kontrol et
                if (inputValue.length === 1) {
                    inputValue = '0' + inputValue; // Tek haneli ise başına 0 ekleyerek iki haneli yap
                    inputElement.value = inputValue;
                } else if (inputValue.length !== 2) {
                    alert('Lütfen geçerli bir plaka girin.');
                    return false; // Formun gönderilmesini engelle
                }

                let inputElement2 = document.getElementById('formattedPlaka');
                let inputValue2 = inputElement2.value;
                if(inputValue2.length > 4){
                    alert('Lütfen geçerli bir plaka girin.');
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <%@include file="kullanici-menu.jsp" %>
        <%
            String kontrol = (String) session.getAttribute("isLogin");
            // İSİMİ DE KONTROL ET , BOŞ İSE EKRAN AÇILMASIN
            if (kontrol == null || !kontrol.equals("true") || username.getName() == null) {
                response.sendRedirect("kullanici-loginpage.jsp");
            }
        %>
    <div class="container">
        <div class="form-box">
            <form action="arac-goster.jsp" method="post" class="form-container" onsubmit="return checkInput()">
                <h1>ARAÇ SORGULA</h1>
                <div class="button-row">
                    <input type="number" id="numberPlaka" name="numberPlaka" min="1" max="81" required class="input-container">                    
                    <input type="text" id="textPlaka" name="textPlaka" class="input-container" oninput="harfKontrolu(event)" maxlength="3" required >                    
                    <input type="number" id="formattedPlaka" class="input-container" name="formattedPlaka" min="1" max="9999" required>
                </div>
                <small>Örnek Format: 34-AB-123</small>
                <input type="submit" value="Plaka Sorgula" class="submit-container">
            </form>
        </div>
    </div>


</body>
</html>