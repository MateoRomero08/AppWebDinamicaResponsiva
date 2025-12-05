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

@WebServlet("/ActualizarUsuarioServlet")
public class ActualizarUsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idusu = Integer.parseInt(request.getParameter("idusu"));
        String num_docu = request.getParameter("num_docu");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String email = request.getParameter("email");
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
        int id_perfil = Integer.parseInt(request.getParameter("id_perfil"));

        Conexion conexion = new Conexion();
        Connection con = conexion.getConnection();
        PreparedStatement ps = null;

        try {
            String sql = "UPDATE usuarios SET num_docu=?, nombre=?, apellido=?, email=?, usuario=?, clave=?, id_perfil=? WHERE idusu=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, num_docu);
            ps.setString(2, nombre);
            ps.setString(3, apellido);
            ps.setString(4, email);
            ps.setString(5, usuario);
            ps.setString(6, clave);
            ps.setInt(7, id_perfil);
            ps.setInt(8, idusu);

            int filas = ps.executeUpdate();
            if (filas > 0) {
                response.sendRedirect("listarUsuarios.jsp?msg=Usuario actualizado correctamente");
            } else {
                response.sendRedirect("listarUsuarios.jsp?msg=No se pudo actualizar el usuario");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("listarUsuarios.jsp?msg=Error al actualizar");
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
