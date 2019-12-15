<%@page import="java.sql.*" %> 
<%@page import="model.Pembelian"%>
<%
    Pembelian pesan = new Pembelian();
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
    rs = stmt.executeQuery("SELECT *from pembelian where kode_pembelian='" + emp_id + "' ");
    while (rs.next()) {
        data = ":" + rs.getString(8) + ":" + emp_id;
    }
    out.println(data);
%>