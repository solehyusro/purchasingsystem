/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Akses;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author USER PC
 */
@WebServlet(name = "loginServlet", urlPatterns = {"/loginServlet"})
public class loginServlet extends HttpServlet {

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

        Akses akses = new Akses();
        Akses validasi = new Akses();

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

            akses.setId_user(request.getParameter("id_user"));
            akses.setPass(request.getParameter("pass"));

            Statement stmt = null;
            ResultSet rs = null;

            stmt =koneksi.createStatement();
            rs = stmt.executeQuery("SELECT * FROM user WHERE id_user = '" + akses.getId_user() + "' AND pass = '" + akses.getPass() + "'");
            
            if (rs.next()) {
                 validasi.setId_user(rs.getString("id_user"));  
                 validasi.setNama(rs.getString("nama")); 
                 validasi.setPass(rs.getString("pass"));
                 validasi.setHak_akses(rs.getString("hak_akses")); 
            }else{
                validasi.setHak_akses("tidak ada"); 
            }
            
            if (validasi.getHak_akses().equals("Purchasing") )  {
                out.println("<script> "
                        + "alert('Selamat Datang di Halaman "+validasi.getHak_akses()+"');"
                        + "document.location='beranda1.jsp';"
                        + " </script>");
            } else if (validasi.getHak_akses().equals("PIC") )  {
                out.println("<script> "
                        + "alert('Selamat Datang di Halaman "+validasi.getHak_akses()+"');"
                        + "document.location='beranda2.jsp';"
                        + " </script>");
            } else if (validasi.getHak_akses().equals("Manager") )  {
                out.println("<script> "
                        + "alert('Selamat Datang di Halaman "+validasi.getHak_akses()+"');"
                        + "document.location='beranda3.jsp';"
                        + " </script>");
                
            } else {
                out.println("<script> "
                        + "alert('ID atau Password Salah');"
                        + "document.location='index.html';"
                        + " </script>");
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
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
