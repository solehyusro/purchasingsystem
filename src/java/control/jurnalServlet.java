package control;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Jurnal;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "jurnalServlet", urlPatterns = {"/jurnalServlet"})
public class jurnalServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");

        Jurnal jurnal = new Jurnal();

        Connection koneksi = null;
        PreparedStatement pstmt = null;
        int result = 0;

        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            koneksi = DriverManager.getConnection("jdbc:mysql://localhost:3306/warung_pasta", "root", "");

            String[] pilih = request.getParameterValues("pilih[]");
            String[] no = request.getParameterValues("no_akunkredit");
            String[] debet = request.getParameterValues("debet");
            String[] kredit = request.getParameterValues("kredit");

            String bal = request.getParameter("balance");
            jurnal.setNoref(request.getParameter("no_referensi"));
            jurnal.setTgl(request.getParameter("tgl_trans"));
            jurnal.setKode_pembelian(request.getParameter("kode_pembelian"));
            jurnal.setKet(request.getParameter("ket"));

            String aksi = request.getParameter("aksi");
            if (aksi != null) {
                switch (aksi) {
                    case "Simpan":
                        if (jurnal.getNoref().equals("") || jurnal.getKode_pembelian().equals("") || jurnal.getTgl().equals("") || jurnal.getKet().equals("")){
                            out.println("<script>alert('Gagal... masih ada data yang belum terisi, Silahkan Ulangi!!!')"
                                    + "</script><meta http-equiv='refresh' content='1;beranda1.jsp?hal=jurnal'/>");
                            
                        }else{
                        
                            pstmt = koneksi.prepareStatement("INSERT INTO jurnal"
                                    + " VALUES(?, ?, ?, ?)");
                            pstmt.setString(1, jurnal.getNoref());
                            pstmt.setString(2, jurnal.getTgl());
                            pstmt.setString(3, jurnal.getKode_pembelian());
                            pstmt.setString(4, jurnal.getKet());
                            pstmt.executeUpdate();
                            out.println(pilih.length);
                            for (int j = 0; j < pilih.length; j++) {
                                pstmt = koneksi.prepareStatement("INSERT INTO jurnal_detail "
                                        + "VALUES ('" + jurnal.getNoref() + "','" + no[j] + "','" + debet[j] + "','" + kredit[j] + "')");
                                pstmt.executeUpdate();
                            }
                            out.println("<script>alert ('Data berhasil Disimpan')</script>"
                                    + "<meta http-equiv='refresh' content='1;beranda1.jsp?hal=jurnal'/>");
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
            Logger.getLogger(jurnalServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(jurnalServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(jurnalServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(jurnalServlet.class.getName()).log(Level.SEVERE, null, ex);
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
