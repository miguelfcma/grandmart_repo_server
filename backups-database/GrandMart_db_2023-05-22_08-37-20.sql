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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `cuenta_bancaria`;
CREATE TABLE `cuenta_bancaria` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint(20) unsigned NOT NULL,
  `nombre_titular` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `numero_cuenta` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `banco` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cuenta_bancaria_FK` (`usuario_id`),
  CONSTRAINT `cuenta_bancaria_FK` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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

DROP TABLE IF EXISTS `denunciabuzons`;
CREATE TABLE `denunciabuzons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `motivo` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `descripcion` varchar(1500) COLLATE utf8_spanish2_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  `id_producto` bigint(20) unsigned DEFAULT NULL,
  `revisar` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `denunciabuzons_FK` (`id_producto`),
  CONSTRAINT `denunciabuzons_FK` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  CONSTRAINT `denunciabuzons_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `denunciasproductos`;
CREATE TABLE `denunciasproductos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `motivo` varchar(1500) CHARACTER SET latin1 NOT NULL,
  `descripcion` varchar(500) CHARACTER SET latin1 DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `id_producto` bigint(20) unsigned DEFAULT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `denunciasproductos_FK` (`id_producto`),
  CONSTRAINT `denunciasproductos_FK` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`)
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `envios`;
CREATE TABLE `envios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `orden_id` bigint(20) unsigned NOT NULL,
  `estado` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `direccion_envio_id` bigint(20) unsigned NOT NULL,
  `fechaEntrega` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `envios_FK` (`orden_id`),
  KEY `envios_FK_1` (`direccion_envio_id`),
  CONSTRAINT `envios_FK` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`),
  CONSTRAINT `envios_FK_1` FOREIGN KEY (`direccion_envio_id`) REFERENCES `direccion_envios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `ordenes`;
CREATE TABLE `ordenes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `total` decimal(10,2) DEFAULT NULL,
  `estado_orden` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `ordenes_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `pago`;
CREATE TABLE `pago` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint(20) unsigned NOT NULL,
  `orden_id` bigint(20) unsigned NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `estado` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_pago_stripe` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_pago` date NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pago_FK` (`usuario_id`),
  KEY `pago_FK_1` (`orden_id`),
  CONSTRAINT `pago_FK` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `pago_FK_1` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

INSERT INTO `carrito_compra_detalles` (`id`, `id_producto`, `id_carrito_compra`, `cantidad`, `createdAt`, `updatedAt`) VALUES
(1, 84, 10, 1, '2023-05-04 17:20:30', '2023-05-04 17:20:30'),
(9, 86, 11, 1, '2023-05-06 21:31:53', '2023-05-06 21:31:53'),
(10, 88, 11, 1, '2023-05-08 00:04:19', '2023-05-08 00:04:19'),
(11, 89, 11, 1, '2023-05-08 07:38:23', '2023-05-08 07:38:23'),
(18, 86, 12, 3, '2023-05-11 23:21:21', '2023-05-12 15:47:53'),
(19, 85, 12, 1, '2023-05-11 23:21:22', '2023-05-11 23:21:22'),
(34, 84, 9, 1, '2023-05-06 21:31:53', '2023-05-06 21:31:53');

INSERT INTO `carritos_compras` (`id`, `fecha_creacion`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(9, '2023-04-26', 74, '2023-04-26 19:37:28', '2023-04-26 19:37:28'),
(10, '2023-04-29', 76, '2023-04-29 17:32:58', '2023-04-29 17:32:58'),
(11, '2023-05-06', 79, '2023-05-06 21:31:53', '2023-05-06 21:31:53'),
(12, '2023-05-09', 80, '2023-05-09 16:13:00', '2023-05-09 16:13:00'),
(13, '2023-05-12', 65, '2023-05-12 18:34:30', '2023-05-12 18:34:30'),
(14, '2023-05-19', 82, '2023-05-19 22:36:23', '2023-05-19 22:36:23');

INSERT INTO `categorias` (`id`, `nombre`, `id_parent`, `createdAt`, `updatedAt`) VALUES
(25, 'Tecnología', NULL, '2023-03-15 17:36:07', '2023-03-16 09:39:15'),
(26, 'Entretenimiento', NULL, '2023-03-15 17:36:19', '2023-03-15 20:08:52'),
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
(64, 'Audición', 36, '2023-04-11 14:59:57', '2023-04-11 14:59:57'),
(65, 'Visión', 36, '2023-04-11 15:00:10', '2023-04-11 15:00:10'),
(66, 'Accesorios para Mascotas', 31, '2023-04-11 16:03:02', '2023-04-11 16:03:02');

INSERT INTO `comentariosblogs` (`id`, `comentario`, `createdAt`, `updatedAt`, `id_publicacionBlog`, `id_usuario`) VALUES
(21, 'a bueno\n', '2023-04-24 18:06:17', '2023-04-24 18:06:17', 78, 74),
(22, 'siuu', '2023-04-24 18:10:38', '2023-04-24 18:10:38', 78, 76);

INSERT INTO `denunciabuzons` (`id`, `motivo`, `descripcion`, `createdAt`, `updatedAt`, `id_usuario`, `id_producto`, `revisar`) VALUES
(3, 'Vende una copia o falsificación', 'awdwqadwad', '2023-05-08 20:24:25', '2023-05-08 20:24:25', 74, 85, 0),
(4, 'Induce en la publicación o en sus respuestas a que se realicen acciones que pueden ser fraudulentas.', 'AXZAX', '2023-05-11 20:47:39', '2023-05-11 20:47:39', 80, 86, 0),
(5, 'Quiere cobrar un precio diferente o hay incoherencias con el precio y los productos de la publicación.', 'ggl', '2023-05-12 19:03:44', '2023-05-18 08:42:11', 65, 92, 1);

INSERT INTO `direccion_envios` (`id`, `estado`, `descripcion`, `nombre_ine`, `calle2`, `calle`, `postal`, `colonia`, `numeroInterior`, `calle1`, `municipio_alcaldia`, `numeroExterior`, `createdAt`, `updatedAt`) VALUES
(47, 'dasd', 'awd', 'dasdasdas', 'dsa', 'das', 'asdasdas', 'asdas', 'as', 'awawd', 'asd', 'das', '2023-05-18 19:56:32', '2023-05-18 19:56:32'),
(48, 'dasd', 'awd', 'dasdasdas', 'dsa', 'das', 'asdasdas', 'asdas', 'as', 'awawd', 'asd', 'das', '2023-05-18 20:00:31', '2023-05-18 20:00:31'),
(49, 'dasd', 'awd', 'dasdasdas', 'dsa', 'das', 'asdasdas', 'asdas', 'as', 'awawd', 'asd', 'das', '2023-05-18 20:02:58', '2023-05-18 20:02:58'),
(50, 'dasd', 'awd', 'dasdasdas', 'dsa', 'das', 'asdasdas', 'asdas', 'as', 'awawd', 'asd', 'das', '2023-05-19 15:33:13', '2023-05-19 15:33:13'),
(51, 'asa', 'ASAsa', 'sASas', 'sASas', 'aS', 'aSas', 'SAsASas', 'asSA', 'asas', 'aSasAS', 'ASAs', '2023-05-19 22:39:59', '2023-05-19 22:39:59'),
(52, 'dasd', 'awd', 'dasdasdas', 'dsa', 'das', 'asdasdas', 'asdas', 'as', 'awawd', 'asd', 'das', '2023-05-20 16:40:44', '2023-05-20 16:40:44');

INSERT INTO `domiciliousuarios` (`id`, `nombre_ine`, `postal`, `estado`, `municipio_alcaldia`, `colonia`, `calle`, `numeroExterior`, `numeroInterior`, `calle1`, `calle2`, `descripcion`, `createdAt`, `updatedAt`, `id_usuario`) VALUES
(36, 'Juan Pérez', '12345', 'Jalisco', 'Guadalajara', 'Colonia Ejemplo', 'Calle Ejemplo', '123', 'A', 'Calle Ejemplo 1', 'Calle Ejemplo 2', 'Esta es una descripción del domicilio de ejemplo', '2023-05-11 23:15:09', '2023-05-12 15:47:29', 74),
(40, 'sASas', 'aSas', 'asa', 'aSasAS', 'SAsASas', 'aS', 'ASAs', 'asSA', 'asas', 'sASas', 'ASAsa', '2023-05-19 22:39:42', '2023-05-19 22:39:42', 82),
(41, 'wdw', 'dw', 'dw', 'dw', 'dw', 'dw', 'dw', 'dw', 'dw', 'dw', 'dw', '2023-05-22 09:12:56', '2023-05-22 09:12:56', 65);

INSERT INTO `envios` (`id`, `orden_id`, `estado`, `direccion_envio_id`, `fechaEntrega`, `createdAt`, `updatedAt`) VALUES
(44, 59, 'Cancelado', 47, NULL, '2023-05-18 19:56:32', '2023-05-18 20:48:28'),
(45, 60, 'Pendiente', 48, NULL, '2023-05-18 20:00:31', '2023-05-18 20:00:31'),
(46, 61, 'Pendiente', 49, NULL, '2023-05-18 20:02:58', '2023-05-18 20:02:58'),
(47, 66, 'Pendiente', 50, NULL, '2023-05-19 15:33:13', '2023-05-19 15:33:13'),
(48, 67, 'Pendiente', 51, NULL, '2023-05-19 22:39:59', '2023-05-19 22:39:59'),
(49, 68, 'Pendiente', 52, NULL, '2023-05-20 16:40:44', '2023-05-20 16:40:44');

INSERT INTO `favoritosproductos` (`id`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(2, '2023-04-16 11:04:13', '2023-04-16 11:04:13', 88, 77),
(5, '2023-04-18 16:00:43', '2023-04-18 16:00:43', 91, 77),
(6, '2023-04-18 16:02:38', '2023-04-18 16:02:38', 92, 77),
(7, '2023-04-18 21:17:13', '2023-04-18 21:17:13', 93, 77),
(9, '2023-05-04 17:20:28', '2023-05-04 17:20:28', 86, 76),
(16, '2023-05-05 22:19:18', '2023-05-05 22:19:18', 87, 74),
(17, '2023-05-05 22:19:19', '2023-05-05 22:19:19', 86, 74),
(18, '2023-05-05 22:19:20', '2023-05-05 22:19:20', 88, 74),
(19, '2023-05-05 22:19:21', '2023-05-05 22:19:21', 89, 74),
(20, '2023-05-06 21:31:52', '2023-05-06 21:31:52', 86, 79),
(21, '2023-05-08 00:04:18', '2023-05-08 00:04:18', 88, 79),
(22, '2023-05-11 20:45:28', '2023-05-11 20:45:28', 86, 80),
(23, '2023-05-22 13:04:56', '2023-05-22 13:04:56', 86, 65);

INSERT INTO `imagenesblogs` (`id`, `url`, `es_portada`, `id_publicacionBlog`, `createdAt`, `updatedAt`) VALUES
(41, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2Fc295489b-8b3f-47f9-a746-88a23dc55e4a_2ffbbe7b-c9c7-4285-bd9d-28be9b58d60e?alt=media&token=0c3ed254-d92f-4734-b663-c4da34f81796', 1, 78, '2023-04-24 17:57:02', '2023-04-24 17:57:02');

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
(146, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Ff6306121-6b3f-4596-bfba-5fe44e51c06a_f732ecd2-1bae-49d3-b490-c4e1fd46ada3?alt=media&token=ff481f0a-6898-46bb-a8bb-6025fac2e2f0', 96, 1, '2023-05-17 20:35:57', '2023-05-17 20:35:57'),
(147, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F01c5a8d6-f3e0-48fd-a04e-1ff173d4830f_94db1a05-52b3-4f2d-8e52-79de6cf794c2?alt=media&token=a38acf5e-8599-4f7f-a84e-415cd37550e4', 97, 1, '2023-05-17 20:36:41', '2023-05-17 20:36:41'),
(148, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F26a59d92-eea2-4f19-988e-952f1e1f4605_491e5762-d997-49cf-812d-b619daa9800f?alt=media&token=013cbf37-29ab-4286-b17c-9aabb749c71c', 98, 0, '2023-05-20 16:38:23', '2023-05-20 16:38:23'),
(149, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F26a59d92-eea2-4f19-988e-952f1e1f4605_edb2a74e-eeec-4159-b736-e521e037e84d?alt=media&token=ff3cc4ea-f994-493f-8a28-34ddb4f17af3', 98, 1, '2023-05-20 16:38:23', '2023-05-20 16:38:23'),
(150, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F26a59d92-eea2-4f19-988e-952f1e1f4605_ad3e788d-d1dc-46a7-b2fa-68aea3fc65ab?alt=media&token=0bab17b9-641e-4fda-a38d-143620367779', 98, 0, '2023-05-20 16:38:23', '2023-05-20 16:38:23'),
(151, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F26a59d92-eea2-4f19-988e-952f1e1f4605_6fc5a302-0c9a-4463-85c2-2d6fcb6bc8d3?alt=media&token=2264a880-a0d5-4d2e-861e-e746204e608d', 98, 0, '2023-05-20 16:38:23', '2023-05-20 16:38:23');

INSERT INTO `imagenesservicios` (`id`, `url`, `es_portada`, `id_servicio`, `createdAt`, `updatedAt`) VALUES
(1, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F192152ca-79bb-4222-8792-1b434363180b_8bcd045f-6a52-4698-a412-e35e8ff516be?alt=media&token=b3980858-bc82-4c57-bca4-b6b94fcb9f45', 1, 27, '2023-04-14 14:04:03', '2023-04-14 14:04:03'),
(2, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F192152ca-79bb-4222-8792-1b434363180b_d2893eb3-725b-407e-9b1a-b7c9751424ee?alt=media&token=f58a6a86-ec0a-4d0e-9524-3881e6bab360', 0, 27, '2023-04-14 14:04:03', '2023-04-14 14:04:03'),
(3, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F192152ca-79bb-4222-8792-1b434363180b_c320c21a-849c-4946-b5c3-d73cf0bb952c?alt=media&token=5f50003e-c4ce-47dd-a478-76af8311d0ae', 0, 27, '2023-04-14 14:04:03', '2023-04-14 14:04:03'),
(8, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F6bfdac03-7cdf-40df-b6a2-8c812ad4215f_e4f1874a-0178-4770-b963-3d832bc40d55?alt=media&token=8e0122b0-720a-4220-8548-6024aa8b021e', 1, 29, '2023-04-29 03:47:02', '2023-04-29 03:47:02'),
(9, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F6bfdac03-7cdf-40df-b6a2-8c812ad4215f_f9aba621-58dc-4bf9-bf90-1dca2b6f8ea5?alt=media&token=a5c95223-f9bf-4e9f-a081-9429fc675dc9', 0, 29, '2023-04-29 03:47:02', '2023-04-29 03:47:02');

INSERT INTO `orden_detalles` (`id`, `cantidad`, `precio_unitario`, `id_producto`, `id_orden`, `createdAt`, `updatedAt`) VALUES
(45, 1, '60.00', 91, 59, '2023-05-18 19:56:32', '2023-05-18 19:56:32'),
(46, 1, '10.00', 92, 59, '2023-05-18 19:56:32', '2023-05-18 19:56:32'),
(47, 1, '60.00', 91, 60, '2023-05-18 20:00:31', '2023-05-18 20:00:31'),
(48, 1, '2000.00', 87, 61, '2023-05-18 20:02:58', '2023-05-18 20:02:58'),
(49, 1, '50.00', 88, 61, '2023-05-18 20:02:58', '2023-05-18 20:02:58'),
(50, 2, '50.00', 85, 66, '2023-05-19 15:33:13', '2023-05-19 15:33:13'),
(51, 1, '150.00', 86, 66, '2023-05-19 15:33:13', '2023-05-19 15:33:13'),
(52, 2, '50.00', 88, 66, '2023-05-19 15:33:13', '2023-05-19 15:33:13'),
(53, 1, '2000.00', 87, 66, '2023-05-19 15:33:13', '2023-05-19 15:33:13'),
(54, 1, '80.00', 89, 66, '2023-05-19 15:33:13', '2023-05-19 15:33:13'),
(55, 1, '80.00', 90, 66, '2023-05-19 15:33:13', '2023-05-19 15:33:13'),
(56, 1, '60.00', 91, 66, '2023-05-19 15:33:13', '2023-05-19 15:33:13'),
(57, 1, '10.00', 92, 66, '2023-05-19 15:33:13', '2023-05-19 15:33:13'),
(58, 1, '500.00', 93, 66, '2023-05-19 15:33:13', '2023-05-19 15:33:13'),
(59, 1, '50.00', 85, 67, '2023-05-19 22:39:59', '2023-05-19 22:39:59'),
(60, 1, '2000.00', 87, 67, '2023-05-19 22:39:59', '2023-05-19 22:39:59'),
(61, 1, '12121.00', 98, 68, '2023-05-20 16:40:44', '2023-05-20 16:40:44');

INSERT INTO `ordenes` (`id`, `total`, `estado_orden`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(59, '70.00', 'Pendiente', 65, '2023-05-18 19:56:30', '2023-05-18 19:56:32'),
(60, '60.00', 'Pendiente', 65, '2023-05-18 20:00:29', '2023-05-18 20:00:31'),
(61, '2050.00', 'Pendiente', 65, '2023-05-18 20:02:56', '2023-05-18 20:02:58'),
(66, '3080.00', 'Pendiente', 65, '2023-05-19 15:33:12', '2023-05-19 15:33:13'),
(67, '2050.00', 'Pendiente', 82, '2023-05-19 22:39:57', '2023-05-19 22:39:59'),
(68, '12121.00', 'Pendiente', 65, '2023-05-20 16:40:43', '2023-05-20 16:40:44');

INSERT INTO `pago` (`id`, `usuario_id`, `orden_id`, `monto`, `estado`, `id_pago_stripe`, `fecha_pago`, `createdAt`, `updatedAt`) VALUES
(9, 65, 59, '7000.00', 'Procesado', 'pi_3N9Cw7IscKwQt1dm1BP2NdTL', '2023-05-18', '2023-05-18 19:56:32', '2023-05-18 19:56:32'),
(10, 65, 60, '6000.00', 'Procesado', 'pi_3N9CzxIscKwQt1dm0r4S1ZY8', '2023-05-18', '2023-05-18 20:00:31', '2023-05-18 20:00:31'),
(11, 65, 61, '205000.00', 'Procesado', 'pi_3N9D2LIscKwQt1dm1stqDAEu', '2023-05-18', '2023-05-18 20:02:58', '2023-05-18 20:02:58'),
(12, 65, 66, '308000.00', 'Procesado', 'pi_3N9VIqIscKwQt1dm1k7gmLDk', '2023-05-19', '2023-05-19 15:33:13', '2023-05-19 15:33:13'),
(13, 82, 67, '205000.00', 'Procesado', 'pi_3N9bxoIscKwQt1dm0FKM5nIV', '2023-05-19', '2023-05-19 22:39:59', '2023-05-19 22:39:59'),
(14, 65, 68, '1212100.00', 'Procesado', 'pi_3N9spjIscKwQt1dm2FqejvOm', '2023-05-20', '2023-05-20 16:40:44', '2023-05-20 16:40:44');

INSERT INTO `preguntasproductos` (`id`, `pregunta`, `respuesta`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(2, 'lo tienes verde?', NULL, '2023-04-22 21:52:07', '2023-04-24 18:05:05', 85, 74),
(3, 'hola esta disponible aun?', NULL, '2023-04-22 22:23:21', '2023-04-22 22:23:21', 85, 74),
(4, '234234234324', 'webos puto', '2023-05-17 20:37:11', '2023-05-20 19:27:29', 97, 65),
(5, 'Hola esta un poco grande que tyipo de señal toma?', NULL, '2023-05-20 19:41:06', '2023-05-20 19:41:06', 98, 65),
(6, 'adswadawdawd', 'dawdaw', '2023-05-20 19:43:32', '2023-05-20 19:43:54', 97, 65),
(7, 'awdawdawd', NULL, '2023-05-20 19:43:35', '2023-05-20 19:43:35', 97, 65);

INSERT INTO `productos` (`id`, `nombre`, `precio`, `stock`, `descripcion`, `marca`, `modelo`, `color`, `estado`, `id_categoria`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(84, 'Audífonos Amplificadores de Sonido', 100, 0, 'Los Audífonos Amplificadores de Sonido están diseñados especialmente para adultos mayores que tienen problemas de audición. Estos audífonos proporcionan una calidad de sonido clara y nítida, permitiendo una mejor audición y comunicación. Además, son cómodos de usar y fáciles de ajustar según las necesidades del usuario.', ' Amplifon', 'X Mini', 'Beige', 1, 64, 74, '2023-04-11 15:16:39', '2023-05-16 17:03:16'),
(85, 'Monitor de Presión Arterial', 50, 94, 'El Monitor de Presión Arterial es un producto esencial para adultos mayores que necesitan controlar su presión arterial. Este monitor es fácil de usar y proporciona mediciones precisas. Además, cuenta con una pantalla grande y fácil de leer, y puede almacenar las mediciones para un seguimiento a largo plazo.', 'Omron', 'BP742N', 'Blanco', 1, 65, 74, '2023-04-11 15:31:33', '2023-05-19 22:39:59'),
(86, 'Andador Plegable con Asiento', 150, 22, 'El Andador Plegable con Asiento es un producto ideal para adultos mayores que necesitan ayuda para caminar y descansar de vez en cuando. Este andador es fácil de usar y cuenta con un asiento cómodo y seguro. Además, se pliega para un fácil almacenamiento y transporte.', 'Drive Medical', 'Nitro DLX', 'Azul', 1, 59, 76, '2023-04-11 15:40:55', '2023-05-19 15:33:13'),
(87, 'Tablet para Adultos Mayores', 2000, 17, ' La Tablet para Adultos Mayores es una herramienta tecnológica diseñada especialmente para este grupo de edad. Cuenta con una interfaz de usuario fácil de usar y botones grandes para una navegación sencilla. Además, cuenta con aplicaciones útiles como un calendario, reloj, acceso a Internet y correo electrónico. También incluye soporte técnico para cualquier duda o problema.', 'GrandPad', 'GrandPad', 'Gris', 1, 51, 76, '2023-04-11 15:44:32', '2023-05-19 22:39:59'),
(88, 'Teléfono con Teclas Grandes', 50, 47, 'El Teléfono con Teclas Grandes es ideal para adultos mayores que necesitan un teléfono fácil de usar y leer. Cuenta con teclas grandes y de alto contraste, una pantalla grande y fácil de leer, y un volumen ajustable. Además, tiene funciones adicionales como identificador de llamadas y memoria para guardar números importantes.', 'Clarity', 'P300', 'Blanco', 1, 52, 76, '2023-04-11 15:48:23', '2023-05-19 15:33:13'),
(89, 'Pulsera Inteligente para Monitoreo de Actividad', 80, 29, ' La Pulsera Inteligente para Monitoreo de Actividad es un gadget útil para adultos mayores que desean monitorear su actividad física y salud. Cuenta con funciones como un podómetro, monitor de ritmo cardíaco y monitoreo de sueño. Además, puede conectarse a una aplicación móvil para obtener un seguimiento más detallado.', 'Fitbit', 'Inspire 2', 'Negro', 1, 53, 76, '2023-04-11 15:50:35', '2023-05-19 15:33:13'),
(90, 'Andador para Rehabilitación', 80, 24, 'El Andador para Rehabilitación es un dispositivo útil para adultos mayores que están en proceso de recuperación después de una lesión o cirugía. Cuenta con un diseño resistente y ajustable, y es fácil de usar. Además, tiene una bandeja de almacenamiento para llevar objetos pequeños.', 'Medline', 'MDS86410KDRB', 'Plata', 1, 59, 77, '2023-04-11 15:56:27', '2023-05-19 15:33:13'),
(91, 'Batidora para Smoothies Nutritivos', 60, 17, 'La Batidora para Smoothies Nutritivos es una herramienta útil para adultos mayores que desean mejorar su nutrición y salud en general. Es fácil de usar y limpiar, y cuenta con una potencia suficiente para triturar frutas y verduras. Además, incluye recetas y consejos para preparar smoothies saludables.', 'Nutribullet', 'NBR-0801', 'Gris', 1, 61, 65, '2023-04-11 15:59:01', '2023-05-19 15:33:13'),
(92, 'Collar para Perros', 10, 44, ' Este collar para perros es de alta calidad y está hecho con materiales duraderos. Viene en varios tamaños y colores, lo que lo hace adecuado para todo tipo de perros. Además, tiene una hebilla de liberación rápida para mayor seguridad.', '', '', '', 1, 66, 65, '2023-04-11 16:04:13', '2023-05-19 15:33:13'),
(93, 'Cinta de Correr para Ejercicio en Casa', 500, 4, 'La Cinta de Correr para Ejercicio en Casa es una herramienta útil para adultos mayores que desean mantenerse activos y saludables sin salir de casa. Es fácil de usar y ajustable, y cuenta con una variedad de programas de entrenamiento para diferentes niveles de condición física. Además, es plegable para un fácil almacenamiento.', 'ordicTrack', 'T 6.5 Si', 'Gris', 1, 62, 65, '2023-04-11 16:05:57', '2023-05-19 15:33:13'),
(96, 'ewrwerewr', 3434, 343, '3434', '34', '3434', '4343', 0, 51, 65, '2023-05-17 20:35:52', '2023-05-17 20:35:52'),
(97, '23423423423423', 4234234, 23423423, '234', '234324', '234234', '234234', 1, 53, 65, '2023-05-17 20:36:33', '2023-05-17 20:36:33'),
(98, 'SqsQS', 12121, 1211, '|121|2', '1|2', '1|2', '121|2', 1, 55, 82, '2023-05-20 16:38:07', '2023-05-20 16:40:44');

INSERT INTO `publicacionesblogs` (`id`, `titulo`, `descripcion`, `createdAt`, `updatedAt`, `id_usuario`) VALUES
(78, 'Hola esta es Título de publicación ', 'Descripción ', '2023-04-24 17:57:02', '2023-04-24 17:57:02', 74);

INSERT INTO `reviewsproductos` (`id`, `titulo`, `comentario`, `calificacion`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(4, 'Excelente muy buen producto.', 'Sin comentarios', 4, '2023-04-28 21:13:41', '2023-04-28 21:13:41', 88, 74),
(5, 'No me gusto ', 'Producto Chafa', 1, '2023-04-28 21:13:41', '2023-04-28 21:13:41', 88, 76),
(6, 'No me gusta ', 'La verdad no es lo que esperaba', 3, '2023-04-29 17:28:12', '2023-04-29 17:28:12', 85, 76),
(7, 'Genial', 'Es un buen producto por su relación calidad precio ', 3, '2023-04-29 17:28:12', '2023-04-29 17:28:12', 85, 74),
(8, 'Mu bueno', 'Fracias por', 4, '2023-05-20 14:48:20', '2023-05-20 14:48:20', 92, 65),
(9, 'czsczsczs', 'cszcszc', 4, '2023-05-20 22:09:44', '2023-05-20 22:09:44', 85, 82);

INSERT INTO `servicios` (`id`, `titulo`, `descripcion`, `precio`, `id_categoria`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(27, 'yhtfy', 'fty', 1, 55, 65, '2023-04-14 13:58:08', '2023-04-14 13:58:08'),
(29, 'sefs', 'sef', 2323, 58, 76, '2023-04-29 03:46:53', '2023-04-29 03:46:53');

INSERT INTO `usuarios` (`id`, `nombre`, `apellidoPaterno`, `apellidoMaterno`, `email`, `sexo`, `fechaNacimiento`, `telefono`, `password`, `tipoUsuario`, `createdAt`, `updatedAt`) VALUES
(65, 'Miguel Ángel ', 'Flores', 'Catalán', 'admin@123', 'M', '2023-03-06', '2313', '$2a$10$0zHDcRP5Ub9MDgdTOevV6uOx4sF77ibidU2CKrRLToHShZH2s.ih.', 1, '2023-03-14 19:19:25', '2023-05-12 15:56:54'),
(74, 'Brayan', 'Chavez ', 'Gasca', 'admin@gmail.com', 'M', '2023-04-04', '435453', '$2a$10$quBryYhGp8Q85TbSmGggDuSddCMNePjs2IJ1VFebR3aSBQ26WTGTe', 1, '2023-04-09 22:13:18', '2023-05-06 21:25:37'),
(76, 'Adolfo ', 'López ', 'Figueroa', 'cliente@123', 'M', '2006-10-18', '213123', '$2a$10$CFGRT/GBvNhmdyBJuF.3jODDxJgM0bWmhZ5dQ4ORjfcZUBdotqpHa', 0, '2023-04-11 15:39:39', '2023-04-11 15:39:39'),
(77, 'Brayan', 'Chavez', 'Gasca', 'cgbo192927@upemor.edu.mx', 'M', '2001-04-03', '34234', '$2a$10$if6V2rX0.9p1Px1zXCmKseVicU2kSOOqFNmH9zuXUETFqJuj0S8t6', 0, '2023-04-11 15:52:41', '2023-04-11 19:31:33'),
(78, 'ssasasad', 'dwdwd', 'wdwdww', 'wdwdef@sd', 'M', '2023-07-04', 'wddfdfdf', '$2a$10$6OxoMDSKlltMCyswj590KOedokJnLYtP9vCazk2CDrhfTEu66gCFO', 0, '2023-05-03 16:46:28', '2023-05-03 16:46:28'),
(79, 'Cliente', 'Prueba', 'Prueba', 'cliente@gmail.com', 'M', '2023-05-18', '2345678', '$2a$10$pmyO6.3WLAN0VeKE4h4pJek.P84LTrkBwFr9MQ5gtkpk7JHOdgwKm', 0, '2023-05-06 21:29:10', '2023-05-06 21:29:10'),
(80, 'fewfwef', 'wefwef', 'ewfwef', 'admin02wef@123', 'M', '2023-05-04', 'wef23123213', '$2a$10$Gt6LhcqGvwOI/KTR57dhBuZybAs0CiL4uzC8Otb5CZuDGXH0hBlae', 0, '2023-05-09 15:28:44', '2023-05-09 15:28:44'),
(81, 'miguel cliente', 'flores', 'catalan', 'miguelangel@cliente.com', 'M', '2023-05-25', '76126172617', '$2a$10$00aOXT/xmFfDCDQLrnNEAeAUO7y.mxY1NxP6l/T53rlO2IeN/3hcW', 0, '2023-05-15 17:18:51', '2023-05-15 17:18:51'),
(82, 'wq213213123', 'qweqwe', '12dewwqeqweqwe', 'dasdqsadsdq@sasa', 'F', '2023-05-08', 'dasdas', '$2a$10$QSd8Ak4qhEMMJbv7EEX0MuwxHv/8oncVwG/GCtpZI5mO5cP8PAcNa', 0, '2023-05-19 22:35:14', '2023-05-19 22:35:14'),
(83, 'awd', 'awdaw', 'dawdawdadada w', 'awdaw@gmail.com', 'M', '2023-05-08', 'awdawd', '$2a$10$xmswkTdWqVganb.9B09/j.BMWV.kIVjy95LHbgR.4coFanGoHmcxu', 2, '2023-05-22 14:34:07', '2023-05-22 14:34:07');

