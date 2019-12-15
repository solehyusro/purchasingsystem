<%@page import="java.sql.*, model.Akun, model.Jurnal, model.Pembelian" %>
<%
    Jurnal jurnal = new Jurnal();
    Akun akun = new Akun();
    Pembelian pembelian = new Pembelian();
    //--Koneksi database--
    Connection koneksi = null;
    Statement stmt = null;

    ResultSet rs = null;
    ResultSet no = null;
    ResultSet qrypembelian = null;

    Class.forName("com.mysql.jdbc.Driver");
    koneksi = DriverManager.getConnection("jdbc:mysql://localhost:3306/warung_pasta", "root", "");
    stmt = koneksi.createStatement();
%>
<style>
    table {
        border-collapse: separate;
        background-color: #ff9900;
        border-color: #c40b00;
        width: auto;
        font-family: cambria, Helvetica, sans-serif;
        color: white;
    }
    th,td {
        text-align: left;
        padding: 5px;
    }
    h1 {
        border-style: inset;
        border-collapse: separate;
        background-color: #c40b00;
        width: 600px;
        height: 50px;
        border-color: #c40b00;
        font-family: 'cambria', sans-serif;
        color: white;
        letter-spacing: 6px;
        font-size: 25px;
        margin-bottom: 10px;
        margin-top: 10px;
    }
    b {
        font-family: 'cambria', sans-serif;
        color: #000066;
        text-decoration:  aquamarine;
        font-size: 20px;
    }
    a {
        color: white;
        text-decoration: none;
    }
    a:hover {
        color: #000066;
    }
    th {background-color: #white; color: #black;}
</style>
<title>Data Jurnal Umum</title>
<br>
<h1>Jurnal Umum Warung Pasta:</h1>
<form action="jurnalServlet" method="POST">
    <table border="17">
        <tr style="background-color: white; color: black;">
            <td> No Referensi</td>
            <td><% try {
                    rs = stmt.executeQuery("Select max(right(no_referensi,8)) as no FROM jurnal");
                    while (rs.next()) {
                        if (rs.first() == false) {
                            out.println("<input type='hidden' name='no_referensi' value='JU00000001'/>");
                            out.println("<input type='text' value='JU00000001' readonly='readonly'/>");
                        } else {
                            rs.last();
                            int autono = rs.getInt(1) + 1;
                            String nomor = String.valueOf(autono);
                            int noLong = nomor.length();

                            for (int a = 1; a < 9 - noLong; a++) {
                                nomor = "0" + nomor;
                            }
                            String nomer = "JU" + nomor;
                            out.println("<input type='hidden' name='no_referensi' value='" + nomer + "'/>");
                            out.println("<input type='text' value='" + nomer + "' readonly='readonly'/>");
                        }
                    }
                } catch (Exception e) {
                    out.println(e);
                }
                %>
            </td>
        </tr>
        <tr>
            <td> Tanggal Transaksi</td>
            <td><input type="date" name="tgl_trans" /></td>
        </tr>
        <tr style="background-color: white; color: black;">
            <td> Kode Pembelian</td>
            <td>
                <select name="kode_pembelian">
                    <%
                        qrypembelian = stmt.executeQuery("SELECT kode_pembelian "
                                + "FROM pembelian ");
                        while (qrypembelian.next()) {
                            pembelian.setKode_pembelian(qrypembelian.getString("kode_pembelian"));
                    %><option value="<%=pembelian.getKode_pembelian()%>"> <%=pembelian.getKode_pembelian()%></option>
                    <%  } %>

                </select>
            </td>
        </tr>
        <tr>
            <td> Keterangan</td>
            <td><textarea name="ket"></textarea></td>
        </tr>
        <tr>
            <td colspan="3">
                <table width="100%" border="3" cellpadding="0" cellspacing="0"> 
                    <tr class="head">
                        <th></th><th>Kode dan Nama Akun</th><th>Debet</th><th>Kredit</th>
                    </tr>
                    <tr class="isi">
                        <td align="center"><input type="checkbox" name="pilih[]" value="${param.pilih}"></td>
                        <td><select name="no_akunkredit" id="akunkredit">
                                <option>Kode Akun | Nama Akun</option>
                                <%
                                    Statement kode1 = koneksi.createStatement();
                                    no = kode1.executeQuery("SELECT kode_akun, nama_akun from master_akun");
                                    while (no.next()) {
                                        akun.setKode_akun(no.getString("kode_akun"));
                                        akun.setNama_akun(no.getString("nama_akun"));
                                %>
                                <option value="<%=akun.getKode_akun()%>"><%=akun.getKode_akun()%> <%=akun.getNama_akun()%></option>
                                <% } %>
                            </select>
                        </td>
                        <td><input name="debet" id="debet1" type="text" onchange="Hitung()" value="0"></td>
                        <td><input name="kredit" id="kredit1" type="text" onchange="Hitung()" value="0"></td>
                    </tr>
                    <tr class="isi">
                        <td align="center"><input type="checkbox" name="pilih[]" value="${param.pilih}"></td>
                        <td><select name="no_akunkredit" id="akunkredit">
                                <option>Kode Akun | Nama Akun</option>
                                <%
                                    Statement kode2 = koneksi.createStatement();
                                    no = kode1.executeQuery("SELECT kode_akun, nama_akun from master_akun");
                                    while (no.next()) {
                                        akun.setKode_akun(no.getString("kode_akun"));
                                        akun.setNama_akun(no.getString("nama_akun"));
                                %>
                                <option value="<%=akun.getKode_akun()%>"><%=akun.getKode_akun()%> <%=akun.getNama_akun()%></option>
                                <% } %>
                            </select>
                        </td>
                        <td><input name="debet" id="debet2" type="text" onchange="Hitung()" value="0"></td>
                        <td><input name="kredit" id="kredit2" type="text" onchange="Hitung()" value="0"></td>
                    </tr>
                    <tr class="isi">
                        <td align="center"><input type="checkbox" name="pilih[]" value="${param.pilih}"></td>
                        <td><select name="no_akunkredit" id="akunkredit">
                                <option>Kode Akun | Nama Akun</option>
                                <%
                                    Statement kode3 = koneksi.createStatement();
                                    no = kode1.executeQuery("SELECT kode_akun, nama_akun from master_akun");
                                    while (no.next()) {
                                        akun.setKode_akun(no.getString("kode_akun"));
                                        akun.setNama_akun(no.getString("nama_akun"));
                                %>
                                <option value="<%=akun.getKode_akun()%>"><%=akun.getKode_akun()%> <%=akun.getNama_akun()%></option>
                                <% } %>

                            </select>
                        </td>
                        <td><input name="debet" id="debet3" type="text" onchange="Hitung()" value="0"></td>
                        <td><input name="kredit" id="kredit3" type="text" onchange="Hitung()" value="0"></td>
                    </tr>
                    <tr class="isi">
                        <td align="center"><input type="checkbox" name="pilih[]" value="${param.pilih}"></td>
                        <td><select name="no_akunkredit" id="akunkredit">
                                <option>Kode Akun | Nama Akun</option>
                                <%
                                    Statement kode4 = koneksi.createStatement();
                                    no = kode1.executeQuery("SELECT kode_akun, nama_akun from master_akun");
                                    while (no.next()) {
                                        akun.setKode_akun(no.getString("kode_akun"));
                                        akun.setNama_akun(no.getString("nama_akun"));
                                %>
                                <option value="<%=akun.getKode_akun()%>"><%=akun.getKode_akun()%> <%=akun.getNama_akun()%></option>
                                <% }%>
                            </select>
                        </td>
                        <td><input name="debet" id="debet4" type="text" onchange="Hitung()" value="0"></td>
                        <td><input name="kredit" id="kredit4" type="text" onchange="Hitung()" value="0"></td>
                    </tr>
                    <tr class="head">
                        <td colspan="2" align="center">Total</td>
                        <td>
                            <input type="text" id="TtlDebet" onchange="Hitung()" readonly="readonly"></td>
                        <td><input type="text" id="TtlKredit" onchange="Hitung()" readonly="readonly"></td>
                    </tr>
                    <tr class="head">
                        <td colspan="2" align="center">Balance</td>
               
                        <td><input type="text" name="balance" id="Balance" onchange="Hitung()" readonly="readonly"></td>
                    </tr>
                    <tr class="isi">
                        <td colspan="4" align="center">
                            <input type="submit" value="Simpan" name="aksi"  class="button"/>
                            <input class="button" type="reset" value="Batal" name="batal"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
<br>
<h1>Data Jurnal Umum Warung Pasta:</h1>
<table border="5">
    <tr class="head">
        <th>No.Referensi</th>
        <th>Tanggal Transaksi</th>
        <th>Kode Pembelian</th>
        <th>Keterangan</th>
        <th>Kode Akun</th>
        <th>Debet</th>
        <th>Kredit</th>

    </tr><%
        rs = stmt.executeQuery("SELECT jurnal.no_referensi, jurnal.tgl_trans, jurnal.kode_pembelian, jurnal.keterangan, jurnal_detail.kode_akun, jurnal_detail.debet, jurnal_detail.kredit "
                + "FROM jurnal "
                + "INNER JOIN jurnal_detail "
                + "ON jurnal.no_referensi=jurnal_detail.no_referensi");
        rs.beforeFirst();
        while (rs.next()) {
            out.println("<tr class=isi>"
                    + "<td>" + rs.getString(1) + "</td>"
                    + "<td>" + rs.getString(2) + "</td>"
                    + "<td>" + rs.getString(3) + "</td>"
                    + "<td>" + rs.getString(4) + "</td>"
                    + "<td>" + rs.getString(5) + "</td>"
                    + "<td>" + rs.getString(6) + "</td>"
                    + "<td>" + rs.getString(7) + "</td>"
                    + "</tr>");
        }
    %>
</table>
<script type="text/javascript">
    function Hitung() {
        kre1 = document.getElementById("kredit1").value;
        kre2 = document.getElementById("kredit2").value;
        kre3 = document.getElementById("kredit3").value;
        kre4 = document.getElementById("kredit4").value;

        TotKre = parseInt(kre1) + parseInt(kre2) + parseInt(kre3) + parseInt(kre4);
        document.getElementById("TtlKredit").value = parseInt(TotKre);

        deb1 = document.getElementById("debet1").value;
        deb2 = document.getElementById("debet2").value;
        deb3 = document.getElementById("debet3").value;
        deb4 = document.getElementById("debet4").value;

        TotDeb = parseInt(deb1) + parseInt(deb2) + parseInt(deb3) + parseInt(deb4);
        document.getElementById("TtlDebet").value = parseInt(TotKre);

        Total = parseInt(TotDeb) - parseInt(TotKre);
        document.getElementById("Balance").value = parseInt(Total);
    }
</script>