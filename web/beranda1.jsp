<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<sql:setDataSource var="dataSource"
                   driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/warung_pasta"
                   user="root" password="" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Purchasing</title>
        <link href="css/style.css" rel="stylesheet" type="text/css" media="screen"/>
    </head>
    <body>
        <div class="transbox">
            <div class="wrap">
                <div id="header">
                    <img src="gambar/warpas.png"/>

                </div>   


                <div id="menu">
                    <ul>    
                        <li><a href="beranda1.jsp?hal=home"><img src="gambar/homee.png"/></a></li>
                        <li><a href="index.html"><img src="gambar/Keluar.ico"/></a></li>
                    </ul>
                </div>

                <div id="wrapper">
                    <div id="content">
                        <div class="post">
                            <div class="entry">
                                <c:choose>

                                    <c:when test="${param.hal=='tampil-akun'}">
                                        <%@include file="tampil_akun.jsp" %>
                                    </c:when>
                                    <c:when test="${param.hal=='new-akun'}">
                                        <%@include file="add_akun.jsp" %>
                                    </c:when>
                                    <c:when test="${param.hal=='edit-akun'}">
                                        <%@include file="edit_akun.jsp" %>
                                    </c:when>
                                    <c:when test="${param.hal=='tampil-user'}">
                                        <%@include file="tampil_user.jsp" %>
                                    </c:when>
                                    <c:when test="${param.hal=='new-user'}">
                                        <%@include file="add_user.jsp" %>
                                    </c:when>
                                    <c:when test="${param.hal=='edit-user'}">
                                        <%@include file="edit_user.jsp" %>
                                    </c:when>
                                    <c:when test="${param.hal=='barang'}">
                                        <%@include file="tampil_barang.jsp" %>
                                    </c:when>
                                    <c:when test="${param.hal=='new-barang'}">
                                        <%@include file="add_barang.jsp" %>
                                    </c:when>
                                    <c:when test="${param.hal=='edit-barang'}">
                                        <%@include file="edit_barang.jsp" %>
                                    </c:when>
                                    <c:when test="${param.hal=='supplier'}">
                                        <%@include file="tampil_supplier.jsp" %>
                                    </c:when>
                                    <c:when test="${param.hal=='new-supplier'}">
                                        <%@include file="add_supplier.jsp" %>
                                    </c:when>
                                    <c:when test="${param.hal=='edit-supplier'}">
                                        <%@include file="edit_supplier.jsp" %>
                                    </c:when>
                                    <c:when test="${param.hal=='pembelian'}">
                                        <%@include file="pembelian.jsp" %>
                                    </c:when>
                                    <c:when test="${param.hal=='pembayaran'}">
                                        <%@include file="pembayaran.jsp" %>
                                    </c:when>
                                    <c:when test="${param.hal=='laporan-barang'}">
                                        <%@include file="tampil_lap_barang.jsp" %>
                                    </c:when>                                                                      
                                     <c:when test="${param.hal=='jurnal'}">
                                         <%@include file="jurnal.jsp" %>
                                    </c:when>



                                    <c:otherwise>
                                        <%@include file="home.jsp" %>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>


                    <div id="sidebar">
                        <div class="post">
                            <ul>        
                                <li>
                                    <h3 class="title">Data Master</h3>
                                    <ul>
                                        <li><a href="beranda1.jsp?hal=tampil-user">User</a></li>
                                        <li><a href="beranda1.jsp?hal=supplier">Supplier</a></li>
                                        <li><a href="beranda1.jsp?hal=tampil-akun">Akun</a></li>
                                    </ul>
                                </li>

                                <li>
                                    <br><h3 class="title">Transaksi</h3>
                                    <ul>
                                        <li><a href="beranda1.jsp?hal=pembelian">Pembelian</a></li>
                                        <li><a href="beranda1.jsp?hal=pembayaran">Pembayaran</a></li>
                                        <li><a href="beranda1.jsp?hal=jurnal">Jurnal Umum</a></li>
                                    </ul>
                                </li>
                                <li>
                                    <br><h3 class="title">Laporan</h3>
                                    <ul>
                                        <li><a href="beranda1.jsp?hal=laporan-barang">Laporan Data Bahan Baku</a></li>
                                        </ul>
                                </li>


                            </ul>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                </div>

                <div id="footer"><p>&copy; Design by Michael & Soleh Programmer Mahasiswa Komputerisasi Akuntansi 11.6A.04</p>
                    <p>Universitas Bina Sarana Informatika "UBSI Bekasi"</p>
                </div>
            </div>
        </div>
    </body>
</html>
