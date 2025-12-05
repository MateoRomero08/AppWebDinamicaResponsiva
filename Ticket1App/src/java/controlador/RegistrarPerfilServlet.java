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

@WebServlet("/RegistrarPerfilServlet")
public class RegistrarPerfilServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String perfil = request.getParameter("perfil");

        Conexion conexion = new Conexion();
        Connection con = conexion.getConnection();
        PreparedStatement ps = null;

        try {
            String sql = "INSERT INTO perfiles (perfil) VALUES (?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, perfil);

            int filas = ps.executeUpdate();
            if (filas > 0) {
                response.sendRedirect("registrarPerfiles.jsp?msg=Perfil registrado correctamente");
            } else {
                response.sendRedirect("registrarPerfiles.jsp?msg=Error al registrar el perfil");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("registrarPerfiles.jsp?msg=Error en la base de datos");
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
