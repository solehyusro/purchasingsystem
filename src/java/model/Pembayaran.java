package model;

public class Pembayaran {
private String kode_pembayaran;
private String kode_pembelian;

    private String tanggal;
 
    private String jumlah_bayar;

    public String getKode_pembayaran() {
        return kode_pembayaran;
    }

    public void setKode_pembayaran(String kode_pembayaran) {
        this.kode_pembayaran = kode_pembayaran;
    }

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

    public String getJumlah_bayar() {
        return jumlah_bayar;
    }

    public void setJumlah_bayar(String jumlah_bayar) {
        this.jumlah_bayar = jumlah_bayar;
    }


}