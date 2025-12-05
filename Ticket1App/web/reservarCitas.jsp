<%@ page import="java.sql.*,modelo.Conexion" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Solo validar que haya sesión activa
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
  <title>Reservar Cita</title>
  <style>
    body { margin: 0; padding: 20px; font-family: Arial, sans-serif; background: #fff; }
    h2 { color: #e4002b; margin-bottom: 20px; text-align: center; }
    form {
      max-width: 400px;
      margin: 0 auto;
      background: #fafafa;
      padding: 20px;
      border: 2px solid #e4002b;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }
    label { display: block; margin-top: 10px; font-weight: bold; }
    select, input {
      width: 100%;
      padding: 8px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-sizing: border-box;
    }
    button {
      background: #e4002b;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      margin-top: 15px;
      cursor: pointer;
      width: 100%;
    }
    button:hover { background: #b3001d; }
    .mensaje {
      margin-top: 15px;
      padding: 10px;
      border-radius: 5px;
      text-align: center;
      font-weight: bold;
    }
    .exito { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
    .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
  </style>
</head>
<body>
  <h2>Reservar una Cita</h2>

  <form action="ReservarCitaServlet" method="post">
    <input type="hidden" name="idusu" value="<%= idusu %>">

    <label>Servicio Médico:</label>
    <select name="idservicio" required>
      <option value="">Seleccione un servicio</option>
      <%
        try {
            Conexion cn = new Conexion();
            Connection con = cn.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT idservicio, nombre_servicio FROM servicios");
            while (rs.next()) {
      %>
        <option value="<%= rs.getInt("idservicio") %>"><%= rs.getString("nombre_servicio") %></option>
      <%
            }
            rs.close();
            st.close();
            con.close();
        } catch (Exception e) {
            out.print("<div class='mensaje error'>Error cargando servicios: " + e.getMessage() + "</div>");
        }
      %>
    </select>

    <label>Fecha:</label>
    <input type="date" name="fecha" required min="<%= java.time.LocalDate.now() %>">

    <label>Hora:</label>
    <input type="time" name="hora" required>

    <button type="submit">Reservar</button>

    <%-- Mensaje visual si viene desde el servlet --%>
    <%
      String mensaje = (String) request.getAttribute("mensaje");
      if (mensaje != null) {
          boolean exito = mensaje.contains("✅") || mensaje.contains("correctamente");
    %>
      <div class="mensaje <%= exito ? "exito" : "error" %>"><%= mensaje %></div>
    <% } %>
  </form>
</body>
</html>
