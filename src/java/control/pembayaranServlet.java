/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Pembayaran; //mengakses parameter 
import model.Pembelian;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.WebServlet;

/**
 *
 * @author michael
 */
@WebServlet(name = "pembayaranServlet", urlPatterns = {"/pembayaranServlet"})
public class pembayaranServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        Pembayaran pembayaran = new Pembayaran();  //--Inisialisasi Object—

        String URL = "jdbc:mysql://localhost:3306/warung_pasta";
        String USERNAME = "root";
        String PASSWORD = "";

        Connection koneksi = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt2 = null;
        int result = 0;
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            Class.forName("com.mysql.jdbc.Driver");
            koneksi = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            String aksi = request.getParameter("aksi");
            if (aksi != null) {
                pembayaran.setKode_pembayaran(request.getParameter("kode_pembayaran"));
                pembayaran.setKode_pembelian(request.getParameter("kode_pembelian"));
                pembayaran.setTanggal(request.getParameter("tanggal"));
                pembayaran.setJumlah_bayar(request.getParameter("jumlah_bayar"));
                switch (aksi) {

                    case "Simpan":

                        if (pembayaran.getKode_pembayaran().equals("") || pembayaran.getKode_pembelian().equals("") || pembayaran.getTanggal().equals("") || pembayaran.getJumlah_bayar().equals("")){
                            out.println("<script>alert('Gagal... masih ada data yang belum terisi, Silahkan Ulangi!!!')"
                                    + "</script><meta http-equiv='refresh' content='1;beranda1.jsp?hal=pembayaran'/>");
                        } else {
                            pstmt = koneksi.prepareStatement("INSERT INTO pembayaran "
                                    + " VALUES(?, ?, ?, ?)");
                            pstmt.setString(1, pembayaran.getKode_pembayaran());
                            pstmt.setString(2, pembayaran.getKode_pembelian());
                            pstmt.setString(3, pembayaran.getTanggal());
                          
                            pstmt.setString(4, pembayaran.getJumlah_bayar());
                            result = pstmt.executeUpdate();
                            
                            pstmt2 = koneksi.prepareStatement("UPDATE pembelian SET keterangan = 'tampil' WHERE kode_pembelian=?");
                            pstmt2.setString(1, pembayaran.getKode_pembelian());

                            result = pstmt2.executeUpdate();
                            if (result > 0) {
                                out.println("<script> "
                                        + "alert('Data telah ditambahkan');"
                                        + "document.location='beranda1.jsp?hal=pembayaran';"
                                        + " </script>");
                            }
                        }
                        break;
                    case "Delete":
                        pstmt = koneksi.prepareStatement("DELETE FROM"
                                + " pembayaran WHERE kode_pembayaran = ?");
                        pstmt.setString(1,pembayaran.getKode_pembayaran());
                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data telah di Hapus');"
                                    + "document.location='beranda1.jsp?hal=pembayaran';"
                                    + " </script>");
                        }
                        break;
                    default:
                        break;
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(pembayaranServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(pembayaranServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(pembayaranServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(pembayaranServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
