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
import model.User; //mengakses parameter 
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.WebServlet;

/**
 *
 * @author michael
 */
@WebServlet(name = "userServlet", urlPatterns = {"/userServlet"})
public class userServlet extends HttpServlet {

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

        User user = new User();  //--Inisialisasi Object—

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
                user.setId_user(request.getParameter("id_user"));
                user.setNama(request.getParameter("nama"));
                user.setPass(request.getParameter("pass"));
                user.setHak_akses(request.getParameter("hak_akses"));
                switch (aksi) {

                    case "Simpan":

                        if (user.getId_user().equals("") || user.getNama().equals("") || user.getPass().equals("") || user.getHak_akses().equals("") ){
                            out.println("<script>alert('Gagal... masih ada data yang belum terisi, Silahkan Ulangi!!!')"
                                    + "</script><meta http-equiv='refresh' content=1;beranda1.jsp?hal=new-user'/>");
                        } else {
                            pstmt = koneksi.prepareStatement("INSERT INTO user "
                                    + " VALUES(?, ?, ?, ?)");
                            pstmt.setString(1, user.getId_user());
                            pstmt.setString(2, user.getNama());
                            pstmt.setString(3, user.getPass());
                            pstmt.setString(4, user.getHak_akses());

                            result = pstmt.executeUpdate();
                            if (result > 0) {
                                out.println("<script> "
                                        + "alert('Data telah ditambahkan');"
                                        + "document.location='beranda1.jsp?hal=tampil-user';"
                                        + " </script>");
                            }
                        }
                        break;
                    case "Update":

                        pstmt = koneksi.prepareStatement("UPDATE user SET "
                                + "nama = ?, "
                                + "pass = ?, "
                                + "hak_akses = ? "
                                + "WHERE id_user = ? ");
                        pstmt.setString(1, user.getNama());
                        pstmt.setString(2, user.getPass());
                        pstmt.setString(3, user.getHak_akses());
                        pstmt.setString(4, user.getId_user());

                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data telah di Update');"
                                    + "document.location='beranda1.jsp?hal=tampil-user';"
                                    + " </script>");
                        }
                        break;
                    case "Delete":
                        pstmt = koneksi.prepareStatement("DELETE FROM"
                                + " user WHERE id_user = ?");
                        pstmt.setString(1, user.getId_user());
                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data telah di Hapus');"
                                    + "document.location='beranda1.jsp?hal=tampil-user';"
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
            Logger.getLogger(userServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(userServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(userServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(userServlet.class.getName()).log(Level.SEVERE, null, ex);
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
