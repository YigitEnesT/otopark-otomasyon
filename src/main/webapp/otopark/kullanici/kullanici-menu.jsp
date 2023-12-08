<%-- 
    Document   : kullanici-menu
    Created on : 3 Ara 2023, 22:28:17
    Author     : yetun
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="username" class="com.mycompany.otopark.otomasyon.nameSession" scope="session" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Menü Sayfası</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Body stilini özelleştirme */
        body {
            padding-top: 100px; /* Navbar'ın sayfa içeriği üzerinde kalmasını sağlar */
            background-color: #bab494; 
            transition: background-color 0.5s ease; /* Sayfa arka plan rengi üzerinde geçiş efekti */
        }

        /* Navbar stilini özelleştirme */
        .navbar {
            background-color: #373633; /* Navbar arka plan rengi */
            transition: background-color 0.5s ease; /* Navbar arka plan rengi üzerinde geçiş efekti */
            
        }

        /* Navbar marka (brand) yazı stilini özelleştirme */
        .navbar-brand {
            color: #ffffff !important; /* Navbar yazı rengi */
            transition: color 0.5s ease; /* Navbar yazı rengi üzerinde geçiş efekti */
            
        }

        /* Navbar açılır menü simgesi stilini özelleştirme */
        .navbar-toggler-icon {
            /* Navbar açılır menü simgesi */
        }

        /* Navbar link yazı stilini özelleştirme */
        .navbar-nav .nav-link {
            color: #ffffff !important; /* Navbar link yazı rengi */
            transition: color 0.5s ease; /* Navbar link yazı rengi üzerinde geçiş efekti */
        }

        /* Navbar link hover stilini özelleştirme */
        .navbar-nav .nav-link:hover {
            color: #bab494 !important; /* Navbar link hover rengi */
            
        }

        /* Navbar açılır menü simgesi stilini özelleştirme */
        .navbar-toggler {
            border-color: #373633; /* Navbar açılır menü simgesi çerçeve rengi */
            transition: border-color 0.5s ease; /* Navbar açılır menü simgesi çerçeve rengi üzerinde geçiş efekti */
        }

        /* Navbar açılır menü simgesi hover stilini özelleştirme */
        .navbar-toggler:hover {
            background-color: gray; /* Navbar açılır menü simgesi hover rengi */
            transition: background-color 0.5s ease; 
            color: #373633;
        }
        

        /* Çıkış yap butonu stilini özelleştirme */
        .logout-button {
            margin-right: 10px; /* Diğer butonlardan biraz uzaklaştırma */
            background-color: #bab494; 
            border: 1px #373633 solid;
            border-radius: 15px;
            color: black;
            transition: background-color 0.5s ease; /* Çıkış yap butonu arka plan rengi üzerinde geçiş efekti */
        }

        /* Çıkış yap butonu hover stilini özelleştirme */
        .logout-button:hover {
            background-color: #dc3545; /* Çıkış yap butonu hover rengi */
            transition: color 0.5s ease;
        }

        /* Navbar içindeki container'ın stilleri */
        .container {
            padding: 0; /* Container içindeki boşlukları kaldırma */
        }
    </style>
</head>
<body>
    <!-- Navbar kodları burada... -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">Hoş Geldiniz <%= username.getName() %></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="kullanici-homepage.jsp">Plaka Sorgulama</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="kullanici-tarife.jsp">Tarife Gör</a>
                    </li>
                </ul>
                <div class="my-2 my-lg-0">
                    <a class="btn btn-danger logout-button" href="logout.jsp">Çıkış Yap</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Sayfa içeriği buraya gelecek -->
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>