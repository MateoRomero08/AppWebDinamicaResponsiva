-- Creación de la base de datos
CREATE DATABASE sistema;
USE sistema;

-- ========================================
-- Tabla: perfiles
-- ========================================
CREATE TABLE perfiles (
    id_perfil INT AUTO_INCREMENT PRIMARY KEY,
    perfil VARCHAR(30) NOT NULL
);

-- ========================================
-- Tabla: actividades
-- ========================================
CREATE TABLE actividades (
    id_actividad INT AUTO_INCREMENT PRIMARY KEY,
    nom_actividad VARCHAR(45) NOT NULL,
    enlace VARCHAR(100)
);

-- ========================================
-- Tabla: usuarios
-- ========================================
CREATE TABLE usuarios (
    idusu INT AUTO_INCREMENT PRIMARY KEY,
    num_docu VARCHAR(20) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    email VARCHAR(60) NOT NULL,
    usuario VARCHAR(30) NOT NULL,
    clave VARCHAR(8) NOT NULL,
    id_perfil INT,
    FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- ========================================
-- Tabla: gesActividad
-- ========================================
CREATE TABLE gesActividad (
    idgesActividad INT AUTO_INCREMENT PRIMARY KEY,
    id_perfil INT,
    id_actividad INT,
    FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_actividad) REFERENCES actividades(id_actividad)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- ========================================
-- Tabla: perfiles
-- ========================================
INSERT INTO perfiles (perfil) VALUES
('Administrador'),
('Paciente');

-- ========================================
-- Tabla: actividades
-- ========================================
INSERT INTO actividades (nom_actividad, enlace) VALUES
('Registrar usuarios', 'registrarUsuarios.jsp'),
('Listar usuarios', 'listarUsuarios.jsp'),
('Reservar citas', 'reservarCitas.jsp'),
('Gestionar citas', 'gestionarCitas.jsp');

-- ========================================
-- Tabla: gesActividad
-- Asignación de permisos a perfiles
-- ========================================

-- Perfil 1 (Administrador): puede registrar, listar y editar usuarios
INSERT INTO gesActividad (id_perfil, id_actividad) VALUES
(1, 1),
(1, 2);


-- Perfil 2 (Paciente): puede reservar y gestionar sus citas
INSERT INTO gesActividad (id_perfil, id_actividad) VALUES
(2, 3),
(2, 4);

-- ========================================
-- Tabla: usuarios (opcional para prueba)
-- ========================================
INSERT INTO usuarios (num_docu, nombre, apellido, email, usuario, clave, id_perfil) VALUES
('1001', 'Carlos', 'Gómez', 'carlos.admin@example.com', 'admin', '12345678', 1),
('2001', 'Laura', 'Pérez', 'laura.paciente@example.com', 'laura', '12345678', 2);


CREATE TABLE servicios (
    idservicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre_servicio VARCHAR(100) NOT NULL,
    descripcion TEXT,
    costo DECIMAL(10,2) NOT NULL
);
INSERT INTO servicios (nombre_servicio, descripcion, costo) VALUES
('Consulta General', 'Atención médica básica para evaluación general del paciente.', 50000),
('Odontología', 'Evaluación y tratamiento dental básico.', 70000),
('Pediatría', 'Atención especializada para niños.', 60000),
('Cardiología', 'Consulta con especialista en el sistema cardiovascular.', 120000);


CREATE TABLE citas (
    idcita INT AUTO_INCREMENT PRIMARY KEY,
    idusu INT NOT NULL,
    idservicio INT NOT NULL,
    fecha_cita DATE NOT NULL,
    hora_cita TIME NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idusu) REFERENCES usuarios(idusu) ON DELETE CASCADE,
    FOREIGN KEY (idservicio) REFERENCES servicios(idservicio) ON DELETE CASCADE
);

ALTER TABLE citas
ADD CONSTRAINT unq_cita_usuario UNIQUE (idusu, fecha_cita, hora_cita);

-- ========================================
-- Nuevas actividades (solo para el administrador)
-- ========================================
INSERT INTO actividades (nom_actividad, enlace) VALUES
('Registrar Actividades', 'registrarActividad.jsp'),
('Gestionar Actividades', 'gestionarActividad.jsp'),
('Registrar Perfiles', 'registrarPerfiles.jsp');

INSERT INTO gesActividad (id_perfil, id_actividad)
SELECT 1, id_actividad
FROM actividades
WHERE nom_actividad IN (
  'Registrar Actividades',
  'Gestionar Actividades',
  'Registrar Perfiles'
);


