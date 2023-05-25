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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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

DROP TABLE IF EXISTS `comisiones`;
CREATE TABLE `comisiones` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vendedor_id` bigint(20) unsigned NOT NULL,
  `orden_id` bigint(20) unsigned NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `estado` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comisiones_FK` (`vendedor_id`),
  KEY `comisiones_FK_1` (`orden_id`),
  CONSTRAINT `comisiones_FK` FOREIGN KEY (`vendedor_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `comisiones_FK_1` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  CONSTRAINT `denunciabuzon_servicios_FK` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id`),
  CONSTRAINT `denunciabuzons_ibfk_1_copy` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `denunciabuzons`;
CREATE TABLE `denunciabuzons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `motivo` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `descripcion` varchar(1500) COLLATE utf8_spanish2_ci NOT NULL,
  `revisar` tinyint(1) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  `id_producto` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `denunciabuzons_FK` (`id_producto`),
  CONSTRAINT `denunciabuzons_FK` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  CONSTRAINT `denunciabuzons_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  KEY `direccion_envios_FK` (`id_orden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `envios`;
CREATE TABLE `envios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `orden_id` bigint(20) unsigned NOT NULL,
  `estado` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `direccion_envio_id` bigint(20) unsigned NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `envios_FK` (`orden_id`),
  KEY `envios_FK_1` (`direccion_envio_id`),
  CONSTRAINT `envios_FK` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`),
  CONSTRAINT `envios_FK_1` FOREIGN KEY (`direccion_envio_id`) REFERENCES `direccion_envios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `estado_pagos`;
CREATE TABLE `estado_pagos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_orden` bigint(20) unsigned NOT NULL,
  `pagado` tinyint(1) NOT NULL,
  `metodo_pago` varchar(255) NOT NULL,
  `referencia_pago` varchar(255) NOT NULL,
  `detalles_pago` text,
  `fecha_pago` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `pago`;
CREATE TABLE `pago` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint(20) unsigned NOT NULL,
  `orden_id` bigint(20) unsigned NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pago_FK` (`usuario_id`),
  KEY `pago_FK_1` (`orden_id`),
  CONSTRAINT `pago_FK` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `pago_FK_1` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  CONSTRAINT `preguntasservicios_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `preguntasservicios_ibfk_1` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

INSERT INTO `carrito_compra_detalles` (`id`, `id_producto`, `id_carrito_compra`, `cantidad`, `createdAt`, `updatedAt`) VALUES
(1, 84, 10, 1, '2023-05-04 17:20:30', '2023-05-04 17:20:30'),
(6, 86, 9, 2, '2023-05-05 19:30:52', '2023-05-21 15:06:19'),
(7, 85, 9, 1, '2023-05-05 19:30:53', '2023-05-05 19:30:53'),
(8, 84, 9, 2, '2023-05-05 19:30:54', '2023-05-21 15:06:23'),
(9, 86, 11, 2, '2023-05-06 21:31:53', '2023-05-19 06:58:23'),
(10, 88, 11, 1, '2023-05-08 00:04:19', '2023-05-08 00:04:19'),
(11, 89, 11, 1, '2023-05-08 07:38:23', '2023-05-08 07:38:23'),
(18, 86, 12, 3, '2023-05-11 23:21:21', '2023-05-12 15:47:53'),
(19, 85, 12, 1, '2023-05-11 23:21:22', '2023-05-11 23:21:22'),
(23, 86, 13, 1, '2023-05-12 18:40:15', '2023-05-12 18:40:15'),
(24, 85, 13, 1, '2023-05-12 18:40:16', '2023-05-12 18:40:16'),
(25, 84, 13, 1, '2023-05-12 18:40:17', '2023-05-12 18:40:17'),
(26, 84, 11, 1, '2023-05-25 11:03:08', '2023-05-25 11:03:08');

INSERT INTO `carritos_compras` (`id`, `fecha_creacion`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(9, '2023-04-26', 74, '2023-04-26 19:37:28', '2023-04-26 19:37:28'),
(10, '2023-04-29', 76, '2023-04-29 17:32:58', '2023-04-29 17:32:58'),
(11, '2023-05-06', 79, '2023-05-06 21:31:53', '2023-05-06 21:31:53'),
(12, '2023-05-09', 80, '2023-05-09 16:13:00', '2023-05-09 16:13:00'),
(13, '2023-05-12', 65, '2023-05-12 18:34:30', '2023-05-12 18:34:30');

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
(21, 'a bueno\n', '2023-04-24 18:06:17', '2023-04-24 18:06:17', 78, 74),
(22, 'siuu', '2023-04-24 18:10:38', '2023-04-24 18:10:38', 78, 76);

INSERT INTO `denunciabuzon_servicios` (`id`, `motivo`, `descripcion`, `revisar`, `createdAt`, `updatedAt`, `id_usuario`, `id_servicio`) VALUES
(1, 'Tiene contenido ofensivo, obsceno o discriminatorio.', 'denunciaaaaaaa', 0, '2023-05-25 10:32:49', '2023-05-25 10:32:49', 74, 30);

INSERT INTO `denunciabuzons` (`id`, `motivo`, `descripcion`, `revisar`, `createdAt`, `updatedAt`, `id_usuario`, `id_producto`) VALUES
(20, 'Vende una copia o falsificación', 'me estafaron', 0, '2023-05-20 08:45:27', '2023-05-21 18:28:28', 74, 84),
(21, 'Utiliza datos de contacto en las respuestas o publicaciones.', 'me estafaron bien cabron', 1, '2023-05-20 20:56:52', '2023-05-23 22:01:15', 74, 89);

INSERT INTO `domiciliousuarios` (`id`, `nombre_ine`, `postal`, `estado`, `municipio_alcaldia`, `colonia`, `calle`, `numeroExterior`, `numeroInterior`, `calle1`, `calle2`, `descripcion`, `createdAt`, `updatedAt`, `id_usuario`) VALUES
(36, 'Juan Pérez', '12345', 'Jalisco', 'Guadalajara', 'Colonia Ejemplo', 'Calle Ejemplo', '123', 'A', 'Calle Ejemplo 1', 'Calle Ejemplo 2', 'Esta es una descripción del domicilio de ejemplo', '2023-05-11 23:15:09', '2023-05-12 15:47:29', 80),
(38, 'AWDAWDAWDAW', 'AWDAWD', 'AWDAWDA', 'WDAWD', 'AWDAWDA', 'AWDA', 'WD', 'WDAWDA', 'AWDAW', 'AWD', 'AWDAWD', '2023-05-12 18:40:54', '2023-05-12 18:40:54', 65),
(39, 'Cliente Prueba Prueba', '62730', 'Morelos', 'Jiutepec', 'Napoles', 'Pte. de las Flores', '6', '6', 'Aldama', 'Mira Montes', 'Es una casa verde', '2023-05-19 06:58:13', '2023-05-19 06:58:13', 79);

INSERT INTO `favoritosproductos` (`id`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(2, '2023-04-16 11:04:13', '2023-04-16 11:04:13', 88, NULL),
(3, '2023-04-17 13:27:10', '2023-04-17 13:27:10', 88, 65),
(4, '2023-04-17 13:27:41', '2023-04-17 13:27:41', 89, 65),
(5, '2023-04-18 16:00:43', '2023-04-18 16:00:43', 91, NULL),
(6, '2023-04-18 16:02:38', '2023-04-18 16:02:38', 92, NULL),
(7, '2023-04-18 21:17:13', '2023-04-18 21:17:13', 93, NULL),
(9, '2023-05-04 17:20:28', '2023-05-04 17:20:28', 86, 76),
(10, '2023-05-04 17:20:29', '2023-05-04 17:20:29', 84, 76),
(16, '2023-05-05 22:19:18', '2023-05-05 22:19:18', 87, 74),
(17, '2023-05-05 22:19:19', '2023-05-05 22:19:19', 86, 74),
(18, '2023-05-05 22:19:20', '2023-05-05 22:19:20', 88, 74),
(19, '2023-05-05 22:19:21', '2023-05-05 22:19:21', 89, 74),
(20, '2023-05-06 21:31:52', '2023-05-06 21:31:52', 86, 79),
(21, '2023-05-08 00:04:18', '2023-05-08 00:04:18', 88, 79),
(22, '2023-05-11 20:45:28', '2023-05-11 20:45:28', 86, 80);

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
(137, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F743cae5b-d478-4b14-b4ee-2ae376d60114_601d7874-03e4-4a43-97c2-eafc8e521a1d?alt=media&token=fe026e68-8328-4a48-ad57-157fb6094bf1', 91, 1, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(138, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F0d168260-0b78-4ebc-93b6-2b633d202161_b8ebc6ad-c715-4c62-b362-5dec871d1d11?alt=media&token=ff10633e-e38a-48d5-b3dd-99a92650c7b2', 91, 0, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(139, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F0d168260-0b78-4ebc-93b6-2b633d202161_e4e18b16-529b-4261-bdf9-8b36afcc3e5f?alt=media&token=1b05d6a9-9ecf-42bd-a85f-547b68d89d18', 91, 0, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(140, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F0d168260-0b78-4ebc-93b6-2b633d202161_9b704ac1-8ac3-49b5-ab7a-ecbdbe200955?alt=media&token=39ce7572-aee9-48c4-a207-008d14a2d10e', 91, 0, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(141, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F3b76336c-10a0-47ae-9bda-0f29c0e99c4d_ec54a85d-8dbf-4364-8256-aaa221cc8f59?alt=media&token=5ac78830-608f-40c2-be23-ca7f97eb3574', 92, 1, '2023-04-11 16:04:48', '2023-04-11 16:04:48'),
(142, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Fa1560457-bd4f-4772-9853-5703d9ff0d83_636483e1-921b-4e03-b6fa-739fa9ea2c4c?alt=media&token=41555e49-8723-49e3-81e5-d20e5fe806fc', 92, 0, '2023-04-11 16:04:48', '2023-04-11 16:04:48'),
(143, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F2ce4c440-43c3-4a10-9822-5ebd0faf8ebf_9609e7b4-3d0c-4e55-a7ec-1a304f590484?alt=media&token=15ec4d3c-1cb2-49d6-bc1f-dfa51eebcfdb', 93, 1, '2023-04-11 16:06:33', '2023-04-11 16:06:33'),
(144, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F76cc811a-7f47-40ee-98ad-23720c4ec8f8_74120d6b-40a1-48fd-9ae3-9f93ae99dfe7?alt=media&token=e7445dae-878c-45e3-863a-b8377cc33dce', 93, 0, '2023-04-11 16:06:33', '2023-04-11 16:06:33'),
(145, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F76cc811a-7f47-40ee-98ad-23720c4ec8f8_ab555593-252d-49f4-a1f5-0512afd5c07f?alt=media&token=801d5ed9-89dc-4bd5-b614-b25d566d9047', 93, 0, '2023-04-11 16:06:33', '2023-04-11 16:06:33'),
(146, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F359533d7-f897-4146-aa28-f5e725e5218b_f411e11c-d458-417e-8e0a-4e3c43d09028?alt=media&token=7b0a4d18-f9cc-4f0d-bb00-d41bb03748a2', 94, 0, '2023-05-18 20:00:56', '2023-05-18 20:00:56'),
(147, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F359533d7-f897-4146-aa28-f5e725e5218b_a4223ce1-2736-4309-bf31-d79a2e4370de?alt=media&token=72ce3800-2140-40f3-82da-56bdde01e859', 94, 1, '2023-05-18 20:00:56', '2023-05-18 20:00:56'),
(148, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F359533d7-f897-4146-aa28-f5e725e5218b_1a5b039c-1bce-47d7-ac9f-78c894ef52ba?alt=media&token=ec5dfc62-769e-48ff-956b-573591b80303', 94, 0, '2023-05-18 20:00:56', '2023-05-18 20:00:56');

INSERT INTO `imagenesservicios` (`id`, `url`, `es_portada`, `id_servicio`, `createdAt`, `updatedAt`) VALUES
(10, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Ffb9c6d55-6ca5-4ef9-b5cd-0c380e701a5e_f6267e12-dd3b-46dc-a894-a133cc39ca52?alt=media&token=37dd5380-4a6e-4bf2-ae78-80546a8aabda', 1, 30, '2023-05-23 22:09:32', '2023-05-23 22:09:32'),
(11, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Ffb9c6d55-6ca5-4ef9-b5cd-0c380e701a5e_b95c5340-db76-46f7-94bf-3d185b20fd20?alt=media&token=59346b52-b925-4e4d-83c7-a2c4506b568b', 0, 30, '2023-05-23 22:09:32', '2023-05-23 22:09:32'),
(12, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Ffb9c6d55-6ca5-4ef9-b5cd-0c380e701a5e_dd6dc9a5-781b-4d76-abf9-176c3247bf5c?alt=media&token=a946c327-ae30-4c0b-8321-cdc057995dc6', 0, 30, '2023-05-23 22:09:32', '2023-05-23 22:09:32');

INSERT INTO `ordenes` (`id`, `total`, `estado_orden`, `id_usuario`, `fechaEntrega`, `createdAt`, `updatedAt`) VALUES
(1, '0.00', 'Pendiente', 79, NULL, '2023-05-25 04:35:18', '2023-05-25 04:35:18'),
(2, '0.00', 'Pendiente', 79, NULL, '2023-05-25 04:35:37', '2023-05-25 04:35:37'),
(3, '0.00', 'Pendiente', 79, NULL, '2023-05-25 11:05:25', '2023-05-25 11:05:25');

INSERT INTO `preguntasproductos` (`id`, `pregunta`, `respuesta`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(2, 'lo tienes verde?', 'Si si lo tenemos bien verde', '2023-04-22 21:52:07', '2023-05-24 19:15:38', 85, 74),
(50, 'a la bestia tio', 'jej', '2023-05-17 17:10:41', '2023-05-24 19:15:27', 84, 74),
(57, 'cuánto te mide?', '1cm', '2023-05-17 20:22:16', '2023-05-24 22:08:09', 84, 74),
(58, 'k dia es hoy', 'hoy me voy a suicidar', '2023-05-18 15:53:04', '2023-05-24 19:15:31', 84, 74),
(59, 'si me corre el frifai?', NULL, '2023-05-24 07:16:37', '2023-05-24 07:16:37', 87, 74),
(60, 'de a cómo la coca?', 'a peso', '2023-05-24 19:04:16', '2023-05-24 19:15:35', 84, 74),
(61, 'por donde keda?', NULL, '2023-05-25 07:24:56', '2023-05-25 07:24:56', 84, 74);

INSERT INTO `preguntasservicios` (`id`, `pregunta`, `respuesta`, `createdAt`, `updatedAt`, `id_servicio`, `id_usuario`) VALUES
(2, 'Precio y cuánto cuesta?', 'le damos precio', '2023-05-24 17:05:52', '2023-05-24 22:06:46', 30, 74),
(3, 'apoco si pa?', 'calmese pa', '2023-05-24 17:54:34', '2023-05-24 22:08:20', 30, 74),
(4, 'Me cago en la puta?', NULL, '2023-05-24 22:02:51', '2023-05-24 22:02:51', 30, 74),
(5, 'a k ora son??', NULL, '2023-05-25 07:24:38', '2023-05-25 07:24:38', 30, 74);

INSERT INTO `productos` (`id`, `nombre`, `precio`, `stock`, `descripcion`, `marca`, `modelo`, `color`, `estado`, `id_categoria`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(84, 'Audífonos Amplificadores de Sonido', 100, 50, 'Los Audífonos Amplificadores de Sonido están diseñados especialmente para adultos mayores que tienen problemas de audición. Estos audífonos proporcionan una calidad de sonido clara y nítida, permitiendo una mejor audición y comunicación. Además, son cómodos de usar y fáciles de ajustar según las necesidades del usuario.', ' Amplifon', 'X Mini', 'Beige', 1, 64, 74, '2023-04-11 15:16:39', '2023-04-11 15:16:39'),
(85, 'Monitor de Presión Arterial', 50, 100, 'El Monitor de Presión Arterial es un producto esencial para adultos mayores que necesitan controlar su presión arterial. Este monitor es fácil de usar y proporciona mediciones precisas. Además, cuenta con una pantalla grande y fácil de leer, y puede almacenar las mediciones para un seguimiento a largo plazo.', 'Omron', 'BP742N', 'Blanco', 1, 65, 74, '2023-04-11 15:31:33', '2023-04-11 15:31:33'),
(86, 'Andador Plegable con Asiento', 150, 30, 'El Andador Plegable con Asiento es un producto ideal para adultos mayores que necesitan ayuda para caminar y descansar de vez en cuando. Este andador es fácil de usar y cuenta con un asiento cómodo y seguro. Además, se pliega para un fácil almacenamiento y transporte.', 'Drive Medical', 'Nitro DLX', 'Azul', 1, 59, 76, '2023-04-11 15:40:55', '2023-04-11 15:40:55'),
(87, 'Tablet para Adultos Mayores', 2000, 20, ' La Tablet para Adultos Mayores es una herramienta tecnológica diseñada especialmente para este grupo de edad. Cuenta con una interfaz de usuario fácil de usar y botones grandes para una navegación sencilla. Además, cuenta con aplicaciones útiles como un calendario, reloj, acceso a Internet y correo electrónico. También incluye soporte técnico para cualquier duda o problema.', 'GrandPad', 'GrandPad', 'Gris', 1, 51, 76, '2023-04-11 15:44:32', '2023-04-11 15:44:32'),
(88, 'Teléfono con Teclas Grandes', 50, 50, 'El Teléfono con Teclas Grandes es ideal para adultos mayores que necesitan un teléfono fácil de usar y leer. Cuenta con teclas grandes y de alto contraste, una pantalla grande y fácil de leer, y un volumen ajustable. Además, tiene funciones adicionales como identificador de llamadas y memoria para guardar números importantes.', 'Clarity', 'P300', 'Blanco', 1, 52, 76, '2023-04-11 15:48:23', '2023-04-11 15:48:23'),
(89, 'Pulsera Inteligente para Monitoreo de Actividad', 80, 30, ' La Pulsera Inteligente para Monitoreo de Actividad es un gadget útil para adultos mayores que desean monitorear su actividad física y salud. Cuenta con funciones como un podómetro, monitor de ritmo cardíaco y monitoreo de sueño. Además, puede conectarse a una aplicación móvil para obtener un seguimiento más detallado.', 'Fitbit', 'Inspire 2', 'Negro', 1, 53, 76, '2023-04-11 15:50:35', '2023-04-11 15:50:35'),
(91, 'Batidora para Smoothies Nutritivos', 60, 20, 'La Batidora para Smoothies Nutritivos es una herramienta útil para adultos mayores que desean mejorar su nutrición y salud en general. Es fácil de usar y limpiar, y cuenta con una potencia suficiente para triturar frutas y verduras. Además, incluye recetas y consejos para preparar smoothies saludables.', 'Nutribullet', 'NBR-0801', 'Gris', 1, 61, 65, '2023-04-11 15:59:01', '2023-04-11 15:59:01'),
(92, 'Collar para Perros', 10, 50, ' Este collar para perros es de alta calidad y está hecho con materiales duraderos. Viene en varios tamaños y colores, lo que lo hace adecuado para todo tipo de perros. Además, tiene una hebilla de liberación rápida para mayor seguridad.', '', '', '', 1, 66, 65, '2023-04-11 16:04:13', '2023-04-11 16:04:13'),
(93, 'Cinta de Correr para Ejercicio en Casa', 500, 5, 'La Cinta de Correr para Ejercicio en Casa es una herramienta útil para adultos mayores que desean mantenerse activos y saludables sin salir de casa. Es fácil de usar y ajustable, y cuenta con una variedad de programas de entrenamiento para diferentes niveles de condición física. Además, es plegable para un fácil almacenamiento.', 'ordicTrack', 'T 6.5 Si', 'Gris', 1, 62, 65, '2023-04-11 16:05:57', '2023-04-11 16:05:57'),
(94, 'Control de playbox', 1500, 2, 'El mejor control gaymer', 'Playbox', '', 'Negro', 1, 53, 74, '2023-05-18 20:00:38', '2023-05-18 20:00:38');

INSERT INTO `publicacionesblogs` (`id`, `titulo`, `descripcion`, `createdAt`, `updatedAt`, `id_usuario`) VALUES
(78, 'Hola esta es Título de publicación ', 'Descripción ', '2023-04-24 17:57:02', '2023-04-24 17:57:02', 74);

INSERT INTO `reviewsproductos` (`id`, `titulo`, `comentario`, `calificacion`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(4, 'SQWS', 'SQ', 4, '2023-04-28 21:13:41', '2023-04-28 21:13:41', 88, 74),
(5, 'menuda mierda', 'sdasdas', 1, '2023-04-28 21:13:41', '2023-04-28 21:13:41', 88, 76),
(6, 'Esta de la vergui jajaja', 'La neta no me gusto caca', 4, '2023-04-29 17:28:12', '2023-04-29 17:28:12', 85, 76);

INSERT INTO `servicios` (`id`, `titulo`, `descripcion`, `precio`, `id_categoria`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(30, 'Terapia Spa Morelos', 'TERAPEUTAS CERTIFICADAS\nSERVICIOS A DOMICILIO\nCUERPO COMPLETO EXCEPTO PARTES INTIMAS ( 100% PROFESIONAL )\n\nSESIONES DE 60 Y 30 MINUTOS\nHORARIO DE SERVICIO DE 8:00 AM a 7:30 PM\nLUNES A DOMINGO\n\nMASAJE RELAJANTE: Ideal para reducir el estrés y tensiones musculares, perfecta para la relajación y paz que buscas.\n\nMASAJE PARA PAREJAS: Eleva a un estado de relajación sublime, ideal para romper la monotonía de la rutina (RELAJANTE O DESCONTRACTURANTE)\n\nMASAJE DESCONTRACTURANTE: Ayuda a liberar tensión y reducir dolores musculares.\n\nPIEDRAS CALIENTES: Revitaliza y oxigena la piel, alivia dolores de espalda y mejora la circulación sanguínea.\n\nREFLEXOLOGIA PODAL: Esta técnica aplica presión en las plantas de tus pies estimulando terminaciones nerviosas del cuerpo,\n\nVENTOSAS (CUPPING): Ideal para suavizar contracturas profundas, provoca un aumento de la irrigación sanguínea.\n\nMASAJE REDUCTIVO: Mueve tejidos adiposos y los canaliza adecuadamente, para que el propio organismo los deseche.', 960, 59, 74, '2023-05-23 22:09:07', '2023-05-23 22:09:07');

INSERT INTO `usuarios` (`id`, `nombre`, `apellidoPaterno`, `apellidoMaterno`, `email`, `sexo`, `fechaNacimiento`, `telefono`, `password`, `tipoUsuario`, `createdAt`, `updatedAt`) VALUES
(65, 'Miguel Ángel ', 'Flores', 'Catalán', 'admin@123', 'M', '2023-03-06', '2313', '$2a$10$0zHDcRP5Ub9MDgdTOevV6uOx4sF77ibidU2CKrRLToHShZH2s.ih.', 1, '2023-03-14 19:19:25', '2023-05-12 15:56:54'),
(74, 'Brayan', 'Chavez ', 'Gasca', 'admin@gmail.com', 'M', '2023-04-04', '435453', '$2a$10$quBryYhGp8Q85TbSmGggDuSddCMNePjs2IJ1VFebR3aSBQ26WTGTe', 1, '2023-04-09 22:13:18', '2023-05-06 21:25:37'),
(76, 'Adolfo ', 'López ', 'Figueroa', 'cliente@123', 'M', '2006-10-18', '213123', '$2a$10$CFGRT/GBvNhmdyBJuF.3jODDxJgM0bWmhZ5dQ4ORjfcZUBdotqpHa', 0, '2023-04-11 15:39:39', '2023-04-11 15:39:39'),
(78, 'ssasasad', 'dwdwd', 'wdwdww', 'wdwdef@sd', 'M', '2023-07-04', 'wddfdfdf', '$2a$10$6OxoMDSKlltMCyswj590KOedokJnLYtP9vCazk2CDrhfTEu66gCFO', 0, '2023-05-03 16:46:28', '2023-05-03 16:46:28'),
(79, 'Cliente', 'Prueba', 'Prueba', 'cliente@gmail.com', 'M', '2023-05-18', '2345678', '$2a$10$pmyO6.3WLAN0VeKE4h4pJek.P84LTrkBwFr9MQ5gtkpk7JHOdgwKm', 0, '2023-05-06 21:29:10', '2023-05-06 21:29:10'),
(80, 'fewfwef', 'wefwef', 'ewfwef', 'admin02wef@123', 'M', '2023-05-04', 'wef23123213', '$2a$10$Gt6LhcqGvwOI/KTR57dhBuZybAs0CiL4uzC8Otb5CZuDGXH0hBlae', 0, '2023-05-09 15:28:44', '2023-05-09 15:28:44'),
(81, 'Brayan', 'Chavez', 'Robles', 'pruebaa@gmail.com', 'M', '2023-05-10', '54678', '$2a$10$qeMsp6WSF09hCzkWdrTcqeqcwM3MlAexxMJPuabUaRep0nGVjdGoS', 0, '2023-05-15 19:15:35', '2023-05-15 19:15:35');

