<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Login - Sistema de Citas</title>
    <style>
        /* Reset básico */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-image: url('img/fate.png');
            background-size: cover;
            background-position: center;
            color: #ffffff;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* HEADER */
        header {
            background-color: rgba(228, 0, 43, 0.8);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 80px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            z-index: 1000;
        }

        .container-header {
            max-width: 1200px;
            margin: 0 auto;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
        }

        .logo {
            height: 70px;
            width: auto;
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 25px;
        }

        nav ul li a {
            text-decoration: none;
            color: #ffffff;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        nav ul li a:hover {
            color: #ffffff;
        }

        /* MAIN - formulario */
        main {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding-top: 80px;
            padding-bottom: 60px;
        }

        .login-container {
            background-color: rgba(228, 0, 43, 0.8);
            padding: 30px 40px;
            border-radius: 8px;
            width: 90%;
            max-width: 400px;
            text-align: center;
        }

        .login-container h1 {
            margin-bottom: 25px;
            color: #ffffff;
        }

        .login-container span#nombre-institucion {
            font-weight: bold;
        }

        .login-form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .login-form label {
            text-align: left;
            font-weight: bold;
            color: #ffffff;
        }

        .login-form input {
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
        }

        /* Botón blanco con letra roja y hover gris suave */
        .login-form button {
            background-color: #ffffff;
            border: none;
            padding: 12px;
            font-weight: bold;
            color: #e4002b;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .login-form button:hover {
            background-color: #e0e0e0; /* Gris suave */
        }

        /* FOOTER */
        footer {
            background-color: rgba(228, 0, 43, 0.8);
            color: #ffffff;
            text-align: center;
            padding: 12px 20px;
            font-size: 14px;
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
        }

        @media (min-width: 768px) {
            main {
                padding-top: 100px;
            }
            .login-container {
                width: 400px;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="container-header">
            <img src="img/logoW.png" alt="Logo" class="logo" />
            <nav>
                <ul>
                    <li><a href="index.jsp">Inicio</a></li>
                    <li><a href="index.jsp">Acerca de</a></li>
                    <li><a href="index.jsp">Contacto</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main>
        <section class="login-container">
            <h1>Bienvenido a <span id="nombre-institucion">Portal de Citas</span></h1>
            <form action="LoginServlet" method="post" class="login-form">
                <label for="usuario">Usuario</label>
                <input type="text" name="usuario" placeholder="Usuario" required />

                <label for="clave">Contraseña</label>
                <input type="password" name="clave" placeholder="Contraseña" required />

                <button type="submit">Ingresar</button>
            </form>
            <% 
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
            <p style="color:white;"><%= error %></p>
            <% } %>
        </section>
    </main>

    <footer>
        <p>Contacto: contacto@miinstitucion.edu | Teléfono: +123 456 7890</p>
    </footer>
</body>
</html>
