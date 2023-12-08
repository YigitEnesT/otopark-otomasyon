/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.otopark.otomasyon;

/**
 *
 * @author yetun
 */
public class tarife {

    public String getBaslangic_saati() {
        return baslangic_saati;
    }

    public void setBaslangic_saati(String baslangic_saati) {
        this.baslangic_saati = baslangic_saati;
    }

    public String getBitis_saati() {
        return bitis_saati;
    }

    public void setBitis_saati(String bitis_saati) {
        this.bitis_saati = bitis_saati;
    }

    public int getUcret() {
        return ucret;
    }

    public void setUcret(int ucret) {
        this.ucret = ucret;
    }
    int id;
    String baslangic_saati;
    String bitis_saati;
    int ucret;
}
