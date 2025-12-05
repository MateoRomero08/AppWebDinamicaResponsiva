<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Registrar Perfil</title>
<style>
  body { font-family: Arial, sans-serif; padding: 20px; background: #fff; }
  h2 { color: #e4002b; }
  form {
    background: #fafafa;
    border: 2px solid #e4002b;
    border-radius: 12px;
    padding: 20px;
    max-width: 400px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
  }
  label { display: block; margin-top: 10px; font-weight: bold; }
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
  button:hover { background: #b3001d; cursor: pointer; }

  .msg {
    text-align: center;
    font-weight: bold;
    margin-top: 20px;
    padding: 10px;
    border-radius: 6px;
  }
  .ok { background: #eaf8ea; color: #0b6b0b; border: 1px solid #6cc66c; }
  .err { background: #fdeaea; color: #c62828; border: 1px solid #f39b9b; }
</style>
</head>
<body>

  <h2>Registrar Nuevo Perfil</h2>

  <form action="RegistrarPerfilServlet" method="post">
    <label>Nombre del Perfil:</label>
    <input type="text" name="perfil" required>
    <button type="submit">Registrar Perfil</button>
  </form>

  <%-- Mostrar mensaje de éxito o error --%>
  <%
    String msg = request.getParameter("msg");
    if (msg != null) {
        String clase = (msg.toLowerCase().contains("error") || msg.toLowerCase().contains("no")) ? "err" : "ok";
  %>
    <div class="msg <%= clase %>"><%= msg %></div>
  <% } %>

</body>
</html>
