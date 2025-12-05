package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import modelo.Conexion;

@WebServlet("/EliminarPerfilServlet")
public class EliminarPerfilServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id_perfil");

        Conexion conexion = new Conexion();
        Connection con = conexion.getConnection();
        PreparedStatement ps = null;

        try {
            String sql = "DELETE FROM perfiles WHERE id_perfil=?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));

            int filas = ps.executeUpdate();
            if (filas > 0) {
                response.sendRedirect("gestionarPerfil.jsp?msg=Perfil eliminado correctamente");
            } else {
                response.sendRedirect("gestionarPerfil.jsp?msg=No se pudo eliminar el perfil");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("gestionarPerfil.jsp?msg=Error al eliminar el perfil");
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
