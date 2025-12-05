<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Registrar Actividad</title>
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
  form {
    background: #fafafa;
    border: 2px solid #e4002b;
    border-radius: 12px;
    padding: 20px;
    max-width: 400px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
  }
  label {
    display: block;
    margin-top: 10px;
    font-weight: bold;
  }
  input {
    width: 100%;
    padding: 8px;
    margin-top: 5px;
    border: 1px solid #ccc;
    border-radius: 6px;
  }
  button {
    background: #e4002b;
    color: #fff;
    border: none;
    padding: 10px 15px;
    border-radius: 6px;
    margin-top: 15px;
    width: 100%;
    font-size: 15px;
  }
  button:hover {
    background: #b3001d;
    cursor: pointer;
  }

  /* Estilos para los mensajes */
  .msg {
    text-align: center;
    font-weight: bold;
    margin-top: 20px;
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

  <h2>Registrar Nueva Actividad</h2>

  <form action="RegistrarActividadServlet" method="post">
    <label>Nombre de la Actividad:</label>
    <input type="text" name="nom_actividad" required>

    <label>Enlace (.jsp asociado):</label>
    <input type="text" name="enlace" required placeholder="Ejemplo: nuevaActividad.jsp">

    <button type="submit">Registrar Actividad</button>
  </form>

  <%-- Mostrar mensaje de confirmación bonito --%>
  <%
    String msg = request.getParameter("msg");
    if (msg != null) {
        String clase = (msg.toLowerCase().contains("error") || msg.toLowerCase().contains("no")) ? "err" : "ok";
  %>
    <div class="msg <%= clase %>"><%= msg %></div>
  <% } %>

</body>
</html>
