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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

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

INSERT INTO `domiciliousuarios` (`id`, `nombre_ine`, `postal`, `estado`, `municipio_alcaldia`, `colonia`, `calle`, `numeroExterior`, `numeroInterior`, `calle1`, `calle2`, `descripcion`, `createdAt`, `updatedAt`, `id_usuario`) VALUES
(36, 'Juan Pérez', '12345', 'Jalisco', 'Guadalajara', 'Colonia Ejemplo', 'Calle Ejemplo', '123', 'A', 'Calle Ejemplo 1', 'Calle Ejemplo 2', 'Esta es una descripción del domicilio de ejemplo', '2023-05-11 23:15:09', '2023-05-12 15:47:29', 74),
(40, 'sASas', 'aSas', 'asa', 'aSasAS', 'SAsASas', 'aS', 'ASAs', 'asSA', 'asas', 'sASas', 'ASAsa', '2023-05-19 22:39:42', '2023-05-19 22:39:42', NULL),
(54, '213123123', '00123', 'Coahuila', '32323', '23', '2323', '', '', '', '', '', '2023-05-23 22:28:09', '2023-05-23 22:28:09', 65),
(55, 'Cliente Prueba', '62735', 'Morelos', 'Jiutepec', 'Joya', 'Aldama', 'SN', '6', 'Puente Flores', 'Maldonado', 'Es una casa con techo blanco.', '2023-05-25 18:08:15', '2023-05-25 18:08:15', NULL),
(56, 'wdsadsdasd', '23213', 'Baja California Sur', '2313', '23', '21321', 'SN', '12312', '3123', '21312', '12312asd', '2023-05-27 13:12:58', '2023-05-27 13:12:58', 76);

INSERT INTO `favoritosproductos` (`id`, `createdAt`, `updatedAt`, `id_producto`, `id_usuario`) VALUES
(2, '2023-04-16 11:04:13', '2023-04-16 11:04:13', 88, 77),
(5, '2023-04-18 16:00:43', '2023-04-18 16:00:43', 91, 77),
(6, '2023-04-18 16:02:38', '2023-04-18 16:02:38', 92, 77),
(7, '2023-04-18 21:17:13', '2023-04-18 21:17:13', NULL, 77),
(21, '2023-05-08 00:04:18', '2023-05-08 00:04:18', 88, NULL),
(26, '2023-05-25 17:58:01', '2023-05-25 17:58:01', 87, NULL);

INSERT INTO `imagenesblogs` (`id`, `url`, `es_portada`, `id_publicacionBlog`, `createdAt`, `updatedAt`) VALUES
(75, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F520898d3-5e61-4e7a-91cd-cd3fa519d11c_515d76c5-dd8e-400f-ad92-474415ce71c6?alt=media&token=17522bd5-d938-472b-abb9-a2a64d0e05f5', 1, 97, '2023-06-01 04:55:05', '2023-06-01 04:55:05'),
(76, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F07103abc-a785-459b-888e-74dcb001ef55_87e65eac-d723-4445-b713-6a21d169e6d9?alt=media&token=3bb5d55a-8852-48b5-b9d6-8d0d29ece06e', 1, 98, '2023-06-01 05:03:44', '2023-06-01 05:03:44'),
(77, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F6bddf76c-7c6a-4c58-8426-b7087ab00fb4_c8de6581-414c-480b-be2f-c3d447f48585?alt=media&token=5afdbbc5-39bd-4e4f-88f0-3a27acc5b9d8', 1, 99, '2023-06-01 05:26:02', '2023-06-01 05:26:02'),
(78, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/blog%2F9faf5542-fbf1-4098-a0bf-a3b1459b3b45_0ad0c565-7988-49fd-b2c5-da48e58561c2?alt=media&token=e698b35b-655a-423c-bc45-6cac683c9874', 1, 100, '2023-06-01 05:27:05', '2023-06-01 05:27:05');

INSERT INTO `imagenesproductos` (`id`, `url`, `id_producto`, `es_portada`, `createdAt`, `updatedAt`) VALUES
(113, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Ff2a47766-3410-4001-b6ae-3cff17bcb991_477aa1f9-3af4-42f4-8a6c-4cfecbae7fc3?alt=media&token=37826744-50ff-4b35-9add-b59403ad7bac', 84, 1, '2023-04-11 15:19:07', '2023-04-11 15:19:07'),
(114, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F59a0280d-b40c-4f9b-baa9-4b160bb1682c_393bb60e-2b47-4394-87d5-9712612b1144?alt=media&token=e62e15be-db35-464c-abfd-51762b661d41', 84, 0, '2023-04-11 15:19:07', '2023-04-11 15:19:07'),
(115, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F59a0280d-b40c-4f9b-baa9-4b160bb1682c_fc0137c1-d0a5-41e7-b77e-12656d8a6cd1?alt=media&token=88c7fb34-2584-4fba-91dd-ce604a09c642', 84, 0, '2023-04-11 15:19:07', '2023-04-11 15:19:07'),
(123, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F1b82fb96-e40f-45a8-9dd2-5bda004edeec_ab59492e-3ec1-4686-b13f-273e6f5b85ab?alt=media&token=e611aa68-d6a6-4797-a319-7dd60035707f', 87, 1, '2023-04-11 15:45:46', '2023-04-11 15:45:46'),
(124, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F6e5f00b4-3615-4ad9-bc02-d60a9b1d63e1_09ef22dd-82f7-47e1-8701-66ccedfa5eb8?alt=media&token=3994f328-335b-47e0-a4f8-d3aea300985b', 87, 0, '2023-04-11 15:45:46', '2023-04-11 15:45:46'),
(125, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F6e5f00b4-3615-4ad9-bc02-d60a9b1d63e1_90e36124-6caf-421a-ab2f-0fc3988cc342?alt=media&token=8e180afa-0d78-488f-a76c-bb3f311ce81e', 87, 0, '2023-04-11 15:45:46', '2023-04-11 15:45:46'),
(126, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F6e5f00b4-3615-4ad9-bc02-d60a9b1d63e1_89683c7d-bbc9-4457-850e-6a8ad494a1be?alt=media&token=678284a2-41e2-4f22-a28b-1d7dfe652cf3', 87, 0, '2023-04-11 15:45:46', '2023-04-11 15:45:46'),
(127, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Faab7edaf-bd78-4b54-99c7-2a7eab20ee9d_c2c53a87-9663-482e-b076-917aa140a6cf?alt=media&token=a84d940f-c82d-4241-bdce-af7be815733e', 88, 1, '2023-04-11 15:49:25', '2023-04-11 15:49:25'),
(128, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F71d0c1d5-4e04-4fc5-8af9-c144479b15c8_64ae28fa-2d16-468f-b375-aebb391f3ecd?alt=media&token=085e8ce2-9217-48a7-9baf-34ec87b82855', 88, 0, '2023-04-11 15:49:25', '2023-04-11 15:49:25'),
(129, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F71d0c1d5-4e04-4fc5-8af9-c144479b15c8_334b78e2-95c5-4899-a80f-a45917128af5?alt=media&token=91fce7ce-a394-4742-a1f2-f69b10664510', 88, 0, '2023-04-11 15:49:25', '2023-04-11 15:49:25'),
(130, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F71d0c1d5-4e04-4fc5-8af9-c144479b15c8_8a2886c3-d07b-45e0-a561-8a9e8c9b6c84?alt=media&token=c81d9c62-57f8-46c7-8ac9-3c08e7148ec2', 88, 0, '2023-04-11 15:49:25', '2023-04-11 15:49:25'),
(137, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F743cae5b-d478-4b14-b4ee-2ae376d60114_601d7874-03e4-4a43-97c2-eafc8e521a1d?alt=media&token=fe026e68-8328-4a48-ad57-157fb6094bf1', 91, 1, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(138, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F0d168260-0b78-4ebc-93b6-2b633d202161_b8ebc6ad-c715-4c62-b362-5dec871d1d11?alt=media&token=ff10633e-e38a-48d5-b3dd-99a92650c7b2', 91, 0, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(139, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F0d168260-0b78-4ebc-93b6-2b633d202161_e4e18b16-529b-4261-bdf9-8b36afcc3e5f?alt=media&token=1b05d6a9-9ecf-42bd-a85f-547b68d89d18', 91, 0, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(140, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F0d168260-0b78-4ebc-93b6-2b633d202161_9b704ac1-8ac3-49b5-ab7a-ecbdbe200955?alt=media&token=39ce7572-aee9-48c4-a207-008d14a2d10e', 91, 0, '2023-04-11 15:59:51', '2023-04-11 15:59:51'),
(141, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2F3b76336c-10a0-47ae-9bda-0f29c0e99c4d_ec54a85d-8dbf-4364-8256-aaa221cc8f59?alt=media&token=5ac78830-608f-40c2-be23-ca7f97eb3574', 92, 1, '2023-04-11 16:04:48', '2023-04-11 16:04:48'),
(142, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/productos%2Fa1560457-bd4f-4772-9853-5703d9ff0d83_636483e1-921b-4e03-b6fa-739fa9ea2c4c?alt=media&token=41555e49-8723-49e3-81e5-d20e5fe806fc', 92, 0, '2023-04-11 16:04:48', '2023-04-11 16:04:48');

INSERT INTO `imagenesservicios` (`id`, `url`, `es_portada`, `id_servicio`, `createdAt`, `updatedAt`) VALUES
(46, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Fc96ea1ec-97d9-4be1-b53e-1407ef07685a_e11b6ced-2998-4d2c-bbeb-7780fc3b24db?alt=media&token=016ab905-c00b-4761-953f-e183e8a58f42', 1, 52, '2023-06-01 04:16:18', '2023-06-01 04:16:18'),
(47, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Fc96ea1ec-97d9-4be1-b53e-1407ef07685a_a53581be-c0fa-454b-b774-837c351b3fd8?alt=media&token=86fa6361-270c-4fd4-a222-9314d0a6f9b0', 0, 52, '2023-06-01 04:16:18', '2023-06-01 04:16:18'),
(48, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Fc96ea1ec-97d9-4be1-b53e-1407ef07685a_e4cd22ec-ecc1-4890-b7a2-b795f6a9b3cf?alt=media&token=b8f45a2c-6f56-41fe-a351-7e41888aa9b6', 0, 52, '2023-06-01 04:16:18', '2023-06-01 04:16:18'),
(49, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Fc96ea1ec-97d9-4be1-b53e-1407ef07685a_77c5e6bc-170b-4f55-985e-40413e9d3758?alt=media&token=4a1e16d3-909c-42f0-b1e9-23378fd2dc8c', 0, 52, '2023-06-01 04:16:18', '2023-06-01 04:16:18'),
(50, 'https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/servicios%2Fc96ea1ec-97d9-4be1-b53e-1407ef07685a_3bd47bc0-4f28-4a43-b37b-b8aa57d1b5ea?alt=media&token=c339942e-f187-41b5-b022-baf74f1b614d', 0, 52, '2023-06-01 04:16:18', '2023-06-01 04:16:18');

INSERT INTO `productos` (`id`, `nombre`, `precio`, `stock`, `descripcion`, `marca`, `modelo`, `color`, `estado`, `id_categoria`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(84, 'rweqweqwe', 100, 1, 'Los Audífonos Amplificadores de Sonido están diseñados especialmente para adultos mayores que tienen problemas de audición. Estos audífonos proporcionan una calidad de sonido clara y nítida, permitiendo una mejor audición y comunicación. Además, son cómodos de usar y fáciles de ajustar según las necesidades del usuario.', ' Amplifon', 'X Mini', 'Beige', 1, 53, 74, '2023-04-11 15:16:39', '2023-06-01 02:25:56'),
(87, 'Tablet para Adultos Mdsdaayoresswsw', 2000, 23, ' La Tablet para Adultos Mayores es una herramienta tecnológica diseñada especialmente para este grupo de edad. Cuenta con una interfaz de usuario fácil de usar y botones grandes para una navegación sencilla. Además, cuenta con aplicaciones útiles como un calendario, reloj, acceso a Internet y correo electrónico. También incluye soporte técnico para cualquier duda o problema.', 'GrandPad', 'GrandPad', 'Gris', 1, 51, 76, '2023-04-11 15:44:32', '2023-05-27 16:45:16'),
(88, 'Teléfono con Teclas Grandess', 50, 61, 'El Teléfono con Teclas Grandes es ideal para adultos mayores que necesitan un teléfono fácil de usar y leer. Cuenta con teclas grandes y de alto contraste, una pantalla grande y fácil de leer, y un volumen ajustable. Además, tiene funciones adicionales como identificador de llamadas y memoria para guardar números importantes.', 'Clarity', 'P300', 'Blanco', 1, 60, 76, '2023-04-11 15:48:23', '2023-05-31 13:29:53'),
(91, 'Batidora para Smoothies Nutritivos', 60, 25, 'La Batidora para Smoothies Nutritivos es una herramienta útil para adultos mayores que desean mejorar su nutrición y salud en general. Es fácil de usar y limpiar, y cuenta con una potencia suficiente para triturar frutas y verduras. Además, incluye recetas y consejos para preparar smoothies saludables.', 'Nutribullet', 'NBR-0801', 'Gris', 1, 61, 65, '2023-04-11 15:59:01', '2023-05-27 13:16:02'),
(92, 'Collar para Perros', 10, 51, ' Este collar para perros es de alta calidad y está hecho con materiales duraderos. Viene en varios tamaños y colores, lo que lo hace adecuado para todo tipo de perros. Además, tiene una hebilla de liberación rápida para mayor seguridad.', '', '', '', 1, 66, 65, '2023-04-11 16:04:13', '2023-05-24 13:36:09');

INSERT INTO `publicacionesblogs` (`id`, `titulo`, `descripcion`, `createdAt`, `updatedAt`, `id_usuario`) VALUES
(97, 'Viajes y aventuras: ¡Nunca es tarde para explorar el mundo!', 'En esta publicación, te invitamos a compartir tus increíbles historias de viajes y aventuras. ¿Has cumplido ese sueño de visitar un lugar exótico? ¿O tal vez descubriste nuevos destinos locales? Cuéntanos cómo el viajar ha enriquecido tu vida y ha hecho que cada día sea una emocionante travesía. Inspiremos a otros adultos mayores a embarcarse en nuevas aventuras y descubrir el mundo que nos rodea.', '2023-06-01 04:55:04', '2023-06-01 04:55:04', 65),
(98, 'Recetas tradicionales: Sabor y nostalgia en cada bocado', 'En este espacio, te animamos a compartir tus recetas tradicionales favoritas. ¿Tienes un plato especial que has heredado de generaciones anteriores? Comparte la historia detrás de esa receta y brinda instrucciones detalladas para recrearla en casa. La cocina es una forma maravillosa de mantener vivas nuestras tradiciones y compartir momentos especiales alrededor de la mesa. ¡Comparte tus sabores favoritos y haz que todos disfruten de la magia de la comida casera!', '2023-06-01 05:03:44', '2023-06-01 05:03:44', 65),
(99, 'Hobbies y pasiones: Descubriendo nuevas pasiones en la tercera edad', 'Descripción: Este blog está dedicado a los hobbies y pasiones que has descubierto o desarrollado en la tercera edad. ¿Has aprendido a pintar, tocar un instrumento musical o a bailar? ¿O tal vez encontraste un amor por la jardinería o la fotografía? Comparte tus experiencias, consejos y logros en el campo de tu pasión. ¡Anima a otros adultos mayores a explorar nuevas actividades y disfrutar de la vida al máximo!', '2023-06-01 05:26:02', '2023-06-01 05:26:02', 65),
(100, 'Reflexiones sobre el envejecimiento: Abrazando la sabiduría y la gratitud', ': En esta sección del blog, te invitamos a reflexionar sobre el proceso de envejecimiento y cómo has aprendido a abrazar la sabiduría y la gratitud en esta etapa de la vida. Comparte tus pensamientos sobre el paso del tiempo, la importancia de cuidar de uno mismo y las lecciones que has aprendido sobre la verdadera felicidad y el significado de la vida. Inspirémonos mutuamente para vivir una vida plena y significativa.', '2023-06-01 05:27:04', '2023-06-01 05:27:04', 65);

INSERT INTO `servicios` (`id`, `titulo`, `descripcion`, `precio`, `id_categoria`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(52, 'qewqe', 'eqwe', 233, 51, 65, '2023-06-01 04:15:38', '2023-06-01 04:15:38');

INSERT INTO `usuarios` (`id`, `nombre`, `apellidoPaterno`, `apellidoMaterno`, `email`, `sexo`, `fechaNacimiento`, `telefono`, `password`, `tipoUsuario`, `createdAt`, `updatedAt`) VALUES
(65, 'Admin2', 'Admin2wdwd', 'Admin2', 'grandmarthtd@gmail.com', 'F', '2001-09-06', '2323232323', '$2a$10$cth2xN8x8ys/2R1jXH.ZneElJlcUvcithrdku7SolMukxAkRNjXhi', 1, '2023-03-14 19:19:25', '2023-05-31 19:13:36'),
(74, 'Admin1', 'Admin1', 'Admin1', 'admin@gmail.com', 'M', '2023-04-04', '435453', '$2a$10$/7xOXIiRBhO4NoNmo6T8fORzJNcokmdhHGGNRYGK7ph5d1vsJIBQ2', 2, '2023-04-09 22:13:18', '2023-05-30 19:00:51'),
(76, 'Cliente1', 'Cliente1', 'Cliente1', 'cliente@gmail.com', 'M', '2006-10-18', '213123', '$2a$10$twpJEjHwE.dDYSQag.Xjqex6feoTeKmCKgecydsHhdT8gFynzErq.', 0, '2023-04-11 15:39:39', '2023-05-26 14:52:39'),
(77, 'Cliente2', 'Cliente2', 'Cliente2', 'cliente2@gmail.com', 'M', '2001-04-03', '34234', '$2a$10$if6V2rX0.9p1Px1zXCmKseVicU2kSOOqFNmH9zuXUETFqJuj0S8t6', 0, '2023-04-11 15:52:41', '2023-04-11 19:31:33'),
(83, 'Repartidor2', 'Repartidor2', 'Repartidor2', 'repartidor2@gmail.com', 'M', '2000-02-23', '2313333333', '$2a$10$BznI6osMzShPBdED1NPOjeNEwkNNtVHLdnB/tw./O/rbM99TbcI7y', 2, '2023-05-22 14:34:07', '2023-05-31 13:31:23');

