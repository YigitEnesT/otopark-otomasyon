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

    public void fullSet(int id, String plaka, Timestamp giris_saati, int bosDolu, long tutar) {
        this.id = id;
        this.plaka = plaka;
        this.giris_saati = giris_saati;
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy HH:mm:ss");
        setFormattedGiris_saati(sdf.format(giris_saati));

        this.bosDolu = bosDolu;
        this.tutar = tutar;
    }
    private int id;
    private String plaka;
    private Timestamp giris_saati;
    private int bosDolu;
    private long tutar = 0;
    private String formattedGiris_saati;

    public Timestamp getTimestampNow() {
        Date now = new Date();
        return new Timestamp(now.getTime());
    }

    public long mevcutTutar(Timestamp giris_saati) {
        admindb fiyat = new admindb();
        return fiyat.fiyatHesapla((getTimestampNow().getTime() - giris_saati.getTime()));
    }
}
