import { Producto } from "../productosModel/ProductoModel.js";
import { FavoritosProducto } from "../productosModel/FavoritoProductoModel.js";
import { ImagenProducto } from "../productosModel/ImagenesProductoModel.js";
import { ReviewProducto } from "../productosModel/ReviewsProductosModel.js";
import { PreguntaProducto } from "../productosModel/PreguntasProductoModel.js";
import { CarritoProductos } from "../productosModel/CarritoProductos.js";

import { ProductosOrden } from "../ordenesModel/ProductosOrdenModel.js";
import { Orden } from "../ordenesModel/OrdenModel.js";
import { EstadoPago } from "../ordenesModel/EstadoPago.js";
import { EstadoPedido } from "../ordenesModel/EstadoPedido.js";

import { Usuario } from "../usuariosModel/UsuarioModel.js";
import { ImagenUsuario } from "../usuariosModel/ImagenesUsuarios.js";
import { DomicilioUsuario } from "../usuariosModel/DomicilioUsuarioModel.js";

import { ImagenServicio } from "../serviciosModel/ImagenesServiciosModel.js";
import { PreguntaServicio } from "../serviciosModel/PreguntasServiciosModel.js";
import { ReviewServicio } from "../serviciosModel/ReviewsServiciosModel.js";
import { Servicio } from "../serviciosModel/ServicioModel.js";
import { UbicacionServicio } from "../serviciosModel/UbicacionServiciosModel.js";

import { Categoria } from "../categoriasModel/CategoriaModel.js";

import { MensajeBuzon } from "../buzonModel/BuzonModel.js";
import { ImagenBuzon } from "../buzonModel/ImagenBuzonModel.js";

import { ComentarioBlog } from "../blogModel/ComentariosBlogModel.js";
import { ImagenBlog } from "../blogModel/ImagenesBlogModel.js";
import { PublicacionBlog } from "../blogModel/PublicacionesBlogModel.js";
import { DatosContactoServicio } from "../serviciosModel/ServicioDatosContactoModel.js";
//.
Producto.hasMany(FavoritosProducto, {
  foreignKey: "id_producto",
  sourceKey: "id",
});

FavoritosProducto.belongsTo(Producto, {
  foreignKey: "id_producto",
  targetId: "id",
});
//.
Producto.hasMany(PreguntaProducto, {
  foreignKey: "id_producto",
  sourceKey: "id",
});

PreguntaProducto.belongsTo(Producto, {
  foreignKey: "id_producto",
  targetId: "id",
});
//.
Producto.hasMany(ImagenProducto, {
  foreignKey: "id_producto",
  sourceKey: "id",
});

ImagenProducto.belongsTo(Producto, {
  foreignKey: "id_producto",
  targetId: "id",
});
//.
Producto.hasMany(ReviewProducto, {
  foreignKey: "id_producto",
  sourceKey: "id",
});

ReviewProducto.belongsTo(Producto, {
  foreignKey: "id_producto",
  targetId: "id",
});
//
Producto.hasMany(CarritoProductos, {
  foreignKey: "id_producto",
  sourceKey: "id",
});

CarritoProductos.belongsTo(Producto, {
  foreignKey: "id_producto",
  targetId: "id",
});
//
Producto.hasMany(ProductosOrden, {
  foreignKey: "id_producto",
  sourceKey: "id",
});

ProductosOrden.belongsTo(Producto, {
  foreignKey: "id_producto",
  targetId: "id",
});

/////////////
Orden.hasMany(ProductosOrden, {
  foreignKey: "id_orden",
  sourceKey: "id",
});

ProductosOrden.belongsTo(Orden, {
  foreignKey: "id_orden",
  targetId: "id",
});
///
EstadoPedido.hasMany(Orden, {
  foreignKey: "id_estadoPedido",
  sourceKey: "id",
});

Orden.belongsTo(EstadoPedido, {
  foreignKey: "id_estadoPedido",
  targetId: "id",
});
///
EstadoPago.hasMany(Orden, {
  foreignKey: "id_estadoPago",
  sourceKey: "id",
});

Orden.belongsTo(EstadoPago, {
  foreignKey: "id_estadoPago",
  targetId: "id",
});

/////////////
Categoria.hasMany(Producto, {
  foreignKey: "id_categoria",
  sourceKey: "id",
});

Producto.belongsTo(Categoria, {
  foreignKey: "id_categoria",
  targetId: "id",
});
Categoria.hasMany(Servicio, {
  foreignKey: "id_categoria",
  sourceKey: "id",
});

Servicio.belongsTo(Categoria, {
  foreignKey: "id_categoria",
  targetId: "id",
});
/////////////
Servicio.hasMany(DatosContactoServicio, {
  foreignKey: "id_servicio",
  sourceKey: "id",
});
DatosContactoServicio.belongsTo(Servicio, {
  foreignKey: "id_servicio",
  targetId: "id",
});

Servicio.hasMany(UbicacionServicio, {
  foreignKey: "id_servicio",
  sourceKey: "id",
});
UbicacionServicio.belongsTo(Servicio, {
  foreignKey: "id_servicio",
  targetId: "id",
});

Servicio.hasMany(ImagenServicio, {
  foreignKey: "id_servicio",
  sourceKey: "id",
});
ImagenServicio.belongsTo(Servicio, {
  foreignKey: "id_servicio",
  targetId: "id",
});

Servicio.hasMany(ReviewServicio, {
  foreignKey: "id_servicio",
  sourceKey: "id",
});
ReviewServicio.belongsTo(Servicio, {
  foreignKey: "id_servicio",
  targetId: "id",
});

Servicio.hasMany(PreguntaServicio, {
  foreignKey: "id_servicio",
  sourceKey: "id",
});
PreguntaServicio.belongsTo(Servicio, {
  foreignKey: "id_servicio",
  targetId: "id",
});
///////////
PublicacionBlog.hasMany(ComentarioBlog, {
  foreignKey: "id_publicacionBlog",
  sourceKey: "id",
});
ComentarioBlog.belongsTo(PublicacionBlog, {
  foreignKey: "id_publicacionBlog",
  targetId: "id",
});

PublicacionBlog.hasMany(ImagenBlog, {
  foreignKey: "id_publicacionBlog",
  sourceKey: "id",
});
ImagenBlog.belongsTo(PublicacionBlog, {
  foreignKey: "id_publicacionBlog",
  targetId: "id",
});

//////////
MensajeBuzon.hasMany(ImagenBuzon, {
  foreignKey: "id_mensajeBuzon",
  sourceKey: "id",
});
ImagenBuzon.belongsTo(MensajeBuzon, {
  foreignKey: "id_mensajeBuzon",
  targetId: "id",
});

//////////
Usuario.hasMany(ImagenUsuario, {
  foreignKey: "id_usuario",
  sourceKey: "id",
});
ImagenUsuario.belongsTo(Usuario, {
  foreignKey: "id_usuario",
  targetId: "id",
});

Usuario.hasMany(PublicacionBlog, {
  foreignKey: "id_usuario",
  sourceKey: "id",
});
PublicacionBlog.belongsTo(Usuario, {
  foreignKey: "id_usuario",
  targetId: "id",
});
Usuario.hasMany(DomicilioUsuario, {
  foreignKey: "id_usuario",
  sourceKey: "id",
});
DomicilioUsuario.belongsTo(Usuario, {
  foreignKey: "id_usuario",
  targetId: "id",
});
Usuario.hasMany(Orden, {
  foreignKey: "id_usuario",
  sourceKey: "id",
});
Orden.belongsTo(Usuario, {
  foreignKey: "id_usuario",
  targetId: "id",
});
Usuario.hasMany(FavoritosProducto, {
  foreignKey: "id_usuario",
  sourceKey: "id",
});
FavoritosProducto.belongsTo(Usuario, {
  foreignKey: "id_usuario",
  targetId: "id",
});
Usuario.hasMany(Producto, {
  foreignKey: "id_usuario",
  sourceKey: "id",
});
Producto.belongsTo(Usuario, {
  foreignKey: "id_usuario",
  targetId: "id",
});
Usuario.hasMany(CarritoProductos, {
  foreignKey: "id_usuario",
  sourceKey: "id",
});
CarritoProductos.belongsTo(Usuario, {
  foreignKey: "id_usuario",
  targetId: "id",
});
Usuario.hasMany(Servicio, {
  foreignKey: "id_usuario",
  sourceKey: "id",
});
Servicio.belongsTo(Usuario, {
  foreignKey: "id_usuario",
  targetId: "id",
});
Usuario.hasMany(MensajeBuzon, {
  foreignKey: "id_usuario",
  sourceKey: "id",
});
MensajeBuzon.belongsTo(Usuario, {
  foreignKey: "id_usuario",
  targetId: "id",
});
/////
Categoria.hasMany(Categoria, {
  foreignKey: "id_categoria",
  sourceKey: "id",

});
Categoria.belongsTo(Categoria, {
  foreignKey: "id_categoria",
  targetId: "id",

});
