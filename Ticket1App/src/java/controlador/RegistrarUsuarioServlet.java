package controladores;

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

@WebServlet("/RegistrarUsuarioServlet")
public class RegistrarUsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String num_docu = request.getParameter("num_docu");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String email = request.getParameter("email");
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
        String id_perfil = request.getParameter("id_perfil");

        Conexion conexion = new Conexion();
        Connection con = conexion.getConnection();
        PreparedStatement ps = null;

        try {
            String sql = "INSERT INTO usuarios (num_docu, nombre, apellido, email, usuario, clave, id_perfil) VALUES (?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, num_docu);
            ps.setString(2, nombre);
            ps.setString(3, apellido);
            ps.setString(4, email);
            ps.setString(5, usuario);
            ps.setString(6, clave);
            ps.setInt(7, Integer.parseInt(id_perfil));

            int filas = ps.executeUpdate();
            if (filas > 0) {
                response.sendRedirect("registrarUsuarios.jsp?msg=Usuario registrado correctamente");
            } else {
                response.sendRedirect("registrarUsuarios.jsp?msg=Error al registrar el usuario");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("registrarUsuarios.jsp?msg=Error en la base de datos");
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
