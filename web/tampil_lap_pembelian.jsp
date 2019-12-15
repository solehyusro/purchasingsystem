<%-- 
    Document   : tampil_rekap_ju_perbulan
    Created on : Oct 15, 2018, 9:20:55 PM
    Author     : Asus
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
        <style type="text/css">

            h1 {
                font-family: 'cambria', sans-serif;
                color: #ff9900;
                letter-spacing: 2px;
                font-size: 24px;
            }
            a {
                color: white;
            }
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

        </style>
  

<%-- 
    Document   : tampil_rekap_ju_perbulan
    Created on : Oct 15, 2018, 9:20:55 PM
    Author     : Asus
--%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;
              charset=UTF-8">
        <title>Laporan Pembelian</title>
        <style>

            h1 {
                font-family: 'cambria', sans-serif;
                color: #ff9900;
                letter-spacing: 2px;
                font-size: 24px;

            }
        </style>
    </head>
    <body>
        
        <h1 align="center">[ Laporan Pembelian ]</h1><br>
       
        <form action="cetaklap_pembelian.jsp" >
            <table align="center" border="5"> 
         
                 <tr style="background-color: #ff9900; color: yellow;">
                     <td>Masukkan Bulan :</td>
                     <td> <select name="bulan" id="bulan">
                <option value="1">Januari</option>
                <option value="2">Februari</option>
                <option value="3">Maret</option>
                <option value="4">April</option>
                <option value="5">Mei</option>
                <option value="6">Juni</option>
                <option value="7">Juli</option>
                <option value="8">Agustus</option>
                <option value="9">September</option>
                <option value="10">Oktober</option>
                <option value="11">November</option>
                <option value="12">Desember</option>
                         </select></td></tr>
                 <tr style="background-color: #ff9900; color: yellow;">
                     <td> Masukkan Tahun :</td>
                     <td> <select name="tahun" id="tahun">
                <option value="2010">2010</option>
                <option value="2011">2011</option>
                <option value="2012">2012</option>
                <option value="2013">2013</option>
                <option value="2014">2014</option>
                <option value="2015">2015</option>
                <option value="2016">2016</option>
                <option value="2017">2017</option>
                <option value="2018">2018</option>
                <option value="2019">2019</option>
                <option value="2020">2020</option>
            </select>
                         <br></td>   </tr>
                 <tr style="background-color: #ff9900; color: yellow;">
                     <td colspan="2"align="center"><input type="submit" value="Cetak"></td>
                     
                 </tr>
           
            </table>
        </form>


     
   
    </body>

</html>
