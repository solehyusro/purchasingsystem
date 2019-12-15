<%-- 
    Document   : edit_supplier
    Created on : Apr 17, 2018, 8:01:22 PM
    Author     : user
--%>
<%@page import="model.Akun"%>
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
                width: 600px;
                height: 70px;
                border-color: #c40b00;
                font-family: 'cambria', sans-serif;
                color: white;
                letter-spacing: 6px;
                font-size: 35px;
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



<%@page import= "java.sql.*,model.Akun" %>
<%
    Akun akun = new Akun ();
    Connection koneksi = null;
    Statement stmt = null;
    ResultSet rs = null;
    Class.forName("com.mysql.jdbc.Driver");
    koneksi = DriverManager.getConnection("jdbc:mysql://localhost/warung_pasta", "root", "");
    stmt = koneksi.createStatement();
    String kode = request.getParameter("master_akun");
    if (kode != null) {
        rs = stmt.executeQuery("SELECT * FROM master_akun"
                + " WHERE kode_akun = '" + kode + "'");
        if (rs.next()) {
            akun.setKode_akun(rs.getString("kode_akun"));
            akun.setNama_akun(rs.getString("nama_akun"));
            akun.setJenis_akun(rs.getString("jenis_akun"));
            akun.setSaldo_normal(rs.getString("saldo_normal"));
        }
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User</title>
    </head>
    <body>
        <h1>[Edit Akun Warung Pasta]</h1>
        <form action="akunServlet" method="POST">
            <table border="17" cellpadding="17">
                <tr style="background-color: white; color: black; ">
                    <td>Kode Akun</td>
                    <td>: <input type="text" name="kode_akun" size="25" value="<%=akun.getKode_akun()%>" readonly/></td>
                </tr>
                <tr>
                    <td>Nama Akun</td>
                    <td>: <input type="text" name="nama_akun" size="25" value="<%=akun.getNama_akun()%>"/></td>
                </tr>
                <tr style="background-color: white; color: black;">
                        <td>Jenis Akun</td>
                        <td> :
                            <select name="jenis_akun">
                                <!--Jenis Akun disesuaikan sendiri-->
                                <option value="Kas/Bank" selected>Kas/Bank</option>
                                <option value="Aktiva Lancar">Aktiva Lancar</option>
                                <option value="Aktiva Tetap">Aktiva Tetap</option>
                                <option value="Kewajiban">Kewajiban</option>
                                <option value="Modal">Modal</option>
                                <option value="Harta">Harta</option>
                                <option value="Pendapatan">Pendapatan</option>                                
                                <option value="Beban">Beban</option>
                            </select>
                        </td>
                    </tr>
                <tr>
                        <td>Saldo Normal</td>
                        <td> :
                            <select name="saldo_normal">
                                <%
                        if (akun.getSaldo_normal()
                                .equalsIgnoreCase("Debet")) { %>
                                <option value="Debet" selected>Debet</option>
                                <option value="Kredit">Kredit</option>
                                <% } else { %>
                                <option value="Debet">Debet</option>
                                <option value="Kredit" selected>Kredit</option>
                                <% }%>
                            </select>
                        </td>
                    </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Update" name="aksi"/></td>
                </tr>
            </table>
        </form>
    </body>
</html>