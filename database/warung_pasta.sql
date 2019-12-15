-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Inang: 127.0.0.1
-- Waktu pembuatan: 12 Sep 2019 pada 06.46
-- Versi Server: 5.5.27
-- Versi PHP: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Basis data: `warung_pasta`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE IF NOT EXISTS `barang` (
  `kode_barang` varchar(6) NOT NULL,
  `nama_barang` varchar(100) NOT NULL,
  `harga_beli` int(25) NOT NULL,
  `stok_barang` int(25) NOT NULL,
  PRIMARY KEY (`kode_barang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`kode_barang`, `nama_barang`, `harga_beli`, `stok_barang`) VALUES
('BB0001', 'Aqua Botol @Dus', 37000, 7),
('BB0002', 'Susu Full Cream @pack', 14500, 9),
('BB0003', 'Pasta Spaghetti @pack', 18500, 15),
('BB0004', 'Pasta Fettucine @pack', 17000, 14),
('BB0005', 'Pasta Fusili @pack', 17000, 9),
('BB0006', 'Saus Cream @pack', 20000, 12),
('BB0007', 'Saus Tomat @pack', 18500, 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurnal`
--

CREATE TABLE IF NOT EXISTS `jurnal` (
  `no_referensi` varchar(10) NOT NULL,
  `tgl_trans` date NOT NULL,
  `kode_pembelian` varchar(25) NOT NULL,
  `keterangan` varchar(25) NOT NULL,
  PRIMARY KEY (`no_referensi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `jurnal`
--

INSERT INTO `jurnal` (`no_referensi`, `tgl_trans`, `kode_pembelian`, `keterangan`) VALUES
('JU00000001', '2019-09-11', 'PM00000001', '12'),
('JU00000002', '2019-09-13', 'PM00000002', 'mm');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurnal_detail`
--

CREATE TABLE IF NOT EXISTS `jurnal_detail` (
  `no_referensi` varchar(25) NOT NULL,
  `kode_akun` varchar(25) NOT NULL,
  `debet` int(20) NOT NULL,
  `kredit` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `jurnal_detail`
--

INSERT INTO `jurnal_detail` (`no_referensi`, `kode_akun`, `debet`, `kredit`) VALUES
('JU00000001', '1-1100', 2, 0),
('JU00000001', '1-1300', 0, 2),
('JU00000002', '5-0000', 33, 0),
('JU00000002', '1-1100', 0, 33);

-- --------------------------------------------------------

--
-- Struktur dari tabel `master_akun`
--

CREATE TABLE IF NOT EXISTS `master_akun` (
  `kode_akun` varchar(6) NOT NULL,
  `nama_akun` varchar(25) NOT NULL,
  `jenis_akun` varchar(25) NOT NULL,
  `saldo_normal` varchar(25) NOT NULL,
  PRIMARY KEY (`kode_akun`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `master_akun`
--

INSERT INTO `master_akun` (`kode_akun`, `nama_akun`, `jenis_akun`, `saldo_normal`) VALUES
('1-1100', 'Bank Mandiri', 'Kas/Bank', 'Debet'),
('1-1300', 'Persediaan Bahan Baku', 'Aktiva Lancar', 'Debet'),
('5-0000', 'Pembelian', 'HPP', 'Debet');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembayaran`
--

CREATE TABLE IF NOT EXISTS `pembayaran` (
  `kode_pembayaran` varchar(10) NOT NULL,
  `kode_pembelian` varchar(25) NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah_bayar` int(25) NOT NULL,
  PRIMARY KEY (`kode_pembayaran`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pembayaran`
--

INSERT INTO `pembayaran` (`kode_pembayaran`, `kode_pembelian`, `tanggal`, `jumlah_bayar`) VALUES
('PB00000001', 'PM00000001', '2019-07-02', 148000),
('PB00000002', 'PM00000002', '2019-07-02', 92500);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembelian`
--

CREATE TABLE IF NOT EXISTS `pembelian` (
  `kode_pembelian` varchar(10) NOT NULL,
  `tgl` date NOT NULL,
  `kode_barang` varchar(25) NOT NULL,
  `kode_supplier` varchar(25) NOT NULL,
  `satuan` varchar(15) NOT NULL,
  `harga_beli` int(25) NOT NULL,
  `qty` int(25) NOT NULL,
  `subtotal` int(25) NOT NULL,
  `keterangan` enum('tampil','tidak tampil') NOT NULL,
  PRIMARY KEY (`kode_pembelian`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pembelian`
--

INSERT INTO `pembelian` (`kode_pembelian`, `tgl`, `kode_barang`, `kode_supplier`, `satuan`, `harga_beli`, `qty`, `subtotal`, `keterangan`) VALUES
('PM00000001', '2019-07-02', 'BB0001', 'SP0001', 'Pack', 37000, 4, 148000, 'tampil'),
('PM00000002', '2019-07-02', 'BB0003', 'SP0002', 'Pack', 18500, 5, 92500, 'tampil'),
('PM00000003', '2019-09-09', 'BB0002', 'SP0003', 'Dus', 14500, 5, 72500, 'tidak tampil');

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

CREATE TABLE IF NOT EXISTS `supplier` (
  `kode_supplier` varchar(6) NOT NULL,
  `nama_supplier` varchar(100) NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `tlp` varchar(15) NOT NULL,
  PRIMARY KEY (`kode_supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `supplier`
--

INSERT INTO `supplier` (`kode_supplier`, `nama_supplier`, `alamat`, `tlp`) VALUES
('SP0001', 'CV. Alam Jaya', 'Jl. Cempaka Raya No. 02 Jakarta', '081281239045'),
('SP0002', 'PT. Bogasari Flour Mils', 'Jl. Raya Cilinging No.01 Jakarta utara', '021-29263800'),
('SP0003', 'PT. Sukanda Djaya', 'Jl. Pasir Putih Kav. 1 Ancol Jakarta', '021-6405678');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id_user` varchar(5) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `pass` varchar(25) NOT NULL,
  `hak_akses` varchar(25) NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `nama`, `pass`, `hak_akses`) VALUES
('MG001', 'Kristopher Kenji', '123456', 'Manager'),
('PC001', 'Soleh Yusro', '123456', 'PIC'),
('PR001', 'Michael Wirianto', '123456', 'Purchasing'),
('PR002', 'Prawira Kusuma', '123456', 'Purchasing');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
