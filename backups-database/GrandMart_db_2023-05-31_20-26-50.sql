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
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  `telefono1` varchar(22) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono2` varchar(22) COLLATE utf8_spanish2_ci NOT NULL,
  `email` varchar(66) COLLATE utf8_spanish2_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_servicio` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_servicio` (`id_servicio`),
  CONSTRAINT `datoscontactoservicios_ibfk_1` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  CONSTRAINT `denunciabuzon_servicios_FK` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `denunciabuzon_servicios_FK_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
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
  CONSTRAINT `denunciabuzons_FK` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `denunciabuzons_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  CONSTRAINT `orden_detalles_FK` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orden_detalles_FK_1` FOREIGN KEY (`id_orden`) REFERENCES `ordenes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  `id_categoria` bigint(20) unsigned DEFAULT NULL,
  `id_usuario` bigint(20) unsigned DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_categoria` (`id_categoria`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
  CONSTRAINT `ubicacionesservicios_ibfk_1` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

INSERT INTO `carritos_compras` (`id`, `fecha_creacion`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(16, '2023-05-26', 76, '2023-05-26 15:08:41', '2023-05-26 15:08:41'),
(17, '2023-05-27', 74, '2023-05-27 15:21:13', '2023-05-27 15:21:13');

INSERT INTO `categorias` (`id`, `nombre`, `id_parent`, `createdAt`, `updatedAt`) VALUES
(25, 'Tecnología', NULL, '2023-03-15 17:36:07', '2023-03-16 09:39:15'),
(26, 'Entretenimiento', NULL, '2023-03-15 17:36:19', '2023-03-15 20:08:52'),
(28, 'Salud', NULL, '2023-03-15 17:39:17', '2023-03-15 20:09:20'),
(29, 'Movilidad', NULL, '2023-03-15 19:43:45', '2023-03-15 20:09:34'),
(30, 'Enseñanza  Aprendizaje', NULL, '2023-03-15 19:44:03', '2023-03-15 20:10:46'),
(31, 'Mascotas', 30, '2023-03-15 19:50:43', '2023-05-30 19:40:44'),
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
(64, 'Audición', 34, '2023-04-11 14:59:57', '2023-05-30 19:40:51'),
(65, 'Visión', 36, '2023-04-11 15:00:10', '2023-04-11 15:00:10'),
(66, 'Accesorios para Mascotas', 31, '2023-04-11 16:03:02', '2023-04-11 16:03:02'),
(70, 'wewe', NULL, '2023-05-31 16:14:13', '2023-05-31 16:14:13'),
(71, '', NULL, '2023-05-31 16:14:55', '2023-05-31 16:14:55'),
(72, 'ewe', NULL, '2023-05-31 16:18:37', '2023-05-31 16:18:37'),
(73, 'adsadaw', NULL, '2023-05-31 16:19:07', '2023-05-31 16:19:20'),
(74, 'sdfdf', NULL, '2023-05-31 16:28:16', '2023-05-31 16:28:16'),
(75, 'sdsadasd', NULL, '2023-05-31 16:28:31', '2023-05-31 16:28:31'),
(76, 'sasa', NULL, '2023-05-31 16:29:18', '2023-05-31 16:29:18'),
(77, 'asas', 26, '2023-05-31 16:29:25', '2023-05-31 16:29:25');

INSERT INTO `comentariosblogs` (`id`, `comentario`, `createdAt`, `updatedAt`, `id_publicacionBlog`, `id_usuario`) VALUES
(21, 'a bueno\n', '2023-04-24 18:06:17', '2023-04-24 18:06:17', NULL, 74),
(22, 'wfewf', '2023-05-27 18:44:39', '2023-05-27 18:44:39', NULL, 74),
(23, 'wefwef', '2023-05-27 18:44:41', '2023-05-27 18:44:41', NULL, 74),
(24, 'wefwef', '2023-05-27 18:44:44', '2023-05-27 18:44:44', NULL, 74),
(25, 'wef', '2023-05-27 18:44:46', '2023-05-27 18:44:46', NULL, 74);

INSERT INTO `denunciabuzons` (`id`, `motivo`, `descripcion`, `createdAt`, `updatedAt`, `id_usuario`, `id_producto`, `revisar`) VALUES
(6, 'Vende una copia o falsificación', 'Este vendedor ha estado ofreciendo productos copia.', '2023-05-26 13:43:48', '2023-05-26 13:43:48', 74, 84, 0),
(7, 'Vende una copia o falsificación', 'creo que este producto es falso ', '2023-05-26 15:28:05', '2023-05-31 16:33:42', 76, 89, 1);

INSERT INTO `direccion_envios` (`id`, `estado`, `descripcion`, `nombre_ine`, `calle2`, `calle`, `postal`, `colonia`, `numeroInterior`, `calle1`, `municipio_alcaldia`, `numeroExterior`, `createdAt`, `updatedAt`) VALUES
(58, 'Baja California Sur', '12312asd', 'wdsadsdasd', '21312', '21321', '23213', '23', '12312', '3123', '2313', 'SN', '2023-05-31 21:07:50', '2023-05-31 21:07:50');

INSERT INTO `domiciliousuarios` (`id`, `nombre_ine`, `postal`, `estado`, `municipio_alcaldia`, `colonia`, `calle`, `numeroExterior`, `numeroInterior`, `calle1`, `calle2`, `descripcion`, `createdAt`, `updatedAt`, `id_usuario`) VALUES
(36, 'Juan Pérez', '12345', 'Jalisco', 'Guadalajara', 'Colonia Ejemplo', 'Calle Ejemplo', '123', 'A', 'Calle Ejemplo 1', 'Calle Ejemplo 2', 'Esta es una descripción del domicilio de ejemplo', '2023-05-11 23:15:09', '2023-05-12 15:47:29', 74),
(40, 'sASas', 'aSas', 'asa', 'aSasAS', 'SAsASas', 'aS', 'ASAs', 'asSA', 'asas', 'sASas', 'ASAsa', '2023-05-19 22:39:42', '2023-05-19 22:39:42', NULL),
(54, '213123123', '00123', 'Coahuila', '32323', '23', '2323', '', '', '', '', '', '2023-05-23 22:28:09', '2023-05-23 22:28:09', 65),
(55, 'Cliente Prueba', '62735', 'Morelos', 'Jiutepec', 'Joya', 'Aldama', 'SN', '6', 'Puente Flores', 'Maldonado', 'Es una casa con techo blanco.', '2023-05-25 18:08:15', '2023-05-25 18:08:15', NULL),
(56, 'wdsadsdasd', '23213', 'Baja California Sur', '2313', '23', '21321', 'SN', '12312', '3123', '21312', '12312asd', '2023-05-27 13:12:58', '2023-05-27 13:12:58', 76);

INSERT INTO `envios` (`id`, `orden_id`, `estado`, `direccion_envio_id`, `fechaEntrega`, `createdAt`, `updatedAt`) VALUES
(55, 77, 'Cancelado', 58, NULL, '2023-05-31 21:07:50', '2023-05-31 21:36:57');

INSERT INTO `favoritosproductos` (`id`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(2, '2023-04-16 11:04:13', '2023-04-16 11:04:13', 88, 77),
(5, '2023-04-18 16:00:43', '2023-04-18 16:00:43', 91, 77),
(6, '2023-04-18 16:02:38', '2023-04-18 16:02:38', 92, 77),
(7, '2023-04-18 21:17:13', '2023-04-18 21:17:13', NULL, 77),
(20, '2023-05-06 21:31:52', '2023-05-06 21:31:52', 86, NULL),
(21, '2023-05-08 00:04:18', '2023-05-08 00:04:18', 88, NULL),
(22, '2023-05-11 20:45:28', '2023-05-11 20:45:28', 86, NULL),
(26, '2023-05-25 17:58:01', '2023-05-25 17:58:01', 87, NULL),
(40, '2023-05-26 00:02:59', '2023-05-26 00:02:59', 86, 76),
(41, '2023-05-26 00:03:00', '2023-05-26 00:03:00', 85, 76);

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
(189, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F78328334-f22d-47aa-931e-2f7832fd2185_58871917-8c5d-4f1a-add0-287b3bad62e2?alt=media&token=0d9ff4c1-11ec-4c33-982b-3541fe240857', 111, 1, '2023-05-31 13:39:27', '2023-05-31 13:39:27'),
(190, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F78328334-f22d-47aa-931e-2f7832fd2185_fb906618-22c7-4c6e-b55d-326ba645c6cb?alt=media&token=abdf34e5-2797-4ea4-8255-e4fdc59eae8e', 111, 0, '2023-05-31 13:39:27', '2023-05-31 13:39:27'),
(191, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F78328334-f22d-47aa-931e-2f7832fd2185_802f3bb5-5bec-4092-83a5-64ff19182313?alt=media&token=bac6638d-4834-4c20-a96e-58634b1ec025', 111, 0, '2023-05-31 13:39:27', '2023-05-31 13:39:27'),
(192, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F78328334-f22d-47aa-931e-2f7832fd2185_e037d950-fa80-4d55-bdff-782046aba39c?alt=media&token=24f61f73-1372-4c78-8d37-cd2f6da879dc', 111, 0, '2023-05-31 13:39:27', '2023-05-31 13:39:27'),
(193, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F78328334-f22d-47aa-931e-2f7832fd2185_bb7096dc-ddbc-409a-af50-ffe8dcd6d355?alt=media&token=503512b9-4c1c-4e77-bbb9-a111f96e9c6a', 111, 0, '2023-05-31 13:39:27', '2023-05-31 13:39:27'),
(194, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F78328334-f22d-47aa-931e-2f7832fd2185_e5dd632f-af59-4f95-a56b-2bff57d3aae2?alt=media&token=9069b495-e6bf-4190-924f-4eaddda86962', 111, 0, '2023-05-31 13:39:27', '2023-05-31 13:39:27'),
(202, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F1aa1a0fe-7d2e-4921-befe-32171d860b9d_b4cf7f14-8004-4314-84f4-3ed70ec4437d?alt=media&token=677b06d0-d749-4219-b72b-004d7c5348b0', 116, 1, '2023-05-31 17:17:35', '2023-05-31 17:17:35'),
(203, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F1aa1a0fe-7d2e-4921-befe-32171d860b9d_0541fd5d-4162-4c4f-a676-81c92e353c4f?alt=media&token=feb0e422-511c-4d4d-991b-c02a13c20ecf', 116, 0, '2023-05-31 17:17:35', '2023-05-31 17:17:35'),
(204, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F1aa1a0fe-7d2e-4921-befe-32171d860b9d_b9e675e0-f203-42f3-9728-26b34cab9cc7?alt=media&token=c39169ca-08ed-4b6e-9117-f00f3214c1b0', 116, 0, '2023-05-31 17:17:35', '2023-05-31 17:17:35'),
(205, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F1aa1a0fe-7d2e-4921-befe-32171d860b9d_2bcf8aa5-2d7f-4f16-845e-ccb98aa5135e?alt=media&token=7f640a2a-2296-41c4-beee-90ccf2668b27', 116, 0, '2023-05-31 17:17:35', '2023-05-31 17:17:35'),
(206, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F1aa1a0fe-7d2e-4921-befe-32171d860b9d_161660af-3c47-46f3-aed1-c560151ae00b?alt=media&token=1de72a12-2b49-45a1-ae20-6b8a223147ef', 116, 0, '2023-05-31 17:17:35', '2023-05-31 17:17:35'),
(207, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F1aa1a0fe-7d2e-4921-befe-32171d860b9d_d593a020-022b-4bf1-b629-96ed0abcf98d?alt=media&token=b2a19622-ec30-411f-85eb-060957ae2344', 116, 0, '2023-05-31 17:17:35', '2023-05-31 17:17:35'),
(208, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F1aa1a0fe-7d2e-4921-befe-32171d860b9d_18ec9a99-ea81-4838-835d-9352f9d7f31a?alt=media&token=2389b99e-4b4c-4af6-b518-861008074514', 116, 0, '2023-05-31 17:17:35', '2023-05-31 17:17:35');

INSERT INTO `imagenesservicios` (`id`, `url`, `es_portada`, `id_servicio`, `createdAt`, `updatedAt`) VALUES
(38, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F221cb5e1-de0f-4046-bd00-2c0d5f6be75b_f0a40223-84c0-42ab-bdad-ddd694b64623?alt=media&token=7827859b-8a3e-422b-8198-c366f408f833', 0, 47, '2023-05-31 15:26:49', '2023-05-31 15:26:49'),
(39, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2F221cb5e1-de0f-4046-bd00-2c0d5f6be75b_9b85407b-77cf-45cd-86a6-c4f0e9f617d7?alt=media&token=1cbca961-ec5a-4b33-8b5c-03dff434049a', 1, 47, '2023-05-31 15:26:49', '2023-05-31 15:26:49');

INSERT INTO `orden_detalles` (`id`, `cantidad`, `precio_unitario`, `id_producto`, `id_orden`, `createdAt`, `updatedAt`) VALUES
(72, 2, '50.00', 85, 77, '2023-05-31 21:07:50', '2023-05-31 21:07:50');

INSERT INTO `ordenes` (`id`, `total`, `estado_orden`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(77, '100.00', 'Pendiente', 76, '2023-05-31 21:07:48', '2023-05-31 21:47:14');

INSERT INTO `pago` (`id`, `usuario_id`, `orden_id`, `monto`, `estado`, `id_pago_stripe`, `fecha_pago`, `createdAt`, `updatedAt`) VALUES
(20, 76, 77, '10000.00', 'Procesado', 'pi_3NDwFEIscKwQt1dm1U041rmU', '2023-05-31', '2023-05-31 21:07:50', '2023-05-31 21:07:50');

INSERT INTO `preguntasproductos` (`id`, `pregunta`, `respuesta`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(12, 'Cuántas gigas de RAM tiene?', NULL, '2023-05-26 15:24:07', '2023-05-26 15:24:07', NULL, 74),
(13, 'Sirve para hacer frappes?', 'si te sirve perfecto', '2023-05-26 15:25:38', '2023-05-26 15:26:00', 91, 74),
(14, 'Hola Lenin ', NULL, '2023-05-26 16:20:54', '2023-05-26 16:20:54', 84, 86);

INSERT INTO `productos` (`id`, `nombre`, `precio`, `stock`, `descripcion`, `marca`, `modelo`, `color`, `estado`, `id_categoria`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(84, 'rweqweqwe', 100, 1, 'Los Audífonos Amplificadores de Sonido están diseñados especialmente para adultos mayores que tienen problemas de audición. Estos audífonos proporcionan una calidad de sonido clara y nítida, permitiendo una mejor audición y comunicación. Además, son cómodos de usar y fáciles de ajustar según las necesidades del usuario.', ' Amplifon', 'X Mini', 'Beige', 1, 53, 74, '2023-04-11 15:16:39', '2023-06-01 02:25:56'),
(85, 'Monitor de Presión Arterial', 50, 105, 'El Monitor de Presión Arterial es un producto esencial para adultos mayores que necesitan controlar su presión arterial. Este monitor es fácil de usar y proporciona mediciones precisas. Además, cuenta con una pantalla grande y fácil de leer, y puede almacenar las mediciones para un seguimiento a largo plazo.', 'Omron', 'BP742N', 'Blanco', 1, 61, 74, '2023-04-11 15:31:33', '2023-05-31 21:07:50'),
(86, 'Andador Plegable con Asientoswewe', 150, 8, 'El Andador Plegable con Asiento es un producto ideal para adultos mayores que necesitan ayuda para caminar y descansar de vez en cuando. Este andador es fácil de usar y cuenta con un asiento cómodo y seguro. Además, se pliega para un fácil almacenamiento y transporte.', 'Drive Medical', 'Nitro DLX', 'Azul', 1, 60, 76, '2023-04-11 15:40:55', '2023-05-31 20:51:49'),
(87, 'Tablet para Adultos Mdsdaayoresswsw', 2000, 23, ' La Tablet para Adultos Mayores es una herramienta tecnológica diseñada especialmente para este grupo de edad. Cuenta con una interfaz de usuario fácil de usar y botones grandes para una navegación sencilla. Además, cuenta con aplicaciones útiles como un calendario, reloj, acceso a Internet y correo electrónico. También incluye soporte técnico para cualquier duda o problema.', 'GrandPad', 'GrandPad', 'Gris', 1, 51, 76, '2023-04-11 15:44:32', '2023-05-27 16:45:16'),
(88, 'Teléfono con Teclas Grandess', 50, 61, 'El Teléfono con Teclas Grandes es ideal para adultos mayores que necesitan un teléfono fácil de usar y leer. Cuenta con teclas grandes y de alto contraste, una pantalla grande y fácil de leer, y un volumen ajustable. Además, tiene funciones adicionales como identificador de llamadas y memoria para guardar números importantes.', 'Clarity', 'P300', 'Blanco', 1, 60, 76, '2023-04-11 15:48:23', '2023-05-31 13:29:53'),
(89, 'Pulsera Inteligente para Monitoreo de Actividad', 80, 35, ' La Pulsera Inteligente para Monitoreo de Actividad es un gadget útil para adultos mayores que desean monitorear su actividad física y salud. Cuenta con funciones como un podómetro, monitor de ritmo cardíaco y monitoreo de sueño. Además, puede conectarse a una aplicación móvil para obtener un seguimiento más detallado.', 'Fitbit', 'Inspire 2', 'Negro', 1, 53, 76, '2023-04-11 15:50:35', '2023-05-25 19:08:17'),
(91, 'Batidora para Smoothies Nutritivos', 60, 25, 'La Batidora para Smoothies Nutritivos es una herramienta útil para adultos mayores que desean mejorar su nutrición y salud en general. Es fácil de usar y limpiar, y cuenta con una potencia suficiente para triturar frutas y verduras. Además, incluye recetas y consejos para preparar smoothies saludables.', 'Nutribullet', 'NBR-0801', 'Gris', 1, 61, 65, '2023-04-11 15:59:01', '2023-05-27 13:16:02'),
(92, 'Collar para Perros', 10, 51, ' Este collar para perros es de alta calidad y está hecho con materiales duraderos. Viene en varios tamaños y colores, lo que lo hace adecuado para todo tipo de perros. Además, tiene una hebilla de liberación rápida para mayor seguridad.', '', '', '', 1, 66, 65, '2023-04-11 16:04:13', '2023-05-24 13:36:09'),
(111, '2323', 232, 32323, '2', '2323', '23', '23', 0, 57, 65, '2023-05-31 13:39:14', '2023-05-31 13:39:14'),
(116, '43434', 34, 34, '43', '4', '', '', 0, NULL, 76, '2023-05-31 17:16:46', '2023-05-31 17:16:46');

INSERT INTO `reviewsproductos` (`id`, `titulo`, `comentario`, `calificacion`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(4, 'Excelente muy buen producto.', 'Sin comentarios', 4, '2023-04-28 21:13:41', '2023-04-28 21:13:41', 88, 74),
(5, 'No me gusto ', 'Producto Chafa', 1, '2023-04-28 21:13:41', '2023-04-28 21:13:41', 88, 76),
(6, 'No me gusta ', 'La verdad no es lo que esperaba', 3, '2023-04-29 17:28:12', '2023-04-29 17:28:12', 85, 76),
(7, 'Genial', 'Es un buen producto por su relación calidad precio ', 3, '2023-04-29 17:28:12', '2023-04-29 17:28:12', 85, 74);

INSERT INTO `servicios` (`id`, `titulo`, `descripcion`, `precio`, `id_categoria`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(32, 'qwdqwdqw', 'wdqwd', 232323, 60, 65, '2023-05-30 23:11:04', '2023-05-30 23:11:04'),
(42, '343', '234324', 234234, 58, 65, '2023-05-31 14:51:48', '2023-05-31 14:51:48'),
(43, '234324', '324234', 4234, 58, 65, '2023-05-31 14:53:29', '2023-05-31 14:53:29'),
(47, '213123123123', '31231', 12312312, 57, 65, '2023-05-31 15:26:34', '2023-05-31 15:26:34'),
(48, '2WEEqwqw', '23123wdwqwqwdwdw', 213123, 56, 76, '2023-05-31 18:25:46', '2023-05-31 19:16:47');

INSERT INTO `usuarios` (`id`, `nombre`, `apellidoPaterno`, `apellidoMaterno`, `email`, `sexo`, `fechaNacimiento`, `telefono`, `password`, `tipoUsuario`, `createdAt`, `updatedAt`) VALUES
(65, 'Admin2', 'Admin2wdwd', 'Admin2', 'grandmarthtd@gmail.com', 'F', '2001-09-06', '2323232323', '$2a$10$cth2xN8x8ys/2R1jXH.ZneElJlcUvcithrdku7SolMukxAkRNjXhi', 1, '2023-03-14 19:19:25', '2023-05-31 19:13:36'),
(74, 'Admin1', 'Admin1', 'Admin1', 'admin@gmail.com', 'M', '2023-04-04', '435453', '$2a$10$/7xOXIiRBhO4NoNmo6T8fORzJNcokmdhHGGNRYGK7ph5d1vsJIBQ2', 2, '2023-04-09 22:13:18', '2023-05-30 19:00:51'),
(76, 'Cliente1', 'Cliente1', 'Cliente1', 'cliente@gmail.com', 'M', '2006-10-18', '213123', '$2a$10$twpJEjHwE.dDYSQag.Xjqex6feoTeKmCKgecydsHhdT8gFynzErq.', 0, '2023-04-11 15:39:39', '2023-05-26 14:52:39'),
(77, 'Cliente2', 'Cliente2', 'Cliente2', 'cliente2@gmail.com', 'M', '2001-04-03', '34234', '$2a$10$if6V2rX0.9p1Px1zXCmKseVicU2kSOOqFNmH9zuXUETFqJuj0S8t6', 0, '2023-04-11 15:52:41', '2023-04-11 19:31:33'),
(83, 'Repartidor2', 'Repartidor2', 'Repartidor2', 'repartidor2@gmail.com', 'M', '2000-02-23', '2313333333', '$2a$10$BznI6osMzShPBdED1NPOjeNEwkNNtVHLdnB/tw./O/rbM99TbcI7y', 2, '2023-05-22 14:34:07', '2023-05-31 13:31:23'),
(84, 'Repartidor1', 'Repartidor1', 'Repartidor1', 'repartidor@gmail.com', 'M', '2023-05-24', 'dsd', '$2a$10$lX6p2ngzKzwf/RQuvFswseiXGILIqrs1CHlQAuqvyLLt0bOHnf1hu', 2, '2023-05-22 15:43:24', '2023-05-22 15:43:24'),
(86, 'Hsjshs', 'Jsjsjd', 'Jsjjsd', 'miguelangelfloca2@gmail.com', 'M', '1991-05-16', '7341346494', '$2a$10$W6TdwhT5vrb/JUr0DWh.re5s7.LHYinzgx4U5SUlvAyUxREuXZq0e', 0, '2023-05-26 16:20:12', '2023-05-26 16:20:12'),
(91, 'r3r32r23r', '32r23', 'r23r23r32', 'cliente5@gmail.com', 'M', '1991-05-15', '3434234324', '$2a$10$GsL0x6zD0sWZEpNmTrnkSe58Nl0yspJOtS7dMYjtXvZ65hG0OFGpu', 1, '2023-05-30 22:03:47', '2023-05-30 22:03:47'),
(93, '234234234', '234324', '34324234234', 'admWEWEWEin@gmail.com', 'M', '2001-09-26', '3232323232', '$2a$10$wu71EbLPDlkYKkz1eAvxxOYYjHV719I1ruIDx4VeszPKPmCkh4gCO', 1, '2023-05-30 22:20:34', '2023-05-30 22:20:34');

