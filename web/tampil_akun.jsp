<%-- ingat tulisan {datasource} memiliki hub dengan 
     <sql:setDataSource var="dataSource" di index.jsp --%>
<sql:query var="qryuser" dataSource="${dataSource}">
    <%-- perubahan muai dari where ...--%>
    SELECT * FROM master_akun WHERE kode_akun 
    LIKE '%${param.cari}%' 
    OR nama_akun
    LIKE '%${param.cari}%'
</sql:query>

<%@page import= "java.sql.*, model.Akun" %>
<%
    Connection koneksi = null;
    Statement stmt = null;
    ResultSet rs = null;
    Class.forName("com.mysql.jdbc.Driver");
    koneksi = DriverManager
            .getConnection("jdbc:mysql://localhost/warung_pasta",
                    "root", "");
    stmt = koneksi.createStatement();
    rs = stmt.executeQuery("SELECT * FROM master_akun"
            + " ORDER BY kode_akun");
%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Master Akun</title>
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
                font-size: 20px;
            }
            tr:nth-child(even){background-color: #ffffff; color: black;}

        </style> 
    </head>
    <body>
        <h1>[Data Nama Akun Warung Pasta]</h1>
        <img src="gambar/user.png" width="45px" height="45px" style="float:left; margin-right: 5px; margin-left: 20px;"/>
        <b><a href="beranda1.jsp?hal=new-akun">Tambah Akun Baru</a></b>
        <form action="#" method="post"><br>
            Cari Data Akun : <input type="text" name="cari" value="${param.cari}"/> <%-- modif value --%>
            <input type="submit" value=" Cari " class="button"/><br>
        </form>
        <table border="17" cellpadding="17">

            <tr>
                <td>Kode Akun</td>
                <td>Nama Akun</td> 
                <td>Jenis Akun</td> 
                <td>Saldo Normal</td> 
                <td>Action</td>
            </tr>
            <c:forEach var="rowakun" items="${qryuser.rowsByIndex}">
                <tr class="isi">
                    <td align='center'>${rowakun[0]}</td>
                    <td align='center'>${rowakun[1]}</td>
                    <td align='center'>${rowakun[2]}</td>
                    <td align='center'>${rowakun[3]}</td>
                    <td align='center'>
                        <a href='beranda1.jsp?hal=edit-akun&master_akun=${rowakun[0]} &nama_akun=${rowakun[1]}&jenis_akun=${rowakun[3]}&saldo_normal=${rowakun[4]}'> Edit</a> |
                        <a href='akunServlet?aksi=Delete&kode_akun=${rowakun[0]} &nama_akun=${rowakun[1]}&jenis_akun=${rowakun[3]}&saldo_normal=${rowakun[4]}'> Hapus</a>

                    </td>
                </tr>
            </c:forEach>

        </table>
    </body>
</html>
