/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.otopark.otomasyon;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author yetun
 */
public class logindb {

    public static void main(String[] args) {

    }

    private String hashPassword(String plainTextPassword) {
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
    }

    private String checkPass(String plainPassword, String hashedPassword) {
        if (BCrypt.checkpw(plainPassword, hashedPassword)) {
            return ("The password matches.");
        } else {
            return ("The password does not match.");
        }
    }

    private Connection conGetir() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/otopark?useSSL=false";
            String username = "root";
            String password = "enes";
            Connection con = DriverManager.getConnection(url, username, password);
            return con;
            
        } catch (Exception e) {
        }
        return null;
    }
    public boolean metinIcindeSayiVarMi(String metin) {
            for (char karakter : metin.toCharArray()) {
                if (Character.isDigit(karakter)) {
                    return true;
                }
            }
            return false;
        }

    public Timestamp getGirisZamani(String plaka, Connection con) {
        Timestamp girisZamani = null;
        try {
            String sql = "SELECT girissaati FROM otopark WHERE plaka = ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, plaka);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                girisZamani = rs.getTimestamp("girissaati");
            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return girisZamani;
    }

    public int getParkYeriID(String aracPlakasi, Connection con) {
        int parkYeriID = -1; // Varsayılan olarak bir hata değeri

        try {
            String query = "SELECT id FROM otopark WHERE plaka = ?";
            // PreparedStatement ile sorgu hazırlama
            PreparedStatement statement = con.prepareStatement(query);
            statement.setString(1, aracPlakasi);

            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                parkYeriID = rs.getInt("id");
            }

            rs.close();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return parkYeriID;
    }

    public ArrayList<String> getAracVerileri(String plaka) {
        ArrayList<String> aracVerileri = new ArrayList<>();

        Connection con = null;
        try {
            con = conGetir();
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM gecmis WHERE plaka = ?");
            stmt.setString(1, plaka);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Tüm sütunları al ve ArrayList'e ekle
                SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy HH:mm:ss");
                String girisSaati = sdf.format(rs.getTimestamp("giris_saati"));
                String cikisSaati = sdf.format(rs.getTimestamp("cikis_saati"));
                String veri = "Park Yeri ID: " + rs.getLong("park_yeri_id") + ", Plaka: " + rs.getString("plaka") + ", Giriş Saati: " + girisSaati + ", Çıkış Saati: " + cikisSaati + ", Tutar: " + rs.getDouble("tutar");
                aracVerileri.add(veri);
            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close(); // Bağlantı kapatılıyor
                } catch (SQLException e) {
                    // Bağlantı kapatma hatası
                }
            }
        }

        return aracVerileri;
    }

    public ArrayList<String> getMevcutAraclar(Connection con, String plaka, Timestamp mevcut_saat) {
        ArrayList<String> mevcutAraclar = new ArrayList<>();

        try {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM otopark WHERE plaka = ?");
            stmt.setString(1, plaka);
            ResultSet rs = stmt.executeQuery();

            Timestamp girisZamani = getGirisZamani(plaka, con);
            long fark = (mevcut_saat.getTime() - girisZamani.getTime());
            while (rs.next()) {
                // Tüm sütunları al ve ArrayList'e ekle
                SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy HH:mm:ss");
                String girisSaati = sdf.format(rs.getTimestamp("girissaati"));
                admindb fiyat = new admindb();
                String veri = "Park Yeri ID: " + rs.getLong("id") + ", Plaka: " + rs.getString("plaka") + ", Giriş Saati: " + girisSaati + ", Tutar: " + fiyat.fiyatHesapla(fark);
                mevcutAraclar.add(veri);
            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return mevcutAraclar;
    }

    public boolean kayitYap(String isim, String soyisim, String eposta, String sifre) {
        boolean kayitBasarili = false;
        Connection con = null;
        try {

            con = conGetir();
            sifre = hashPassword(sifre);
            PreparedStatement checkStmt = con.prepareStatement("SELECT COUNT(*) FROM kullanicilar WHERE eposta = ?");
            checkStmt.setString(1, eposta);
            ResultSet resultSet = checkStmt.executeQuery();
            resultSet.next();
            int count = resultSet.getInt(1);
            if (count > 0) {
                // Eposta zaten kayıtlı, işlem yapılmayabilir veya hata durumu işlenebilir.
            } else {
                PreparedStatement stmt = con.prepareStatement("INSERT INTO kullanicilar (isim , soyisim, sifre, eposta) VALUES (?,?,?,?)");
                stmt.setString(1, isim);
                stmt.setString(2, soyisim);
                stmt.setString(3, sifre);
                stmt.setString(4, eposta);
                kayitBasarili = true;
                stmt.executeUpdate();
                stmt.close();
            }
            checkStmt.close();

        } catch (Exception e) {
        } finally {
            if (con != null) {
                try {
                    con.close(); // Bağlantı kapatılıyor
                } catch (SQLException e) {
                    // Bağlantı kapatma hatası
                }
            }
        }
        return kayitBasarili;
    }

    public boolean checkUser(String eposta, String pass, HttpServletRequest request) {
        boolean isValidUser = false;

        try {
            Connection con = conGetir();

            // Veritabanında kullanıcıyı sorgula
            String query = "SELECT * FROM kullanicilar WHERE eposta = ?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, eposta);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String hashedPasswordFromDB = rs.getString("sifre");

                HttpSession session = request.getSession();

                String uname = rs.getString("isim");
                nameSession use = new nameSession();
                use.setName(uname);
                session.setAttribute("username", use);

                // Kullanıcı bulundu, şifreyi kontrol et
                if (checkPass(pass, hashedPasswordFromDB).equals("The password matches.")) {

                    isValidUser = true;
                }
            }

            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace(); // Hata durumunda hatayı görüntüle
        }
        return isValidUser;
    }

    public boolean adminEkle(String isim, String soyisim, String eposta, String sifre) {
        boolean kayitBasarili = false;
        Connection con = null;
        try {

            con = conGetir();
            sifre = hashPassword(sifre);
            PreparedStatement checkStmt = con.prepareStatement("SELECT COUNT(*) FROM adminler WHERE eposta = ?");
            checkStmt.setString(1, eposta);
            ResultSet resultSet = checkStmt.executeQuery();
            resultSet.next();
            int count = resultSet.getInt(1);
            if (count > 0) {
                // Eposta zaten kayıtlı, işlem yapılmayabilir veya hata durumu işlenebilir.
            } else {
                PreparedStatement stmt = con.prepareStatement("INSERT INTO adminler (isim , soyisim, sifre, eposta) VALUES (?,?,?,?)");
                stmt.setString(1, isim);
                stmt.setString(2, soyisim);
                stmt.setString(3, sifre);
                stmt.setString(4, eposta);
                kayitBasarili = true;
                stmt.executeUpdate();
                stmt.close();
            }
            checkStmt.close();

        } catch (Exception e) {
        } finally {
            if (con != null) {
                try {
                    con.close(); // Bağlantı kapatılıyor
                } catch (SQLException e) {
                    // Bağlantı kapatma hatası
                }
            }
        }
        return kayitBasarili;
    }

    public boolean checkAdmin(String eposta, String pass, HttpServletRequest request) {
        boolean isValidUser = false;

        try {

            Connection con = conGetir();

            // Veritabanında kullanıcıyı sorgula
            String query = "SELECT * FROM adminler WHERE eposta = ?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, eposta);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String hashedPasswordFromDB = rs.getString("sifre");

                // Kullanıcı bulundu, şifreyi kontrol et
                if (checkPass(pass, hashedPasswordFromDB).equals("The password matches.")) {
                    HttpSession session = request.getSession();

                    String aname = rs.getString("isim");
                    nameSession use = new nameSession();
                    use.setName(aname);
                    session.setAttribute("adminName", use);
                    isValidUser = true;
                }
            }

            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace(); // Hata durumunda hatayı görüntüle
        }
        return isValidUser;
    }

    public boolean resetPass(String isim, String eposta, String sifre) {
        boolean basari = false;
        Connection con = null;
        try {
            con = conGetir();

            String query = "SELECT * FROM kullanicilar WHERE eposta = ? AND isim= ?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, eposta);
            stmt.setString(2, isim);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String updateQuery = "UPDATE kullanicilar SET sifre = ? WHERE eposta= ? ";
                stmt = con.prepareStatement(updateQuery);
                sifre = hashPassword(sifre);
                stmt.setString(1, sifre);
                stmt.setString(2, eposta);
                int affectedRows = stmt.executeUpdate();
                if (affectedRows > 0) {
                    basari = true;
                } else {
                    System.out.println("Kayıt eklenirken bir hata oluştu.");
                }
            } else {
                System.out.println("Kullanıcı bulunamadı.");
            }

            con.close();
        } catch (Exception e) {
        }
        return basari;
    }
}
