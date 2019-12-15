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
import model.Supplier; //mengakses parameter 
import model.Barang;
import model.Pembelian;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.WebServlet;

/**
 *
 * @author michael
 */
@WebServlet(name = "pembelianServlet", urlPatterns = {"/pembelianServlet"})
public class pembelianServlet extends HttpServlet {

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

        Pembelian pembelian = new Pembelian();  //--Inisialisasi Object—

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
                pembelian.setKode_pembelian(request.getParameter("kode_pembelian"));
                pembelian.setTanggal(request.getParameter("tgl"));
                pembelian.setKode_barang(request.getParameter("kode_barang"));
                pembelian.setKode_supplier(request.getParameter("kode_supplier"));
                pembelian.setSatuan(request.getParameter("satuan"));
                pembelian.setHarga_beli(request.getParameter("harga_beli"));
                pembelian.setQty(request.getParameter("qty"));
                pembelian.setSubtotal(request.getParameter("subtotal"));
                switch (aksi) {

                    case "Insert":

                        if (pembelian.getKode_pembelian().equals("") || pembelian.getTanggal().equals("") || pembelian.getKode_barang().equals("") || pembelian.getKode_supplier().equals("") || pembelian.getSatuan().equals("") || pembelian.getHarga_beli().equals("") || pembelian.getQty().equals("") || pembelian.getSubtotal().equals("")){
                            out.println("<script>alert('Gagal... masih ada data yang belum terisi, Silahkan Ulangi!!!')"
                                    + "</script><meta http-equiv='refresh' content='1;index.jsp?hal=pembelian'/>");
                        } else {
                            pstmt = koneksi.prepareStatement("INSERT INTO pembelian "
                                    + " VALUES(?, ?, ?, ?, ?, ?, ?, ?)");
                            pstmt.setString(1, pembelian.getKode_pembelian());
                            pstmt.setString(2, pembelian.getTanggal());
                            pstmt.setString(3, pembelian.getKode_barang());
                            pstmt.setString(4, pembelian.getKode_supplier());
                            pstmt.setString(5, pembelian.getSatuan());
                            pstmt.setString(6, pembelian.getHarga_beli());
                            pstmt.setString(7, pembelian.getQty());
                            pstmt.setString(8, pembelian.getSubtotal());

                            result = pstmt.executeUpdate();
                            if (result > 0) {
                                out.println("<script> "
                                        + "alert('Data telah ditambahkan');"
                                        + "document.location='index.jsp?hal=pembelian';"
                                        + " </script>");
                            }
                        }
                        break;
                    case "Delete":
                        pstmt = koneksi.prepareStatement("DELETE FROM"
                                + " pembelian WHERE kode_pembelian = ?");
                        pstmt.setString(1,pembelian.getKode_pembelian());
                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data telah di Hapus');"
                                    + "document.location='index.jsp?hal=pembelian';"
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
            Logger.getLogger(pembelianServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(pembelianServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(pembelianServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(pembelianServlet.class.getName()).log(Level.SEVERE, null, ex);
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
