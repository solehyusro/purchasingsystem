<%@page import="java.sql.*" %> 
<%@page import="model.Pembelian"%>
<%
    Pembelian pembelian = new Pembelian();
    ResultSet rs = null;
    Connection koneksi = null;
    Statement stmt = null;
    String emp_id = request.getParameter("emp_id").toString();
    String data = null;
    Statement st;
    koneksi = DriverManager
            .getConnection("jdbc:mysql://localhost/warung_pasta", "root", "");
    stmt = koneksi.createStatement();
    rs = stmt.executeQuery("SELECT *from pembelian where kode_pembelian='" + emp_id + "' ");
    while (rs.next()) {
        data = ":" + rs.getString(8) + ":" + emp_id;
    }
    out.println(data);
%>