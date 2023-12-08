<%-- 
    Document   : otopark1
    Created on : 28 Kas 2023, 20:39:10
    Author     : yetun
--%>


<%@page import="com.mycompany.otopark.otomasyon.admindb"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
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
        String value = request.getParameter("sub");

        String numberPlaka = request.getParameter("numberPlaka");
        String textPlaka = request.getParameter("textPlaka");
        String formattedPlaka = request.getParameter("formattedPlaka");
        if (numberPlaka != null && textPlaka != null && formattedPlaka != null) {
            String birlesikPlaka = numberPlaka + "-" + textPlaka.toUpperCase() + "-" + formattedPlaka;
            
            admindb db = new admindb();
            if (value.equals("Plaka Gönder")) {
                if (db.addParkYeri(birlesikPlaka)) 
                {
                        out.println("Plaka Eklendi.");
                        response.sendRedirect("admin-homepage.jsp");
                }
                else{
                    out.println("Plaka ekleme olmadı.");
                }
                
            } else if (value.equals("Plaka Sil")) {
                if (db.deleteArac(birlesikPlaka)) {
                    out.println("Plaka Silindi.");
                    response.sendRedirect("admin-homepage.jsp");
                }
                else{
                    out.println("Silme İşlemi Başarısız!");
                }
                
                
            }else if(value.equals("Plaka Sorgula")){
                RequestDispatcher dispatcher = request.getRequestDispatcher("arac-sorgu.jsp");
                dispatcher.forward(request, response);
            }else {
                out.println("HATA!");
            }
        }

    %>

</body>
</html>
