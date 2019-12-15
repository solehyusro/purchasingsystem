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
import model.Akun; //mengakses parameter 
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.WebServlet;

/**
 *
 * @author michael
 */
@WebServlet(name = "akunServlet", urlPatterns = {"/akunServlet"})
public class akunServlet extends HttpServlet {

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

        Akun akun = new Akun();  //--Inisialisasi Object—

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
                akun.setKode_akun(request.getParameter("kode_akun"));
                akun.setNama_akun(request.getParameter("nama_akun"));
                akun.setJenis_akun(request.getParameter("jenis_akun"));
                akun.setSaldo_normal(request.getParameter("saldo_normal"));
                switch (aksi) {

                    case "Simpan":

                        if (akun.getKode_akun().equals("") || akun.getNama_akun().equals("") || akun.getJenis_akun().equals("") || akun.getSaldo_normal().equals("") ){
                            out.println("<script>alert('Gagal... masih ada data yang belum terisi, Silahkan Ulangi!!!')"
                                    + "</script><meta http-equiv='refresh' content=1;beranda1.jsp?hal=new-akun'/>");
                        } else {
                            pstmt = koneksi.prepareStatement("INSERT INTO master_akun "
                                    + " VALUES(?, ?, ?, ?)");
                            pstmt.setString(1, akun.getKode_akun());
                            pstmt.setString(2, akun.getNama_akun());
                            pstmt.setString(3, akun.getJenis_akun());
                            pstmt.setString(4, akun.getSaldo_normal());

                            result = pstmt.executeUpdate();
                            if (result > 0) {
                                out.println("<script> "
                                        + "alert('Data telah ditambahkan');"
                                        + "document.location='beranda1.jsp?hal=tampil-akun';"
                                        + " </script>");
                            }
                        }
                        break;
                    case "Update":

                        pstmt = koneksi.prepareStatement("UPDATE master_akun SET "
                                + "nama_akun = ?, "
                                + "jenis_akun = ?, "
                                + "saldo_normal = ? "
                                + "WHERE kode_akun = ? ");
                        pstmt.setString(1, akun.getNama_akun());
                        pstmt.setString(2, akun.getJenis_akun());
                        pstmt.setString(3, akun.getSaldo_normal());
                        pstmt.setString(4, akun.getKode_akun());

                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data telah di Update');"
                                    + "document.location='beranda1.jsp?hal=tampil-akun';"
                                    + " </script>");
                        }
                        break;
                    case "Delete":
                        pstmt = koneksi.prepareStatement("DELETE FROM"
                                + " master_akun WHERE kode_akun = ?");
                        pstmt.setString(1, akun.getKode_akun());
                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data telah di Hapus');"
                                    + "document.location='beranda1.jsp?hal=tampil-akun';"
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
            Logger.getLogger(akunServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(akunServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(akunServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(akunServlet.class.getName()).log(Level.SEVERE, null, ex);
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
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */