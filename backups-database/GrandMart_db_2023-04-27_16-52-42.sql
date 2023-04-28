CREATE DATABASE IF NOT EXISTS `grandmart_db`;

USE `grandmart_db`;

DROP TABLE IF EXISTS `carrito_compra_detalles`;
CREATE TABLE `carrito_compra_detalles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_producto` bigint(20) unsigned DEFAULT NULL,
  `id_carrito_compra` bigint(20) unsigned DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `carrito_compra_detalles_FK` (`id_producto`),
  KEY `carrito_compra_detalles_FK_1` (`id_carrito_compra`),
  CONSTRAINT `carrito_compra_detalles_FK` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  CONSTRAINT `carrito_compra_detalles_FK_1` FOREIGN KEY (`id_carrito_compra`) REFERENCES `carritos_compras` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `carritos_compras`;
CREATE TABLE `carritos_compras` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fecha_creacion` date NOT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `carritos_compras_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `id_parent` bigint(20) unsigned DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_categoria` (`id_parent`),
  CONSTRAINT `categorias_ibfk_1` FOREIGN KEY (`id_parent`) REFERENCES `categorias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `comentariosblogs`;
CREATE TABLE `comentariosblogs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comentario` text COLLATE utf8_spanish2_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_publicacionBlog` bigint(20) unsigned DEFAULT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_publicacionBlog` (`id_publicacionBlog`),
  KEY `comentariosblogs_FK` (`id_usuario`),
  CONSTRAINT `comentariosblogs_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `comentariosblogs_ibfk_1` FOREIGN KEY (`id_publicacionBlog`) REFERENCES `publicacionesblogs` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `datoscontactoservicios`;
CREATE TABLE `datoscontactoservicios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `telefono1` varchar(22) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono2` varchar(22) COLLATE utf8_spanish2_ci NOT NULL,
  `email` varchar(66) COLLATE utf8_spanish2_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_servicio` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_servicio` (`id_servicio`),
  CONSTRAINT `datoscontactoservicios_ibfk_1` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `direccion_envios`;
CREATE TABLE `direccion_envios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `estado` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish2_ci,
  `nombre_ine` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `calle2` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `calle` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `postal` varchar(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `colonia` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `numeroInterior` varchar(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `calle1` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `municipio_alcaldia` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `numeroExterior` varchar(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_orden` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `direccion_envios_FK` (`id_orden`),
  CONSTRAINT `direccion_envios_FK` FOREIGN KEY (`id_orden`) REFERENCES `ordenes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `domiciliousuarios`;
CREATE TABLE `domiciliousuarios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_ine` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `postal` varchar(10) COLLATE utf8_spanish2_ci NOT NULL,
  `estado` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `municipio_alcaldia` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `colonia` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `calle` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `numeroExterior` varchar(10) COLLATE utf8_spanish2_ci NOT NULL,
  `numeroInterior` varchar(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `calle1` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `calle2` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8_spanish2_ci,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `domiciliousuarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `estado_pagos`;
CREATE TABLE `estado_pagos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_orden` bigint(20) unsigned NOT NULL,
  `pagado` tinyint(1) NOT NULL,
  `metodo_pago` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `referencia_pago` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `detalles_pago` text COLLATE utf8_spanish2_ci,
  `fecha_pago` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `estado_pagos_FK` (`id_orden`),
  CONSTRAINT `estado_pagos_FK` FOREIGN KEY (`id_orden`) REFERENCES `ordenes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `favoritosproductos`;
CREATE TABLE `favoritosproductos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_producto` bigint(20) unsigned DEFAULT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_producto` (`id_producto`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `favoritosproductos_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `favoritosproductos_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `imagenesblogs`;
CREATE TABLE `imagenesblogs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `es_portada` tinyint(1) NOT NULL,
  `id_publicacionBlog` bigint(20) unsigned NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_publicacionBlog` (`id_publicacionBlog`),
  CONSTRAINT `imagenesblogs_ibfk_1` FOREIGN KEY (`id_publicacionBlog`) REFERENCES `publicacionesblogs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `imagenesproductos`;
CREATE TABLE `imagenesproductos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `id_producto` bigint(20) unsigned NOT NULL,
  `es_portada` tinyint(1) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `imagenesproductos_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `imagenesservicios`;
CREATE TABLE `imagenesservicios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `es_portada` tinyint(1) NOT NULL,
  `id_servicio` bigint(20) unsigned NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_servicio` (`id_servicio`),
  CONSTRAINT `imagenesservicios_ibfk_1` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `imagenesusuarios`;
CREATE TABLE `imagenesusuarios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `es_portada` tinyint(1) NOT NULL,
  `id_usuario` bigint(20) unsigned NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `imagenesusuarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `mensajebuzons`;
CREATE TABLE `mensajebuzons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `motivo` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `descripcion` varchar(1500) COLLATE utf8_spanish2_ci NOT NULL,
  `fecha` date DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `mensajebuzons_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `orden_detalles`;
CREATE TABLE `orden_detalles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `id_producto` bigint(20) unsigned DEFAULT NULL,
  `id_orden` bigint(20) unsigned DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orden_detalles_FK` (`id_producto`),
  KEY `orden_detalles_FK_1` (`id_orden`),
  CONSTRAINT `orden_detalles_FK` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  CONSTRAINT `orden_detalles_FK_1` FOREIGN KEY (`id_orden`) REFERENCES `ordenes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `ordenes`;
CREATE TABLE `ordenes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `total` decimal(10,2) DEFAULT NULL,
  `estado_orden` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  `fechaEntrega` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `ordenes_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `preguntasproductos`;
CREATE TABLE `preguntasproductos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(1500) COLLATE utf8_spanish2_ci NOT NULL,
  `respuesta` varchar(2000) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_producto` bigint(20) unsigned DEFAULT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_producto` (`id_producto`),
  KEY `preguntasproductos_FK` (`id_usuario`),
  CONSTRAINT `preguntasproductos_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `preguntasproductos_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `preguntasservicios`;
CREATE TABLE `preguntasservicios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(1500) COLLATE utf8_spanish2_ci NOT NULL,
  `respuesta` varchar(2000) COLLATE utf8_spanish2_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_servicio` bigint(20) unsigned DEFAULT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_servicio` (`id_servicio`),
  CONSTRAINT `preguntasservicios_ibfk_1` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `precio` double(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` text COLLATE utf8_spanish2_ci,
  `marca` varchar(60) COLLATE utf8_spanish2_ci NOT NULL,
  `modelo` varchar(60) COLLATE utf8_spanish2_ci NOT NULL,
  `color` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `id_categoria` bigint(20) unsigned NOT NULL,
  `id_usuario` bigint(20) unsigned NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_categoria` (`id_categoria`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `publicacionesblogs`;
CREATE TABLE `publicacionesblogs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish2_ci,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `publicacionesblogs_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `reviewsproductos`;
CREATE TABLE `reviewsproductos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `comentario` text COLLATE utf8_spanish2_ci,
  `calificacion` smallint(6) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_producto` bigint(20) unsigned DEFAULT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_producto` (`id_producto`),
  KEY `reviewsproductos_FK` (`id_usuario`),
  CONSTRAINT `reviewsproductos_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `reviewsproductos_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `reviewsservicios`;
CREATE TABLE `reviewsservicios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `comentario` text COLLATE utf8_spanish2_ci NOT NULL,
  `calificacion` smallint(6) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_servicio` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_servicio` (`id_servicio`),
  CONSTRAINT `reviewsservicios_ibfk_1` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `servicios`;
CREATE TABLE `servicios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(60) COLLATE utf8_spanish2_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish2_ci,
  `precio` double(10,2) NOT NULL,
  `id_categoria` bigint(20) unsigned NOT NULL,
  `id_usuario` bigint(20) unsigned NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_categoria` (`id_categoria`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `servicios_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `servicios_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `ubicacionesservicios`;
CREATE TABLE `ubicacionesservicios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `estado` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `municipio_alcaldia` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `colonia` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `calle` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `numeroExterior` varchar(5) COLLATE utf8_spanish2_ci NOT NULL,
  `numeroInterior` varchar(5) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8_spanish2_ci,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_servicio` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_servicio` (`id_servicio`),
  CONSTRAINT `ubicacionesservicios_ibfk_1` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `apellidoPaterno` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `apellidoMaterno` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `email` varchar(66) COLLATE utf8_spanish2_ci NOT NULL,
  `sexo` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `telefono` varchar(22) COLLATE utf8_spanish2_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `tipoUsuario` tinyint(1) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

INSERT INTO `carrito_compra_detalles` (`id`, `id_producto`, `id_carrito_compra`, `cantidad`, `createdAt`, `updatedAt`) VALUES
(60, 85, 6, 1, '2023-04-19 19:27:03', '2023-04-19 19:27:03'),
(61, 92, 6, 1, '2023-04-19 19:27:08', '2023-04-19 19:27:08'),
(62, 98, 7, 3, '2023-04-27 07:11:20', '2023-04-27 09:56:20'),
(63, 89, 7, 1, '2023-04-27 07:11:44', '2023-04-27 07:25:49'),
(65, 92, 7, 1, '2023-04-27 07:24:26', '2023-04-27 07:24:26'),
(69, 98, 8, 1, '2023-04-27 08:44:53', '2023-04-27 08:44:53'),
(70, 91, 7, 1, '2023-04-27 09:56:29', '2023-04-27 09:56:29');

INSERT INTO `carritos_compras` (`id`, `fecha_creacion`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(6, '2023-04-19', 76, '2023-04-19 19:27:03', '2023-04-19 19:27:03'),
(7, '2023-04-27', 74, '2023-04-27 07:11:20', '2023-04-27 07:11:20'),
(8, '2023-04-27', 78, '2023-04-27 08:44:52', '2023-04-27 08:44:52');

INSERT INTO `categorias` (`id`, `nombre`, `id_parent`, `createdAt`, `updatedAt`) VALUES
(25, 'Tecnología', NULL, '2023-03-15 17:36:07', '2023-03-16 09:39:15'),
(26, 'Entretenimiento', NULL, '2023-03-15 17:36:19', '2023-03-15 20:08:52'),
(27, 'Consultoría', NULL, '2023-03-15 17:36:30', '2023-03-15 20:09:10'),
(28, 'Salud', NULL, '2023-03-15 17:39:17', '2023-03-15 20:09:20'),
(29, 'Movilidad', NULL, '2023-03-15 19:43:45', '2023-03-15 20:09:34'),
(30, 'Enseñanza  Aprendizaje', NULL, '2023-03-15 19:44:03', '2023-03-15 20:10:46'),
(31, 'Mascotas', NULL, '2023-03-15 19:50:43', '2023-03-15 20:11:01'),
(32, 'Vivienda', NULL, '2023-03-15 19:50:56', '2023-03-15 20:11:18'),
(33, 'Emprendimientos', NULL, '2023-03-15 20:11:38', '2023-03-15 20:11:38'),
(34, 'Belleza', NULL, '2023-03-15 20:11:45', '2023-03-15 20:11:45'),
(35, 'Caprichos y cariños', NULL, '2023-03-15 20:11:57', '2023-03-15 20:12:22'),
(36, 'Aparatos funcionales', NULL, '2023-03-15 20:12:34', '2023-03-15 20:12:34'),
(37, 'Moda', NULL, '2023-03-15 20:12:55', '2023-03-15 20:12:55'),
(50, 'Donaciones', NULL, '2023-04-11 14:49:33', '2023-04-11 14:49:33'),
(51, 'Computación', 25, '2023-04-11 14:54:25', '2023-04-11 14:54:25'),
(52, 'Comunicación', 25, '2023-04-11 14:54:35', '2023-04-11 14:54:35'),
(53, 'Gadgets Accesorios', 25, '2023-04-11 14:54:48', '2023-04-11 14:55:16'),
(54, 'CCTV', 25, '2023-04-11 14:55:02', '2023-04-11 14:55:02'),
(55, 'Asesoría', 25, '2023-04-11 14:55:24', '2023-04-11 14:55:38'),
(56, 'Instalaciones', 25, '2023-04-11 14:55:33', '2023-04-11 14:55:44'),
(57, 'Atención Médica General y Especializada', 28, '2023-04-11 14:56:27', '2023-04-11 14:56:27'),
(58, 'Hospitalización', 28, '2023-04-11 14:56:54', '2023-04-11 14:56:54'),
(59, 'Rehabilitación', 28, '2023-04-11 14:57:12', '2023-04-11 14:57:12'),
(60, 'Fisioterapia', 28, '2023-04-11 14:57:46', '2023-04-11 14:57:46'),
(61, 'Nutrición', 28, '2023-04-11 14:58:32', '2023-04-11 14:58:32'),
(62, 'Deportes', 28, '2023-04-11 14:58:51', '2023-04-11 14:58:51'),
(63, 'Movilidad/Marcha/Autonomía', 36, '2023-04-11 14:59:31', '2023-04-11 14:59:31'),
(64, 'Audición', 36, '2023-04-11 14:59:57', '2023-04-11 14:59:57'),
(65, 'Visión', 36, '2023-04-11 15:00:10', '2023-04-11 15:00:10'),
(66, 'Accesorios para Mascotas', 31, '2023-04-11 16:03:02', '2023-04-11 16:03:02');

INSERT INTO `comentariosblogs` (`id`, `comentario`, `createdAt`, `updatedAt`, `id_publicacionBlog`, `id_usuario`) VALUES
(1, 'rfgdfg', '2023-04-10 04:01:59', '2023-04-10 04:01:59', NULL, 74),
(2, 'x', '2023-04-10 04:04:21', '2023-04-10 04:04:21', NULL, 74),
(3, 'sd', '2023-04-10 12:28:51', '2023-04-10 12:28:51', NULL, 74),
(4, 'sd', '2023-04-10 12:37:00', '2023-04-10 12:37:00', NULL, 74),
(5, 'sd', '2023-04-10 12:37:03', '2023-04-10 12:37:03', NULL, 74),
(6, 'dsad', '2023-04-10 16:00:19', '2023-04-10 16:00:19', NULL, 74),
(7, 'sdasd', '2023-04-10 16:00:36', '2023-04-10 16:00:36', NULL, 65),
(8, 'asd', '2023-04-10 16:00:38', '2023-04-10 16:00:38', NULL, 65),
(9, 'rgerg', '2023-04-10 16:16:23', '2023-04-10 16:16:23', NULL, 65),
(10, 'fgbgfb', '2023-04-12 08:42:13', '2023-04-12 08:42:13', NULL, 65),
(11, 'wefwef', '2023-04-12 14:43:37', '2023-04-12 14:43:37', NULL, 65),
(12, 'wefewf', '2023-04-12 14:43:40', '2023-04-12 14:43:40', NULL, 65),
(13, '', '2023-04-12 14:56:14', '2023-04-12 14:56:14', NULL, 65),
(14, '?', '2023-04-12 22:24:02', '2023-04-12 22:24:02', NULL, 65),
(15, 'aZZAzAZ', '2023-04-12 22:27:06', '2023-04-12 22:27:06', NULL, 65),
(16, 'SAs', '2023-04-12 22:29:17', '2023-04-12 22:29:17', NULL, 65),
(17, 'webos', '2023-04-12 22:59:06', '2023-04-12 22:59:06', NULL, 65),
(18, 'saaS', '2023-04-13 23:36:08', '2023-04-13 23:36:08', 58, 65),
(19, 'asaS', '2023-04-13 23:36:12', '2023-04-13 23:36:12', 51, 65),
(20, 'sadasd', '2023-04-19 19:25:05', '2023-04-19 19:25:05', 58, 74);

INSERT INTO `direccion_envios` (`id`, `estado`, `descripcion`, `nombre_ine`, `calle2`, `calle`, `postal`, `colonia`, `numeroInterior`, `calle1`, `municipio_alcaldia`, `numeroExterior`, `createdAt`, `updatedAt`, `id_orden`) VALUES
(1, 'wef', 'wef', 'ewfwef', 'wef', 'wef', 'wef', 'wef', 'wef', 'wef', 'wef', 'wef', '2023-04-21 17:52:40', '2023-04-21 17:52:40', NULL),
(2, 'wef', 'wef', 'ewfwef', 'wef', 'wef', 'wef', 'wef', 'wef', 'wef', 'wef', 'wef', '2023-04-21 17:54:31', '2023-04-21 17:54:31', NULL),
(3, 'estado', 'descripcion', 'ine', 'calle 2', 'calle', 'postal', 'colonia', 'numero int', 'calle 1', 'municipio', 'numero ex', '2023-04-21 19:03:01', '2023-04-21 19:03:01', 14),
(4, 'estado', 'descripcion', 'ine', 'calle 2', 'calle', 'postal', 'colonia', 'numero int', 'calle 1', 'municipio', 'numero ex', '2023-04-21 21:53:00', '2023-04-21 21:53:00', 34),
(5, 'estado', 'descripcion', 'ine', 'calle 2', 'calle', 'postal', 'colonia', 'numero int', 'calle 1', 'municipio', 'numero ex', '2023-04-23 08:29:39', '2023-04-23 08:29:39', 35);

INSERT INTO `domiciliousuarios` (`id`, `nombre_ine`, `postal`, `estado`, `municipio_alcaldia`, `colonia`, `calle`, `numeroExterior`, `numeroInterior`, `calle1`, `calle2`, `descripcion`, `createdAt`, `updatedAt`, `id_usuario`) VALUES
(16, 'oaijsidjasiodj', 'daskmd', 'dspjkdqjk', 'sapjs', 'k', 'xpksk', 'p', 'kwk', 'xpokspk', 'dasd', 'ada', '2023-03-30 20:17:18', '2023-03-30 20:17:18', NULL),
(18, 'ewrewr', 'wer', 'wer', 'er', '', 'wer', 'wer', 'ewr', 'wer', 'wr', 'wer', '2023-04-01 15:44:58', '2023-04-01 15:45:04', 65),
(19, 'ine', 'postal', 'estado', 'municipio', 'colonia', 'calle', 'numero ex', 'numero int', 'calle 1', 'calle 2', 'descripcion', '2023-04-21 17:26:50', '2023-04-21 17:26:50', 74);

INSERT INTO `favoritosproductos` (`id`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(2, '2023-04-16 11:04:13', '2023-04-16 11:04:13', 88, 77),
(3, '2023-04-17 13:27:10', '2023-04-17 13:27:10', 88, 65),
(4, '2023-04-17 13:27:41', '2023-04-17 13:27:41', 89, 65),
(5, '2023-04-18 16:00:43', '2023-04-18 16:00:43', 91, 77),
(6, '2023-04-18 16:02:38', '2023-04-18 16:02:38', 92, 77),
(7, '2023-04-18 21:17:13', '2023-04-18 21:17:13', 93, 77),
(14, '2023-04-27 07:43:21', '2023-04-27 07:43:21', 86, 74),
(15, '2023-04-27 07:45:09', '2023-04-27 07:45:09', 88, 74),
(16, '2023-04-27 07:48:31', '2023-04-27 07:48:31', 98, 74),
(17, '2023-04-27 08:44:52', '2023-04-27 08:44:52', 98, 78),
(18, '2023-04-27 09:56:29', '2023-04-27 09:56:29', 91, 74);

INSERT INTO `imagenesblogs` (`id`, `url`, `es_portada`, `id_publicacionBlog`, `createdAt`, `updatedAt`) VALUES
(4, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F24bca0f6-8fec-41d9-b386-6462c35b2374_6b251679-7d09-4ca6-ae23-abaa381af9d6?alt=media&token=73439fc4-12bf-4d55-a28b-dc375cc46d09', 1, 51, '2023-04-13 22:06:55', '2023-04-13 22:06:55'),
(5, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F24bca0f6-8fec-41d9-b386-6462c35b2374_422a459f-fdc5-4556-9ae9-580038fb6d58?alt=media&token=9e0b7a06-c3ce-4fe7-abe7-00c87ef456f7', 0, 51, '2023-04-13 22:06:55', '2023-04-13 22:06:55'),
(6, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F24bca0f6-8fec-41d9-b386-6462c35b2374_cbada0d4-395a-45d3-92b0-e4952d4cfdc5?alt=media&token=7451a7ac-863e-43df-874f-325ba92e6496', 0, 51, '2023-04-13 22:06:55', '2023-04-13 22:06:55'),
(16, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Fdf42e19a-652c-4f4d-a798-ebb644c6db97_1b591166-a680-4b85-bcb8-2e7003ef0a59?alt=media&token=214cfd18-9e71-4bac-b894-3434d9edf513', 1, 58, '2023-04-13 23:36:00', '2023-04-13 23:36:00'),
(17, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Fd1be7f53-6f01-49e7-bf10-1bb002cecbc2_0d1d314b-e43c-4dc2-a852-d4c28dc3adba?alt=media&token=a419b343-90b1-4503-b9ef-a8880fc03b8c', 1, 59, '2023-04-13 23:36:23', '2023-04-13 23:36:23'),
(18, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Feff98e69-5823-4929-80cb-468f6a006174_26a3f2bd-d22f-4cad-a64e-c9cca789780a?alt=media&token=d675350d-7c45-4fae-8762-827d72c89ac0', 1, 60, '2023-04-13 23:36:29', '2023-04-13 23:36:29'),
(19, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Fa768a564-032e-461e-ade9-8c1c8892dda5_b85b93c3-e141-484d-b52f-c6299d9a344f?alt=media&token=6378f545-b530-4d40-b109-e3df6ed25333', 0, 61, '2023-04-14 01:27:27', '2023-04-14 01:27:27'),
(20, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Fa768a564-032e-461e-ade9-8c1c8892dda5_a3b77a69-8c8c-4ecc-a361-b002ec6fa68a?alt=media&token=4069d5ab-beaf-4f56-9475-098ad991037a', 1, 61, '2023-04-14 01:27:27', '2023-04-14 01:27:27'),
(21, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Fa768a564-032e-461e-ade9-8c1c8892dda5_732c7039-43e4-4b78-b19d-27835a1c0c0b?alt=media&token=c243887d-eac6-4643-bc58-e1f6dfa23e3a', 0, 61, '2023-04-14 01:27:27', '2023-04-14 01:27:27'),
(22, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F25df2de7-f0b6-4cfd-af28-0a263f9c5d7a_db2ba41f-f1f8-4ff5-93d4-3cffaff9f011?alt=media&token=f04ec840-40ef-43b6-abec-8656fb7a44ed', 0, 62, '2023-04-14 01:28:18', '2023-04-14 01:28:18'),
(23, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F25df2de7-f0b6-4cfd-af28-0a263f9c5d7a_8c4c0537-fc7f-4541-9675-283d93753a1a?alt=media&token=1c556f4f-762d-4fb9-adba-c84b12778b98', 1, 62, '2023-04-14 01:28:18', '2023-04-14 01:28:18'),
(24, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Fed016f2a-9ed6-44ab-b583-9ecafc2bcebc_81d8015f-b834-4836-b8b5-0b364167563b?alt=media&token=cbf29356-2f18-4d77-bce0-8def217ad932', 1, 63, '2023-04-14 01:29:56', '2023-04-14 01:29:56'),
(25, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Fb9b68e77-6d07-4fb8-8dcd-6fea53a32cfd_dc7da56e-db66-42d3-884e-227cb6fbadde?alt=media&token=b1b5e915-e88e-4dc6-878f-d66b758e3a3e', 1, 64, '2023-04-14 01:31:25', '2023-04-14 01:31:25'),
(26, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F682d2cb3-28e6-4880-bca0-131c331b7591_aed1a330-c1c1-4fd3-9130-055be8f18a1c?alt=media&token=c1d4ffa0-a6f3-4052-8f84-6665e06b8562', 1, 65, '2023-04-14 01:32:19', '2023-04-14 01:32:19'),
(27, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F3da43317-e218-4d9c-8c5c-25fa6a525a13_552e502a-0734-4262-8cbb-55330ab07759?alt=media&token=53e865ed-a35b-41fc-a58d-949cb9a8fc22', 1, 66, '2023-04-14 01:58:11', '2023-04-14 01:58:11'),
(28, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F4cf3c7b0-ef3d-4c2a-b468-d2c0a4e4e0aa_95471805-c75d-4f3d-ad70-ab82b44ea767?alt=media&token=073283b5-dbb6-4833-9e01-823dd5a0de71', 1, 67, '2023-04-14 02:01:10', '2023-04-14 02:01:10'),
(29, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Fccb5c4f5-36a2-4d6e-9f06-042cbd40928f_511719ef-d0db-4f42-9fff-bb0ceaed43cd?alt=media&token=be8ddd94-52a9-47ea-be99-5c4a0b77711f', 1, 68, '2023-04-14 02:03:31', '2023-04-14 02:03:31'),
(30, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F72425467-6188-4f1c-ba25-93d7cbe3b0c8_8a295a68-f27f-4eba-9ef6-b482a20d124f?alt=media&token=aa452fdf-b99b-4376-82c6-e1c0e95936f5', 1, 69, '2023-04-14 02:03:59', '2023-04-14 02:03:59'),
(31, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F9ac8d3d6-f91f-4944-8a73-85eb1d72ce86_25e478ca-528c-4ebf-9307-8f52b66e0b7b?alt=media&token=99bf7b01-d35b-4492-9a12-4ebde73e1d10', 1, 70, '2023-04-14 03:03:38', '2023-04-14 03:03:38'),
(32, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Fd1cad974-58f1-4697-b2f6-db2f3902df53_49b69c68-0fe2-495d-a708-8b450ad406cd?alt=media&token=0ce723bc-a9d3-48a3-858f-bac8df162685', 1, 71, '2023-04-14 03:07:42', '2023-04-14 03:07:42'),
(33, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Ffe5f07a8-3a1d-4ce1-b31a-12673b27272f_7f5138e4-4cbc-4427-b7a7-1968b0847204?alt=media&token=42310c23-6d71-42f3-8fe8-1d3bc60719f3', 1, 72, '2023-04-14 03:07:59', '2023-04-14 03:07:59'),
(34, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Ffe5f07a8-3a1d-4ce1-b31a-12673b27272f_db349493-1324-4f65-8a8c-69adfd27ef94?alt=media&token=0943d332-c590-4dd0-b95b-44dd468e40b5', 0, 72, '2023-04-14 03:07:59', '2023-04-14 03:07:59'),
(35, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Ffe5f07a8-3a1d-4ce1-b31a-12673b27272f_887044fd-03a3-48ad-a7dc-2cf6a49af14e?alt=media&token=1b9fc61e-5d08-40f8-9c3d-86a191b821d1', 0, 72, '2023-04-14 03:07:59', '2023-04-14 03:07:59'),
(36, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Fb84f0ccb-40cf-4d21-970c-6cd7f7791b5b_377bd322-9f9b-4d07-8acf-0cb8f2e6ac14?alt=media&token=987cd732-4e6a-404d-8e50-5a01192ea0d2', 1, 73, '2023-04-14 03:09:21', '2023-04-14 03:09:21'),
(37, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F6a05e65b-a46f-4012-ba97-e40544e84ac8_0eef3459-c3e9-4914-9968-e9bd9ab404c0?alt=media&token=cb3808e3-081b-4e63-ad8c-69d61b7c93c5', 1, 74, '2023-04-14 03:13:39', '2023-04-14 03:13:39'),
(38, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Fc45b0df9-94ae-4a33-bfd5-84cb2aeda34c_1c9243fd-53c3-4df6-a47f-dd056fc8ad95?alt=media&token=6ea1661b-1de4-430f-b475-9271f8003b37', 1, 75, '2023-04-14 03:14:49', '2023-04-14 03:14:49'),
(39, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Fc1a22a46-01c4-42ea-b866-1557a0769816_fc2fc2f9-484b-45d3-87bb-702a9f9e8ae0?alt=media&token=d86e100e-41d4-4b71-a5b5-85d8dc3fea7c', 1, 76, '2023-04-14 03:14:54', '2023-04-14 03:14:54'),
(40, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F0a8b16d8-11fc-4de8-aaa2-b9bf37738431_1583fdc1-35b8-403d-857a-307918e8beb4?alt=media&token=b9b91afe-fcf1-4bef-af11-0ac7921f90d1', 1, 77, '2023-04-14 03:30:45', '2023-04-14 03:30:45');

INSERT INTO `imagenesproductos` (`id`, `url`, `id_producto`, `es_portada`, `createdAt`, `updatedAt`) VALUES
(113, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Ff2a47766-3410-4001-b6ae-3cff17bcb991_477aa1f9-3af4-42f4-8a6c-4cfecbae7fc3?alt=media&token=37826744-50ff-4b35-9add-b59403ad7bac', 84, 1, '2023-04-11 15:19:07', '2023-04-11 15:19:07'),
(114, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F59a0280d-b40c-4f9b-baa9-4b160bb1682c_393bb60e-2b47-4394-87d5-9712612b1144?alt=media&token=e62e15be-db35-464c-abfd-51762b661d41', 84, 0, '2023-04-11 15:19:07', '2023-04-11 15:19:07'),
(115, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F59a0280d-b40c-4f9b-baa9-4b160bb1682c_fc0137c1-d0a5-41e7-b77e-12656d8a6cd1?alt=media&token=88c7fb34-2584-4fba-91dd-ce604a09c642', 84, 0, '2023-04-11 15:19:07', '2023-04-11 15:19:07'),
(116, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F5345f0ae-13ee-4606-bd61-67a377257464_adbcc6eb-3590-49fe-95a5-590184a65663?alt=media&token=31d31140-98f7-47e9-9c4f-a56ec81ab41c', 85, 1, '2023-04-11 15:32:39', '2023-04-11 15:32:39'),
(117, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F4cd7d137-9e83-4676-8f85-416cbd4d6506_cedef48f-f657-4e68-a380-b549222aeceb?alt=media&token=128117b5-b3b0-4431-8297-2de26bf1e4d0', 85, 0, '2023-04-11 15:32:39', '2023-04-11 15:32:39'),
(118, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F4cd7d137-9e83-4676-8f85-416cbd4d6506_805262c5-5404-4d8e-be07-4357d7aa9aaf?alt=media&token=bcb7bf38-dedd-4543-903d-d0ac54683bed', 85, 0, '2023-04-11 15:32:39', '2023-04-11 15:32:39'),
(119, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F4cd7d137-9e83-4676-8f85-416cbd4d6506_56c8992b-8fe3-460f-857b-052444653302?alt=media&token=acc5d088-128f-4eda-8426-a37362085ee8', 85, 0, '2023-04-11 15:32:39', '2023-04-11 15:32:39'),
(120, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Fd413cd9e-a163-4f67-a212-476d9b76bb5a_0c5bf523-edff-4438-8eb4-be6a8fce1b66?alt=media&token=c8d0bc28-8b3e-4278-85c7-5b528eeb28a9', 86, 1, '2023-04-11 15:41:49', '2023-04-11 15:41:49'),
(121, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Fb4cfc228-f623-49c4-8152-6228527c5846_7e850653-e460-4674-a8e5-c8026a96459f?alt=media&token=04ad0055-ae53-4242-9855-b8c212947d8c', 86, 0, '2023-04-11 15:41:49', '2023-04-11 15:41:49'),
(122, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Fb4cfc228-f623-49c4-8152-6228527c5846_92d10b69-d0b9-44b9-8502-b7a4b920393f?alt=media&token=6c91364b-c8df-4a8f-a7a2-9896aeb8fa7e', 86, 0, '2023-04-11 15:41:49', '2023-04-11 15:41:49'),
(123, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F1b82fb96-e40f-45a8-9dd2-5bda004edeec_ab59492e-3ec1-4686-b13f-273e6f5b85ab?alt=media&token=e611aa68-d6a6-4797-a319-7dd60035707f', 87, 1, '2023-04-11 15:45:46', '2023-04-11 15:45:46'),
(124, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F6e5f00b4-3615-4ad9-bc02-d60a9b1d63e1_09ef22dd-82f7-47e1-8701-66ccedfa5eb8?alt=media&token=3994f328-335b-47e0-a4f8-d3aea300985b', 87, 0, '2023-04-11 15:45:46', '2023-04-11 15:45:46'),
(125, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F6e5f00b4-3615-4ad9-bc02-d60a9b1d63e1_90e36124-6caf-421a-ab2f-0fc3988cc342?alt=media&token=8e180afa-0d78-488f-a76c-bb3f311ce81e', 87, 0, '2023-04-11 15:45:46', '2023-04-11 15:45:46'),
(126, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F6e5f00b4-3615-4ad9-bc02-d60a9b1d63e1_89683c7d-bbc9-4457-850e-6a8ad494a1be?alt=media&token=678284a2-41e2-4f22-a28b-1d7dfe652cf3', 87, 0, '2023-04-11 15:45:46', '2023-04-11 15:45:46'),
(127, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Faab7edaf-bd78-4b54-99c7-2a7eab20ee9d_c2c53a87-9663-482e-b076-917aa140a6cf?alt=media&token=a84d940f-c82d-4241-bdce-af7be815733e', 88, 1, '2023-04-11 15:49:25', '2023-04-11 15:49:25'),
(128, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F71d0c1d5-4e04-4fc5-8af9-c144479b15c8_64ae28fa-2d16-468f-b375-aebb391f3ecd?alt=media&token=085e8ce2-9217-48a7-9baf-34ec87b82855', 88, 0, '2023-04-11 15:49:25', '2023-04-11 15:49:25'),
(129, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F71d0c1d5-4e04-4fc5-8af9-c144479b15c8_334b78e2-95c5-4899-a80f-a45917128af5?alt=media&token=91fce7ce-a394-4742-a1f2-f69b10664510', 88, 0, '2023-04-11 15:49:25', '2023-04-11 15:49:25'),
(130, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F71d0c1d5-4e04-4fc5-8af9-c144479b15c8_8a2886c3-d07b-45e0-a561-8a9e8c9b6c84?alt=media&token=c81d9c62-57f8-46c7-8ac9-3c08e7148ec2', 88, 0, '2023-04-11 15:49:25', '2023-04-11 15:49:25'),
(131, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F5c48ae2f-fb2d-48da-baeb-620c26803919_81a39b90-7dc2-46ca-820d-431aef0b6259?alt=media&token=65e32008-7118-4079-af98-dcd332d3c8ed', 89, 1, '2023-04-11 15:51:19', '2023-04-11 15:51:19'),
(132, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F0f11b11b-ea37-49d5-a60a-df01d96b0768_3c4ed077-fae5-4099-ba26-d354d161301d?alt=media&token=98b05f7f-2666-4fdb-a3ac-bfcc0329c1ae', 89, 0, '2023-04-11 15:51:19', '2023-04-11 15:51:19'),
(133, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F0f11b11b-ea37-49d5-a60a-df01d96b0768_3c512f5d-c66a-4464-953b-a18b135c15d2?alt=media&token=31d89623-97f7-4bd0-924d-eeb0a21162a7', 89, 0, '2023-04-11 15:51:19', '2023-04-11 15:51:19'),
(134, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Ff08348a3-7a01-4fcd-ad8f-37d816e8365d_0314619a-ccf9-42ca-bd46-8d63c8df1efd?alt=media&token=70b85f7b-f726-4a29-b7d4-8bed97c84ae0', 90, 1, '2023-04-11 15:57:09', '2023-04-11 15:57:09'),
(135, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F73312ea7-9252-4121-b369-e6c14db227fa_808fb445-bc13-4ae1-83a0-5fcb6d3eae35?alt=media&token=8f437fa3-17f3-4bbe-80cc-ff2c7d994655', 90, 0, '2023-04-11 15:57:09', '2023-04-11 15:57:09'),
(136, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F73312ea7-9252-4121-b369-e6c14db227fa_8fd84a12-92c8-424c-a9f2-571e1ff4508b?alt=media&token=38a787f5-afec-40ec-b9bb-ce3d35553658', 90, 0, '2023-04-11 15:57:10', '2023-04-11 15:57:10'),
(137, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F743cae5b-d478-4b14-b4ee-2ae376d60114_601d7874-03e4-4a43-97c2-eafc8e521a1d?alt=media&token=fe026e68-8328-4a48-ad57-157fb6094bf1', 91, 1, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(138, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F0d168260-0b78-4ebc-93b6-2b633d202161_b8ebc6ad-c715-4c62-b362-5dec871d1d11?alt=media&token=ff10633e-e38a-48d5-b3dd-99a92650c7b2', 91, 0, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(139, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F0d168260-0b78-4ebc-93b6-2b633d202161_e4e18b16-529b-4261-bdf9-8b36afcc3e5f?alt=media&token=1b05d6a9-9ecf-42bd-a85f-547b68d89d18', 91, 0, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(140, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F0d168260-0b78-4ebc-93b6-2b633d202161_9b704ac1-8ac3-49b5-ab7a-ecbdbe200955?alt=media&token=39ce7572-aee9-48c4-a207-008d14a2d10e', 91, 0, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(141, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F3b76336c-10a0-47ae-9bda-0f29c0e99c4d_ec54a85d-8dbf-4364-8256-aaa221cc8f59?alt=media&token=5ac78830-608f-40c2-be23-ca7f97eb3574', 92, 1, '2023-04-11 16:04:48', '2023-04-11 16:04:48'),
(142, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Fa1560457-bd4f-4772-9853-5703d9ff0d83_636483e1-921b-4e03-b6fa-739fa9ea2c4c?alt=media&token=41555e49-8723-49e3-81e5-d20e5fe806fc', 92, 0, '2023-04-11 16:04:48', '2023-04-11 16:04:48'),
(143, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F2ce4c440-43c3-4a10-9822-5ebd0faf8ebf_9609e7b4-3d0c-4e55-a7ec-1a304f590484?alt=media&token=15ec4d3c-1cb2-49d6-bc1f-dfa51eebcfdb', 93, 1, '2023-04-11 16:06:33', '2023-04-11 16:06:33'),
(144, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F76cc811a-7f47-40ee-98ad-23720c4ec8f8_74120d6b-40a1-48fd-9ae3-9f93ae99dfe7?alt=media&token=e7445dae-878c-45e3-863a-b8377cc33dce', 93, 0, '2023-04-11 16:06:33', '2023-04-11 16:06:33'),
(145, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F76cc811a-7f47-40ee-98ad-23720c4ec8f8_ab555593-252d-49f4-a1f5-0512afd5c07f?alt=media&token=801d5ed9-89dc-4bd5-b614-b25d566d9047', 93, 0, '2023-04-11 16:06:33', '2023-04-11 16:06:33'),
(146, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Ff1d62e24-f349-4d60-9cd9-c08208153618_5025645e-e498-4f22-95f8-fe00979bc2e7?alt=media&token=9f125706-6290-4e91-a908-3a463a340db5', 96, 1, '2023-04-22 08:58:49', '2023-04-22 08:58:49'),
(147, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F1dc8529f-5a4d-4845-bcf6-d79c17aef808_74d2d54e-fbde-494c-bf58-dd95329d1fe7?alt=media&token=53c8b4f5-dd2c-464c-8d52-89608e1b6930', 96, 0, '2023-04-22 08:58:49', '2023-04-22 08:58:49'),
(148, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F91fb480c-fb4c-431a-87ad-f2504f221afd_8821db34-65af-4026-80ae-bf4e76e5d019?alt=media&token=1c9a3d78-213d-4477-a58a-c491bbde9c75', 97, 1, '2023-04-22 09:16:27', '2023-04-22 09:16:27'),
(149, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F9dcd1f81-0c6d-4082-9c4f-b062afa6bc36_b9ce7ee5-a9f1-4f16-ae30-ae63f0ec1190?alt=media&token=959d6495-2eb5-4537-9e21-a444f04a8be4', 97, 0, '2023-04-22 09:16:27', '2023-04-22 09:16:27'),
(150, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F2b0f211a-33c6-474a-a587-61c60308a9e1_a624e4d8-0f12-41fe-b2fc-874796a555cb?alt=media&token=a7ec6821-cd55-4477-8da7-01688af2940c', 98, 1, '2023-04-26 06:03:47', '2023-04-26 06:03:47'),
(151, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Ff86bd3ca-c966-42ac-8c40-fcb85e3dec67_5c2d5d54-b609-4136-97db-28642a4afd68?alt=media&token=929d34b9-a1b8-4ffe-be1c-2338af1bbdfb', 98, 0, '2023-04-26 06:03:47', '2023-04-26 06:03:47'),
(152, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Ff86bd3ca-c966-42ac-8c40-fcb85e3dec67_a108e2f0-a16e-4ac2-b51a-48fbbd4cd517?alt=media&token=1cf172d0-6e86-40b3-a206-dfd2cfd4a598', 98, 0, '2023-04-26 06:03:47', '2023-04-26 06:03:47'),
(153, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Ff86bd3ca-c966-42ac-8c40-fcb85e3dec67_dfaea414-e492-4b00-bb5c-3c0936499e9a?alt=media&token=dcdd0718-f0f9-44df-814b-61119d5758c8', 98, 0, '2023-04-26 06:03:47', '2023-04-26 06:03:47'),
(154, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Ff86bd3ca-c966-42ac-8c40-fcb85e3dec67_a61e5f46-bf14-4da0-96aa-870527e5345d?alt=media&token=037b0635-bf2c-43ab-b7bb-bbd8cb8218df', 98, 0, '2023-04-26 06:03:47', '2023-04-26 06:03:47'),
(155, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Ff86bd3ca-c966-42ac-8c40-fcb85e3dec67_4b7f9155-4171-4668-b2ad-1bb59b9627b2?alt=media&token=31ebc436-8c4c-4515-90bb-4559de345412', 98, 0, '2023-04-26 06:03:48', '2023-04-26 06:03:48'),
(156, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Ff86bd3ca-c966-42ac-8c40-fcb85e3dec67_c3fc4ed4-9014-452e-9011-00f736bfefa9?alt=media&token=fa55b62a-0e20-4390-88c8-f95229bd813b', 98, 0, '2023-04-26 06:03:48', '2023-04-26 06:03:48');

INSERT INTO `imagenesservicios` (`id`, `url`, `es_portada`, `id_servicio`, `createdAt`, `updatedAt`) VALUES
(1, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F192152ca-79bb-4222-8792-1b434363180b_8bcd045f-6a52-4698-a412-e35e8ff516be?alt=media&token=b3980858-bc82-4c57-bca4-b6b94fcb9f45', 1, 27, '2023-04-14 14:04:03', '2023-04-14 14:04:03'),
(2, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F192152ca-79bb-4222-8792-1b434363180b_d2893eb3-725b-407e-9b1a-b7c9751424ee?alt=media&token=f58a6a86-ec0a-4d0e-9524-3881e6bab360', 0, 27, '2023-04-14 14:04:03', '2023-04-14 14:04:03'),
(3, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F192152ca-79bb-4222-8792-1b434363180b_c320c21a-849c-4946-b5c3-d73cf0bb952c?alt=media&token=5f50003e-c4ce-47dd-a478-76af8311d0ae', 0, 27, '2023-04-14 14:04:03', '2023-04-14 14:04:03'),
(4, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F52ed716e-0a08-4e62-821d-5549def93b2c_6703765b-8689-43b9-92b7-fe4865976773?alt=media&token=de2b8b87-51eb-4668-a0b7-7aefa7d96dac', 1, 28, '2023-04-14 18:22:35', '2023-04-14 18:22:35'),
(5, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F52ed716e-0a08-4e62-821d-5549def93b2c_8e692b14-a9b7-40b4-98df-792bdf869295?alt=media&token=24055f51-ffc3-44e1-b662-114bfe431387', 0, 28, '2023-04-14 18:22:35', '2023-04-14 18:22:35'),
(6, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F52ed716e-0a08-4e62-821d-5549def93b2c_b69b8530-3a1d-4cf6-a843-580ede5e7e93?alt=media&token=ed85e012-9e0e-4c69-952e-bb37eae6e09b', 0, 28, '2023-04-14 18:22:35', '2023-04-14 18:22:35'),
(7, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F187b0907-379d-401a-b213-c920ec5fdfbf_1e5c179d-52f0-4f18-a50c-e40f2a94bfe3?alt=media&token=a96fedf1-0fd0-4b9c-9daf-0a92d572ab32', 1, 28, '2023-04-14 18:23:36', '2023-04-14 18:23:36'),
(8, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Fa2a10d7a-2150-43d2-b53b-b1b089ee35c2_b15ec6fb-69c5-4ad9-bcdf-9e8be0d11fc6?alt=media&token=c8eefdbf-0206-45fc-823a-dbb668dc5b4b', 1, 29, '2023-04-22 08:59:31', '2023-04-22 08:59:31'),
(9, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F6c26f9ac-3818-4f73-a3b8-65b870bda65d_8826198d-d2a3-4842-9525-0a5f52af4aca?alt=media&token=73a4fd97-e708-4111-8627-9e0c5fb40d82', 1, 30, '2023-04-22 09:17:49', '2023-04-22 09:17:49'),
(10, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Fbaf0ad30-7950-43f7-88c6-c16487053f81_14972bc0-908f-421a-9826-637d7e971ab5?alt=media&token=65b44234-40f2-499c-8de8-865d4f28d864', 1, 31, '2023-04-23 01:54:56', '2023-04-23 01:54:56');

INSERT INTO `orden_detalles` (`id`, `cantidad`, `precio_unitario`, `id_producto`, `id_orden`, `createdAt`, `updatedAt`) VALUES
(15, 1, '100.00', 84, 14, '2023-04-20 17:18:49', '2023-04-20 17:18:49'),
(16, 1, '50.00', 85, 14, '2023-04-20 17:18:49', '2023-04-20 17:18:49'),
(17, 1, '150.00', 86, 14, '2023-04-20 17:18:49', '2023-04-20 17:18:49'),
(18, 1, '100.00', 84, 15, '2023-04-20 17:50:13', '2023-04-20 17:50:13'),
(19, 1, '50.00', 85, 15, '2023-04-20 17:50:13', '2023-04-20 17:50:13'),
(20, 1, '50.00', 88, 15, '2023-04-20 17:50:13', '2023-04-20 17:50:13'),
(21, 1, '60.00', 91, 15, '2023-04-20 17:50:13', '2023-04-20 17:50:13'),
(22, 3, '50.00', 85, 16, '2023-04-20 23:10:32', '2023-04-20 23:10:32'),
(23, 1, '100.00', 84, 16, '2023-04-20 23:10:32', '2023-04-20 23:10:32'),
(24, 1, '100.00', 84, 17, '2023-04-21 17:52:40', '2023-04-21 17:52:40'),
(25, 1, '50.00', 85, 17, '2023-04-21 17:52:41', '2023-04-21 17:52:41'),
(26, 1, '2000.00', 87, 18, '2023-04-21 17:54:31', '2023-04-21 17:54:31'),
(27, 1, '50.00', 88, 18, '2023-04-21 17:54:31', '2023-04-21 17:54:31'),
(28, 1, '80.00', 89, 18, '2023-04-21 17:54:31', '2023-04-21 17:54:31'),
(29, 1, '100.00', 84, 33, '2023-04-21 19:03:01', '2023-04-21 19:03:01'),
(30, 1, '50.00', 85, 33, '2023-04-21 19:03:01', '2023-04-21 19:03:01'),
(31, 1, '50.00', 85, 34, '2023-04-21 21:53:00', '2023-04-21 21:53:00'),
(32, 1, '100.00', 84, 34, '2023-04-21 21:53:00', '2023-04-21 21:53:00'),
(33, 1, '150.00', 86, 35, '2023-04-23 08:29:39', '2023-04-23 08:29:39'),
(34, 1, '50.00', 85, 35, '2023-04-23 08:29:40', '2023-04-23 08:29:40');

INSERT INTO `ordenes` (`id`, `total`, `estado_orden`, `id_usuario`, `fechaEntrega`, `createdAt`, `updatedAt`) VALUES
(14, '300.00', 'cancelado', 74, NULL, '2023-04-20 17:18:49', '2023-04-20 23:06:07'),
(15, '260.00', 'pendiente', 74, NULL, '2023-04-20 17:50:13', '2023-04-21 15:57:17'),
(16, '250.00', 'pendiente', 74, NULL, '2023-04-20 23:10:32', '2023-04-20 23:10:32'),
(17, '150.00', 'entregado', 74, NULL, '2023-04-21 17:52:40', '2023-04-21 20:36:56'),
(18, '2130.00', 'pendiente', 74, NULL, '2023-04-21 17:54:31', '2023-04-21 17:54:31'),
(19, '0.00', 'pendiente', 74, NULL, '2023-04-21 18:00:40', '2023-04-21 18:00:40'),
(20, '0.00', 'pendiente', 74, NULL, '2023-04-21 18:02:17', '2023-04-21 18:02:17'),
(21, '0.00', 'pendiente', 74, NULL, '2023-04-21 18:03:16', '2023-04-21 18:03:16'),
(22, '0.00', 'pendiente', 74, NULL, '2023-04-21 18:11:41', '2023-04-21 18:11:41'),
(23, '0.00', 'pendiente', 74, NULL, '2023-04-21 18:15:15', '2023-04-21 18:15:15'),
(24, '0.00', 'pendiente', 74, NULL, '2023-04-21 18:17:50', '2023-04-21 18:17:50'),
(25, '0.00', 'pendiente', 74, NULL, '2023-04-21 18:21:28', '2023-04-21 18:21:28'),
(26, '0.00', 'pendiente', 74, NULL, '2023-04-21 18:32:58', '2023-04-21 18:32:58'),
(27, '0.00', 'pendiente', 74, '2023-04-21 18:34:32', '2023-04-21 18:34:32', '2023-04-21 18:34:32'),
(28, '0.00', 'pendiente', 74, NULL, '2023-04-21 18:41:07', '2023-04-21 18:41:07'),
(29, '0.00', 'pendiente', 74, NULL, '2023-04-21 18:47:56', '2023-04-21 18:47:56'),
(30, '0.00', 'pendiente', 74, NULL, '2023-04-21 18:49:17', '2023-04-21 18:49:17'),
(31, '0.00', 'pendiente', 74, NULL, '2023-04-21 18:55:38', '2023-04-21 18:55:38'),
(32, '0.00', 'pendiente', 74, NULL, '2023-04-21 18:57:40', '2023-04-21 18:57:40'),
(33, '150.00', 'pendiente', 74, NULL, '2023-04-21 19:03:01', '2023-04-21 19:03:02'),
(34, '150.00', 'pendiente', 74, NULL, '2023-04-21 21:53:00', '2023-04-21 21:53:00'),
(35, '200.00', 'pendiente', 74, NULL, '2023-04-23 08:29:39', '2023-04-23 08:29:40');

INSERT INTO `preguntasproductos` (`id`, `pregunta`, `respuesta`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(1, 'Es muy pesada?', 'Ci', '2023-04-27 08:45:28', '2023-04-27 08:51:36', 98, 78);

INSERT INTO `productos` (`id`, `nombre`, `precio`, `stock`, `descripcion`, `marca`, `modelo`, `color`, `estado`, `id_categoria`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(84, 'Audífonos Amplificadores de Sonido', 100, 50, 'Los Audífonos Amplificadores de Sonido están diseñados especialmente para adultos mayores que tienen problemas de audición. Estos audífonos proporcionan una calidad de sonido clara y nítida, permitiendo una mejor audición y comunicación. Además, son cómodos de usar y fáciles de ajustar según las necesidades del usuario.', ' Amplifon', 'X Mini', 'Beige', 1, 64, 74, '2023-04-11 15:16:39', '2023-04-11 15:16:39'),
(85, 'Monitor de Presión Arterial', 50, 100, 'El Monitor de Presión Arterial es un producto esencial para adultos mayores que necesitan controlar su presión arterial. Este monitor es fácil de usar y proporciona mediciones precisas. Además, cuenta con una pantalla grande y fácil de leer, y puede almacenar las mediciones para un seguimiento a largo plazo.', 'Omron', 'BP742N', 'Blanco', 1, 65, 74, '2023-04-11 15:31:33', '2023-04-11 15:31:33'),
(86, 'Andador Plegable con Asiento', 150, 30, 'El Andador Plegable con Asiento es un producto ideal para adultos mayores que necesitan ayuda para caminar y descansar de vez en cuando. Este andador es fácil de usar y cuenta con un asiento cómodo y seguro. Además, se pliega para un fácil almacenamiento y transporte.', 'Drive Medical', 'Nitro DLX', 'Azul', 1, 59, 76, '2023-04-11 15:40:55', '2023-04-11 15:40:55'),
(87, 'Tablet para Adultos Mayores', 2000, 20, ' La Tablet para Adultos Mayores es una herramienta tecnológica diseñada especialmente para este grupo de edad. Cuenta con una interfaz de usuario fácil de usar y botones grandes para una navegación sencilla. Además, cuenta con aplicaciones útiles como un calendario, reloj, acceso a Internet y correo electrónico. También incluye soporte técnico para cualquier duda o problema.', 'GrandPad', 'GrandPad', 'Gris', 1, 51, 76, '2023-04-11 15:44:32', '2023-04-11 15:44:32'),
(88, 'Teléfono con Teclas Grandes', 50, 50, 'El Teléfono con Teclas Grandes es ideal para adultos mayores que necesitan un teléfono fácil de usar y leer. Cuenta con teclas grandes y de alto contraste, una pantalla grande y fácil de leer, y un volumen ajustable. Además, tiene funciones adicionales como identificador de llamadas y memoria para guardar números importantes.', 'Clarity', 'P300', 'Blanco', 1, 52, 76, '2023-04-11 15:48:23', '2023-04-11 15:48:23'),
(89, 'Pulsera Inteligente para Monitoreo de Actividad', 80, 30, ' La Pulsera Inteligente para Monitoreo de Actividad es un gadget útil para adultos mayores que desean monitorear su actividad física y salud. Cuenta con funciones como un podómetro, monitor de ritmo cardíaco y monitoreo de sueño. Además, puede conectarse a una aplicación móvil para obtener un seguimiento más detallado.', 'Fitbit', 'Inspire 2', 'Negro', 1, 53, 76, '2023-04-11 15:50:35', '2023-04-11 15:50:35'),
(90, 'Andador para Rehabilitación', 80, 25, 'El Andador para Rehabilitación es un dispositivo útil para adultos mayores que están en proceso de recuperación después de una lesión o cirugía. Cuenta con un diseño resistente y ajustable, y es fácil de usar. Además, tiene una bandeja de almacenamiento para llevar objetos pequeños.', 'Medline', 'MDS86410KDRB', 'Plata', 1, 59, 77, '2023-04-11 15:56:27', '2023-04-11 15:56:27'),
(91, 'Batidora para Smoothies Nutritivos', 60, 20, 'La Batidora para Smoothies Nutritivos es una herramienta útil para adultos mayores que desean mejorar su nutrición y salud en general. Es fácil de usar y limpiar, y cuenta con una potencia suficiente para triturar frutas y verduras. Además, incluye recetas y consejos para preparar smoothies saludables.', 'Nutribullet', 'NBR-0801', 'Gris', 1, 61, 65, '2023-04-11 15:59:01', '2023-04-11 15:59:01'),
(92, 'Collar para Perros', 10, 50, ' Este collar para perros es de alta calidad y está hecho con materiales duraderos. Viene en varios tamaños y colores, lo que lo hace adecuado para todo tipo de perros. Además, tiene una hebilla de liberación rápida para mayor seguridad.', '', '', '', 1, 66, 65, '2023-04-11 16:04:13', '2023-04-11 16:04:13'),
(93, 'Cinta de Correr para Ejercicio en Casa', 500, 5, 'La Cinta de Correr para Ejercicio en Casa es una herramienta útil para adultos mayores que desean mantenerse activos y saludables sin salir de casa. Es fácil de usar y ajustable, y cuenta con una variedad de programas de entrenamiento para diferentes niveles de condición física. Además, es plegable para un fácil almacenamiento.', 'ordicTrack', 'T 6.5 Si', 'Gris', 1, 62, 65, '2023-04-11 16:05:57', '2023-04-11 16:05:57'),
(94, 'ghy', 345, 435, 'sefse', '', 'ffsef', '', 1, 51, 65, '2023-04-12 15:02:58', '2023-04-12 15:02:58'),
(95, 'qweqwd', 34, 423, '', '', '', '', 1, 61, 65, '2023-04-13 20:23:31', '2023-04-13 20:23:31'),
(96, 'Silla de ruedas', 125, 11, 'Es un producto bueno jej', '', '', '', 1, 63, 74, '2023-04-22 08:57:40', '2023-04-22 08:57:40'),
(97, 'Control de playbox', 12, 1, 'Control de playbox', 'Microsoft', '', '', 1, 53, 78, '2023-04-22 09:11:52', '2023-04-22 09:11:52'),
(98, 'MEDICAL STORE Silla de Ruedas', 2349, 5, '? Silla de Ruedas para Adultos: La Elección de Materiales Durables, Al Igual que Su Estructura Reforzada Fabricada en Acero, Las Hace Altamente Resistentes.\n? Sillas de Ruedas para Adultos: Su asientos y respaldo esta tapizado en vinil de alta resistencia. Esta silla de ruedas es de la marca mas reconocida a nivel mundial DRIVE MEDICAL, reconocida por su lujo y su calidad.\n? Dimensiones de Sillas del paquete: Ancho: 68 cm. Alto: 86 cm. Largo: 105 cm Peso: 17.5 Kg, Soporta 110kg.\n? Silla de Ruedas Medical Store: Esta Silla de Ruedas con Descansapies Abatibles, es de la mas Alta en Calidad, con Acabados de Alta Resistencia, Brindándole una Silla Prácticamente para toda una Vida.\n? Las Sillas de Ruedas para Adultos Mayores está Equipada con asiento y respaldo tapizados en vinil de alta resistencia.', 'MEDICAL STORE', 'Modelo 809F', 'Negro', 1, 63, 74, '2023-04-26 06:02:51', '2023-04-26 06:02:51');

INSERT INTO `publicacionesblogs` (`id`, `titulo`, `descripcion`, `createdAt`, `updatedAt`, `id_usuario`) VALUES
(51, 'Opinión sobre la silla de ruedas XXSAS', 'La verdad al principió me gusto la comodidad de la silla, sin embargo al pasar de los días el acolchado fue disminuyendo.', '2023-04-13 22:06:55', '2023-04-13 22:06:55', 65),
(58, 'ancianas en bikini', 'ke riko', '2023-04-13 23:36:00', '2023-04-13 23:36:00', 65),
(59, 'ancianas en bikini', 'ke riko', '2023-04-13 23:36:22', '2023-04-13 23:36:22', 65),
(60, 'ancianas en bikini', 'ke riko', '2023-04-13 23:36:29', '2023-04-13 23:36:29', 65),
(61, 'DASD', 'werwasd', '2023-04-14 01:27:26', '2023-04-14 01:27:26', 65),
(62, 'FEF', 'SEF', '2023-04-14 01:28:18', '2023-04-14 01:28:18', 65),
(63, 'FDSD', 'ASD', '2023-04-14 01:29:56', '2023-04-14 01:29:56', 65),
(64, 'grg', 'drg', '2023-04-14 01:31:24', '2023-04-14 01:31:24', 65),
(65, 'fesss', 'sfe', '2023-04-14 01:32:19', '2023-04-14 01:32:19', 65),
(66, 'sad', 'asd', '2023-04-14 01:58:10', '2023-04-14 01:58:10', 65),
(67, 'sad', 'asd', '2023-04-14 02:01:10', '2023-04-14 02:01:10', 65),
(68, 'sad', 'asd', '2023-04-14 02:03:30', '2023-04-14 02:03:30', 65),
(69, 'sad', 'asd', '2023-04-14 02:03:59', '2023-04-14 02:03:59', 65),
(70, '321', '123', '2023-04-14 03:03:38', '2023-04-14 03:03:38', 65),
(71, '321', '123', '2023-04-14 03:07:41', '2023-04-14 03:07:41', 65),
(72, '321', '123', '2023-04-14 03:07:59', '2023-04-14 03:07:59', 65),
(73, 'esf', 'dfsgv', '2023-04-14 03:09:21', '2023-04-14 03:09:21', 65),
(74, 'sdasd', 'asdasd', '2023-04-14 03:13:39', '2023-04-14 03:13:39', 65),
(75, 'sdasd', 'asdasd', '2023-04-14 03:14:49', '2023-04-14 03:14:49', 65),
(76, 'sdasd', 'asdasd', '2023-04-14 03:14:54', '2023-04-14 03:14:54', 65),
(77, 'ddd', 'ASD', '2023-04-14 03:30:45', '2023-04-14 03:30:45', 65);

INSERT INTO `servicios` (`id`, `titulo`, `descripcion`, `precio`, `id_categoria`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(6, 'dawdawad', 'Ed ', 2134, 52, 65, '2023-04-13 15:48:02', '2023-04-13 15:48:02'),
(7, 'dawdawadc', 'Ed ', 2134, 52, 65, '2023-04-13 15:50:33', '2023-04-13 15:50:33'),
(8, 'dawdawadcc', 'Ed ', 2134, 52, 65, '2023-04-13 15:50:41', '2023-04-13 15:50:41'),
(9, 'fwef', 'wef', 213, 59, 65, '2023-04-13 16:14:12', '2023-04-13 16:14:12'),
(10, 'fwefs', 'wef', 213, 59, 65, '2023-04-13 16:16:53', '2023-04-13 16:16:53'),
(11, 'fwefsd', 'wef', 213, 59, 65, '2023-04-13 16:19:40', '2023-04-13 16:19:40'),
(12, 'fwefsdq', 'wef', 213, 59, 65, '2023-04-13 16:21:23', '2023-04-13 16:21:23'),
(13, 'fwefsdqs', 'wef', 213, 59, 65, '2023-04-13 16:21:40', '2023-04-13 16:21:40'),
(14, 'fwefssdqs', 'wef', 213, 59, 65, '2023-04-13 16:22:19', '2023-04-13 16:22:19'),
(15, 'fwefssdqss', 'wef', 213, 59, 65, '2023-04-13 16:23:36', '2023-04-13 16:23:36'),
(16, 'fwefssdqssf', 'wef', 213, 59, 65, '2023-04-13 16:25:17', '2023-04-13 16:25:17'),
(17, 'fwefssdqssfs', 'wef', 213, 59, 65, '2023-04-13 16:25:43', '2023-04-13 16:25:43'),
(20, 'SERVICO DEPROTITUCION', '123', 12312, 51, 65, '2023-04-13 23:37:23', '2023-04-13 23:37:23'),
(21, 'dawsd', 'awe', 213, 56, 65, '2023-04-14 11:53:33', '2023-04-14 11:53:33'),
(22, 'rgegdrg', '123123', 123, 65, 65, '2023-04-14 11:55:24', '2023-04-21 13:36:49'),
(23, 'wqwe', 'daf', 423, 56, 65, '2023-04-14 12:17:16', '2023-04-14 12:17:16'),
(24, '3', '123', 123, 55, 65, '2023-04-14 12:20:33', '2023-04-14 12:20:33'),
(25, 'qs', '132', 123, 56, 65, '2023-04-14 12:24:00', '2023-04-14 12:24:00'),
(26, '34', '2234', 324, 56, 65, '2023-04-14 13:48:19', '2023-04-14 13:48:19'),
(27, 'yhtfy', 'fty', 1, 55, 65, '2023-04-14 13:58:08', '2023-04-14 13:58:08'),
(28, '2314', '324', 34234, 52, 65, '2023-04-14 18:22:21', '2023-04-14 18:22:21'),
(29, 'Servicio de secso', 'Servicio a domicilio', 1800, 58, 74, '2023-04-22 08:59:22', '2023-04-22 08:59:22'),
(30, 'Servicio de auto', 'Lavado de ass', 123, 57, 78, '2023-04-22 09:17:41', '2023-04-22 09:17:41'),
(31, 'Servicio de masajes', 'Servicio de masajes', 1200, 58, 74, '2023-04-23 01:54:46', '2023-04-23 01:54:46');

INSERT INTO `usuarios` (`id`, `nombre`, `apellidoPaterno`, `apellidoMaterno`, `email`, `sexo`, `fechaNacimiento`, `telefono`, `password`, `tipoUsuario`, `createdAt`, `updatedAt`) VALUES
(65, 'Miguel Ángel ', 'Flores', 'Catalán', 'admin@123', 'M', '2023-03-06', '2313', '$2a$10$ZaJdb.9.1EsVNy.KPtlPxOaUka95uHqUmoiJsQjYi8BQjw2mdp6bK', 1, '2023-03-14 19:19:25', '2023-04-12 23:14:43'),
(74, 'Brayan', 'Chavez ', 'Gasca', 'admin@gmail.com', 'M', '2023-04-04', '435453', '$2a$10$UMhHmmOuqsC5MaYOmt4u3.3vYgTXZFu3swni8LrQq4TEnT7Unq0fS', 1, '2023-04-09 22:13:18', '2023-04-21 22:19:30'),
(76, 'Adolfo ', 'López ', 'Figueroa', 'cliente@123', 'M', '2006-10-18', '213123', '$2a$10$CFGRT/GBvNhmdyBJuF.3jODDxJgM0bWmhZ5dQ4ORjfcZUBdotqpHa', 0, '2023-04-11 15:39:39', '2023-04-11 15:39:39'),
(77, 'Brayan', 'Chavez', 'Gasca', 'cgbo192927@upemor.edu.mx', 'M', '2001-04-03', '34234', '$2a$10$if6V2rX0.9p1Px1zXCmKseVicU2kSOOqFNmH9zuXUETFqJuj0S8t6', 0, '2023-04-11 15:52:41', '2023-04-11 19:31:33'),
(78, 'Cliente', 'Prueba', 'Prueba', 'cliente@gmail.com', 'M', '2023-04-04', '2345678', '$2a$10$gGr4iHkrRtJaTzNlvqlQ3eKHSfbwkJjj5XWCscikvDRGaATzbuZVq', 0, '2023-04-21 22:26:47', '2023-04-21 22:26:47');

