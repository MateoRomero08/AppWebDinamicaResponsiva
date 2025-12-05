<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, modelo.Conexion" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Gestionar Perfiles</title>
<style>
  body {
    font-family: Arial, sans-serif;
    padding: 20px;
    background: #fff;
  }
  h2 {
    color: #e4002b;
    margin-bottom: 20px;
  }
  table {
    width: 100%;
    max-width: 600px;
    border-collapse: collapse;
    background: #fafafa;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
  }
  th, td {
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #ddd;
  }
  th {
    background: #e4002b;
    color: #fff;
  }
  tr:hover {
    background: #f3f3f3;
  }
  .btn {
    padding: 7px 12px;
    border: none;
    border-radius: 5px;
    color: #fff;
    cursor: pointer;
    text-decoration: none;
  }
  .btn-delete {
    background: #d32f2f;
  }
  .btn-delete:hover {
    background: #b71c1c;
  }
  .msg {
    text-align: center;
    font-weight: bold;
    margin-bottom: 15px;
    padding: 10px;
    border-radius: 6px;
  }
  .ok {
    background: #eaf8ea;
    color: #0b6b0b;
    border: 1px solid #6cc66c;
  }
  .err {
    background: #fdeaea;
    color: #c62828;
    border: 1px solid #f39b9b;
  }
</style>
</head>
<body>

  <h2>Gestionar Perfiles</h2>

  <%-- Mostrar mensajes de confirmación o error --%>
  <%
    String msg = request.getParameter("msg");
    if (msg != null) {
        String clase = (msg.toLowerCase().contains("error") || msg.toLowerCase().contains("no")) ? "err" : "ok";
  %>
    <div class="msg <%= clase %>"><%= msg %></div>
  <% } %>

  <table>
    <thead>
      <tr>
        <th>ID</th>
        <th>Nombre del Perfil</th>
        <th>Acción</th>
      </tr>
    </thead>
    <tbody>
      <%
        Conexion conexion = new Conexion();
        Connection con = conexion.getConnection();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM perfiles");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
      %>
        <tr>
          <td><%= rs.getInt("id_perfil") %></td>
          <td><%= rs.getString("perfil") %></td>
          <td>
            <% if (rs.getInt("id_perfil") != 1) { %> <%-- Evitar eliminar el Admin --%>
              <a href="EliminarPerfilServlet?id_perfil=<%= rs.getInt("id_perfil") %>"
                 class="btn btn-delete"
                 onclick="return confirm('¿Seguro que deseas eliminar este perfil?');">
                 Eliminar
              </a>
            <% } else { %>
              <span style="color: gray;">No editable</span>
            <% } %>
          </td>
        </tr>
      <%
            }
            con.close();
        } catch (Exception e) {
            out.println("<tr><td colspan='3' style='color:red;'>Error al cargar perfiles.</td></tr>");
        }
      %>
    </tbody>
  </table>

</body>
</html>
