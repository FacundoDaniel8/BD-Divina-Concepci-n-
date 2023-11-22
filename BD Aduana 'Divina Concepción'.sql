-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-10-2023 a las 13:08:56
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `aduana_divina_concepcion`
--
DROP DATABASE IF EXISTS aduana_divina_concepcion;
CREATE DATABASE aduana_divina_concepcion;
USE aduana_divina_concepcion;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `embarcaciones`
--

CREATE TABLE `embarcaciones` (
  `id_barco` varchar(11) NOT NULL,
  `id_modelo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `id_empresa` varchar(5) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inspecciones`
--

CREATE TABLE `inspecciones` (
  `id_puerto` varchar(10) NOT NULL,
  `id_barco` varchar(11) NOT NULL,
  `fecha_inspeccion` date NOT NULL,
  `estado` varchar(10) NOT NULL,
  `motivo_detencion` varchar(200) DEFAULT NULL,
  `arancel` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelo`
--

CREATE TABLE `modelo` (
  `id_modelo` int(11) NOT NULL,
  `modelo` varchar(60) NOT NULL,
  `capacidad_max_tripulantes` int(11) DEFAULT NULL,
  `cargamento_max` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `navegantes`
--

CREATE TABLE `navegantes` (
  `id_navegante` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `apellido2` varchar(50) DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `cargo` varchar(25) DEFAULT NULL,
  `id_barco` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `id_tipo` varchar(10) NOT NULL,
  `id_empresa` varchar(5) NOT NULL,
  `id_barco` varchar(11) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `peso` float NOT NULL,
  `valor` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puertos`
--

CREATE TABLE `puertos` (
  `id_puerto` varchar(10) NOT NULL,
  `ubicacion` varchar(50) NOT NULL,
  `pais` varchar(60) NOT NULL,
  `nombre_puerto` varchar(100) DEFAULT NULL,
  `telefono` int(15) DEFAULT NULL,
  `capacidad` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_producto`
--

CREATE TABLE `tipo_producto` (
  `id_tipo` varchar(10) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `impuesto` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `embarcaciones`
--
ALTER TABLE `embarcaciones`
  ADD PRIMARY KEY (`id_barco`),
  ADD KEY `id_modelo` (`id_modelo`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id_empresa`);

--
-- Indices de la tabla `inspecciones`
--
ALTER TABLE `inspecciones`
  ADD PRIMARY KEY (`id_puerto`,`id_barco`),
  ADD KEY `id_barco` (`id_barco`);

--
-- Indices de la tabla `modelo`
--
ALTER TABLE `modelo`
  ADD PRIMARY KEY (`id_modelo`);

--
-- Indices de la tabla `navegantes`
--
ALTER TABLE `navegantes`
  ADD PRIMARY KEY (`id_navegante`),
  ADD KEY `id_barco` (`id_barco`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_tipo` (`id_tipo`),
  ADD KEY `id_empresa` (`id_empresa`),
  ADD KEY `id_barco` (`id_barco`);

--
-- Indices de la tabla `puertos`
--
ALTER TABLE `puertos`
  ADD PRIMARY KEY (`id_puerto`);

--
-- Indices de la tabla `tipo_producto`
--
ALTER TABLE `tipo_producto`
  ADD PRIMARY KEY (`id_tipo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `modelo`
--
ALTER TABLE `modelo`
  MODIFY `id_modelo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `navegantes`
--
ALTER TABLE `navegantes`
  MODIFY `id_navegante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `embarcaciones`
--
ALTER TABLE `embarcaciones`
  ADD CONSTRAINT `embarcaciones_ibfk_1` FOREIGN KEY (`id_modelo`) REFERENCES `modelo` (`id_modelo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `inspecciones`
--
ALTER TABLE `inspecciones`
  ADD CONSTRAINT `inspecciones_ibfk_1` FOREIGN KEY (`id_puerto`) REFERENCES `puertos` (`id_puerto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inspecciones_ibfk_2` FOREIGN KEY (`id_barco`) REFERENCES `embarcaciones` (`id_barco`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `navegantes`
--
ALTER TABLE `navegantes`
  ADD CONSTRAINT `navegantes_ibfk_1` FOREIGN KEY (`id_barco`) REFERENCES `embarcaciones` (`id_barco`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_producto` (`id_tipo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `producto_ibfk_3` FOREIGN KEY (`id_barco`) REFERENCES `embarcaciones` (`id_barco`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
