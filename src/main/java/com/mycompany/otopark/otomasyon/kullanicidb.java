/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.otopark.otomasyon;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author yetun
 */
public class kullanicidb {

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
    public  Timestamp getTimestampNow() 
    {
        Date now = new Date();
        return new Timestamp(now.getTime());
    }
    public parkYeri getMevcutArac(String plaka) {
        parkYeri mevcutArac = new parkYeri();
        
        try {
            Connection con = conGetir();
            
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM `mevcut-otopark` WHERE plaka = ?");
            stmt.setString(1, plaka);
            ResultSet rs = stmt.executeQuery();

           
            
            while (rs.next()) {
                Timestamp giris_saati = rs.getTimestamp("giris_saati");
                Timestamp mevcut_saat = getTimestampNow();
                long fark = (mevcut_saat.getTime() - giris_saati.getTime());
                
                // Tüm sütunları al ve ArrayList'e ekle
                SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy HH:mm:ss");
                String girisSaati = sdf.format(rs.getTimestamp("giris_saati"));
                
                // Önceden Yaptığım işlem
                //String veri = "Park Yeri ID: " + rs.getInt("id") + ", Plaka: " + rs.getString("plaka") + ", Giriş Saati: " + girisSaati + ", Tutar: " + fiyatHesapla(fark);
                
                admindb obj = new admindb();
                mevcutArac.fullSet(rs.getInt("id"), rs.getString("plaka"),rs.getTimestamp("giris_saati"),rs.getInt("bos_dolu"));
                mevcutArac.setTutar(mevcutArac.mevcutTutar(rs.getTimestamp("giris_saati")));
            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return mevcutArac;
    }
    
    public ArrayList<tarife> getTarife(){
        ArrayList<tarife> myList = new ArrayList<tarife>();
        try {
            Connection con = conGetir();
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM `tarife`");
            ResultSet rs = stmt.executeQuery();
           
            while (rs.next()) {
                tarife kayit = new tarife();
                
                kayit.setBaslangic_saati(rs.getString("baslangic_saati"));
                kayit.setBitis_saati(rs.getString("bitis_saati"));
                kayit.setUcret(rs.getInt("ucret"));
                myList.add(kayit);
            }

            con.close();
        } catch (Exception e) {
        }
        return myList;
    }
}