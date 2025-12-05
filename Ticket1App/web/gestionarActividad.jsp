<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, jakarta.servlet.http.*, modelo.Conexion" %>

<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_perfil") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String mensaje = "";
    Conexion cn = new Conexion();
    Connection con = cn.getConnection();

    // ✅ Eliminar actividad
    if (request.getParameter("eliminar") != null) {
        int idEliminar = Integer.parseInt(request.getParameter("eliminar"));
        PreparedStatement psDel = con.prepareStatement("DELETE FROM actividades WHERE id_actividad=?");
        psDel.setInt(1, idEliminar);
        psDel.executeUpdate();
        psDel.close();
        mensaje = "✅ Actividad eliminada correctamente.";
    }

    // ✅ Editar actividad
    if (request.getParameter("editar") != null) {
        int idEditar = Integer.parseInt(request.getParameter("id_actividad"));
        String nombre = request.getParameter("nombre");
        String enlace = request.getParameter("enlace");

        PreparedStatement psUpd = con.prepareStatement(
            "UPDATE actividades SET nom_actividad=?, enlace=? WHERE id_actividad=?"
        );
        psUpd.setString(1, nombre);
        psUpd.setString(2, enlace);
        psUpd.setInt(3, idEditar);
        psUpd.executeUpdate();
        psUpd.close();
        mensaje = "✅ Actividad actualizada correctamente.";
    }

    // ✅ Asignar actividad a perfil
    if (request.getParameter("asignar") != null) {
        int idPerfil = Integer.parseInt(request.getParameter("id_perfil"));
        int idActividad = Integer.parseInt(request.getParameter("id_actividad_sel"));

        PreparedStatement psIns = con.prepareStatement(
            "INSERT INTO gesActividad (id_perfil, id_actividad) VALUES (?, ?)"
        );
        psIns.setInt(1, idPerfil);
        psIns.setInt(2, idActividad);
        psIns.executeUpdate();
        psIns.close();
        mensaje = "✅ Actividad asignada correctamente al perfil.";
    }

    // ✅ Consultar actividades y perfiles
    PreparedStatement psAct = con.prepareStatement("SELECT * FROM actividades ORDER BY id_actividad ASC");
    ResultSet rsAct = psAct.executeQuery();

    PreparedStatement psPerf = con.prepareStatement("SELECT * FROM perfiles ORDER BY id_perfil ASC");
    ResultSet rsPerf = psPerf.executeQuery();
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Gestionar Actividades</title>
<style>
  body { font-family: Arial, sans-serif; padding: 20px; background: #fff; }
  h2 { color: #e4002b; border-bottom: 2px solid #e4002b; padding-bottom: 5px; }
  .msg { text-align: center; font-weight: bold; margin-top: 20px; padding: 10px;
         border-radius: 6px; width: fit-content; margin-inline: auto; }
  .ok { background: #eaf8ea; color: #0b6b0b; border: 1px solid #6cc66c; }
  .err { background: #fdeaea; color: #c62828; border: 1px solid #f39b9b; }

  table { width: 100%; border-collapse: collapse; margin-top: 15px; }
  th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
  th { background-color: #e4002b; color: white; }
  tr:nth-child(even) { background-color: #f9f9f9; }

  input[type="text"], select {
    width: 90%;
    padding: 6px;
    border-radius: 6px;
    border: 1px solid #ccc;
  }

  .btn {
    padding: 6px 10px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    color: white;
  }
  .edit { background-color: #007bff; }
  .delete { background-color: #dc3545; }
  .edit:hover { background-color: #0056b3; }
  .delete:hover { background-color: #a71d2a; }

  form.inline { display: inline; }

  .asignar {
    margin-top: 30px;
    background: #fafafa;
    padding: 20px;
    border-radius: 12px;
    max-width: 480px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    border: 2px solid #e4002b;
  }

  .asignar h3 { color: #e4002b; margin-bottom: 10px; }
  .asignar button {
    background-color: #e4002b;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 6px;
    margin-top: 10px;
    width: 100%;
    font-size: 15px;
  }
  .asignar button:hover { background-color: #b3001d; cursor: pointer; }
</style>
</head>
<body>

  <h2>Gestionar Actividades</h2>

  <% if (!mensaje.isEmpty()) { %>
    <div class="msg <%= mensaje.contains("error") ? "err" : "ok" %>"><%= mensaje %></div>
  <% } %>

  <table>
    <tr>
      <th>ID</th>
      <th>Nombre</th>
      <th>Enlace</th>
      <th>Acciones</th>
    </tr>
    <% while (rsAct.next()) { %>
    <tr>
      <form method="post" class="inline">
        <td><%= rsAct.getInt("id_actividad") %></td>
        <td><input type="text" name="nombre" value="<%= rsAct.getString("nom_actividad") %>"></td>
        <td><input type="text" name="enlace" value="<%= rsAct.getString("enlace") %>"></td>
        <td>
          <input type="hidden" name="id_actividad" value="<%= rsAct.getInt("id_actividad") %>">
          <button class="btn edit" name="editar">Actualizar️</button>
          <button class="btn delete" name="eliminar" value="<%= rsAct.getInt("id_actividad") %>">Eliminar️</button>
        </td>
      </form>
    </tr>
    <% } rsAct.close(); psAct.close(); %>
  </table>

  <div class="asignar">
    <h3>🎯 Asignar Actividad a Perfil</h3>
    <form method="post">
      <label>Seleccionar Perfil:</label>
      <select name="id_perfil" required>
        <option value="">Seleccione...</option>
        <% while (rsPerf.next()) { %>
          <option value="<%= rsPerf.getInt("id_perfil") %>"><%= rsPerf.getString("perfil") %></option>
        <% } rsPerf.close(); psPerf.close(); %>
      </select>

      <br><br>
      <label>Seleccionar Actividad:</label>
      <%
        PreparedStatement psA = con.prepareStatement("SELECT * FROM actividades");
        ResultSet rsA = psA.executeQuery();
      %>
      <select name="id_actividad_sel" required>
        <option value="">Seleccione...</option>
        <% while (rsA.next()) { %>
          <option value="<%= rsA.getInt("id_actividad") %>"><%= rsA.getString("nom_actividad") %></option>
        <% } rsA.close(); psA.close(); con.close(); %>
      </select>

      <button type="submit" name="asignar">➕ Asignar Actividad</button>
    </form>
  </div>

</body>
</html>
