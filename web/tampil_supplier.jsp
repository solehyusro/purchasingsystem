<%-- ingat tulisan {datasource} memiliki hub dengan 
     <sql:setDataSource var="dataSource" di index.jsp --%>
<sql:query var="qrysupplier" dataSource="${dataSource}">
    <%-- perubahan muai dari where ...--%>
    SELECT * FROM supplier WHERE kode_supplier 
    LIKE '%${param.cari}%' 
    OR nama_supplier
    LIKE '%${param.cari}%'
</sql:query>
<style>
    table {
        width: 800px;
        font-family: Arial, Helvetica, sans-serif;
        background-color: #ff9900;
        border-style: ridge;
        border-color: #c40b00;
        border-collapse: separate;
        text-align: left;
        padding: 4px;
        color: white;
        font-size: 15px;
    }
    h1 {
        border-style: inset;
        border-collapse: separate;
        background-color: #c40b00;
        width: 800px;
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
    a {
        color: black;
        font: "Times New Roman",sans-serif;
        font-size: 15px;
    }
    tr:nth-child(even){background-color: #ffffff; color: black;}

</style>

<%@page import= "java.sql.*, model.Supplier" %>
<%
    Connection koneksi = null;
    Statement stmt = null;
    ResultSet rs = null;
    Class.forName("com.mysql.jdbc.Driver");
    koneksi = DriverManager
            .getConnection("jdbc:mysql://localhost/warung_pasta",
                    "root", "");
    stmt = koneksi.createStatement();
    rs = stmt.executeQuery("SELECT * FROM supplier"
            + " ORDER BY kode_supplier");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Supplier</title>
    </head>
    <body>
        <h1>[Data Nama Supplier Warung Pasta]</h1>
        <img src="gambar/user.png" width="45px" height="45px" style="float:left; margin-right: 5px; margin-left: 20px;"/>
        <b><a href="beranda1.jsp?hal=new-supplier">Tambah Supplier Baru</a></b>
        <form action="#" method="post"><br>
            Cari Data Akun : <input type="text" name="cari" value="${param.cari}"/> <%-- modif value --%>
            <input type="submit" value=" Cari " class="button"/><br>
        </form>
        <table border="17" cellpadding="17">

            <tr>
                <td>Kode Supplier</td>
                <td>Nama Supplier</td>
                <td>Alamat Supplier</td>
                <td>No Telphone Supplier</td>
                <td>Action</td>
            </tr>
            <c:forEach var="rowakun" items="${qrysupplier.rowsByIndex}">
                <tr class="isi">
                    <td align='center'>${rowakun[0]}</td>
                    <td>${rowakun[1]}</td>
                    <td align='center'>${rowakun[2]}</td>
                    <td align='center'>${rowakun[3]}</td>
                    <td align='center'>
                        <a href='beranda1.jsp?hal=edit-supplier&supplier=${rowakun[0]} &nama_supplier=${rowakun[1]}&alamat=${rowakun[3]}&tlp=${rowakun[4]}'> Edit</a> |
                        <a href='supplierServlet?aksi=Delete&kode_supplier=${rowakun[0]} &nama_supplier=${rowakun[1]}&alamat=${rowakun[3]}&tlp=${rowakun[4]}'> Hapus</a>

                    </td>
                </tr>
            </c:forEach>

        </table>
    </body>
</html>
