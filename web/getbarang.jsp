<%@page import="java.sql.*" %> 
<%@page import="model.Barang"%>
<%
    Barang pesan = new Barang();
    ResultSet rs = null;
    String emp_id = request.getParameter("emp_id").toString();
    Connection koneksi = null;
    String data = null;
    Statement st;
    Statement stmt = null;
    koneksi = DriverManager
            .getConnection("jdbc:mysql://localhost/warung_pasta",
                    "root", "");
    stmt = koneksi.createStatement();
    rs = stmt.executeQuery("SELECT *from barang where kode_barang='" + emp_id + "' ");
    while (rs.next()) {
        data = ":" + rs.getString(3) + ":" + emp_id;
    }
    out.println(data);
%>