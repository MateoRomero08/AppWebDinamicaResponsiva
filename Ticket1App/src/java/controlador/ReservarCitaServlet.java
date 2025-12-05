package controlador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import modelo.Conexion;

@WebServlet("/ReservarCitaServlet")
public class ReservarCitaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Obtener parámetros del formulario
        int idusu = Integer.parseInt(request.getParameter("idusu"));
        int idservicio = Integer.parseInt(request.getParameter("idservicio"));
        String fecha = request.getParameter("fecha");
        String hora = request.getParameter("hora");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Conexion cn = new Conexion();
            con = cn.getConnection();

            // 🔎 1️⃣ Verificar si ya existe una cita en la misma fecha y hora para el mismo usuario
            String checkSql = "SELECT COUNT(*) FROM citas WHERE idusu = ? AND fecha_cita = ? AND hora_cita = ?";
            ps = con.prepareStatement(checkSql);
            ps.setInt(1, idusu);
            ps.setString(2, fecha);
            ps.setString(3, hora);
            rs = ps.executeQuery();

            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }

            // Cerrar objetos usados antes de reutilizar ps
            rs.close();
            ps.close();

            if (count > 0) {
                // ⚠️ Ya tiene cita en ese horario
                request.setAttribute("mensaje", "⚠️ Ya tienes una cita registrada en esa fecha y hora.");
            } else {
                // ✅ Registrar nueva cita
                String insertSql = "INSERT INTO citas (idusu, idservicio, fecha_cita, hora_cita) VALUES (?, ?, ?, ?)";
                ps = con.prepareStatement(insertSql);
                ps.setInt(1, idusu);
                ps.setInt(2, idservicio);
                ps.setString(3, fecha);
                ps.setString(4, hora);

                int result = ps.executeUpdate();

                if (result > 0) {
                    request.setAttribute("mensaje", "✅ Cita reservada correctamente.");
                } else {
                    request.setAttribute("mensaje", "❌ No se pudo reservar la cita. Intenta nuevamente.");
                }
            }

        } catch (SQLIntegrityConstraintViolationException e) {
            // 🚫 Captura si se viola la restricción UNIQUE en la base de datos
            request.setAttribute("mensaje", "⚠️ Ya existe una cita registrada en ese horario. Verifica e intenta con otro.");
            e.printStackTrace();

        } catch (SQLException e) {
            request.setAttribute("mensaje", "⚠️ Error SQL: " + e.getMessage());
            e.printStackTrace();

        } finally {
            // 🔒 Cerrar recursos correctamente
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // 🔁 Redirigir al JSP con mensaje
        RequestDispatcher rd = request.getRequestDispatcher("reservarCitas.jsp");
        rd.forward(request, response);
    }
}

