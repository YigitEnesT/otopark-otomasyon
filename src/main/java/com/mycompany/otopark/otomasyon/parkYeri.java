/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.otopark.otomasyon;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author yetun
 */
public class parkYeri {

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPlaka() {
        return plaka;
    }

    public void setPlaka(String plaka) {
        this.plaka = plaka;
        if (plaka != "-") {
            String[] plakaBolumleri = plaka.split("-");

            setPlakaBas(plakaBolumleri[0]);
            setPlakaOrta(plakaBolumleri[1]);
            setPlakaSon(plakaBolumleri[2]);
        } else {
            setPlakaBas(" ");
            setPlakaOrta(" ");
            setPlakaSon(" ");
        }

    }

    public Timestamp getGiris_saati() {
        return giris_saati;
    }

    public void setGiris_saati(Timestamp giris_saati) {
        this.giris_saati = giris_saati;
    }

    public int getBosDolu() {
        return bosDolu;
    }

    public void setBosDolu(int bosDolu) {
        this.bosDolu = bosDolu;
    }

    public long getTutar() {
        return tutar;
    }

    public String getFormattedGiris_saati() {
        return formattedGiris_saati;
    }

    public void setFormattedGiris_saati(String formattedGiris_saati) {
        this.formattedGiris_saati = formattedGiris_saati;
    }

    public void setTutar(long tutar) {
        this.tutar = tutar;
    }

    public long getFark() {
        return fark;
    }

    public void setFark(long fark) {
        this.fark = fark;
    }

    public void fullSet(int id, String plaka, Timestamp giris_saati, int bosDolu) {
        this.id = id;
        setPlaka(plaka);
        this.giris_saati = giris_saati;

        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy HH:mm:ss");
        setFormattedGiris_saati(sdf.format(giris_saati));
        if (giris_saati != null) {
            long fark2 = (getTimestampNow().getTime() - giris_saati.getTime());
            setFark(fark2);
        } else {
            setFark(0);
        }

        this.bosDolu = bosDolu;
    }

    private int id;
    private String plaka;
    private Timestamp giris_saati;
    private int bosDolu;
    private long tutar = 0;
    private String formattedGiris_saati;
    private long fark;
    private String plakaBas;
    private String plakaOrta;

    public String getPlakaBas() {
        return plakaBas;
    }

    public void setPlakaBas(String plakaBas) {
        this.plakaBas = plakaBas;
    }

    public String getPlakaOrta() {
        return plakaOrta;
    }

    public void setPlakaOrta(String plakaOrta) {
        this.plakaOrta = plakaOrta;
    }

    public String getPlakaSon() {
        return plakaSon;
    }

    public void setPlakaSon(String plakaSon) {
        this.plakaSon = plakaSon;
    }
    private String plakaSon;

    public String getParkTime() {
        if (getBosDolu() == 1) {
            long dakikaFarki = (getFark() / (60 * 1000));
            if (dakikaFarki < 60) {
                return dakikaFarki + "DK";
            } else {
                long saatFarki = dakikaFarki / 60;
                dakikaFarki = dakikaFarki % 60;
                return (saatFarki + " Saat " + dakikaFarki + " DK");
            }
        } else {
            return "-";
        }

    }

    public Timestamp getTimestampNow() {
        Date now = new Date();
        return new Timestamp(now.getTime());
    }

    public long mevcutTutar(Timestamp giris_saati) {
        if (getBosDolu() == 1) {
            long fark = getTimestampNow().getTime() - giris_saati.getTime() ;
            admindb fiyat = new admindb();
            return fiyat.fiyatHesapla(fark);
        } else {
            return 0;
        }
    }
}
