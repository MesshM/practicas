-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-08-2024 a las 16:13:35
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ejercicio_biblioteca`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarLibrosEnPrestamo` ()   BEGIN
    SELECT l.lib_titulo, l.lib_isbn, s.soc_numero, s.soc_nombre, s.soc_apellido, p.pres_fechaPrestamo, p.pres_fechaDevolucion
    FROM tbl_libro l
    INNER JOIN tbl_prestamo p ON l.lib_isbn = p.lib_copiaISBN
    INNER JOIN tbl_socio s ON p.soc_numero = s.soc_numero
    WHERE p.pres_fechaDevolucion IS NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarSociosConPrestamos` ()   BEGIN
    SELECT s.soc_numero, s.soc_nombre, s.soc_apellido, s.soc_direccion, s.soc_telefono, 
           p.pres_id, p.pres_fechaPrestamo, p.pres_fechaDevolucion, p.lib_copiaISBN
    FROM tbl_socio s
    LEFT JOIN tbl_prestamo p ON s.soc_numero = p.soc_numero;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `contar_socios` () RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM tbl_socio;
    RETURN total;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `dias_prestamo` (`p_isbn` BIGINT) RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE dias INT;
    SELECT DATEDIFF(IFNULL(pres_fechaDevolucion, CURDATE()), pres_fechaPrestamo) INTO dias
    FROM tbl_prestamo
    WHERE lib_copiaISBN = p_isbn
    ORDER BY pres_fechaPrestamo DESC
    LIMIT 1;
    RETURN IFNULL(dias, 0);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aprendiz`
--

CREATE TABLE `aprendiz` (
  `id_aprendiz` int(11) NOT NULL,
  `apr_nombre` varchar(50) DEFAULT NULL,
  `apr_apellido` varchar(50) DEFAULT NULL,
  `apr_correo` varchar(100) DEFAULT NULL,
  `apr_ubicacion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aprendiz`
--

INSERT INTO `aprendiz` (`id_aprendiz`, `apr_nombre`, `apr_apellido`, `apr_correo`, `apr_ubicacion`) VALUES
(1, 'Juan', 'Pérez', 'juan.perez@example.com', 'Ciudad A'),
(2, 'María', 'Gómez', 'maria.gomez@example.com', 'Ciudad B'),
(3, 'Pedro', 'López', 'pedro.lopez@example.com', 'Ciudad C'),
(4, 'Laura', 'Torres', 'laura.torres@example.com', 'Ciudad A'),
(5, 'Carlos', 'Rodríguez', 'carlos.rodriguez@example.com', 'Ciudad B');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aprendizvidx`
--

CREATE TABLE `aprendizvidx` (
  `id_aprendiz` varchar(11) NOT NULL,
  `apr_nombre` varchar(45) NOT NULL,
  `apr_apellido` varchar(45) NOT NULL,
  `apr_correo` varchar(45) NOT NULL,
  `apr_ubicacion` varchar(10) NOT NULL DEFAULT 'Bogotá'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audi_socio`
--

CREATE TABLE `audi_socio` (
  `id_audi` int(10) NOT NULL,
  `socNumero_audi` int(11) DEFAULT NULL,
  `socNombre_anterior` varchar(45) DEFAULT NULL,
  `socApellido_anterior` varchar(45) DEFAULT NULL,
  `socDireccion_anterior` varchar(255) DEFAULT NULL,
  `socTelefono_anterior` varchar(10) DEFAULT NULL,
  `socNombre_nuevo` varchar(45) DEFAULT NULL,
  `socApellido_nuevo` varchar(45) DEFAULT NULL,
  `socDireccion_nuevo` varchar(255) DEFAULT NULL,
  `socTelefono_nuevo` varchar(10) DEFAULT NULL,
  `audi_fechaModificacion` datetime DEFAULT NULL,
  `audi_usuario` varchar(10) DEFAULT NULL,
  `audi_accion` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `audi_socio`
--

INSERT INTO `audi_socio` (`id_audi`, `socNumero_audi`, `socNombre_anterior`, `socApellido_anterior`, `socDireccion_anterior`, `socTelefono_anterior`, `socNombre_nuevo`, `socApellido_nuevo`, `socDireccion_nuevo`, `socTelefono_nuevo`, `audi_fechaModificacion`, `audi_usuario`, `audi_accion`) VALUES
(1, 2, 'Andrés Felipe', 'Galindo Luna', 'Avenida del Sol 456, Pueblo Nuevo, Madrid', '2123456789', 'Andrés Felipe', 'Galindo Luna', 'Calle 72 #\r\n2', '2928088', '2024-07-31 09:52:44', 'root@local', 'Actualización'),
(2, 5, 'Pedro', 'Martínez', 'Calle del Bosque 654, Los Pinos, Málaga', '1234567812', NULL, NULL, NULL, NULL, '2024-07-31 11:17:38', 'root@local', 'Registro eliminado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posiciones`
--

CREATE TABLE `posiciones` (
  `id` int(11) NOT NULL,
  `grupo` char(10) NOT NULL,
  `pais` varchar(45) NOT NULL,
  `jugados` int(11) NOT NULL,
  `ganados` int(11) NOT NULL,
  `empatados` int(11) NOT NULL,
  `perdidos` int(11) NOT NULL,
  `puntos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_auditoria_libro`
--

CREATE TABLE `tbl_auditoria_libro` (
  `aud_id` int(11) NOT NULL,
  `lib_isbn` bigint(20) DEFAULT NULL,
  `accion` varchar(10) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datos_antiguos` text DEFAULT NULL,
  `datos_nuevos` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_auditoria_medico`
--

CREATE TABLE `tbl_auditoria_medico` (
  `auditoria_id` int(11) NOT NULL,
  `medico_id` int(11) DEFAULT NULL,
  `accion` varchar(10) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `usuario` varchar(50) DEFAULT NULL,
  `datos_antiguos` text DEFAULT NULL,
  `datos_nuevos` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_autor`
--

CREATE TABLE `tbl_autor` (
  `aut_codigo` int(3) NOT NULL,
  `aut_apellido` varchar(45) DEFAULT NULL,
  `aut_nacimiento` date DEFAULT NULL,
  `aut_muerte` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_autor`
--

INSERT INTO `tbl_autor` (`aut_codigo`, `aut_apellido`, `aut_nacimiento`, `aut_muerte`) VALUES
(98, 'Smith', '1974-12-21', '2018-07-21'),
(123, 'Taylor', '1980-04-15', '0000-00-00'),
(234, 'Medina', '1977-06-21', '2005-09-12'),
(345, 'Wilson', '1975-08-29', '0000-00-00'),
(432, 'Miller', '1981-10-26', '0000-00-00'),
(456, 'García', '1978-09-27', '2021-12-09'),
(567, 'Davis', '1983-03-04', '2010-03-28'),
(678, 'Silva', '1986-02-02', '0000-00-00'),
(765, 'López', '1976-07-08', '2023-07-24'),
(789, 'Rodríguez', '1985-12-10', '0000-00-00'),
(890, 'Brown', '1982-11-17', '0000-00-00'),
(901, 'Soto', '1979-05-13', '2015-11-05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_libro`
--

CREATE TABLE `tbl_libro` (
  `lib_isbn` bigint(20) NOT NULL,
  `lib_titulo` varchar(255) DEFAULT NULL,
  `lib_genero` varchar(20) DEFAULT NULL,
  `lib_numeroPaginas` int(11) DEFAULT NULL,
  `lib_diasPrestamo` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_libro`
--

INSERT INTO `tbl_libro` (`lib_isbn`, `lib_titulo`, `lib_genero`, `lib_numeroPaginas`, `lib_diasPrestamo`) VALUES
(1234567890, 'El Sueño de los Susurros', 'novela', 275, 7),
(1357924680, 'El Jardín de las Mariposas Perdidas', 'novela', 536, 7),
(2468135790, 'La Melodía de la Oscuridad', 'romance', 189, 7),
(2718281828, 'El Bosque de los Suspiros', 'novela', 387, 2),
(3141592653, 'El Secreto de las Estrellas Olvidadas', 'Misterio', 203, 7),
(5555555555, 'La Última Llave del Destino', 'cuento', 503, 7),
(7777777777, 'El Misterio de la Luna Plateada', 'Misterio', 422, 7),
(8642097531, 'El Reloj de Arena Infinito', 'novela', 321, 7),
(8888888888, 'La Ciudad de los Susurros', 'Misterio', 274, 1),
(9517530862, 'Las Crónicas del Eco Silencioso', 'fantasía', 448, 7),
(9876543210, 'El Laberinto de los Recuerdos', 'cuento', 412, 7),
(9999999999, 'El Enigma de los Espejos Rotos', 'romance', 156, 7);

--
-- Disparadores `tbl_libro`
--
DELIMITER $$
CREATE TRIGGER `tr_auditoria_libro_delete` AFTER DELETE ON `tbl_libro` FOR EACH ROW BEGIN
    INSERT INTO tbl_auditoria_libro (lib_isbn, accion, datos_antiguos)
    VALUES (
        OLD.lib_isbn,
        'DELETE',
        CONCAT('Titulo: ', OLD.lib_titulo, ', Genero: ', OLD.lib_genero, ', Numero Paginas: ', OLD.lib_numeroPaginas, ', Dias Prestamo: ', OLD.lib_diasPrestamo)
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_auditoria_libro_update` AFTER UPDATE ON `tbl_libro` FOR EACH ROW BEGIN
    INSERT INTO tbl_auditoria_libro (lib_isbn, accion, datos_antiguos, datos_nuevos)
    VALUES (
        OLD.lib_isbn,
        'UPDATE',
        CONCAT('Titulo: ', OLD.lib_titulo, ', Genero: ', OLD.lib_genero, ', Numero Paginas: ', OLD.lib_numeroPaginas, ', Dias Prestamo: ', OLD.lib_diasPrestamo),
        CONCAT('Titulo: ', NEW.lib_titulo, ', Genero: ', NEW.lib_genero, ', Numero Paginas: ', NEW.lib_numeroPaginas, ', Dias Prestamo: ', NEW.lib_diasPrestamo)
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_medico`
--

CREATE TABLE `tbl_medico` (
  `medico_id` int(11) NOT NULL,
  `medico_nombre` varchar(100) NOT NULL,
  `medico_apellido` varchar(100) NOT NULL,
  `medico_especialidad` varchar(100) DEFAULT NULL,
  `medico_telefono` varchar(15) DEFAULT NULL,
  `medico_email` varchar(100) DEFAULT NULL,
  `medico_direccion` varchar(255) DEFAULT NULL,
  `medico_fecha_ingreso` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `tbl_medico`
--
DELIMITER $$
CREATE TRIGGER `trg_auditoria_delete_medico` AFTER DELETE ON `tbl_medico` FOR EACH ROW BEGIN
    INSERT INTO tbl_auditoria_medico (
        medico_id, 
        accion, 
        datos_antiguos
    ) VALUES (
        OLD.medico_id, 
        'DELETE', 
        CONCAT('Nombre: ', OLD.medico_nombre, ', Teléfono: ', OLD.medico_telefono)  -- Ajusta según las columnas de tbl_medico
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_auditoria_insert_medico` AFTER INSERT ON `tbl_medico` FOR EACH ROW BEGIN
    INSERT INTO tbl_auditoria_medico (
        medico_id, 
        accion, 
        datos_nuevos
    ) VALUES (
        NEW.medico_id, 
        'INSERT', 
        CONCAT('Nombre: ', NEW.medico_nombre, ', Teléfono: ', NEW.medico_telefono)  -- Ajusta según las columnas de tbl_medico
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_auditoria_update_medico` AFTER UPDATE ON `tbl_medico` FOR EACH ROW BEGIN
    INSERT INTO tbl_auditoria_medico (
        medico_id, 
        accion, 
        datos_antiguos, 
        datos_nuevos
    ) VALUES (
        OLD.medico_id, 
        'UPDATE', 
        CONCAT('Nombre: ', OLD.medico_nombre, ', Teléfono: ', OLD.medico_telefono),  -- Ajusta según las columnas de tbl_medico
        CONCAT('Nombre: ', NEW.medico_nombre, ', Teléfono: ', NEW.medico_telefono)   -- Ajusta según las columnas de tbl_medico
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_prestamo`
--

CREATE TABLE `tbl_prestamo` (
  `pres_id` varchar(20) NOT NULL,
  `pres_fechaPrestamo` date DEFAULT NULL,
  `pres_fechaDevolucion` date DEFAULT NULL,
  `soc_numero` int(11) DEFAULT NULL,
  `lib_copiaISBN` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_prestamo`
--

INSERT INTO `tbl_prestamo` (`pres_id`, `pres_fechaPrestamo`, `pres_fechaDevolucion`, `soc_numero`, `lib_copiaISBN`) VALUES
('pres1', '2023-01-15', '2024-01-18', 1, 1234567890),
('pres6', '2023-08-19', '2023-08-26', 12, 5555555555),
('pres7', '2023-10-24', '2023-10-27', 3, 1357924680),
('pres8', '2023-11-11', '2023-11-12', 4, 9999999999);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_socio`
--

CREATE TABLE `tbl_socio` (
  `soc_numero` int(11) NOT NULL,
  `soc_nombre` varchar(45) DEFAULT NULL,
  `soc_apellido` varchar(45) DEFAULT NULL,
  `soc_direccion` varchar(255) DEFAULT NULL,
  `soc_telefono` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_socio`
--

INSERT INTO `tbl_socio` (`soc_numero`, `soc_nombre`, `soc_apellido`, `soc_direccion`, `soc_telefono`) VALUES
(0, 'soc_nombre', 'soc_apellido', 'soc_direccion', 'soc_telefo'),
(1, 'Ana', 'Ruiz', 'Calle Primavera 123, Ciudad Jardín, Barcelona', '9123456780'),
(2, 'Andrés Felipe', 'Galindo Luna', 'Calle 72 #\r\n2', '2928088'),
(3, 'Juan', 'González', 'Calle Principal 789, Villa Flores, Valencia', '2012345678'),
(4, 'María', 'Rodríguez', 'Carrera del Río 321, El Pueblo, Sevilla', '3012345678'),
(6, 'Ana', 'López', 'Avenida Central 987, Villa Hermosa, Bilbao', '6123456789'),
(7, 'Carlos', 'Sánchez', 'Calle de la Luna 234, El Prado, Alicante', '1123456781'),
(8, 'Laura', 'Ramírez', 'Carrera del Mar 567, Playa Azul, Palma de Mallorca', '1312345678'),
(9, 'Luis', 'Hernández', 'Avenida de la Montaña 890, Monte Verde, Granada', '6101234567'),
(10, 'Andrea', 'García', 'Calle del Sol 432, La Colina, Zaragoza', '1112345678'),
(11, 'Alejandro', 'Torres', 'Carrera del Oeste 765, Ciudad Nueva, Murcia', '4951234567'),
(12, 'Sofía', 'Morales', 'Avenida del Mar 098, Costa Brava, Gijón', '5512345678');

--
-- Disparadores `tbl_socio`
--
DELIMITER $$
CREATE TRIGGER `socios_after_delete` AFTER DELETE ON `tbl_socio` FOR EACH ROW INSERT INTO audi_socio(
socNumero_audi,
socNombre_anterior,
socApellido_anterior,
socDireccion_anterior,
socTelefono_anterior,
audi_fechaModificacion,
audi_usuario,
audi_accion)
VALUES(
old.soc_numero,
old.soc_nombre,
old.soc_apellido,
old.soc_direccion,
old.soc_telefono,
NOW(),
CURRENT_USER(),
'Registro eliminado')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `socios_before_update` BEFORE UPDATE ON `tbl_socio` FOR EACH ROW INSERT INTO audi_socio(
socNumero_audi,
socNombre_anterior,
socApellido_anterior,
socDireccion_anterior,
socTelefono_anterior,
socNombre_nuevo,
socApellido_nuevo,
socDireccion_nuevo,
socTelefono_nuevo,
audi_fechaModificacion,
audi_usuario,
audi_accion)
VALUES(
new.soc_numero,
old.soc_nombre,
old.soc_apellido,
old.soc_direccion,
old.soc_telefono,
new.soc_nombre,
new.soc_apellido,
new.soc_direccion,
new.soc_telefono,
NOW(),
CURRENT_USER(),
'Actualización')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipoautores`
--

CREATE TABLE `tbl_tipoautores` (
  `copiaISBN` bigint(20) NOT NULL,
  `copiaAutor` int(11) NOT NULL,
  `tipoAutor` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_tipoautores`
--

INSERT INTO `tbl_tipoautores` (`copiaISBN`, `copiaAutor`, `tipoAutor`) VALUES
(1234567890, 123, 'Autor'),
(1234567890, 456, 'Coautor'),
(1234567890, 890, 'Autor'),
(1357924680, 123, 'Traductor'),
(2468135790, 234, 'Autor'),
(2718281828, 789, 'Traductor'),
(3141592653, 901, 'Autor'),
(5555555555, 678, 'Autor'),
(7777777777, 765, 'Autor'),
(8642097531, 345, 'Autor'),
(8888888888, 234, 'Autor'),
(8888888888, 345, 'Coautor'),
(9517530862, 432, 'Autor'),
(9876543210, 567, 'Autor'),
(9999999999, 98, 'Autor');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_aprendices_correo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_aprendices_correo` (
`apr_nombre` varchar(50)
,`apr_correo` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_detalles_prestamos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_detalles_prestamos` (
`prestamo_id` varchar(20)
,`libro_titulo` varchar(255)
,`socio_nombre` varchar(45)
,`pres_fechaPrestamo` date
,`pres_fechaDevolucion` date
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_libros_disponibles`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_libros_disponibles` (
`lib_isbn` bigint(20)
,`lib_titulo` varchar(255)
,`lib_genero` varchar(20)
,`lib_numeroPaginas` int(11)
,`lib_diasPrestamo` tinyint(4)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_aprendices_correo`
--
DROP TABLE IF EXISTS `vista_aprendices_correo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_aprendices_correo`  AS SELECT `aprendiz`.`apr_nombre` AS `apr_nombre`, `aprendiz`.`apr_correo` AS `apr_correo` FROM `aprendiz` ORDER BY `aprendiz`.`apr_nombre` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_detalles_prestamos`
--
DROP TABLE IF EXISTS `vista_detalles_prestamos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_detalles_prestamos`  AS SELECT `p`.`pres_id` AS `prestamo_id`, `l`.`lib_titulo` AS `libro_titulo`, `s`.`soc_nombre` AS `socio_nombre`, `p`.`pres_fechaPrestamo` AS `pres_fechaPrestamo`, `p`.`pres_fechaDevolucion` AS `pres_fechaDevolucion` FROM ((`tbl_prestamo` `p` join `tbl_libro` `l` on(`p`.`lib_copiaISBN` = `l`.`lib_isbn`)) join `tbl_socio` `s` on(`p`.`soc_numero` = `s`.`soc_numero`)) WHERE `p`.`pres_fechaDevolucion` is null ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_libros_disponibles`
--
DROP TABLE IF EXISTS `vista_libros_disponibles`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_libros_disponibles`  AS SELECT `l`.`lib_isbn` AS `lib_isbn`, `l`.`lib_titulo` AS `lib_titulo`, `l`.`lib_genero` AS `lib_genero`, `l`.`lib_numeroPaginas` AS `lib_numeroPaginas`, `l`.`lib_diasPrestamo` AS `lib_diasPrestamo` FROM (`tbl_libro` `l` left join `tbl_prestamo` `p` on(`l`.`lib_isbn` = `p`.`lib_copiaISBN` and `p`.`pres_fechaDevolucion` is null)) WHERE `p`.`pres_id` is null ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aprendiz`
--
ALTER TABLE `aprendiz`
  ADD PRIMARY KEY (`id_aprendiz`);

--
-- Indices de la tabla `aprendizvidx`
--
ALTER TABLE `aprendizvidx`
  ADD PRIMARY KEY (`id_aprendiz`),
  ADD UNIQUE KEY `apr_correo` (`apr_correo`),
  ADD KEY `apr_nombre` (`apr_nombre`);

--
-- Indices de la tabla `audi_socio`
--
ALTER TABLE `audi_socio`
  ADD PRIMARY KEY (`id_audi`);

--
-- Indices de la tabla `posiciones`
--
ALTER TABLE `posiciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_grupo_pais` (`grupo`,`pais`),
  ADD KEY `idx_pais` (`pais`);

--
-- Indices de la tabla `tbl_auditoria_libro`
--
ALTER TABLE `tbl_auditoria_libro`
  ADD PRIMARY KEY (`aud_id`);

--
-- Indices de la tabla `tbl_auditoria_medico`
--
ALTER TABLE `tbl_auditoria_medico`
  ADD PRIMARY KEY (`auditoria_id`);

--
-- Indices de la tabla `tbl_autor`
--
ALTER TABLE `tbl_autor`
  ADD PRIMARY KEY (`aut_codigo`);

--
-- Indices de la tabla `tbl_libro`
--
ALTER TABLE `tbl_libro`
  ADD PRIMARY KEY (`lib_isbn`),
  ADD KEY `idx_lib_titulo` (`lib_titulo`);

--
-- Indices de la tabla `tbl_medico`
--
ALTER TABLE `tbl_medico`
  ADD PRIMARY KEY (`medico_id`);

--
-- Indices de la tabla `tbl_prestamo`
--
ALTER TABLE `tbl_prestamo`
  ADD PRIMARY KEY (`pres_id`),
  ADD KEY `soc_numero` (`soc_numero`),
  ADD KEY `lib_copiaISBN` (`lib_copiaISBN`);

--
-- Indices de la tabla `tbl_socio`
--
ALTER TABLE `tbl_socio`
  ADD PRIMARY KEY (`soc_numero`);

--
-- Indices de la tabla `tbl_tipoautores`
--
ALTER TABLE `tbl_tipoautores`
  ADD PRIMARY KEY (`copiaISBN`,`copiaAutor`),
  ADD KEY `copiaAutor` (`copiaAutor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `audi_socio`
--
ALTER TABLE `audi_socio`
  MODIFY `id_audi` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `posiciones`
--
ALTER TABLE `posiciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_auditoria_libro`
--
ALTER TABLE `tbl_auditoria_libro`
  MODIFY `aud_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_auditoria_medico`
--
ALTER TABLE `tbl_auditoria_medico`
  MODIFY `auditoria_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_medico`
--
ALTER TABLE `tbl_medico`
  MODIFY `medico_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_prestamo`
--
ALTER TABLE `tbl_prestamo`
  ADD CONSTRAINT `tbl_prestamo_ibfk_1` FOREIGN KEY (`soc_numero`) REFERENCES `tbl_socio` (`soc_numero`),
  ADD CONSTRAINT `tbl_prestamo_ibfk_2` FOREIGN KEY (`lib_copiaISBN`) REFERENCES `tbl_libro` (`lib_isbn`);

--
-- Filtros para la tabla `tbl_tipoautores`
--
ALTER TABLE `tbl_tipoautores`
  ADD CONSTRAINT `tbl_tipoautores_ibfk_1` FOREIGN KEY (`copiaISBN`) REFERENCES `tbl_libro` (`lib_isbn`),
  ADD CONSTRAINT `tbl_tipoautores_ibfk_2` FOREIGN KEY (`copiaAutor`) REFERENCES `tbl_autor` (`aut_codigo`);

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`root`@`localhost` EVENT `minuto_eliminar_prestamos` ON SCHEDULE EVERY 1 MINUTE STARTS '2024-08-08 06:50:59' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
DELETE FROM tbl_prestamo
WHERE pres_fechaDevolucion <= NOW() - INTERVAL 1 YEAR;
#datos menores a la fecha actual - 1 año
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
