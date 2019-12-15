package model;
public class Akun {

    private String kode_akun;
    private String nama_akun;
    private String jenis_akun;
    private String saldo_normal;

    public String getKode_akun() {
        return kode_akun;
    }

    public void setKode_akun(String kode_akun) {
        this.kode_akun = kode_akun;
    }

    public String getNama_akun() {
        return nama_akun;
    }

    public void setNama_akun(String nama_akun) {
        this.nama_akun = nama_akun;
    }

    public String getJenis_akun() {
        return jenis_akun;
    }

    public void setJenis_akun(String jenis_akun) {
        this.jenis_akun = jenis_akun;
    }

    public String getSaldo_normal() {
        return saldo_normal;
    }

    public void setSaldo_normal(String saldo_normal) {
        this.saldo_normal = saldo_normal;
    }

}