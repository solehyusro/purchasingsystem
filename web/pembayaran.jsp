<%-- ingat tulisan {datasource} memiliki hub dengan 
     <sql:setDataSource var="dataSource" di index.jsp --%>
<sql:query var="qryuser" dataSource="${dataSource}">
    <%-- perubahan muai dari where ...--%>
    SELECT * FROM pembayaran WHERE kode_pembayaran
    LIKE '%${param.cari}%' 
    OR tanggal
    LIKE '%${param.cari}%'
</sql:query>
<%@page import= "java.sql.*, model.Pembelian, model.Pembayaran" %>
<%
    Pembelian pembelian = new Pembelian();
    Pembayaran pembayaran = new Pembayaran();
//--koneksi database--
    Connection koneksi = null;
    Statement stmt = null;

    ResultSet rs = null;
    ResultSet qrypembelian = null;
    ResultSet ttl = null;

    Class.forName("com.mysql.jdbc.Driver");
    koneksi = DriverManager.getConnection("jdbc:mysql://localhost/warung_pasta", "root", "");
    stmt = koneksi.createStatement();
    rs = stmt.executeQuery("SELECT * FROM pembayaran"
            + " WHERE kode_pembayaran");
%>
<script type="text/javascript">
    function showEmp(emp_value)
    {
        if (document.getElementById("emp_id").value != "-1")
        {
            xmlHttp = GetXmlHttpObject()
            if (xmlHttp == null)
            {
                alert("Browser does not support HTTP Request")
                return
            }
            var url = "getotal.jsp"
            url = url + "?emp_id=" + emp_value

            xmlHttp.onreadystatechange = stateChanged
            xmlHttp.open("GET", url, true)
            xmlHttp.send(null)
        } else
        {
            alert("-");
        }
    }

    function stateChanged()
    {
        document.getElementById("ename").value = "";
        document.getElementById("emp_id").value = "";
        if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete")
        {

            var showdata = xmlHttp.responseText;
            var strar = showdata.split(":");

            if (strar.length == 1)
            {
                document.getElementById("emp_id").focus();
                alert("-");
                document.getElementById("ename").value = " ";
                document.getElementById("emp_id").value = " ";
            } else if (strar.length > 1)
            {
                document.getElementById("ename").value = strar[1];
            }

        }
    }

    function GetXmlHttpObject()
    {
        var xmlHttp = null;
        try
        {
            xmlHttp = new XMLHttpRequest();
        } catch (e)
        {
            try
            {
                xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (e)
            {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
        }
        return xmlHttp;
    }
</script>
<h1>[ Form Pembayaran ]</h1>
<style type="text/css">
    table {
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
    a {
        color: black;
        font: "Times New Roman",sans-serif;
        font-size: 20px;
    }
    h1 {
        border-style: inset;
        border-collapse: separate;
        background-color: #c40b00;
        width: 460px;
        height: 50px;
        border-color: #c40b00;
        font-family: 'cambria', sans-serif;
        color: white;
        letter-spacing: 6px;
        font-size: 35px;
        margin-bottom: 10px;
        margin-top: 10px;
    }
    input {
        border-color: white;
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
        background-color: white;
        color: #ff9900;
        font-family: 'Roboto', sans-serif;
        margin-right: 10px;
    }
    input.button:hover {
        background-color: #ff9900;
        color: #ffffff;
    }
    select {
        border-color: white;
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
    tr:nth-child(even){background-color: #ffffff; color: black;}
</style> 
<form action="pembayaranServlet" method="post">
    <table border="17">
        <tr style="background-color: #ff9900; color: white;">
            <td>Kode Pembayaran</td>
            <td>
                <%
                    try {

                        rs = stmt.executeQuery("Select max(right(kode_pembayaran,8)) as no FROM pembayaran");
                        while (rs.next()) {
                            if (rs.first() == false) {
                                out.println("<input type='hidden' name='id_byr' value='PB00000001' id='t1'/>");
                                out.println("<input type=''text' value='PB00000001' readonly ='readonly'/>");
                            } else {
                                rs.last();
                                int autono = rs.getInt(1) + 1;
                                String nomor = String.valueOf(autono);
                                int noLong = nomor.length();

                                for (int a = 1; a < 9 - noLong; a++) {
                                    nomor = "0" + nomor;
                                }
                                String nomer = "PB" + nomor;
                                out.println("<input type='hidden' name='kode_pembayaran' value='" + nomer + "'/>");
                                out.println("<input type='text' value='" + nomer + "' readonly = 'readonly'/>");
                            }
                        }
                    } catch (Exception e) {
                        out.println(e);
                    }
                %>
            </td>
        </tr>
        <tr>
            <td>Kode Pembelian</td>
            <td>
                <select name="kode_pembelian" onchange="showEmp(this.value);">
                    <option value="">Pilih Kode Pembelian</option>
                    <%
                        rs = stmt.executeQuery("SELECT kode_pembelian "
                                + "FROM pembelian where keterangan='tidak tampil'");
                        while (rs.next()) {
                            pembelian.setKode_pembelian(rs.getString("kode_pembelian"));

                    %>
                    <option value="<%=pembelian.getKode_pembelian()%>"><%=pembelian.getKode_pembelian()%></option>
                    <%  }%>
                </select>
            </td>
        </tr>
        <tr style="background-color: #ff9900; color: white;">
            <td>Tanggal Bayar</td> 
            <td><input type="date" name="tanggal"/></td>
        </tr>
        <tr style="background-color: #ff9900; color: white;">
        <input  type="hidden" name="emp_id" id="emp_id" value="">
        <td>Jumlah Bayar</td>
        <td><input type="text" name="jumlah_bayar" id="ename" readonly/></td>
        </tr>
        <tr>
            <td colspan="3" align="center"><input type="submit" name="aksi" value="Simpan" class="button"/></td>
        </tr>
    </table>
</form>
<form action="#" method="post"><br>
    Cari Data Pembayaran : <input type="text" name="cari" value="${param.cari}"/> <%-- modif value --%>
    <input type="submit" value=" Cari " class="button"/><br>
</form>
<table border="5"  cellpadding="5" cellspacing="5">
    <tr class="head">
        <td>Kode Pembayaran</td>
        <td>Kode Pembelian</td>
        <td>Tanggal</td>
        <td>Jumlah Bayar</td>
    </tr>
  <c:forEach var="rowakun" items="${qryuser.rowsByIndex}">
        <tr class="isi">
            <td align='center'>${rowakun[0]}</td>
            <td align='center'>${rowakun[1]}</td>
            <td align='center'>${rowakun[2]}</td>
            <td align='center'>${rowakun[3]}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
