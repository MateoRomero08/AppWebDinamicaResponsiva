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

@WebServlet("/EliminarUsuarioServlet")
public class EliminarUsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idusu = request.getParameter("id");

        if (idusu == null || idusu.isEmpty()) {
            response.sendRedirect("listarUsuarios.jsp?msg=ID no válido");
            return;
        }

        Conexion conexion = new Conexion();
        Connection con = conexion.getConnection();
        PreparedStatement ps = null;

        try {
            String sql = "DELETE FROM usuarios WHERE idusu = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(idusu));

            int filas = ps.executeUpdate();
            if (filas > 0) {
                response.sendRedirect("listarUsuarios.jsp?msg=Usuario eliminado correctamente");
            } else {
                response.sendRedirect("listarUsuarios.jsp?msg=No se pudo eliminar el usuario");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("listarUsuarios.jsp?msg=Error en la base de datos");
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
