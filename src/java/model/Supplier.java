/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author USER PC
 */
public class Supplier {

    private String kode_supplier;
    private String nama_supplier;
    private String alamat;
    private String tlp;

    public String getKode_supplier() {
        return kode_supplier;
    }

    public void setKode_supplier(String kode_supplier) {
        this.kode_supplier = kode_supplier;
    }

    public String getNama_supplier() {
        return nama_supplier;
    }

    public void setNama_supplier(String nama_supplier) {
        this.nama_supplier = nama_supplier;
    }

    public String getAlamat() {
        return alamat;
    }

    public void setAlamat(String alamat) {
        this.alamat = alamat;
    }

    public String getTlp() {
        return tlp;
    }

    public void setTlp(String tlp) {
        this.tlp = tlp;
    }
}
