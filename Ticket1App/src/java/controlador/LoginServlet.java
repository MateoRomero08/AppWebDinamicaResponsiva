
package controlador;

import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import modelo.Conexion;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");

        try {
            Conexion cn = new Conexion();
            Connection con = cn.getConnection();

            String sql = "SELECT * FROM usuarios WHERE usuario=? AND clave=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, usuario);
            ps.setString(2, clave);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Credenciales correctas
                HttpSession sesion = request.getSession();
                sesion.setAttribute("idusu", rs.getInt("idusu"));
                sesion.setAttribute("nombre", rs.getString("nombre"));
                sesion.setAttribute("id_perfil", rs.getInt("id_perfil"));

                // Redirigir al dashboard
                response.sendRedirect("dashboard.jsp");
            } else {
                // Credenciales incorrectas
                request.setAttribute("error", "Usuario o clave incorrecta");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (ServletException | IOException | SQLException e) {
            response.sendRedirect("login.jsp");
        }
    }
}