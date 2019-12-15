<%-- ingat tulisan {datasource} memiliki hub dengan 
     <sql:setDataSource var="dataSource" di index.jsp --%>
<sql:query var="qryuser" dataSource="${dataSource}">
    <%-- perubahan muai dari where ...--%>
    SELECT * FROM user WHERE id_user 
    LIKE '%${param.cari}%' 
    OR nama
    LIKE '%${param.cari}%'
</sql:query>

<%@page import= "java.sql.*, model.User" %>
<%
    Connection koneksi = null;
    Statement stmt = null;
    ResultSet rs = null;
    Class.forName("com.mysql.jdbc.Driver");
    koneksi = DriverManager
            .getConnection("jdbc:mysql://localhost/warung_pasta",
                    "root", "");
    stmt = koneksi.createStatement();
    rs = stmt.executeQuery("SELECT * FROM user"
            + " ORDER BY id_user");
%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User</title>
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
        <h1>[Data Nama User Warung Pasta]</h1>
        <img src="gambar/user.png" width="45px" height="45px" style="float:left; margin-right: 5px; margin-left: 20px;"/>
        <b><a href="beranda1.jsp?hal=new-user">Tambah User Baru</a></b>
        <form action="#" method="post"><br>
            Cari Data Akun : <input type="text" name="cari" value="${param.cari}"/> <%-- modif value --%>
            <input type="submit" value=" Cari " class="button"/><br>
        </form>
        <table border="17" cellpadding="17">

            <tr>
                <td>ID User</td>
                <td>Nama User</td> 
                <td>Password</td> 
                <td>Hak Akses</td> 
                <td>Action</td>
            </tr>
            <c:forEach var="rowakun" items="${qryuser.rowsByIndex}">
                <tr class="isi">
                    <td align='center'>${rowakun[0]}</td>
                    <td>${rowakun[1]}</td>
                    <td align='center'${rowakun[2]}>*****</td>
                    <td align='center'>${rowakun[3]}</td>
                    <td align='center'>
                        <a href='beranda1.jsp?hal=edit-user&user=${rowakun[0]} &nama=${rowakun[1]}&pass=${rowakun[3]}&hak_akses=${rowakun[4]}'> Edit</a> |
                        <a href='userServlet?aksi=Delete&id_user=${rowakun[0]} &nama=${rowakun[1]}&pass=${rowakun[3]}&hak_akses=${rowakun[4]}'> Hapus</a>

                    </td>
                </tr>
            </c:forEach>

        </table>
    </body>
</html>
