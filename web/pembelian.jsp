<%-- ingat tulisan {datasource} memiliki hub dengan 
     <sql:setDataSource var="dataSource" di index.jsp --%>
<sql:query var="qryuser" dataSource="${dataSource}">
    <%-- perubahan muai dari where ...--%>
    SELECT * FROM pembelian WHERE kode_pembelian 
    LIKE '%${param.cari}%' 
    OR tgl
    LIKE '%${param.cari}%'
</sql:query>

<%@page import="java.sql.*, model.Supplier, model.Barang, model.Pembelian"%>

<%
    Supplier supplier = new Supplier();
    Barang barang = new Barang();
    Pembelian pembelian = new Pembelian();
    //--koneksi database--
    Connection koneksi = null;
    Statement stmt = null;
    ResultSet rs = null;
    Class.forName("com.mysql.jdbc.Driver");
    koneksi = DriverManager.getConnection("jdbc:mysql://localhost/warung_pasta", "root", "");
    stmt = koneksi.createStatement();
    rs = stmt.executeQuery("SELECT * FROM pembelian"
            + " WHERE kode_pembelian");
%>
<h1>[ From Pembelian ]</h1>
<form action="pembelian1Servlet" method="post">
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
            font-size: 12px;
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
            width: 430px;
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
                var url = "getbarang.jsp"
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
    <table border="17">
        <tr style="background-color: #ff9900; color: white;">
            <td>Kode Pembelian</td>
            <td>
                <%
                    try {
                        ResultSet nopm = null;
                        Statement perintah = koneksi.createStatement();
                        nopm = perintah.executeQuery("Select max(right(kode_pembelian,8)) as no FROM pembelian");
                        while (nopm.next()) {
                            if (nopm.first() == false) {
                                out.println("<input type='hidden' name='kode_pembelian' value='Pembelian001' id='t1'/>");
                                out.println("<input type=''text' disabled='disabled' value='P00000001'/>");
                            } else {
                                nopm.last();
                                int autonopm = nopm.getInt(1) + 1;
                                String nomorpm = String.valueOf(autonopm);
                                int noLong = nomorpm.length();

                                for (int a = 1; a < 9 - noLong; a++) {
                                    nomorpm = "0" + nomorpm;
                                }
                                String nomerpm = "PM" + nomorpm;
                                out.println("<input type='hidden' name='kode_pembelian' value='" + nomerpm + "'/>");
                                out.println("<input type='text' disabled='disabled' value='" + nomerpm + "'/>");
                            }
                        }
                    } catch (Exception e) {
                        out.println(e);
                    }
                %>
            </td>
        </tr>
        <tr>
            <td>Tanggal Beli</td> 
            <td><input type="date" name="tgl"/></td>
        </tr>
        <tr style="background-color: #ff9900; color: white;">
            <td>Kode Bahan Baku</td>
            <td>
                <select name="kode_barang" onchange="showEmp(this.value);">
                    <option value="">Pilih Kode Bahan Baku</option>
                    <%
                        rs = stmt.executeQuery("SELECT * FROM barang ");
                        while (rs.next()) {
                            barang.setKode_barang(rs.getString("kode_barang"));
                            barang.setNama_barang(rs.getString("nama_barang"));
                    %>
                    <option value="<%=barang.getKode_barang()%>"><%=barang.getKode_barang()%> || <%=barang.getNama_barang()%></option>
                    <%  }%>
                </select>

            </td>
        </tr>
        <tr>
            <td>Kode Supplier</td>
            <td>
                <select name="kode_supplier">
                    <option value="">Pilih Kode Supplier</option>
                    <%
                        rs = stmt.executeQuery("SELECT * FROM supplier");
                        while (rs.next()) {
                            supplier.setKode_supplier(rs.getString("kode_supplier"));
                            supplier.setNama_supplier(rs.getString("nama_supplier"));

                    %>
                    <option value="<%=supplier.getKode_supplier()%>"><%=supplier.getKode_supplier()%> || <%=supplier.getNama_supplier()%></option>
                    <%  }%> 
                </select>
            </td>
        <tr style="background-color: #ff9900; color: white;">
            <td>Satuan</td>
            <td><input type="text" name="satuan" size="25"/></td>
        </tr>
        <tr style="background-color: #ff9900; color: white;">
            <td>Harga Beli</td>
            <td id="emp_id" value="" ><input type="text" name="harga_beli" id="ename" value="" onchange="beli()" readonly/></td>
        </tr>
        <tr style="background-color: #ff9900; color: white;">
            <td>Quantity</td>
            <td><input type="text" name="qty" size="25" id="qty" onchange="jumlah()"/></td>
        </tr>
        <tr>
            <td>Subtotal</td>
            <td><input type="text" name="subtotal" size="25" id="subtotal" readonly/></td>
        </tr>  
        <tr>
            <td colspan="3" align="center"><input type="submit" name="aksi" value="Simpan" class="button"/></td>
        </tr>
    </table>
</form>

<script type="text/javascript">
    function jumlah() {
        var jumlah = document.getElementById("qty").value;
        var beli = document.getElementById("ename").value;
        var subtotal = jumlah * beli;
        document.getElementById("subtotal").value = subtotal;
    }
</script>
<form action="#" method="post"><br>
    Cari Data Pembelian : <input type="text" name="cari" value="${param.cari}"/> <%-- modif value --%>
    <input type="submit" value=" Cari " class="button"/><br>
</form>
<table border="5"  cellpadding="5" cellspacing="5">
    <tr class="head">
        <td>Kode Pembelian</td>
        <td>Tanggal</td>
        <td>Kode Barang</td>
        <td>Kode Supplier</td>
        <td>Satuan</td>
        <td>Harga Beli</td>
        <td>Quantity</td>
        <td>Subtotal</td>

    </tr>
    <c:forEach var="rowakun" items="${qryuser.rowsByIndex}">
        <tr class="isi">
            <td align='center'>${rowakun[0]}</td>
            <td align='center'>${rowakun[1]}</td>
            <td align='center'>${rowakun[2]}</td>
            <td align='center'>${rowakun[3]}</td>
            <td align='center'>${rowakun[4]}</td>
            <td align='center'>${rowakun[5]}</td>
            <td align='center'>${rowakun[6]}</td>
            <td align='center'>${rowakun[7]}</td>
           
        </tr>
    </c:forEach>
</table>
</body>
</html>
