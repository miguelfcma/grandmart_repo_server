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
  CONSTRAINT `carrito_compra_detalles_FK` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `carrito_compra_detalles_FK_1` FOREIGN KEY (`id_carrito_compra`) REFERENCES `carritos_compras` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `carritos_compras`;
CREATE TABLE `carritos_compras` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fecha_creacion` date NOT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `carritos_compras_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  CONSTRAINT `comentariosblogs_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comentariosblogs_ibfk_1` FOREIGN KEY (`id_publicacionBlog`) REFERENCES `publicacionesblogs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  CONSTRAINT `cuenta_bancaria_FK` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `datoscontactoservicios`;
CREATE TABLE `datoscontactoservicios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `estado` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `municipio_alcaldia` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `colonia` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `calle` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `numeroExterior` varchar(10) COLLATE utf8_spanish2_ci NOT NULL,
  `numeroInterior` varchar(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8_spanish2_ci,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_servicio` bigint(20) unsigned DEFAULT NULL,
  `telefono1` varchar(22) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono2` varchar(22) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `email` varchar(66) COLLATE utf8_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_servicio` (`id_servicio`),
  CONSTRAINT `datoscontactoservicios_ibfk_1` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `denunciabuzon_servicios`;
CREATE TABLE `denunciabuzon_servicios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `motivo` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `descripcion` varchar(1500) COLLATE utf8_spanish2_ci NOT NULL,
  `revisar` tinyint(1) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  `id_servicio` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `denunciabuzons_FK` (`id_servicio`) USING BTREE,
  KEY `id_usuario` (`id_usuario`) USING BTREE,
  CONSTRAINT `denunciabuzon_servicios_FK` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `denunciabuzon_servicios_FK_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  CONSTRAINT `denunciabuzons_FK` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `denunciabuzons_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  CONSTRAINT `domiciliousuarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `envios`;
CREATE TABLE `envios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `orden_id` bigint(20) unsigned NOT NULL,
  `estado` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `direccion_envio_id` bigint(20) unsigned DEFAULT NULL,
  `fechaEntrega` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `envios_FK` (`orden_id`),
  KEY `envios_FK_1` (`direccion_envio_id`),
  CONSTRAINT `envios_FK` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `envios_FK_1` FOREIGN KEY (`direccion_envio_id`) REFERENCES `direccion_envios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  CONSTRAINT `favoritosproductos_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `favoritosproductos_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=233 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `imagenesusuarios`;
CREATE TABLE `imagenesusuarios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `es_portada` tinyint(1) NOT NULL,
  `id_usuario` bigint(20) unsigned NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
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
  CONSTRAINT `orden_detalles_FK` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orden_detalles_FK_1` FOREIGN KEY (`id_orden`) REFERENCES `ordenes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `pago`;
CREATE TABLE `pago` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint(20) unsigned DEFAULT NULL,
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
  CONSTRAINT `pago_FK` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `pago_FK_1` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  CONSTRAINT `preguntasproductos_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `preguntasproductos_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `preguntasservicios`;
CREATE TABLE `preguntasservicios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(1500) COLLATE utf8_spanish2_ci NOT NULL,
  `respuesta` varchar(2000) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_servicio` bigint(20) unsigned DEFAULT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_servicio` (`id_servicio`),
  KEY `preguntasservicios_FK` (`id_usuario`),
  CONSTRAINT `preguntasservicios_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `preguntasservicios_ibfk_1` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  `id_categoria` bigint(20) unsigned DEFAULT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_categoria` (`id_categoria`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  CONSTRAINT `publicacionesblogs_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  CONSTRAINT `reviewsproductos_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reviewsproductos_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `reviewsservicios`;
CREATE TABLE `reviewsservicios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `comentario` text COLLATE utf8_spanish2_ci NOT NULL,
  `calificacion` tinyint(1) NOT NULL,
  `id_servicio` bigint(20) unsigned NOT NULL,
  `id_usuario` bigint(20) unsigned NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `servicios`;
CREATE TABLE `servicios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(60) COLLATE utf8_spanish2_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish2_ci,
  `precio` double(10,2) NOT NULL,
  `id_categoria` bigint(20) unsigned DEFAULT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_categoria` (`id_categoria`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `servicios_FK` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`),
  CONSTRAINT `servicios_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

INSERT INTO `carrito_compra_detalles` (`id`, `id_producto`, `id_carrito_compra`, `cantidad`, `createdAt`, `updatedAt`) VALUES
(3, 126, 22, 1, '2023-06-10 03:57:33', '2023-06-10 03:57:33'),
(4, 92, 20, 1, '2023-09-27 22:51:18', '2023-09-27 22:51:18');

INSERT INTO `carritos_compras` (`id`, `fecha_creacion`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(17, '2023-05-27', 74, '2023-05-27 15:21:13', '2023-05-27 15:21:13'),
(20, '2023-06-01', 96, '2023-06-01 17:03:48', '2023-06-01 17:03:48'),
(22, '2023-06-08', 99, '2023-06-08 03:30:57', '2023-06-08 03:30:57'),
(23, '2023-06-30', 101, '2023-06-30 22:34:34', '2023-06-30 22:34:34');

INSERT INTO `categorias` (`id`, `nombre`, `id_parent`, `createdAt`, `updatedAt`) VALUES
(25, 'Tecnología', NULL, '2023-03-15 17:36:07', '2023-03-16 09:39:15'),
(26, 'Entretenimiento', NULL, '2023-03-15 17:36:19', '2023-03-15 20:08:52'),
(28, 'Salud', NULL, '2023-03-15 17:39:17', '2023-03-15 20:09:20'),
(29, 'Movilidad', NULL, '2023-03-15 19:43:45', '2023-03-15 20:09:34'),
(30, 'Enseñanza  Aprendizaje', NULL, '2023-03-15 19:44:03', '2023-03-15 20:10:46'),
(31, 'Mascotas', NULL, '2023-03-15 19:50:43', '2023-06-07 15:05:35'),
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
(56, 'Instalaciones', 25, '2023-04-11 14:55:33', '2023-04-11 14:55:44'),
(57, 'Atención Médica General y Especializada', 28, '2023-04-11 14:56:27', '2023-04-11 14:56:27'),
(58, 'Hospitalización', 28, '2023-04-11 14:56:54', '2023-04-11 14:56:54'),
(60, 'Fisioterapia', 28, '2023-04-11 14:57:46', '2023-04-11 14:57:46'),
(61, 'Nutrición', 28, '2023-04-11 14:58:32', '2023-04-11 14:58:32'),
(62, 'Deportes', 28, '2023-04-11 14:58:51', '2023-04-11 14:58:51'),
(64, 'Audición', 36, '2023-04-11 14:59:57', '2023-06-07 22:22:11'),
(65, 'Visión', 36, '2023-04-11 15:00:10', '2023-04-11 15:00:10'),
(79, 'Vestido', 37, '2023-06-07 14:50:23', '2023-06-07 14:50:23'),
(80, 'Calzado', 37, '2023-06-07 14:50:34', '2023-06-07 14:50:34'),
(81, 'Accesorios', 37, '2023-06-07 14:50:53', '2023-06-07 14:50:53'),
(82, 'Tendencias', 37, '2023-06-07 14:51:10', '2023-06-07 14:51:10'),
(83, 'Turismo', 26, '2023-06-07 14:51:33', '2023-06-07 14:51:33'),
(84, 'Recreación', 26, '2023-06-07 14:53:08', '2023-06-07 14:53:08'),
(85, 'Cultura', 26, '2023-06-07 14:53:20', '2023-06-07 14:53:20'),
(86, 'Actividades Sociales', 26, '2023-06-07 14:53:30', '2023-06-07 14:53:56'),
(87, 'Altruismo', 26, '2023-06-07 14:53:45', '2023-06-07 14:53:45'),
(88, 'Consultoría Asesoría', NULL, '2023-06-07 14:54:38', '2023-06-07 14:54:38'),
(89, 'Jurídica', 88, '2023-06-07 14:55:18', '2023-06-07 14:55:18'),
(90, 'Financiera', 88, '2023-06-07 14:55:31', '2023-06-07 14:55:31'),
(91, 'Laboral', 88, '2023-06-07 14:55:53', '2023-06-07 14:55:53'),
(92, 'Notarial', 88, '2023-06-07 14:56:03', '2023-06-07 14:56:03'),
(93, 'Contable', 88, '2023-06-07 14:56:14', '2023-06-07 14:56:14'),
(94, 'Seguros', 88, '2023-06-07 14:56:24', '2023-06-07 14:56:24'),
(95, 'Rehabilitación', 28, '2023-06-07 14:57:30', '2023-06-07 14:57:30'),
(96, 'Transporte', 29, '2023-06-07 14:58:12', '2023-06-07 14:58:12'),
(97, 'Comunidad habitacional', 29, '2023-06-07 14:58:33', '2023-06-07 14:58:33'),
(98, 'Almacenamiento', 29, '2023-06-07 14:58:55', '2023-06-07 14:58:55'),
(99, 'Cursos/talleres con modalidad Online y presencial', 30, '2023-06-07 15:00:24', '2023-06-07 15:00:24'),
(100, 'Programa Gran maestro', 30, '2023-06-07 15:00:58', '2023-06-07 15:00:58'),
(101, 'Adquisición/adopción', 31, '2023-06-07 15:02:04', '2023-06-07 15:02:04'),
(102, 'Cuidados', 31, '2023-06-07 15:02:17', '2023-06-07 15:02:17'),
(103, 'Atención médica', 31, '2023-06-07 15:02:33', '2023-06-07 15:02:33'),
(105, 'Accesorios Mascotas', 31, '2023-06-07 15:06:44', '2023-06-07 15:06:44'),
(106, 'Entretenimiento Mascotas', 31, '2023-06-07 15:07:13', '2023-06-07 15:07:13'),
(107, 'Remodelación', 32, '2023-06-07 15:07:30', '2023-06-07 15:07:30'),
(108, 'Habilitación', 32, '2023-06-07 15:07:44', '2023-06-07 15:07:44'),
(109, 'Venta/adquisición', 32, '2023-06-07 15:08:04', '2023-06-07 15:08:04'),
(110, 'Productos', 33, '2023-06-07 15:08:27', '2023-06-07 15:08:27'),
(111, 'Cuidado personal', 34, '2023-06-07 15:08:51', '2023-06-07 15:08:51'),
(112, 'Maquillaje', 34, '2023-06-07 15:09:07', '2023-06-07 15:09:07'),
(114, 'Servicios belleza', 34, '2023-06-07 15:09:26', '2023-06-08 22:47:52'),
(115, 'Movilidades', 36, '2023-06-07 22:27:01', '2023-06-07 22:38:53'),
(116, 'Limpieza del hogar', 117, '2023-06-08 22:46:56', '2023-06-08 22:48:20'),
(117, 'Servicios', NULL, '2023-06-08 22:47:59', '2023-06-08 22:48:52'),
(118, 'Peluquería', 117, '2023-06-08 22:48:07', '2023-06-08 22:52:19'),
(121, 'Automóviles', 117, '2023-06-30 22:09:16', '2023-06-30 22:09:16');

INSERT INTO `comentariosblogs` (`id`, `comentario`, `createdAt`, `updatedAt`, `id_publicacionBlog`, `id_usuario`) VALUES
(21, 'a bueno\n', '2023-04-24 18:06:17', '2023-04-24 18:06:17', NULL, 74),
(22, 'wfewf', '2023-05-27 18:44:39', '2023-05-27 18:44:39', NULL, 74),
(23, 'wefwef', '2023-05-27 18:44:41', '2023-05-27 18:44:41', NULL, 74),
(24, 'wefwef', '2023-05-27 18:44:44', '2023-05-27 18:44:44', NULL, 74),
(25, 'wef', '2023-05-27 18:44:46', '2023-05-27 18:44:46', NULL, 74),
(27, 'Excelente publicación!! ', '2023-07-05 20:05:45', '2023-07-05 20:05:45', 99, 96);

INSERT INTO `datoscontactoservicios` (`id`, `estado`, `municipio_alcaldia`, `colonia`, `calle`, `numeroExterior`, `numeroInterior`, `descripcion`, `createdAt`, `updatedAt`, `id_servicio`, `telefono1`, `telefono2`, `email`) VALUES
(12, 'Estado De México', 'Cuauhtémoc', 'Roma Norte', 'Calle Durango', 'SN', '', 'Departamento ubicado en el cuarto piso.', '2023-06-08 23:05:52', '2023-06-14 19:46:50', 79, '5551234567', '5551234562', 'ejemplo@email.com'),
(13, 'Nuevo León', 'Monterrey', 'Centro', 'Avenida Juárez', '456', '', 'Local ubicado en la plaza principal.', '2023-06-08 23:10:08', '2023-06-08 23:10:08', 80, '1234132434', '4356546547', ''),
(16, 'Tamaulipas', 'Nuevo Laredo', 'centro', 'Chiltepin', '13', '', 'Local ubicado a un costado de la escuela primaria Rojas.', '2023-06-30 22:12:35', '2023-06-30 22:12:35', 83, '7384738473', '', ''),
(18, 'Guanajuato', '4ewrr', 'w3r', 'w3rw3rw3r', '3', '', '', '2023-10-04 20:01:58', '2023-10-04 20:04:47', 85, '4234234324', '3423423423', '');

INSERT INTO `denunciabuzon_servicios` (`id`, `motivo`, `descripcion`, `revisar`, `createdAt`, `updatedAt`, `id_usuario`, `id_servicio`) VALUES
(4, 'Vende una copia o falsificación', '.', 0, '2023-06-10 16:02:24', '2023-06-10 16:02:24', 65, 80),
(5, 'Quiere cobrar un precio diferente o hay incoherencias con el precio y los servicios de la publicación.', 'no me parece buen servicio', 0, '2023-06-17 20:01:01', '2023-06-17 20:01:01', 99, 80);

INSERT INTO `denunciabuzons` (`id`, `motivo`, `descripcion`, `createdAt`, `updatedAt`, `id_usuario`, `id_producto`, `revisar`) VALUES
(23, 'Vende una copia o falsificación', 'me parece muy chafa ', '2023-06-14 20:11:04', '2023-10-04 18:26:09', 96, 126, 1),
(26, 'El producto genera dudas acerca de su legalidad o no transmite la confianza necesaria.', 'parece falso ', '2023-06-17 22:13:36', '2023-06-18 16:26:20', 65, 92, 1),
(27, 'Vende una copia o falsificación', 'Los tenis que vende son copia de los originales.', '2023-06-30 22:29:02', '2023-07-05 19:42:21', 101, 130, 1);

INSERT INTO `direccion_envios` (`id`, `estado`, `descripcion`, `nombre_ine`, `calle2`, `calle`, `postal`, `colonia`, `numeroInterior`, `calle1`, `municipio_alcaldia`, `numeroExterior`, `createdAt`, `updatedAt`) VALUES
(61, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-01 22:34:10', '2023-06-01 22:34:10'),
(62, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-01 22:37:18', '2023-06-01 22:37:18'),
(63, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-01 22:38:39', '2023-06-01 22:38:39'),
(64, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-01 22:39:50', '2023-06-01 22:39:50'),
(65, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-01 22:44:04', '2023-06-01 22:44:04'),
(66, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-01 22:54:51', '2023-06-01 22:54:51'),
(67, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-01 23:06:11', '2023-06-01 23:06:11'),
(68, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-01 23:08:06', '2023-06-01 23:08:06'),
(69, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-01 23:08:54', '2023-06-01 23:08:54'),
(70, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-01 23:10:56', '2023-06-01 23:10:56'),
(71, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-01 23:43:20', '2023-06-01 23:43:20'),
(72, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-02 01:03:37', '2023-06-02 01:03:37'),
(73, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-02 14:15:18', '2023-06-02 14:15:18'),
(74, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-02 14:37:45', '2023-06-02 14:37:45'),
(75, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-02 14:53:11', '2023-06-02 14:53:11'),
(76, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-02 15:07:11', '2023-06-02 15:07:11'),
(77, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-02 15:10:20', '2023-06-02 15:10:20'),
(78, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-02 15:16:54', '2023-06-02 15:16:54'),
(79, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-02 15:21:12', '2023-06-02 15:21:12'),
(80, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-02 16:28:46', '2023-06-02 16:28:46'),
(81, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-02 16:31:09', '2023-06-02 16:31:09'),
(82, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-02 16:43:37', '2023-06-02 16:43:37'),
(83, 'Morelos', 'Hay una casa blanca', 'FLORES CATALAN MIGUEL ANGEL', '', 'FELIPE FLORES', '34342', 'CENTRO', '', '', 'TLATIZAPAN', '9', '2023-06-02 20:51:24', '2023-06-02 20:51:24'),
(84, 'Coahuila', 'fefefsdfsdfvsf', 'FLORES CATALAN MIGUEL ANGEL', '', 'Calle Ejemplo', '62773', 'CENTRO', '', '', 'TLATIZAPAN', 'SN', '2023-06-08 03:28:44', '2023-06-08 03:28:44'),
(85, 'Baja California', 'awdadawd', 'sadasdadwd', '', 'dawdawda', '21312', 'wda', '', '', 'addad', 'SN', '2023-06-08 03:31:30', '2023-06-08 03:31:30'),
(86, 'Coahuila', 'fefefsdfsdfvsf', 'FLORES CATALAN MIGUEL ANGEL', '', 'Calle Ejemplo', '62773', 'CENTRO', '', '', 'TLATIZAPAN', 'SN', '2023-06-08 03:49:37', '2023-06-08 03:49:37'),
(87, 'Coahuila', 'fefefsdfsdfvsf', 'FLORES CATALAN MIGUEL ANGEL', '', 'Calle Ejemplo', '62773', 'CENTRO', '', '', 'TLATIZAPAN', 'SN', '2023-06-08 03:51:30', '2023-06-08 03:51:30'),
(88, 'Estado De México', 'Frente al parque principal, edificio de color verde.', ' Juan Pérez Rodiguez Mendoza', 'Calle Colima', 'Avenida Insurgentes', '12345', 'Roma Norte', '2B', 'Calle Durango', 'Cuauhtémoc', '123', '2023-06-14 20:35:34', '2023-06-14 20:35:34'),
(89, 'Morelos', 'EL domicilio esta ubicado frente a el oxxo en la gasolinera.', 'HUGO PEREZ MUÑOZ', '', 'Galeana', '45345', 'Centro', '', '', 'Jiutepec ', '34', '2023-06-30 22:37:32', '2023-06-30 22:37:32');

INSERT INTO `domiciliousuarios` (`id`, `nombre_ine`, `postal`, `estado`, `municipio_alcaldia`, `colonia`, `calle`, `numeroExterior`, `numeroInterior`, `calle1`, `calle2`, `descripcion`, `createdAt`, `updatedAt`, `id_usuario`) VALUES
(36, 'Juan Pérez', '12345', 'Jalisco', 'Guadalajara', 'Colonia Ejemplo', 'Calle Ejemplo', '123', 'A', 'Calle Ejemplo 1', 'Calle Ejemplo 2', 'Esta es una descripción del domicilio de ejemplo', '2023-05-11 23:15:09', '2023-05-12 15:47:29', 74),
(40, 'sASas', 'aSas', 'asa', 'aSasAS', 'SAsASas', 'aS', 'ASAs', 'asSA', 'asas', 'sASas', 'ASAsa', '2023-05-19 22:39:42', '2023-05-19 22:39:42', NULL),
(54, '213123123', '00123', 'Coahuila', '32323', '23', '2323', '', '', '', '', '', '2023-05-23 22:28:09', '2023-05-23 22:28:09', 65),
(55, 'Cliente Prueba', '62735', 'Morelos', 'Jiutepec', 'Joya', 'Aldama', 'SN', '6', 'Puente Flores', 'Maldonado', 'Es una casa con techo blanco.', '2023-05-25 18:08:15', '2023-05-25 18:08:15', NULL),
(65, 'HUGO PEREZ MUÑOZ', '45345', 'Morelos', 'Jiutepec ', 'Centro', 'Galeana', '34', '', '', '', 'EL domicilio esta ubicado frente a el oxxo en la gasolinera.', '2023-06-30 22:36:56', '2023-06-30 22:36:56', 101);

INSERT INTO `envios` (`id`, `orden_id`, `estado`, `direccion_envio_id`, `fechaEntrega`, `createdAt`, `updatedAt`) VALUES
(59, 82, 'En tránsito', 62, NULL, '2023-06-01 22:37:18', '2023-06-14 19:50:15'),
(63, 86, 'Pendiente', 66, NULL, '2023-06-01 22:54:51', '2023-06-01 22:54:51'),
(64, 87, 'Pendiente', 67, NULL, '2023-06-01 23:06:11', '2023-06-01 23:06:11'),
(66, 89, 'En tránsito', 69, NULL, '2023-06-01 23:08:54', '2023-06-09 18:33:25'),
(67, 90, 'Pendiente', 70, NULL, '2023-06-01 23:10:56', '2023-06-01 23:10:56'),
(69, 92, 'Pendiente', 72, NULL, '2023-06-02 01:03:37', '2023-06-02 01:03:37'),
(77, 107, 'Pendiente', 80, NULL, '2023-06-02 16:28:46', '2023-06-02 16:28:46'),
(78, 108, 'En tránsito', 81, NULL, '2023-06-02 16:31:09', '2023-06-02 20:27:15'),
(82, 112, 'Pendiente', 85, NULL, '2023-06-08 03:31:30', '2023-06-08 03:31:30'),
(83, 113, 'Pendiente', 86, NULL, '2023-06-08 03:49:37', '2023-06-08 03:49:37'),
(84, 114, 'Pendiente', 87, NULL, '2023-06-08 03:51:30', '2023-06-08 03:51:30'),
(85, 115, 'Pendiente', 88, NULL, '2023-06-14 20:35:34', '2023-06-14 20:35:34'),
(86, 116, 'Pendiente', 89, NULL, '2023-06-30 22:37:32', '2023-06-30 22:37:32');

INSERT INTO `favoritosproductos` (`id`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(5, '2023-04-18 16:00:43', '2023-04-18 16:00:43', 91, 77),
(6, '2023-04-18 16:02:38', '2023-04-18 16:02:38', 92, 77),
(7, '2023-04-18 21:17:13', '2023-04-18 21:17:13', NULL, 77),
(17, '2023-07-05 20:00:02', '2023-07-05 20:00:02', 128, 96),
(18, '2023-07-05 20:00:17', '2023-07-05 20:00:17', 129, 96);

INSERT INTO `imagenesblogs` (`id`, `url`, `es_portada`, `id_publicacionBlog`, `createdAt`, `updatedAt`) VALUES
(75, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F520898d3-5e61-4e7a-91cd-cd3fa519d11c_515d76c5-dd8e-400f-ad92-474415ce71c6?alt=media&token=17522bd5-d938-472b-abb9-a2a64d0e05f5', 1, 97, '2023-06-01 04:55:05', '2023-06-01 04:55:05'),
(76, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F07103abc-a785-459b-888e-74dcb001ef55_87e65eac-d723-4445-b713-6a21d169e6d9?alt=media&token=3bb5d55a-8852-48b5-b9d6-8d0d29ece06e', 1, 98, '2023-06-01 05:03:44', '2023-06-01 05:03:44'),
(77, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F6bddf76c-7c6a-4c58-8426-b7087ab00fb4_c8de6581-414c-480b-be2f-c3d447f48585?alt=media&token=5afdbbc5-39bd-4e4f-88f0-3a27acc5b9d8', 1, 99, '2023-06-01 05:26:02', '2023-06-01 05:26:02'),
(78, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F9faf5542-fbf1-4098-a0bf-a3b1459b3b45_0ad0c565-7988-49fd-b2c5-da48e58561c2?alt=media&token=e698b35b-655a-423c-bc45-6cac683c9874', 1, 100, '2023-06-01 05:27:05', '2023-06-01 05:27:05');

INSERT INTO `imagenesproductos` (`id`, `url`, `id_producto`, `es_portada`, `createdAt`, `updatedAt`) VALUES
(137, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F743cae5b-d478-4b14-b4ee-2ae376d60114_601d7874-03e4-4a43-97c2-eafc8e521a1d?alt=media&token=fe026e68-8328-4a48-ad57-157fb6094bf1', 91, 1, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(138, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F0d168260-0b78-4ebc-93b6-2b633d202161_b8ebc6ad-c715-4c62-b362-5dec871d1d11?alt=media&token=ff10633e-e38a-48d5-b3dd-99a92650c7b2', 91, 0, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(139, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F0d168260-0b78-4ebc-93b6-2b633d202161_e4e18b16-529b-4261-bdf9-8b36afcc3e5f?alt=media&token=1b05d6a9-9ecf-42bd-a85f-547b68d89d18', 91, 0, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(140, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F0d168260-0b78-4ebc-93b6-2b633d202161_9b704ac1-8ac3-49b5-ab7a-ecbdbe200955?alt=media&token=39ce7572-aee9-48c4-a207-008d14a2d10e', 91, 0, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(141, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F3b76336c-10a0-47ae-9bda-0f29c0e99c4d_ec54a85d-8dbf-4364-8256-aaa221cc8f59?alt=media&token=5ac78830-608f-40c2-be23-ca7f97eb3574', 92, 1, '2023-04-11 16:04:48', '2023-04-11 16:04:48'),
(142, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Fa1560457-bd4f-4772-9853-5703d9ff0d83_636483e1-921b-4e03-b6fa-739fa9ea2c4c?alt=media&token=41555e49-8723-49e3-81e5-d20e5fe806fc', 92, 0, '2023-04-11 16:04:48', '2023-04-11 16:04:48'),
(223, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F356a0263-b0b5-4ce9-a9c7-e92b7db83fb2_c11bcb46-057d-467d-8765-ed68b84624f0?alt=media&token=1da1b5fc-a972-4a1e-bef3-6e439750c1ec', 126, 1, '2023-06-07 16:17:19', '2023-06-07 16:17:19'),
(224, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F356a0263-b0b5-4ce9-a9c7-e92b7db83fb2_5bb81231-55f5-4442-a6ec-58355fb170ac?alt=media&token=691e140a-4258-4b04-983a-49f6af65eb49', 126, 0, '2023-06-07 16:17:19', '2023-06-07 16:17:19'),
(225, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F356a0263-b0b5-4ce9-a9c7-e92b7db83fb2_cd825150-53a8-4055-9ebf-a473e69f209c?alt=media&token=8c878858-ce0c-4392-a65c-2905d0feee50', 126, 0, '2023-06-07 16:17:19', '2023-06-07 16:17:19'),
(227, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F80e9af26-1d4b-4299-a7a9-4e0ff528f16a_0ac657d4-c212-4b34-84ff-104b1eb7dd22?alt=media&token=25a3a21c-993b-4998-9ef9-c432a2c58eec', 128, 1, '2023-06-09 17:08:19', '2023-06-09 17:08:19'),
(228, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Ff4e581db-f754-45a1-9647-7848f6ea78c8_63b917d3-6cfa-45f2-b606-3ade8152af87?alt=media&token=b81388b1-5c35-407b-aee4-000e9bbf6ee8', 129, 1, '2023-06-09 17:10:12', '2023-06-09 17:10:12'),
(229, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F58d8b2fc-07d2-4698-a874-ed081ff3e5b7_10e5480c-973b-49aa-a0ec-ba6699b40205?alt=media&token=cb85f5e6-4bc6-4f19-8f31-5e048d56c284', 130, 1, '2023-06-30 22:01:33', '2023-06-30 22:01:33'),
(230, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F58d8b2fc-07d2-4698-a874-ed081ff3e5b7_c15497ce-94a3-4de9-8cf5-14d6734a793b?alt=media&token=d7ac034f-7879-46a4-96c7-aeb249ce5cb3', 130, 0, '2023-06-30 22:01:33', '2023-06-30 22:01:33'),
(231, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F58d8b2fc-07d2-4698-a874-ed081ff3e5b7_c37b4823-cf83-45aa-b73c-48c29a51c229?alt=media&token=eb73da30-7fc1-4192-a471-b64f58a43c9f', 130, 0, '2023-06-30 22:01:33', '2023-06-30 22:01:33'),
(232, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F58d8b2fc-07d2-4698-a874-ed081ff3e5b7_bb731524-3051-41a8-991e-75bf78b521d7?alt=media&token=67798d68-3aaf-42d3-81d3-feaa9382f84e', 130, 0, '2023-06-30 22:01:33', '2023-06-30 22:01:33');

INSERT INTO `imagenesservicios` (`id`, `url`, `es_portada`, `id_servicio`, `createdAt`, `updatedAt`) VALUES
(77, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Fe89a38ab-66b9-4f0d-ac3d-e5986968f3e0_c6447c20-e2e9-4288-89bf-70f5bd44e425?alt=media&token=b3d71565-1325-44c6-8a23-86f64f06244f', 1, 79, '2023-06-08 23:07:37', '2023-06-08 23:07:37'),
(78, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Fe89a38ab-66b9-4f0d-ac3d-e5986968f3e0_ee0dfa5f-cd51-4c81-8d5b-892ece57504f?alt=media&token=7eda190f-6bb2-495e-9261-b44e54b39c98', 0, 79, '2023-06-08 23:07:37', '2023-06-08 23:07:37'),
(79, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Fe89a38ab-66b9-4f0d-ac3d-e5986968f3e0_9bb83923-5a3d-42d9-934d-8dc4332e7bf5?alt=media&token=f46f44bc-92ce-4ae1-b0ae-c0013313d280', 0, 79, '2023-06-08 23:07:37', '2023-06-08 23:07:37'),
(80, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Fbd957016-2605-4439-9822-ebb727fb14e1_585ba956-6358-48fe-b283-7376165bdc75?alt=media&token=61adc2af-d57f-4bda-895c-d535ee4dde09', 1, 80, '2023-06-08 23:10:19', '2023-06-08 23:10:19'),
(81, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Fbd957016-2605-4439-9822-ebb727fb14e1_8e8991cd-9a53-4134-8971-ac0a3e2a87db?alt=media&token=e7567410-fc70-4c3f-bace-db51372174e2', 0, 80, '2023-06-08 23:10:19', '2023-06-08 23:10:19'),
(86, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F26e133d3-2499-49b8-99e2-0fb6c67b29cf_4b3f5531-1e20-4fdb-bc89-cba2d482be81?alt=media&token=97d9c47b-51ea-4ca1-9765-258fcfdbeb20', 1, 83, '2023-06-30 22:13:56', '2023-06-30 22:13:56'),
(92, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F7dc3e59d-2f61-4361-898f-9c844edaf6a5_7109cb7a-6bdd-42eb-8b35-7af261680f9f?alt=media&token=56386429-3e81-41e5-b02d-3b27f997ac44', 1, 85, '2023-10-04 20:02:07', '2023-10-04 20:02:07');

INSERT INTO `orden_detalles` (`id`, `cantidad`, `precio_unitario`, `id_producto`, `id_orden`, `createdAt`, `updatedAt`) VALUES
(78, 1, '60.00', 91, 82, '2023-06-01 22:37:18', '2023-06-01 22:37:18'),
(82, 1, '10.00', 92, 86, '2023-06-01 22:54:51', '2023-06-01 22:54:51'),
(83, 1, '60.00', 91, 87, '2023-06-01 23:06:11', '2023-06-01 23:06:11'),
(85, 1, '10.00', 92, 89, '2023-06-01 23:08:54', '2023-06-01 23:08:54'),
(86, 1, '60.00', 91, 90, '2023-06-01 23:10:56', '2023-06-01 23:10:56'),
(88, 1, '60.00', 91, 92, '2023-06-02 01:03:37', '2023-06-02 01:03:37'),
(98, 1, '60.00', 91, 107, '2023-06-02 16:28:45', '2023-06-02 16:28:45'),
(99, 1, '10.00', 92, 107, '2023-06-02 16:28:46', '2023-06-02 16:28:46'),
(100, 1, '60.00', 91, 108, '2023-06-02 16:31:09', '2023-06-02 16:31:09'),
(102, 1, '10.00', 92, 108, '2023-06-02 16:31:09', '2023-06-02 16:31:09'),
(106, 1, '99.99', 126, 112, '2023-06-08 03:31:28', '2023-06-08 03:31:28'),
(107, 1, '60.00', 91, 113, '2023-06-08 03:49:34', '2023-06-08 03:49:34'),
(108, 1, '10.00', 92, 113, '2023-06-08 03:49:34', '2023-06-08 03:49:34'),
(109, 1, '99.99', 126, 113, '2023-06-08 03:49:34', '2023-06-08 03:49:34'),
(110, 7, '99.99', 126, 114, '2023-06-08 03:51:28', '2023-06-08 03:51:28'),
(111, 2, '10.00', 92, 115, '2023-06-14 20:35:30', '2023-06-14 20:35:30'),
(113, 1, '99.99', 126, 115, '2023-06-14 20:35:30', '2023-06-14 20:35:30'),
(114, 1, '79.99', 130, 116, '2023-06-30 22:37:30', '2023-06-30 22:37:30');

INSERT INTO `ordenes` (`id`, `total`, `estado_orden`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(82, '60.00', 'Pendiente', 96, '2023-06-01 22:37:17', '2023-06-01 22:37:18'),
(86, '10.00', 'Cancelada', 96, '2023-06-01 22:54:49', '2023-06-08 22:02:59'),
(87, '60.00', 'Completada', 96, '2023-06-01 23:06:09', '2023-06-08 22:06:30'),
(89, '10.00', 'En proceso', 96, '2023-06-01 23:08:53', '2023-06-13 23:50:13'),
(90, '60.00', 'En proceso', 96, '2023-06-01 23:10:55', '2023-06-08 21:53:03'),
(92, '60.00', 'Pendiente', 96, '2023-06-02 01:03:36', '2023-06-02 01:03:37'),
(107, '70.00', 'Completada', 96, '2023-06-02 16:28:44', '2023-06-08 22:06:41'),
(108, '170.00', 'Pendiente', 96, '2023-06-02 16:31:07', '2023-06-02 16:31:09'),
(112, '99.99', 'En proceso', 99, '2023-06-08 03:31:26', '2023-06-08 22:06:55'),
(113, '169.99', 'Pendiente', 96, '2023-06-08 03:49:33', '2023-06-08 03:49:37'),
(114, '699.93', 'Pendiente', 96, '2023-06-08 03:51:27', '2023-06-08 03:51:30'),
(115, '359.99', 'Pendiente', 96, '2023-06-14 20:35:27', '2023-06-14 20:35:34'),
(116, '79.99', 'Completada', 101, '2023-06-30 22:37:28', '2023-06-30 22:45:45');

INSERT INTO `pago` (`id`, `usuario_id`, `orden_id`, `monto`, `estado`, `id_pago_stripe`, `fecha_pago`, `createdAt`, `updatedAt`) VALUES
(24, 96, 82, '6000.00', 'Procesado', 'pi_3NEK7MIscKwQt1dm0Ki7zymj', '2023-06-01', '2023-06-01 22:37:18', '2023-06-01 22:37:18'),
(28, 96, 86, '1000.00', 'Procesado', 'pi_3NEKOKIscKwQt1dm2i8RSrkc', '2023-06-01', '2023-06-01 22:54:51', '2023-06-01 22:54:51'),
(29, 96, 87, '6000.00', 'Procesado', 'pi_3NEKZIIscKwQt1dm1bNq59DT', '2023-06-01', '2023-06-01 23:06:11', '2023-06-01 23:06:11'),
(31, 96, 89, '1000.00', 'Procesado', 'pi_3NEKbvIscKwQt1dm0XYGvlsI', '2023-06-01', '2023-06-01 23:08:54', '2023-06-01 23:08:54'),
(32, 96, 90, '6000.00', 'Procesado', 'pi_3NEKdtIscKwQt1dm078FtVPS', '2023-06-01', '2023-06-01 23:10:56', '2023-06-01 23:10:56'),
(34, 96, 92, '6000.00', 'Procesado', 'pi_3NEMOwIscKwQt1dm04dMWpDg', '2023-06-02', '2023-06-02 01:03:37', '2023-06-02 01:03:37'),
(42, 96, 107, '7000.00', 'Procesado', 'pi_3NEaqFIscKwQt1dm0MABeV8B', '2023-06-02', '2023-06-02 16:28:45', '2023-06-02 16:28:45'),
(43, 96, 108, '17000.00', 'Procesado', 'pi_3NEasZIscKwQt1dm0OAZ7wMz', '2023-06-02', '2023-06-02 16:31:09', '2023-06-02 16:31:09'),
(47, 99, 112, '9999.00', 'Procesado', 'pi_3NGZZJIscKwQt1dm0RabZRY3', '2023-06-08', '2023-06-08 03:31:28', '2023-06-08 03:31:28'),
(48, 96, 113, '16999.00', 'Procesado', 'pi_3NGZqqIscKwQt1dm2XsbVlYq', '2023-06-08', '2023-06-08 03:49:34', '2023-06-08 03:49:34'),
(49, 96, 114, '69993.00', 'Procesado', 'pi_3NGZsgIscKwQt1dm2Lfmdp5g', '2023-06-08', '2023-06-08 03:51:28', '2023-06-08 03:51:28'),
(50, 96, 115, '35999.00', 'Procesado', 'pi_3NJ0PcIscKwQt1dm28mzDbkj', '2023-06-14', '2023-06-14 20:35:29', '2023-06-14 20:35:30'),
(51, 101, 116, '7999.00', 'Procesado', 'pi_3NOpwSIscKwQt1dm2dowNvES', '2023-06-30', '2023-06-30 22:37:30', '2023-06-30 22:37:30');

INSERT INTO `preguntasproductos` (`id`, `pregunta`, `respuesta`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(31, 'Lo tendras en color negro?', '    ', '2023-06-30 22:26:55', '2023-10-04 18:22:00', 130, 101);

INSERT INTO `productos` (`id`, `nombre`, `precio`, `stock`, `descripcion`, `marca`, `modelo`, `color`, `estado`, `id_categoria`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(91, 'Batidora para Smoothies Nutritivos', 60, 0, 'La Batidora para Smoothies Nutritivos es una herramienta útil para adultos mayores que desean mejorar su nutrición y salud en general. Es fácil de usar y limpiar, y cuenta con una potencia suficiente para triturar frutas y verduras. Además, incluye recetas y consejos para preparar smoothies saludables.', 'Nutribullet', 'NBR-0801', 'Gris', 1, 61, 65, '2023-04-11 15:59:01', '2023-06-08 03:49:34'),
(92, 'Collar para Perros', 10, 32, ' Este collar para perros es de alta calidad y está hecho con materiales duraderos. Viene en varios tamaños y colores, lo que lo hace adecuado para todo tipo de perros. Además, tiene una hebilla de liberación rápida para mayor seguridad.', '', '', '', 1, 31, 65, '2023-04-11 16:04:13', '2023-06-14 20:35:30'),
(126, ' Teléfono móvil para adultos mayores \"SeniorPhone\"', 99.99, 40, ' El teléfono móvil para adultos mayores \"SeniorPhone\" está diseñado pensando en las necesidades específicas de las personas mayores. Cuenta con una interfaz simple y fácil de usar, grandes botones numéricos y un amplio display de alto contraste para facilitar la lectura. Además, incorpora funciones como llamadas de emergencia, linterna integrada y volumen amplificado para adaptarse a las dificultades de audición. Este teléfono es ideal para aquellos que buscan mantenerse conectados de manera sencilla y segura.', 'SeniorTech', 'SP-200', 'Negro', 1, 52, 96, '2023-06-07 16:15:27', '2023-06-14 20:35:30'),
(128, 'Champú revitalizante para mascotas', 15, 100, 'Un champú suave y enriquecido con ingredientes naturales que promueven el crecimiento del pelaje, fortalecen la piel y dejan a tu mascota con un aspecto saludable y brillante. Ideal para perros y gatos de todas las razas y tamaños.', 'PetCare', '', '', 1, 103, 99, '2023-06-09 17:07:34', '2023-06-09 17:07:34'),
(129, 'Barra de proteínas nutritivas', 3, 200, 'Una deliciosa barra de proteínas diseñada para proporcionar un impulso energético y satisfacer los requerimientos nutricionales después del ejercicio. Contiene una mezcla de proteínas de alta calidad y nutrientes clave para apoyar la recuperación muscular.', 'FitFuel', '', '', 1, 61, 99, '2023-06-09 17:09:20', '2023-06-09 17:09:20'),
(130, 'Zapatos ortopédicos para adultos mayores', 79.99, 3, 'Los zapatos ortopédicos para adultos mayores son una opción ideal para aquellos que buscan comodidad y soporte en su calzado. Están diseñados pensando en las necesidades específicas de las personas de edad avanzada, brindando un ajuste adecuado y una base estable para caminar. Estos zapatos cuentan con plantillas acolchadas y contorneadas, proporcionando un excelente soporte para el arco y reduciendo la presión en los pies. Además, tienen suelas antideslizantes que garantizan una mayor seguridad al caminar. Su estilo clásico y discreto los convierte en una opción elegante y funcional para cualquier ocasión.', 'ComfortWalk', 'CW-300', 'Negro', 1, 80, 96, '2023-06-30 22:00:45', '2023-10-04 20:04:33');

INSERT INTO `publicacionesblogs` (`id`, `titulo`, `descripcion`, `createdAt`, `updatedAt`, `id_usuario`) VALUES
(97, 'Viajes y aventuras: ¡Nunca es tarde para explorar el mundo!', 'En esta publicación, te invitamos a compartir tus increíbles historias de viajes y aventuras. ¿Has cumplido ese sueño de visitar un lugar exótico? ¿O tal vez descubriste nuevos destinos locales? Cuéntanos cómo el viajar ha enriquecido tu vida y ha hecho que cada día sea una emocionante travesía. Inspiremos a otros adultos mayores a embarcarse en nuevas aventuras y descubrir el mundo que nos rodea.', '2023-06-01 04:55:04', '2023-06-01 04:55:04', 65),
(98, 'Recetas tradicionales: Sabor y nostalgia en cada bocado', 'En este espacio, te animamos a compartir tus recetas tradicionales favoritas. ¿Tienes un plato especial que has heredado de generaciones anteriores? Comparte la historia detrás de esa receta y brinda instrucciones detalladas para recrearla en casa. La cocina es una forma maravillosa de mantener vivas nuestras tradiciones y compartir momentos especiales alrededor de la mesa. ¡Comparte tus sabores favoritos y haz que todos disfruten de la magia de la comida casera!', '2023-06-01 05:03:44', '2023-06-01 05:03:44', 65),
(99, 'Hobbies y pasiones: Descubriendo nuevas pasiones en la tercera edad', 'Descripción: Este blog está dedicado a los hobbies y pasiones que has descubierto o desarrollado en la tercera edad. ¿Has aprendido a pintar, tocar un instrumento musical o a bailar? ¿O tal vez encontraste un amor por la jardinería o la fotografía? Comparte tus experiencias, consejos y logros en el campo de tu pasión. ¡Anima a otros adultos mayores a explorar nuevas actividades y disfrutar de la vida al máximo!', '2023-06-01 05:26:02', '2023-06-01 05:26:02', 65),
(100, 'Reflexiones sobre el envejecimiento: Abrazando la sabiduría y la gratitud', ': En esta sección del blog, te invitamos a reflexionar sobre el proceso de envejecimiento y cómo has aprendido a abrazar la sabiduría y la gratitud en esta etapa de la vida. Comparte tus pensamientos sobre el paso del tiempo, la importancia de cuidar de uno mismo y las lecciones que has aprendido sobre la verdadera felicidad y el significado de la vida. Inspirémonos mutuamente para vivir una vida plena y significativa.', '2023-06-01 05:27:04', '2023-06-01 05:27:04', 65);

INSERT INTO `reviewsproductos` (`id`, `titulo`, `comentario`, `calificacion`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(14, 'muy malo ', 'es un collar muy malo no sirve se rompe', 2, '2023-07-31 13:19:55', '2023-07-31 13:19:55', 92, 96);

INSERT INTO `servicios` (`id`, `titulo`, `descripcion`, `precio`, `id_categoria`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(79, 'Limpieza de hogar', '$50 por hora\nDescripción del servicio: Ofrezco servicios de limpieza de hogar, incluyendo barrido, trapeado, aspirado, limpieza de baños y cocina, entre otros.', 50, 116, 65, '2023-06-08 23:04:14', '2023-06-08 23:04:14'),
(80, 'Corte de cabello', '$20\nDescripción del servicio: Realizo cortes de cabello modernos y clásicos para hombres y mujeres. También ofrezco servicios de peinado y arreglo de barba.', 20, 118, 65, '2023-06-08 23:08:17', '2023-06-08 23:08:17'),
(83, 'Lavado de autos', 'Lavado de autos completo a muy buen precio y de calidad.Los viernes hay dos por uno.', 250, 121, 65, '2023-06-30 22:10:17', '2023-06-30 22:15:18'),
(85, '34234', '', 234234, 54, 96, '2023-10-04 20:01:41', '2023-10-04 20:01:41');

INSERT INTO `usuarios` (`id`, `nombre`, `apellidoPaterno`, `apellidoMaterno`, `email`, `sexo`, `fechaNacimiento`, `telefono`, `password`, `tipoUsuario`, `createdAt`, `updatedAt`) VALUES
(65, 'Admin2', 'Admin2', 'Admin2', 'grandmarthtd@gmail.com', 'M', '2001-09-06', '2323232323', '$2a$10$1q4V2uq94qkMG77U7BUZRe7k5plMsr2Fzqo.7Fniw/MnKyL4ZpfiK', 1, '2023-03-14 19:19:25', '2023-06-30 21:15:08'),
(74, 'Admin1', 'Admin1', 'Admin1', 'admin@gmail.com', 'M', '2001-04-04', '4354534234', '$2a$10$/7xOXIiRBhO4NoNmo6T8fORzJNcokmdhHGGNRYGK7ph5d1vsJIBQ2', 1, '2023-04-09 22:13:18', '2023-06-08 22:20:06'),
(77, 'Cliente2', 'Cliente2', 'Cliente2', 'cliente2@gmail.com', 'M', '2001-04-03', '34234', '$2a$10$if6V2rX0.9p1Px1zXCmKseVicU2kSOOqFNmH9zuXUETFqJuj0S8t6', 0, '2023-04-11 15:52:41', '2023-04-11 19:31:33'),
(83, 'Repartidor2', 'Repartidor2', 'Repartidor2', 'repartidor2@gmail.com', 'M', '2000-02-23', '2313333333', '$2a$10$BznI6osMzShPBdED1NPOjeNEwkNNtVHLdnB/tw./O/rbM99TbcI7y', 2, '2023-05-22 14:34:07', '2023-05-31 13:31:23'),
(96, 'Miguel Angel', 'Flores', 'Catalán ', 'miguelangelfloca@gmail.com', 'M', '2001-09-26', '3423423423', '$2a$10$pWSNVOXPmKCdgImJGp7L9OLNsrHC9XUXaefhXnscTW0/n9vI9XkC2', 0, '2023-06-01 17:02:21', '2023-09-27 22:21:37'),
(99, 'Benito ', 'Pérez ', 'Rodríguez', 'juanperez@gmail.com', 'M', '1990-05-15', '1234567890', '$2a$10$VRvVgV427hihZFylX7f.S.6KTFUiMd3gN4tFDH/n7cyvemQdIMj4S', 0, '2023-06-07 18:42:09', '2023-06-07 18:44:02'),
(101, 'Hugo', 'Lopez', 'Muñoz', 'fcmo190775@upemor.edu.mx', 'M', '2001-09-23', '2342342342', '$2a$10$fE1AIfVZsvRF3sWD4oJWZOxLD.MeQui7LD/dHFFyiLM6m.WygqdzK', 0, '2023-06-30 22:24:45', '2023-06-30 22:24:45');

