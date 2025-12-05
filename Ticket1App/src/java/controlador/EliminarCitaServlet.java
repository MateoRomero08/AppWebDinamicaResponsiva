package controlador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import modelo.Conexion;

@WebServlet("/EliminarCitaServlet")
public class EliminarCitaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idcita = Integer.parseInt(request.getParameter("idcita"));
        Connection con = null;
        PreparedStatement ps = null;

        try {
            Conexion cn = new Conexion();
            con = cn.getConnection();

            String sql = "DELETE FROM citas WHERE idcita = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, idcita);

            int result = ps.executeUpdate();

            if (result > 0) {
                request.setAttribute("mensaje", "✅ Cita cancelada correctamente.");
            } else {
                request.setAttribute("mensaje", "⚠️ No se encontró la cita o ya fue eliminada.");
            }

        } catch (SQLException e) {
            request.setAttribute("mensaje", "❌ Error SQL: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) { e.printStackTrace(); }
        }

        // Volver a cargar gestionarCitas.jsp con el mensaje
        RequestDispatcher rd = request.getRequestDispatcher("gestionarCitas.jsp");
        rd.forward(request, response);
    }
}
