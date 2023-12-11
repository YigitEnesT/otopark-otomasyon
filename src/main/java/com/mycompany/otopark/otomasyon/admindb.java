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
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author yetun
 */
public class admindb {

    public static void main(String[] args) {

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

    public boolean addParkYeri(String plaka) throws SQLException {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean basari = false;

        try {
            Connection con = conGetir();
            PreparedStatement checkStmt = con.prepareStatement("SELECT COUNT(*) FROM `mevcut-otopark` WHERE plaka = ?");
            checkStmt.setString(1, plaka);
            ResultSet checkRs = checkStmt.executeQuery();

            int rowCount = 0;
            if (checkRs.next()) {
                rowCount = checkRs.getInt(1);
            }

            checkRs.close();
            checkStmt.close();

            if (rowCount > 0) {
                System.out.println("Plaka zaten kayıtlı!");
            } else {
                String selectQuery = "SELECT id FROM `mevcut-otopark` WHERE bos_dolu = 0 LIMIT 1";
                stmt = con.prepareStatement(selectQuery);
                rs = stmt.executeQuery();

                int parkYerId = 0;
                if (rs.next()) {
                    parkYerId = rs.getInt("id");
                }
                if (parkYerId != 0) {
                    String updateQuery = "UPDATE `mevcut-otopark` SET plaka = ?, giris_saati = ?, bos_dolu = ? WHERE id = ?";
                    stmt = con.prepareStatement(updateQuery);

                    stmt.setString(1, plaka);
                    stmt.setTimestamp(2, getTimestampNow());
                    stmt.setInt(3, 1); // Dolu olduğunu belirtmek için "1" değeri
                    stmt.setInt(4, parkYerId);

                    int affectedRows = stmt.executeUpdate();
                    if (affectedRows > 0) {
                        System.out.println("Kayıt eklendi.");
                        basari = true;
                    } else {
                        System.out.println("Kayıt eklenirken bir hata oluştu.");
                    }
                } else {
                    if (parkYerId == 0) {
                        System.out.println("Boş park yeri bulunamadı.");
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("SQLException: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }
        return basari;
    }

    public boolean deleteArac(String plaka) {
        boolean basari = false;
        long tutar = 0;
        Timestamp giris_saati = null;
        int park_yeri_id = 0;
        try {

            Connection con = conGetir();

            String sql = "SELECT * FROM `mevcut-otopark` WHERE plaka = ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, plaka);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                giris_saati = rs.getTimestamp("giris_saati");
                park_yeri_id = rs.getInt("id");
            }
            System.out.println("Girdi - deleteArac()");

            if (giris_saati != null) {
                Timestamp cikis_saati = getTimestampNow();
                long fark = cikis_saati.getTime() - giris_saati.getTime();
                tutar = fiyatHesapla(fark); // Dakika bazında fiyat hesaplaması
                basari = plakaTasi(con, park_yeri_id, plaka, tutar, giris_saati, cikis_saati);
            }

        } catch (Exception e) {
        }

        return basari;
    }

    public Timestamp getTimestampNow() {
        Date now = new Date();
        return new Timestamp(now.getTime());
    }

    public long fiyatHesapla(long saatFarki) {
        saatFarki = saatFarki / (60 * 60 * 1000);
        long tutar = 0;
        kullanicidb tarife = new kullanicidb();
        ArrayList<tarife> tarifeListem = tarife.getTarife();

        for (tarife kayit : tarifeListem) {
            int baslangic_saati = Integer.parseInt(kayit.getBaslangic_saati());
            int ucret = kayit.getUcret();
            if (kayit.getBitis_saati() == null) {
                if (saatFarki >= baslangic_saati) {
                    tutar = saatFarki * ucret;
                    return tutar; // Eşleşme bulundu, döngüden çık
                }
            } else {
                int bitis_saati = Integer.parseInt(kayit.getBitis_saati());
                if (saatFarki >= baslangic_saati && saatFarki < bitis_saati) {
                    tutar = saatFarki * ucret;
                    return tutar; // Eşleşme bulundu, döngüden çık
                }

            }

        }
        return tutar;
    }

    public boolean plakaTasi(Connection con, int park_yeri_id, String plaka, long tutar, Timestamp giris_zamani, Timestamp cikis_zamani) {
        boolean basari = false;
        try {
            con.setAutoCommit(false); // Transaction başlat
            System.out.println("Girdi plakatasi");
            String countQuery = "SELECT COUNT(*) FROM gecmis WHERE plaka = ?";
            try (PreparedStatement checkStmt = con.prepareStatement(countQuery)) {
                checkStmt.setString(1, plaka);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        int rowCount = rs.getInt(1);

                        PreparedStatement stmt;
                        if (rowCount > 0) {
                            String updateQuery = "UPDATE gecmis SET park_yeri_id = ?, giris_saati = ?, cikis_saati = ?, tutar = ? WHERE plaka = ?";
                            stmt = con.prepareStatement(updateQuery);
                            stmt.setInt(1, park_yeri_id);
                            stmt.setTimestamp(2, giris_zamani);
                            stmt.setTimestamp(3, cikis_zamani);
                            stmt.setLong(4, tutar);
                            stmt.setString(5, plaka);
                            System.out.println("İFE GİRDİ");
                        } else {
                            String insertQuery = "INSERT INTO gecmis (park_yeri_id, plaka, giris_saati, cikis_saati, tutar) VALUES (?, ?, ?, ?, ?)";
                            stmt = con.prepareStatement(insertQuery);
                            stmt.setInt(1, park_yeri_id);
                            stmt.setString(2, plaka);
                            stmt.setTimestamp(3, giris_zamani);
                            stmt.setTimestamp(4, cikis_zamani);
                            stmt.setLong(5, tutar);
                            System.out.println("ELSE GİRDİ");
                        }

                        int affectedRows = stmt.executeUpdate();

                        if (affectedRows > 0) {
                            System.out.println("Veri başarıyla eklendi veya güncellendi.");
                            basari = true;

                        } else {
                            System.out.println("Veri eklenirken veya güncellenirken bir hata oluştu.");
                        }
                        stmt.close();
                    }
                }
            }

            String updateQuery = "UPDATE `mevcut-otopark` SET plaka = NULL, giris_saati = NULL, bos_dolu = 0 WHERE id = ?";
            try (PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {
                updateStmt.setInt(1, park_yeri_id);
                int updatedRows = updateStmt.executeUpdate();
                if (updatedRows > 0) {
                    System.out.println("mevcut-otopark tablosu güncellendi.");
                } else {
                    System.out.println("mevcut-otopark tablosu güncellenirken bir hata oluştu.");
                }
            }

            con.commit(); // Transaction başarıyla tamamlandı
            basari = true;

        } catch (SQLException e) {
            try {
                con.rollback(); // Hata durumunda geri al
            } catch (SQLException rollbackException) {
                rollbackException.printStackTrace(); // Geri alma işlemi sırasında hata
            }
            e.printStackTrace(); // Hata detaylarını göstermek için
            basari = false;
            System.out.println("\n" + basari + "\n");// Hata olduğunda basari false olur
        } finally {
            try {
                con.setAutoCommit(true); // Transaction kapat
            } catch (SQLException setAutoCommitException) {
                setAutoCommitException.printStackTrace(); // AutoCommit ayarlanırken hata
            }
        }
        return basari;
    }

    public ArrayList<parkYeri> getOtoparkDurumu() throws SQLException {
        ArrayList<parkYeri> parkYerleri = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String query = "SELECT * FROM `mevcut-otopark`";
            Connection con = conGetir();
            stmt = con.prepareStatement(query);
            rs = stmt.executeQuery();

            while (rs.next()) {
                parkYeri parkYer = new parkYeri();
                Timestamp giris_saati = rs.getTimestamp("giris_saati");
                String plaka = rs.getString("plaka");

                if (plaka == null || plaka.isEmpty()) {
                    plaka = "-";
                }

                if (giris_saati == null || plaka.isEmpty()) {
                    giris_saati = getTimestampNow();
                }
                parkYer.fullSet(rs.getInt("id"), plaka, giris_saati, rs.getInt("bos_dolu"));
                parkYerleri.add(parkYer);
            }
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }

        return parkYerleri;
    }

    public int getDoluluk() {
        int doluluk = 0;
        try {
            String sql = "SELECT COUNT(*) AS sayi FROM `mevcut-otopark` WHERE bos_dolu = 1";
            Connection con = conGetir();
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                doluluk = rs.getInt("sayi");
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doluluk;
    }
}
