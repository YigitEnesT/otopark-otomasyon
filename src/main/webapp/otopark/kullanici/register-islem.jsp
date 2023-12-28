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
            errorMessage.append("İsim alanı boş olamaz");
        }
        if (soyisim == null || soyisim.isEmpty()) {
            isValid = false;
            errorMessage.append("Soyisim alanı boş olamaz.");
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
            out.println("<script>");
            out.println("alert('" + errorMessage.toString() + "');");
            out.println("window.location.href = 'kullanici-loginpage.jsp';");
            out.println("</script>");
        } else {
            logindb obj = new logindb();
            
            
            if ( obj.metinIcindeSayiVarMi(isim) || obj.metinIcindeSayiVarMi(soyisim)) {
            %>
                <script>
                        alert("Kayıt başarısız!");
                        window.location.href = "kullanici-loginpage.jsp";
                    </script>
             <%}else{
            
            boolean kayitSonucu = obj.kayitYap(isim, soyisim, eposta, sifre);
            
            
            if (kayitSonucu) {
                if ((obj.checkUser(eposta, sifre, request))) {
                        session.setAttribute("isLogin", "true");
                         %>
                        <script>
                            alert('Kullanıcı Kaydı Başarılı!... \n Giriş Yapılıyor.');
                            window.location.href = "kullanici-homepage.jsp";
                        </script>
                        <%
                    }
                else{%>
                    <script>
                        alert("Kayıt başarısız!");
                        window.location.href = "kullanici-loginpage.jsp";
                    </script>
                    <%
                }
            } else { %>
            <script>
                alert("Kayıt başarısız!");
                window.location.href = "kullanici-loginpage.jsp";
            </script>
            <%}
        }}%>
        
</body>
</html>