/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author user
 */
public class Pembelian {
    private String kode_pembelian;
    private String tanggal;
    private String kode_barang;
    private String kode_supplier;
    private String satuan;
    private String harga_beli;
    private String qty;
    private String subtotal;

    public String getKode_pembelian() {
        return kode_pembelian;
    }

    public void setKode_pembelian(String kode_pembelian) {
        this.kode_pembelian = kode_pembelian;
    }

    public String getTanggal() {
        return tanggal;
    }

    public void setTanggal(String tanggal) {
        this.tanggal = tanggal;
    }

    public String getKode_barang() {
        return kode_barang;
    }

    public void setKode_barang(String kode_barang) {
        this.kode_barang = kode_barang;
    }

    public String getKode_supplier() {
        return kode_supplier;
    }

    public void setKode_supplier(String kode_supplier) {
        this.kode_supplier = kode_supplier;
    }

    public String getSatuan() {
        return satuan;
    }

    public void setSatuan(String satuan) {
        this.satuan = satuan;
    }

    public String getHarga_beli() {
        return harga_beli;
    }

    public void setHarga_beli(String harga_beli) {
        this.harga_beli = harga_beli;
    }

    public String getQty() {
        return qty;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }

    public String getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(String subtotal) {
        this.subtotal = subtotal;
    }


}