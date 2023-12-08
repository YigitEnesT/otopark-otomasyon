<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Sayfası</title>
        <style>
            body {
            font-family: Arial, sans-serif;
            background: rgb(165,151,88);
            background: linear-gradient(0deg, rgba(165,151,88,1) 0%, rgba(205,180,125,1) 100%);
            text-align: center;
            margin: 0;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        h1 {
            color: #fff;
            margin-right: 100px;
            width: 100px;
            text-align: left;
        }
        

        form {
            width: 300px;
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
            margin-top: 15px;
            color: #fff;
            width: 100%;
            margin-bottom: 30px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            cursor: pointer;
            background-color: #4a483f ; /* Daha koyu bir renk */
            color: #fff;
            font-weight: bold;
            border: none;
            border-radius: 50px;
            transition: background-color 0.5s ease;
        }

        input[type="submit"]:hover {
            background-color: #ede5ca; /* Hover rengi */
            color: #000000;
            transition: color 0.2s ease;
        }

        input[type="number"], input[type="text"] {
            font-size: 16px;
            background-color: #4a483f; /* Daha koyu bir renk */
            color: #fff;
            font-weight: bold;
            border: 1px solid #205080;
            border-radius: 50px;
            transition: background-color 0.5s ease;
            text-align: center;
        }
        </style>
        <script>
            function harfKontrolu(event) {
                var enteredChar = event.data.toUpperCase();

                // Z, Ğ, İ, Ç, Ö, Ü, Ş harfleri kontrolü
                var invalidChars = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "Ğ", "ğ", "İ", "i", "Ç", "ç", "Ö", "ö", "Ü", "ü", "Ş", "ş", "Q", "q", "W", "w"];

                if (invalidChars.includes(enteredChar)) {
                    alert("Geçerli Plaka Giriniz!");
                    event.target.value = event.target.value.slice(0, -1);
                }
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
   
        <h1>Plaka İşlemleri</h1>

        <form action="plaka-islem.jsp" method="post">
            <input type="number" id="numberPlaka" name="numberPlaka" min="1" max="81" required>

            <input type="text" id="textPlaka" name="textPlaka" oninput="harfKontrolu(event)" maxlength="3" required>

            <input type="number" id="formattedPlaka" name="formattedPlaka" min="1" max="999" required>
            <small>Örnek Format: 34-AB-123</small>

            <input type="submit" value="Plaka Gönder" name="sub">
            <input type="submit" value="Plaka Sorgula" name="sub">
            <input type="submit" value="Plaka Sil" name="sub">

        </form>

    </body>
</html>
