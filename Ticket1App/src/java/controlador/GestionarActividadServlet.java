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

@WebServlet("/GestionarActividadServlet")
public class GestionarActividadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id_perfil = request.getParameter("id_perfil");
        String id_actividad = request.getParameter("id_actividad");

        Conexion conexion = new Conexion();
        Connection con = conexion.getConnection();
        PreparedStatement ps = null;

        try {
            String sql = "INSERT INTO gesActividad (id_perfil, id_actividad) VALUES (?, ?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id_perfil));
            ps.setInt(2, Integer.parseInt(id_actividad));

            int filas = ps.executeUpdate();
            if (filas > 0) {
                response.sendRedirect("gestionarActividad.jsp?msg=Permiso asignado correctamente");
            } else {
                response.sendRedirect("gestionarActividad.jsp?msg=Error al asignar el permiso");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("gestionarActividad.jsp?msg=Error en la base de datos");
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
