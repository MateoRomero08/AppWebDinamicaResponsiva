<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Bienvenido - Ticket1</title>
  <style>
    html, body {
      margin: 0;
      padding: 0;
      font-family: Arial, sans-serif;
      background-color: #fff;
      height: 100%;
      overflow: hidden;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .welcome-container {
      text-align: center;
      padding: 40px;
      border: 2px solid #e4002b;
      border-radius: 15px;
      background: #fafafa;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      max-width: 400px;
      animation: fadeIn 0.8s ease-in-out;
    }
    .welcome-container img {
      width: 130px;
      margin-bottom: 20px;
    }
    .welcome-container h1 {
      color: #e4002b;
      font-size: 26px;
      margin-bottom: 15px;
    }
    .welcome-container p {
      color: #333;
      font-size: 17px;
      margin-bottom: 10px;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: scale(0.95); }
      to { opacity: 1; transform: scale(1); }
    }
  </style>
</head>
<body>
  <div class="welcome-container">
    <img src="img/T1.png" alt="Logo Ticket1">
    <h1>Bienvenido a TICKET1</h1>
    <p>Gestione y administre las citas de manera rápida y sencilla.</p>
  </div>
</body>
</html>
