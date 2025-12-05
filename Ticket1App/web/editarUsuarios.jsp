<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, modelo.Conexion" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Editar Usuario</title>
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
  form {
    max-width: 600px;
    margin: 0 auto;
    background: #f7f7f7;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
  }
  label {
    display: block;
    margin-top: 10px;
    font-weight: bold;
  }
  input, select {
    width: 100%;
    padding: 8px;
    margin-top: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
  }
  button {
    margin-top: 15px;
    background-color: #e4002b;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
  }
  button:hover {
    background-color: #b80023;
  }
  a {
    display: block;
    margin-top: 15px;
    text-align: center;
    color: #e4002b;
    text-decoration: none;
  }
</style>
</head>
<body>

<h1>Editar Usuario</h1>

<%
  String idusu = request.getParameter("id");
  if (idusu == null) {
      out.println("<p>ID de usuario no válido.</p>");
      return;
  }

  Conexion conexion = new Conexion();
  Connection con = conexion.getConnection();
  PreparedStatement ps = null;
  ResultSet rs = null;
  PreparedStatement psPerfiles = null;
  ResultSet rsPerfiles = null;

  try {
      String sql = "SELECT * FROM usuarios WHERE idusu = ?";
      ps = con.prepareStatement(sql);
      ps.setInt(1, Integer.parseInt(idusu));
      rs = ps.executeQuery();

      if (rs.next()) {
%>
  <form action="ActualizarUsuarioServlet" method="post">
    <input type="hidden" name="idusu" value="<%= rs.getInt("idusu") %>">

    <label>Número de documento:</label>
    <input type="text" name="num_docu" value="<%= rs.getString("num_docu") %>" required>

    <label>Nombre:</label>
    <input type="text" name="nombre" value="<%= rs.getString("nombre") %>" required>

    <label>Apellido:</label>
    <input type="text" name="apellido" value="<%= rs.getString("apellido") %>" required>

    <label>Correo electrónico:</label>
    <input type="email" name="email" value="<%= rs.getString("email") %>" required>

    <label>Usuario:</label>
    <input type="text" name="usuario" value="<%= rs.getString("usuario") %>" required>

    <label>Contraseña:</label>
    <input type="password" name="clave" value="<%= rs.getString("clave") %>" required>

    <label>Perfil:</label>
    <select name="id_perfil" required>
      <%
        psPerfiles = con.prepareStatement("SELECT id_perfil, perfil FROM perfiles");
        rsPerfiles = psPerfiles.executeQuery();
        int perfilActual = rs.getInt("id_perfil");
        while (rsPerfiles.next()) {
            int idPerfil = rsPerfiles.getInt("id_perfil");
            String nombrePerfil = rsPerfiles.getString("perfil");
            String selected = (idPerfil == perfilActual) ? "selected" : "";
      %>
          <option value="<%= idPerfil %>" <%= selected %>><%= nombrePerfil %></option>
      <%
        }
      %>
    </select>

    <button type="submit">Actualizar Usuario</button>
  </form>
  <a href="listarUsuarios.jsp">← Volver al listado</a>
<%
      } else {
          out.println("<p>No se encontró el usuario.</p>");
      }
  } catch (SQLException e) {
      e.printStackTrace();
      out.println("<p>Error al cargar los datos del usuario.</p>");
  } finally {
      try {
          if (rs != null) rs.close();
          if (ps != null) ps.close();
          if (psPerfiles != null) psPerfiles.close();
          if (rsPerfiles != null) rsPerfiles.close();
          if (con != null) con.close();
      } catch (SQLException e) {
          e.printStackTrace();
      }
  }
%>

</body>
</html>
