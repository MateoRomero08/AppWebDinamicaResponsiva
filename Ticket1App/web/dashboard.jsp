<%@page import="java.sql.*"%>
<%@page import="modelo.Conexion"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Validar sesión
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_perfil") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Datos del usuario logueado
    int idPerfil = (int) sesion.getAttribute("id_perfil");
    String nombre = (String) sesion.getAttribute("nombre");
    if (nombre == null) nombre = "Usuario";

    // Obtener nombre del perfil
    Conexion cn = new Conexion();
    Connection con = cn.getConnection();
    String perfil = "";
    try {
        PreparedStatement psPerfil = con.prepareStatement("SELECT perfil FROM perfiles WHERE id_perfil=?");
        psPerfil.setInt(1, idPerfil);
        ResultSet rsPerfil = psPerfil.executeQuery();
        if (rsPerfil.next()) {
            perfil = rsPerfil.getString("perfil");
        }
        rsPerfil.close();
        psPerfil.close();
    } catch (Exception e) {
        perfil = "Perfil desconocido";
    }

    // Consulta de actividades según perfil
    PreparedStatement ps = con.prepareStatement(
        "SELECT a.nom_actividad, a.enlace " +
        "FROM actividades a INNER JOIN gesActividad g ON a.id_actividad = g.id_actividad " +
        "WHERE g.id_perfil = ?"
    );
    ps.setInt(1, idPerfil);
    ResultSet rs = ps.executeQuery();

    // Imagen por defecto
    String fotoPerfil = "img/pic.jpg";
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<title>Dashboard - Sistema de Citas</title>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;600&display=swap" rel="stylesheet">
<style>
  body, html {
    margin: 0; padding: 0; height: 100vh; font-family: Arial, sans-serif;
    background-color: #fff;
  }
  #front2 {
    height: 60px;
    background: #e4002b;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 20px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  }
  #front2 .logo {
    font-weight: bold;
    font-size: 24px;
    color: white;
    font-family: 'Oswald', sans-serif;
  }
  #front2 .logout {
    cursor: pointer;
    color: white;
    text-decoration: underline;
  }
  #container {
    display: flex;
    height: calc(100vh - 60px);
  }
  #front1 {
    width: 220px;
    background: #fff;
    padding: 20px;
    box-sizing: border-box;
    overflow-y: auto;
    border-right: 1px solid #ccc;
  }
  #front1 h2 {
    margin-top: 0;
    color: #e4002b;
  }
  #front1 .profile {
    text-align: center;
    margin-bottom: 20px;
  }
  #front1 .profile img {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    margin-bottom: 10px;
  }
  #front1 .profile p {
    color: #e4002b;
    font-size: 18px;
  }
  #front1 .menu a {
    display: block;
    margin: 10px 0;
    cursor: pointer;
    color: #e4002b;
    text-decoration: none;
  }
  #front1 .menu a:hover {
    text-decoration: underline;
  }
  #front3 {
    flex-grow: 1;
    position: relative;
  }
  #front3 iframe {
    width: 100%;
    height: 100%;
    border: none;
  }
</style>
<script>
  function cerrarSesion() {
    window.location.href = 'LogoutServlet';
  }
</script>
</head>
<body>
  <div id="front2">
    <div class="logo">
      <img src="img/logoW.png" alt="Logo" style="height:45px; vertical-align: middle;">
      TICKET1
    </div>
    <div class="logout" onclick="cerrarSesion()">Cerrar sesión</div>
  </div>

  <div id="container">
    <div id="front1">
      <h2><%= perfil %></h2>
      <div class="profile">
        <img src="<%= fotoPerfil %>" alt="Foto de perfil" />
        <p><strong><%= nombre %></strong></p>
      </div>

      <div class="menu">
        <%
          while (rs.next()) {
              String nomAct = rs.getString("nom_actividad");
              String enlace = rs.getString("enlace");
        %>
            <a href="<%= enlace %>" target="contenido"><%= nomAct %></a>
        <%
          }
          rs.close();
          ps.close();
          con.close();
        %>
      </div>
    </div>

    <div id="front3">
      <!-- Aquí se cargan las páginas internas -->
      <iframe id="contenido" name="contenido" src="portada.jsp"></iframe>
    </div>
  </div>
</body>
</html>
