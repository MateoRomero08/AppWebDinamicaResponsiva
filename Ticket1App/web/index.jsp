<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Sitio - Index</title>
    <style>
        /* fuentes y reset */
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }

        /* encabezado black */
        header {
            background:#0a0a0a; 
            color:#fff;
            display:flex; 
            justify-content:space-between; 
            align-items:center;
            padding:15px 40px; 
            position:sticky; 
            top:0; 
            z-index:1000;
        }
        header .logo img { height:40px; }
        header nav ul { list-style:none; display:flex; gap:20px; }
        header nav ul li a { 
            color:#fff; 
            text-decoration:none; 
            font-weight:500; 
            transition:color .3s; 
        }
        header nav ul li a:hover { color:#e60023; }

        /* fondo de portada difuminado con mensaje de bienvenida (hero) */
        .hero {
            height:90vh;
            background:
              linear-gradient(rgba(0,0,0,.5), rgba(0,0,0,.7)),
              url("img/wallpaper.png") center/cover no-repeat;
            display:flex; 
            justify-content:center; 
            align-items:center;
            text-align:center; 
            color:#fff; 
            padding:20px;
        }
        .hero-text h2 { font-size:3rem; margin-bottom:20px; }
        .hero-text p { font-size:1.2rem; margin-bottom:30px; }
        .hero-text .btn {
            padding:12px 25px; 
            background:#e60023; 
            color:#fff; 
            border-radius:6px;
            text-decoration:none; 
            font-weight:700; 
            transition:background .3s;
        }
        .hero-text .btn:hover { background:#b3001b; }

        /* === primera sección (fondo blanco) === */
        .inspire-wrap {
            background:#fff;
            width:100%;
        }
        .inspire {
            max-width:1200px;
            margin:0 auto;
            padding:60px 24px 30px 24px;
            display:flex;
            align-items:center;
            justify-content:center;
            gap:48px;
        }
        .inspire .mark img {
            height:72px;
            display:block;
        }
        .inspire .quote {
            font-weight:900;
            font-size:42px;
            line-height:1.1;
            color:#0a0a0a;
            letter-spacing:.5px;
            text-transform:uppercase;
        }

        /* estilos para los servicios */
        .services {
            max-width:900px;
            margin:0 auto;
            padding:20px 24px 60px 24px;
            text-align:center;
        }
        .services h4 {
            font-size:1.8rem;
            margin-bottom:15px;
            color:#e60023;
        }
        .services ul {
            list-style:none;
            padding:0;
            text-align:left;
            display:inline-block;
        }
        .services ul li {
            font-size:1.1rem;
            margin:8px 0;
            color:#333;
        }

        /* Responsividad, adaptarse a dispositivos móviles */
        @media (max-width: 900px){
            .inspire { 
                flex-direction:column; 
                gap:20px; 
                padding:40px 16px; 
            }
            .inspire .mark img { height:56px; }
            .inspire .quote { font-size:28px; text-align:center; }
            .services h4 { font-size:1.5rem; }
            .services ul li { font-size:1rem; }
        }
        /* pie de página */
        footer { 
            background:#0a0a0a; 
            color:#fff; 
            text-align:center; 
            padding:15px; 
        }
    </style>
</head>
<body>

    <!-- head -->
    <header>
        <div class="logo">
            <a href="index.jsp"><img src="img/T1.png" alt="Logo T1"></a>
        </div>
        <nav>
            <ul>
                <li><a href="login.jsp">Iniciar sesión</a></li>
            </ul>
        </nav>
    </header>

    <!-- (hero) -->
    <section class="hero">
        <div class="hero-text">
            <h2>Bienvenido a TICKET1</h2>
            <p>Explora nuestra plataforma moderna y sencilla. <br> Diseñada por Mateo Romero y Jonatan Gómez </p>
            <a href="login.jsp" class="btn">Comenzar</a>
        </div>
    </section>

    <!-- LOGO + MENSAJE + SERVICIOS -->
    <div class="inspire-wrap">
        <section class="inspire">
            <div class="mark">
                <img src="img/T1.png" alt="T1 mark">
            </div>
            <h3 class="quote">"TU PORTAL DE CITAS MOVIL"</h3>
        </section>
        <div class="services">
            <h4>Servicios que ofrecemos</h4>
            <ul>
                <li>✔ Reserva rápida de citas con profesionales.</li>
                <li>✔ Disponibilidad actualizada en tiempo real.</li>
                <li>✔ Prevención de dobles reservas.</li>
                <li>✔ Gestión de citas: crear, modificar o cancelar fácilmente.</li>
                <li>✔ Notificaciones y recordatorios automáticos.</li>
            </ul>
        </div>
    </div>

    <!-- final, pie de páginma -->
    <footer>
        <strong><p>© 2025 TICKET1. Todos los derechos reservados.</p></strong>
    </footer>

</body>
</html>
