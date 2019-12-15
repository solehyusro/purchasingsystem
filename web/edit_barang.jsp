<%-- 
    Document   : edit_supplier
    Created on : Apr 17, 2018, 8:01:22 PM
    Author     : user
--%>
<style type="text/css">
           table {
                width: 600px;
                font-family: Arial, Helvetica, sans-serif;
                background-color: #ff9900;
                border-style: ridge;
                border-color: #c40b00;
                border-collapse: separate;
                text-align: left;
                padding: 4px;
                color: white;
            }
             h1 {
                border-style: inset;
                border-collapse: separate;
                background-color: #c40b00;
                width: 700px;
                height: 70px;
                border-color: #c40b00;
                font-family: 'cambria', sans-serif;
                color: white;
                letter-spacing: 6px;
                font-size: 30px;
                padding: 15px;
                margin-bottom: 10px;
                margin-top: 10px;
           }
            input {
                border-color: #ff9900;
                color: #ff9900;
                font-family: Georgia, Arial, sans-serif;
                font-size: 16px;
                padding: 3px;
            }
            input:hover {
                background-color: #ff9900;
                color: #ffffff;
            }
            input.button {
                background-color: #ff9900;
                color: #ff9900;
                font-family: 'Roboto', sans-serif;
                margin-right: 10px;
            }
            input.button:hover {
                background-color: #ff9900;
                color: #ffffff;
            }
            select {
                border-color: #ff9900;
                color: #ff9900;
                font-family: Georgia, Arial, sans-serif;
            }
            select:hover {
                background-color: #ff9900;
                color: #ffffff;
            }
            select option [selected="selected"]
            {
                font-weight: bold;
                background-color: #ff9900;
                color: #ff9900;
            }
        </style> 



<%@page import= "java.sql.*,model.Barang" %>
<%
    Barang barang = new Barang ();
    Connection koneksi = null;
    Statement stmt = null;
    ResultSet rs = null;
    Class.forName("com.mysql.jdbc.Driver");
    koneksi = DriverManager.getConnection("jdbc:mysql://localhost/warung_pasta", "root", "");
    stmt = koneksi.createStatement();
    String kode = request.getParameter("barang");
    if (kode != null) {
        rs = stmt.executeQuery("SELECT * FROM barang"
                + " WHERE kode_barang = '" + kode + "'");
        if (rs.next()) {
            barang.setKode_barang(rs.getString("kode_barang"));
            barang.setNama_barang(rs.getString("nama_barang"));
            barang.setHarga_beli(rs.getString("harga_beli"));
            barang.setStok_barang(rs.getString("stok_barang"));
        }
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Barang</title>
    </head>
    <body>
        <h1>[Edit Bahan Baku Warung Pasta ]</h1>
        <form action="barangServlet" method="POST">
            <table border="17" cellpadding="17">
               <tr style="background-color: white; color: black; ">
                    <td>Kode Bahan Baku</td>
                    <td>: <input type="text" name="kode_barang" size="25" value="<%=barang.getKode_barang()%>"readonly/></td>
                </tr>
                <tr>
                    <td>Nama Bahan Baku</td>
                    <td>: <input type="text" name="nama_barang" size="25" value="<%=barang.getNama_barang()%>"/></td>
                </tr>
               <tr style="background-color: white; color: black; ">
                    <td>Harga Beli</td>
                    <td>: <input type="text" name="harga_beli" size="25" value="<%=barang.getHarga_beli()%>"/></td>
                </tr>
                <tr>
                    <td>Stok Bahan Baku</td>
                    <td>: <input type="text" name="stok_barang" size="25" value="<%=barang.getStok_barang()%>"/></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Update" name="aksi"/></td>
                </tr>
            </table>
        </form>
    </body>
</html>