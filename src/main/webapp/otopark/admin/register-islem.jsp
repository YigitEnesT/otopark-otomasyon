<%-- 
    Document   : register-islem
    Created on : 8 Ara 2023, 17:27:20
    Author     : yetun
--%>

<%@page import="com.mycompany.otopark.otomasyon.logindb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");

        String isim = request.getParameter("isim");
        String soyisim = request.getParameter("soyisim");
        String eposta = request.getParameter("eposta");
        String sifre = request.getParameter("sifre");

        boolean isValid = true;
        StringBuilder errorMessage = new StringBuilder();

        if (isim == null || isim.isEmpty()) {
            isValid = false;
            errorMessage.append("İsim alanı boş olamaz.<br>");
        }
        if (soyisim == null || soyisim.isEmpty()) {
            isValid = false;
            errorMessage.append("Soyisim alanı boş olamaz.<br>");
        }
        if (eposta == null || eposta.isEmpty()) {
            isValid = false;
            errorMessage.append("Geçerli bir e-posta adresi giriniz.<br>");
        }
        if (sifre == null || sifre.length() < 5) {
            isValid = false;
            errorMessage.append("Şifre en az 5 karakter olmalıdır.<br>");
        }

        if (!isValid) {
            out.println("<p style='color: red;'>" + errorMessage.toString() + "</p>");
        } else {
            logindb obj = new logindb();
            boolean kayitSonucu = obj.adminEkle(isim, soyisim, eposta, sifre);
            if (kayitSonucu) {
                //Kayıt başarılı alerti versin
                response.sendRedirect("admin-register.jsp");

            } else {
                // Kayıt başarısız durumu, hata mesajı veya farklı bir işlem yapılabilir
                out.println("<p style='color: red;'>Kayıt başarısız oldu!</p>");
                response.sendRedirect("admin-register.jsp");
            }
        }
    %>
</body>
</html>