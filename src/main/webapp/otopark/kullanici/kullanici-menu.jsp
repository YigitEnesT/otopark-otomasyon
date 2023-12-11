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
         body {
            padding-top: 60px; /* Navbar'ın sayfa içeriği üzerinde kalmasını sağlar */
        }
        /* Çıkış yap butonu için özel stil */
        .logout-button {
            margin-right: 10px; /* Diğer butonlardan biraz uzaklaştırma */
        }
    </style>
</head>
<body>
    <!-- Navbar kodları burada... -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="kullanici-homepage.jsp">Hoş Geldin <%= username.getName()%></a>
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
                    <li class="nav-item">
                        <a class="nav-link" href="gecmis-sorgular.jsp">Geçmiş Sorgular</a>
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