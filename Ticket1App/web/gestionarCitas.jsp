<%@ page import="java.sql.*,modelo.Conexion" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Validar sesión activa
    if (session.getAttribute("idusu") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int idusu = (int) session.getAttribute("idusu");
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Gestionar Citas</title>

<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
  body { font-family: Arial, sans-serif; margin: 20px; background-color: #fff; }
  h2 { color: #e4002b; text-align: center; }
  table {
    width: 90%;
    margin: 20px auto;
    border-collapse: collapse;
    box-shadow: 0 3px 6px rgba(0,0,0,0.1);
  }
  th, td {
    padding: 10px;
    border: 1px solid #ccc;
    text-align: center;
  }
  th {
    background-color: #e4002b;
    color: white;
  }
  tr:nth-child(even) { background-color: #f9f9f9; }
  button {
    background: #e4002b;
    color: #fff;
    border: none;
    padding: 6px 12px;
    border-radius: 4px;
    cursor: pointer;
  }
  button:hover { background: #b3001d; }
  .mensaje {
    text-align: center;
    font-weight: bold;
    margin-top: 15px;
  }
  .exito { color: green; }
  .error { color: red; }
</style>
</head>
<body>
  <h2>Mis Citas Reservadas</h2>

  <%
    String mensaje = (String) request.getAttribute("mensaje");
    if (mensaje != null) {
        boolean exito = mensaje.contains("✅") || mensaje.contains("correctamente");
  %>
        <div class="mensaje <%= exito ? "exito" : "error" %>"><%= mensaje %></div>
  <% } %>

  <table>
    <tr>
      <th>#</th>
      <th>Servicio</th>
      <th>Fecha</th>
      <th>Hora</th>
      <th>Fecha Registro</th>
      <th>Acción</th>
    </tr>
    <%
      try {
          Conexion cn = new Conexion();
          Connection con = cn.getConnection();
          String sql = "SELECT c.idcita, s.nombre_servicio, c.fecha_cita, c.hora_cita, c.fecha_registro " +
                       "FROM citas c INNER JOIN servicios s ON c.idservicio = s.idservicio " +
                       "WHERE c.idusu = ? ORDER BY c.fecha_cita ASC";
          PreparedStatement ps = con.prepareStatement(sql);
          ps.setInt(1, idusu);
          ResultSet rs = ps.executeQuery();
          int i = 0;
          while (rs.next()) {
              i++;
    %>
    <tr>
      <td><%= i %></td>
      <td><%= rs.getString("nombre_servicio") %></td>
      <td><%= rs.getString("fecha_cita") %></td>
      <td><%= rs.getString("hora_cita") %></td>
      <td><%= rs.getString("fecha_registro") %></td>
      <td>
        <form action="EliminarCitaServlet" method="post" class="formEliminar" style="margin:0;">
          <input type="hidden" name="idcita" value="<%= rs.getInt("idcita") %>">
          <button type="submit">Cancelar</button>
        </form>
      </td>
    </tr>
    <%
          }
          if (i == 0) {
    %>
      <tr><td colspan="6">No tienes citas registradas.</td></tr>
    <%
          }
          rs.close();
          ps.close();
          con.close();
      } catch (Exception e) {
          out.print("<tr><td colspan='6'>⚠️ Error al cargar las citas: " + e.getMessage() + "</td></tr>");
      }
    %>
  </table>

<script>
  // Interceptar todos los formularios de eliminación
  document.querySelectorAll(".formEliminar").forEach(form => {
    form.addEventListener("submit", function(e) {
      e.preventDefault();
      Swal.fire({
        title: "¿Cancelar esta cita?",
        text: "Esta acción no se puede deshacer.",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#e4002b",
        cancelButtonColor: "#777",
        confirmButtonText: "Sí, cancelar",
        cancelButtonText: "No, volver"
      }).then((result) => {
        if (result.isConfirmed) {
          form.submit();
        }
      });
    });
  });
</script>
</body>
</html>
