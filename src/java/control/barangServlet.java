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
import model.Barang; //mengakses parameter 
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.WebServlet;

/**
 *
 * @author michael
 */
@WebServlet(name = "barangServlet", urlPatterns = {"/barangServlet"})
public class barangServlet extends HttpServlet {

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

        Barang barang = new Barang();  //--Inisialisasi Object—

        String URL = "jdbc:mysql://localhost:3306/warung_pasta";
        String USERNAME = "root";
        String PASSWORD = "";

        Connection koneksi = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            Class.forName("com.mysql.jdbc.Driver");
            koneksi = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            String aksi = request.getParameter("aksi");
            if (aksi != null) {
                barang.setKode_barang(request.getParameter("kode_barang"));
                barang.setNama_barang(request.getParameter("nama_barang"));
                barang.setHarga_beli(request.getParameter("harga_beli"));
                barang.setStok_barang(request.getParameter("stok_barang"));
                switch (aksi) {

                    case "Simpan":

                        if (barang.getKode_barang().equals("") || barang.getNama_barang().equals("") || barang.getHarga_beli().equals("") || barang.getStok_barang().equals("")){
                            out.println("<script>alert('Gagal... masih ada data yang belum terisi, Silahkan Ulangi!!!')"
                                    + "</script><meta http-equiv='refresh' content='1;beranda2.jsp?hal=new-barang'/>");
                        } else {
                            pstmt = koneksi.prepareStatement("INSERT INTO barang "
                                    + " VALUES(?, ?, ?, ?)");
                            pstmt.setString(1, barang.getKode_barang());
                            pstmt.setString(2, barang.getNama_barang());
                            pstmt.setString(3, barang.getHarga_beli());
                            pstmt.setString(4, barang.getStok_barang());

                            result = pstmt.executeUpdate();
                            if (result > 0) {
                                out.println("<script> "
                                        + "alert('Data telah ditambahkan');"
                                        + "document.location='beranda2.jsp?hal=barang';"
                                        + " </script>");
                            }
                        }
                        break;
                    case "Update":

                        pstmt = koneksi.prepareStatement("UPDATE barang SET "
                                + "nama_barang = ?, "
                                + "harga_beli = ?, "
                                + "stok_barang = ? "
                                + "WHERE kode_barang = ? ");
                        pstmt.setString(1, barang.getNama_barang());
                        pstmt.setString(2, barang.getHarga_beli());
                        pstmt.setString(3, barang.getStok_barang());
                        pstmt.setString(4, barang.getKode_barang());

                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data telah di Update');"
                                    + "document.location='beranda2.jsp?hal=barang';"
                                    + " </script>");
                        }
                        break;
                    case "Delete":
                        pstmt = koneksi.prepareStatement("DELETE FROM"
                                + " barang WHERE kode_barang = ?");
                        pstmt.setString(1, barang.getKode_barang());
                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data telah di Hapus');"
                                    + "document.location='beranda2.jsp?hal=barang';"
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
            Logger.getLogger(barangServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(barangServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(barangServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(barangServlet.class.getName()).log(Level.SEVERE, null, ex);
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
