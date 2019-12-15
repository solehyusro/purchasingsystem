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



<%@page import= "java.sql.*,model.User" %>
<%
    User user = new User ();
    Connection koneksi = null;
    Statement stmt = null;
    ResultSet rs = null;
    Class.forName("com.mysql.jdbc.Driver");
    koneksi = DriverManager.getConnection("jdbc:mysql://localhost/warung_pasta", "root", "");
    stmt = koneksi.createStatement();
    String kode = request.getParameter("user");
    if (kode != null) {
        rs = stmt.executeQuery("SELECT * FROM user"
                + " WHERE Id_user = '" + kode + "'");
        if (rs.next()) {
            user.setId_user(rs.getString("id_user"));
            user.setNama(rs.getString("nama"));
            user.setPass(rs.getString("pass"));
            user.setHak_akses(rs.getString("hak_akses"));
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
        <h1>[Edit User Warung Pasta]</h1>
        <form action="userServlet" method="POST">
            <table border="17" cellpadding="17">
                <tr style="background-color: white; color: black; ">
                    <td>ID User</td>
                    <td>: <input type="text" name="id_user" size="25" value="<%=user.getId_user()%>" readonly/></td>
                </tr>
                <tr>
                    <td>Nama User</td>
                    <td>: <input type="text" name="nama" size="25" value="<%=user.getNama()%>"/></td>
                </tr>
                <tr style="background-color: white; color: black;">
                    <td>Password</td>
                    <td>: <input type="password" name="pass" size="25" value="<%=user.getPass()%>"/></td>
                </tr>
                <tr>
                    <td>Hak Akses</td>
                    <td>: <input type="text" name="hak_akses" size="25" value="<%=user.getHak_akses()%>"/></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Update" name="aksi"/></td>
                </tr>
            </table>
        </form>
    </body>
</html>