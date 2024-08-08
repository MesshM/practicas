-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-08-2024 a las 14:16:08
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioteca`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_socio` (IN `p_numero` INT, IN `p_telefono` VARCHAR(10), IN `p_direccion` VARCHAR(255))   BEGIN
    UPDATE tbl_socio
    SET soc_telefono = p_telefono, soc_direccion = p_direccion
    WHERE soc_numero = p_numero;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_libro` (IN `p_titulo` VARCHAR(255))   BEGIN
    SELECT * FROM tbl_libro WHERE lib_titulo LIKE CONCAT('%', p_titulo, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_libro` (IN `p_isbn` BIGINT)   BEGIN
    DECLARE prestamo_count INT;
    SELECT COUNT(*) INTO prestamo_count FROM tbl_prestamo WHERE lib_copiaISBN = p_isbn;
    
    IF prestamo_count = 0 THEN
        DELETE FROM tbl_tipoautores WHERE copiaISBN = p_isbn;
        DELETE FROM tbl_libro WHERE lib_isbn = p_isbn;
        SELECT 'Libro eliminado con éxito' AS mensaje;
    ELSE
        SELECT 'No se puede eliminar el libro debido a préstamos existentes' AS mensaje;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_libros_prestados` ()   BEGIN
    SELECT l.lib_titulo, s.soc_nombre, s.soc_apellido, p.pres_fechaPrestamo, p.pres_fechaDevolucion
    FROM tbl_libro l
    INNER JOIN tbl_prestamo p ON l.lib_isbn = p.lib_copiaISBN
    INNER JOIN tbl_socio s ON p.soc_copiaNuero = s.soc_numero;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_listaAutores` ()   SELECT aut_codigo,aut_apellido
FROM tbl_autor
ORDER BY aut_apellido DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_socios_prestamos` ()   BEGIN
    SELECT s.*, p.*
    FROM tbl_socio s
    LEFT JOIN tbl_prestamo p ON s.soc_numero = p.soc_copiaNuero;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_tipoAutor` (`variable` VARCHAR(20))   SELECT aut_apellido as 'Autor', tipoAutor
FROM tbl_autor
INNER JOIN tbl_tipoautores
ON aut_codigo=copiaAutor
WHERE tipoAutor=variable$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_libro` (`c1_isbn` BIGINT(20), `c2_titulo` VARCHAR(255), `c3_genero` VARCHAR(20), `c4_paginas` INT(11), `c5diaspres` TINYINT(4))   INSERT INTO
tbl_libro(lib_isbn,lib_titulo,lib_genero,lib_numeroPaginas,lib_diasPrestamo)
VALUES (c1_isbn,c2_titulo,c3_genero, c4_paginas,c5diaspres)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_socio` (IN `p_numero` INT, IN `p_nombre` VARCHAR(45), IN `p_apellido` VARCHAR(45), IN `p_direccion` VARCHAR(255), IN `p_telefono` VARCHAR(10))   BEGIN
    INSERT INTO tbl_socio (soc_numero, soc_nombre, soc_apellido, soc_direccion, soc_telefono)
    VALUES (p_numero, p_nombre, p_apellido, p_direccion, p_telefono);
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
-- Estructura de tabla para la tabla `audi_autor`
--

CREATE TABLE `audi_autor` (
  `id_audi` int(10) NOT NULL,
  `aut_codigo_audi` int(11) DEFAULT NULL,
  `aut_apellido_anterior` varchar(45) DEFAULT NULL,
  `aut_nacimiento_anterior` date DEFAULT NULL,
  `aut_muerte_anterior` date DEFAULT NULL,
  `aut_apellido_nuevo` varchar(45) DEFAULT NULL,
  `aut_nacimiento_nuevo` date DEFAULT NULL,
  `aut_muerte_nuevo` date DEFAULT NULL,
  `audi_fechaModificacion` datetime DEFAULT NULL,
  `audi_usuario` varchar(45) DEFAULT NULL,
  `audi_accion` varchar(45) DEFAULT NULL
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
(1, 3, ' Juan ', 'González', 'Calle Principal 789, Villa Flores, Valencia', '2012345678', ' Juan ', 'González', 'Calle 72 #2', '709862', '2024-08-01 06:45:08', 'root@local', 'Actualización'),
(2, 7, 'Carlos', 'Sánchez', 'Calle de la Luna 234, El Prado, Alicante', '1123456781', NULL, NULL, NULL, NULL, '2024-08-01 07:00:06', 'root@local', 'Registro eliminado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_autor`
--

CREATE TABLE `tbl_autor` (
  `aut_codigo` int(11) NOT NULL,
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
(765, 'López', '1976-07-08', '2023-07-15'),
(789, 'Rodríguez', '1985-12-10', '0000-00-00'),
(890, 'Brown', '1982-11-17', '0000-00-00'),
(901, 'Soto', '1979-05-13', '2015-11-05');

--
-- Disparadores `tbl_autor`
--
DELIMITER $$
CREATE TRIGGER `autores_after_delete` AFTER DELETE ON `tbl_autor` FOR EACH ROW BEGIN
    INSERT INTO audi_autor (
        aut_codigo_audi,
        aut_apellido_anterior,
        aut_nacimiento_anterior,
        aut_muerte_anterior,
        audi_fechaModificacion,
        audi_usuario,
        audi_accion
    ) VALUES (
        OLD.aut_codigo,
        OLD.aut_apellido,
        OLD.aut_nacimiento,
        OLD.aut_muerte,
        NOW(),
        CURRENT_USER(),
        'Eliminación'
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `autores_after_insert` AFTER INSERT ON `tbl_autor` FOR EACH ROW BEGIN
    INSERT INTO audi_autor (
        aut_codigo_audi,
        aut_apellido_nuevo,
        aut_nacimiento_nuevo,
        aut_muerte_nuevo,
        audi_fechaModificacion,
        audi_usuario,
        audi_accion
    ) VALUES (
        NEW.aut_codigo,
        NEW.aut_apellido,
        NEW.aut_nacimiento,
        NEW.aut_muerte,
        NOW(),
        CURRENT_USER(),
        'Inserción'
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `autores_before_update` BEFORE UPDATE ON `tbl_autor` FOR EACH ROW BEGIN
    INSERT INTO audi_autor (
        aut_codigo_audi,
        aut_apellido_anterior,
        aut_nacimiento_anterior,
        aut_muerte_anterior,
        aut_apellido_nuevo,
        aut_nacimiento_nuevo,
        aut_muerte_nuevo,
        audi_fechaModificacion,
        audi_usuario,
        audi_accion
    ) VALUES (
        NEW.aut_codigo,
        OLD.aut_apellido,
        OLD.aut_nacimiento,
        OLD.aut_muerte,
        NEW.aut_apellido,
        NEW.aut_nacimiento,
        NEW.aut_muerte,
        NOW(),
        CURRENT_USER(),
        'Actualización'
    );
END
$$
DELIMITER ;

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
(9999999999, 'El Enigma de los Espejos Rotos', 'romance', 156, 7),
(9788426721006, 'sql', 'ingenieria', 384, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_prestamo`
--

CREATE TABLE `tbl_prestamo` (
  `pres_id` varchar(20) NOT NULL,
  `pres_fechaPrestamo` date DEFAULT NULL,
  `pres_fechaDevolucion` date DEFAULT NULL,
  `soc_copiaNuero` int(11) DEFAULT NULL,
  `lib_copiaISBN` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_prestamo`
--

INSERT INTO `tbl_prestamo` (`pres_id`, `pres_fechaPrestamo`, `pres_fechaDevolucion`, `soc_copiaNuero`, `lib_copiaISBN`) VALUES
('pres1', '2023-01-15', '2023-01-20', 1, 1234567890),
('pres2', '2023-02-03', '2023-02-04', 2, 9999999999),
('pres3', '2023-04-09', '2023-04-11', 6, 2718281828),
('pres4', '2023-06-14', '2023-06-15', 9, 8888888888),
('pres5', '2023-07-02', '2023-07-09', 10, 5555555555),
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
(1, 'Ana ', 'Ruiz', 'Calle Primavera 123, Ciudad Jardín, Barcelona', '9123456780'),
(2, 'Andrés Felipe', 'Galindo Luna', 'Avenida del Sol 456, Pueblo Nuevo, Madrid', '2123456789'),
(3, ' Juan ', 'González', 'Calle 72 #2', '709862'),
(4, 'María ', 'Rodríguez', 'Carrera del Río 321, El Pueblo, Sevilla', '3012345678'),
(5, 'Pedro ', 'Martínez', 'Calle del Bosque 654, Los Pinos, Málaga', '1234567812'),
(6, 'Ana', ' López', 'Avenida Central 987, Villa Hermosa, Bilbao', '6123456781'),
(8, ' Laura ', 'Ramírez', 'Carrera del Mar 567, Playa Azul, Palma de Mallorca', '1312345678'),
(9, 'Luis ', 'Hernández', 'Avenida de la Montaña 890, Monte Verde, Granada', '6101234567'),
(10, 'Andrea ', 'García', 'Calle del Sol 432, La Colina, Zaragoza', '1112345678'),
(11, 'Alejandro ', 'Torres', 'Carrera del Oeste 765, Ciudad Nueva, Murcia', '4951234567'),
(12, 'Sofia ', 'Morales', 'Avenida del Mar 098, Costa Brava, Gijón', '5512345678');

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

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `audi_autor`
--
ALTER TABLE `audi_autor`
  ADD PRIMARY KEY (`id_audi`);

--
-- Indices de la tabla `audi_socio`
--
ALTER TABLE `audi_socio`
  ADD PRIMARY KEY (`id_audi`);

--
-- Indices de la tabla `tbl_autor`
--
ALTER TABLE `tbl_autor`
  ADD PRIMARY KEY (`aut_codigo`);

--
-- Indices de la tabla `tbl_libro`
--
ALTER TABLE `tbl_libro`
  ADD PRIMARY KEY (`lib_isbn`);

--
-- Indices de la tabla `tbl_prestamo`
--
ALTER TABLE `tbl_prestamo`
  ADD PRIMARY KEY (`pres_id`),
  ADD KEY `soc_copiaNuero` (`soc_copiaNuero`),
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
-- AUTO_INCREMENT de la tabla `audi_autor`
--
ALTER TABLE `audi_autor`
  MODIFY `id_audi` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `audi_socio`
--
ALTER TABLE `audi_socio`
  MODIFY `id_audi` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_prestamo`
--
ALTER TABLE `tbl_prestamo`
  ADD CONSTRAINT `tbl_prestamo_ibfk_1` FOREIGN KEY (`soc_copiaNuero`) REFERENCES `tbl_socio` (`soc_numero`),
  ADD CONSTRAINT `tbl_prestamo_ibfk_2` FOREIGN KEY (`lib_copiaISBN`) REFERENCES `tbl_libro` (`lib_isbn`);

--
-- Filtros para la tabla `tbl_tipoautores`
--
ALTER TABLE `tbl_tipoautores`
  ADD CONSTRAINT `tbl_tipoautores_ibfk_1` FOREIGN KEY (`copiaISBN`) REFERENCES `tbl_libro` (`lib_isbn`),
  ADD CONSTRAINT `tbl_tipoautores_ibfk_2` FOREIGN KEY (`copiaAutor`) REFERENCES `tbl_autor` (`aut_codigo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
