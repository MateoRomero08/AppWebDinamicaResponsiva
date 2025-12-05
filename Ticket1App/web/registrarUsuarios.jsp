<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, modelo.Conexion" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Registrar Usuario</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #fff;
    margin: 0; padding: 20px;
  }
  h1 {
    color: #e4002b;
    text-align: center;
  }
  form {
    max-width: 500px;
    margin: auto;
    padding: 20px;
    border: 2px solid #e4002b;
    border-radius: 10px;
    background: #fdfdfd;
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
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 5px;
    cursor: pointer;
    width: 100%;
  }
  button:hover {
    background-color: #b3001d;
  }
  .msg {
    text-align: center;
    margin-top: 15px;
    font-weight: bold;
    padding: 10px;
    border-radius: 5px;
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

  <h1>Registrar Nuevo Usuario</h1>

  <form action="RegistrarUsuarioServlet" method="post">
    <label for="num_docu">Número de documento:</label>
    <input type="text" id="num_docu" name="num_docu" required>

    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" required>

    <label for="apellido">Apellido:</label>
    <input type="text" id="apellido" name="apellido" required>

    <label for="email">Correo electrónico:</label>
    <input type="email" id="email" name="email" required>

    <label for="usuario">Usuario:</label>
    <input type="text" id="usuario" name="usuario" required>

    <label for="clave">Contraseña:</label>
    <input type="password" id="clave" name="clave" maxlength="8" required>

    <label for="id_perfil">Perfil:</label>
    <select id="id_perfil" name="id_perfil" required>
      <option value="">Seleccione un perfil...</option>
      <%
        Conexion conexion = new Conexion();
        Connection con = conexion.getConnection();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM perfiles ORDER BY id_perfil ASC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
      %>
            <option value="<%= rs.getInt("id_perfil") %>">
              <%= rs.getString("perfil") %>
            </option>
      <%
            }
            con.close();
        } catch (Exception e) {
            out.println("<option disabled>Error al cargar perfiles</option>");
        }
      %>
    </select>

    <button type="submit">Registrar</button>
  </form>

  <% 
    String msg = request.getParameter("msg");
    if (msg != null) {
        String clase = (msg.toLowerCase().contains("error") || msg.toLowerCase().contains("no")) ? "err" : "ok";
  %>
      <div class="msg <%= clase %>"><%= msg %></div>
  <% } %>

</body>
</html>
