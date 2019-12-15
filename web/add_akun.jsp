<%-- 
    Document   : add_user
    Created on : Apr 11, 2018, 12:28:55 PM
    Author     : USER PC
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Akun</title>
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
                font-size: 30px;
                padding: 15px;
                margin-bottom: 10px;
                margin-top: 10px;
                margin-left: 70px;
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
    </head>
    <body>
        <h1>Tambah Akun Baru</h1>
        <img src="gambar/user.png" width="45px" height="45px" style="float:left; margin-right: 5px; margin-left: 20px;"/>
        <form action="akunServlet" method="POST">
            <table border="17" cellpadding="17">
                <tbody>
                    <tr style="background-color: white; color: black;">
                        <td>Kode Akun</td>
                        <td><input type="text" name="kode_akun" size="25" /></td>
                    </tr>
                    <tr>
                        <td>Nama Akun</td>
                        <td><input type="text" name="nama_akun" size="25"/> </td>
                    </tr>
                    <tr style="background-color: white; color: black;">
                        <td>Jenis Akun</td>
                        <td>
                            <select name="jenis_akun">
                                <!--Jenis Akun disesuaikan sendiri-->
                                <option value="Kas/Bank" selected>Kas/Bank</option>
                                <option value="Aktiva Lancar">Aktiva Lancar</option>
                                <option value="Aktiva Tetap">Aktiva Tetap</option>
                                <option value="Kewajiban">Kewajiban</option>
                                <option value="Modal">Modal</option>
                                <option value="Harta">Harta</option>
                                <option value="HPP">HPP</option>
                                <option value="Pendapatan">Pendapatan</option>                                
                                <option value="Beban">Beban</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Saldo Normal</td>
                        <td>
                            <select name="saldo_normal">
                                <option value="Debet">Debet</option>
                                <option value="Kredit">Kredit</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Simpan" name="aksi"/></td>
                        <td><input type="reset" value="Batal" name="batal"/></td>
                    </tr>
            </table>
        </form>
    </body>
</html>
