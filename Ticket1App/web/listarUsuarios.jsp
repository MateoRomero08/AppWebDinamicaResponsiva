<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, modelo.Conexion" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Listado de Usuarios</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #fff;
    margin: 0;
    padding: 20px;
  }
  h1 {
    color: #e4002b;
  }
  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
  }
  th, td {
    border: 1px solid #ccc;
    padding: 8px;
    text-align: left;
  }
  th {
    background-color: #e4002b;
    color: white;
  }
  tr:nth-child(even) {
    background-color: #f9f9f9;
  }
  a {
    color: #e4002b;
    text-decoration: none;
    font-weight: bold;
  }
  a:hover {
    text-decoration: underline;
  }
  .msg {
    text-align: center;
    font-weight: bold;
    margin-top: 10px;
  }
</style>
</head>
<body>

<h1>Usuarios Registrados</h1>

<%
  Conexion conexion = new Conexion();
  Connection con = conexion.getConnection();
  Statement st = null;
  ResultSet rs = null;

  try {
      st = con.createStatement();
      rs = st.executeQuery(
          "SELECT u.idusu, u.num_docu, u.nombre, u.apellido, u.email, u.usuario, p.perfil " +
          "FROM usuarios u INNER JOIN perfiles p ON u.id_perfil = p.id_perfil"
      );
%>
  <table>
    <tr>
      <th>ID</th>
      <th>Documento</th>
      <th>Nombre</th>
      <th>Apellido</th>
      <th>Correo</th>
      <th>Usuario</th>
      <th>Perfil</th>
      <th>Acciones</th>
    </tr>
<%
      while (rs.next()) {
%>
    <tr>
      <td><%= rs.getInt("idusu") %></td>
      <td><%= rs.getString("num_docu") %></td>
      <td><%= rs.getString("nombre") %></td>
      <td><%= rs.getString("apellido") %></td>
      <td><%= rs.getString("email") %></td>
      <td><%= rs.getString("usuario") %></td>
      <td><%= rs.getString("perfil") %></td>
      <td>
        <a href="editarUsuarios.jsp?id=<%= rs.getInt("idusu") %>">Editar</a> |
        <a href="EliminarUsuarioServlet?id=<%= rs.getInt("idusu") %>" onclick="return confirm('¿Seguro que deseas eliminar este usuario?')">Eliminar</a>
      </td>
    </tr>
<%
      }
  } catch (SQLException e) {
      out.println("<tr><td colspan='8'>Error al cargar usuarios.</td></tr>");
      e.printStackTrace();
  } finally {
      try {
          if (rs != null) rs.close();
          if (st != null) st.close();
          if (con != null) con.close();
      } catch (SQLException e) {
          e.printStackTrace();
      }
  }
%>
  </table>

  <% if (request.getParameter("msg") != null) { %>
    <div class="msg"><%= request.getParameter("msg") %></div>
  <% } %>

</body>
</html>
