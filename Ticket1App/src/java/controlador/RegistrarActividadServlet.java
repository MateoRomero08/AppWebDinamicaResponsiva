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

@WebServlet("/RegistrarActividadServlet")
public class RegistrarActividadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Leer ambos nombres por compatibilidad (si el JSP usa "nom_actividad" o "nombre")
        String nomActividad = request.getParameter("nom_actividad");
        if (nomActividad == null || nomActividad.trim().isEmpty()) {
            nomActividad = request.getParameter("nombre");
        }
        String enlace = request.getParameter("enlace");

        // Validación básica
        if (nomActividad == null || nomActividad.trim().isEmpty() || enlace == null || enlace.trim().isEmpty()) {
            response.sendRedirect("registrarActividad.jsp?msg=Rellena todos los campos");
            return;
        }

        Conexion conexion = new Conexion();
        Connection con = conexion.getConnection();
        PreparedStatement ps = null;

        try {
            String sql = "INSERT INTO actividades (nom_actividad, enlace) VALUES (?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, nomActividad.trim());
            ps.setString(2, enlace.trim());

            int filas = ps.executeUpdate();
            if (filas > 0) {
                response.sendRedirect("registrarActividad.jsp?msg=Actividad registrada correctamente");
            } else {
                response.sendRedirect("registrarActividad.jsp?msg=No se registró la actividad");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Enviar mensaje corto al JSP (no volcar el SQL completo en la UI)
            response.sendRedirect("registrarActividad.jsp?msg=Error en la BD");
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
