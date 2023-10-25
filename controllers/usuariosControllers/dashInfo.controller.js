import { Orden } from "../../models/ordenesModel/OrdenModel.js";
import { DetalleOrden } from "../../models/ordenesModel/OrdenDetallesModel.js";
import { Producto } from "../../models/productosModel/ProductoModel.js";
import { PreguntaProducto } from "../../models/productosModel/PreguntasProductoModel.js";
import { ReviewProducto } from "../../models/productosModel/ReviewsProductosModel.js";
import { Servicio } from "../../models/serviciosModel/ServicioModel.js";
import { PreguntaServicio } from "../../models/serviciosModel/PreguntasServiciosModel.js";

// Esta función cuenta varios tipos de información relacionada con un usuario.
export const informacionContada = async (req, res) => {
  try {
    const { id_usuario } = req.params;

    // Contar ventas
    const ordenes = await Orden.findAll();
    let contadorVentas = 0;
    await Promise.all(
      ordenes.map(async (orden) => {
        const detalles = await DetalleOrden.findAll({
          where: { id_orden: orden.id },
        });
        const productosPromises = detalles.map(async (detalle) => {
          const producto = await Producto.findOne({
            where: { id: detalle.id_producto, id_usuario: id_usuario },
          });
          return {
            producto,
            cantidad: detalle.cantidad,
          };
        });
        const productosDetalles = await Promise.all(productosPromises);
        const productosFiltrados = productosDetalles.filter(
          (detalle) => detalle.producto !== null
        );
        if (productosFiltrados.length > 0) {
          contadorVentas++;
        }
      })
    );

    // Contar preguntas en productos
    const productos = await Producto.findAll({ where: { id_usuario } });
    let contadorPreguntasProductos = 0;
    await Promise.all(
      productos.map(async (producto) => {
        const preguntas = await PreguntaProducto.findAll({
          where: { id_producto: producto.id },
        });
        if (preguntas.length > 0) {
          contadorPreguntasProductos += preguntas.length;
        }
      })
    );

    // Contar preguntas en servicios
    const servicios = await Servicio.findAll({ where: { id_usuario } });
    let contadorPreguntasServicios = 0;
    await Promise.all(
      servicios.map(async (servicio) => {
        const preguntas = await PreguntaServicio.findAll({
          where: { id_servicio: servicio.id },
        });
        if (preguntas.length > 0) {
          contadorPreguntasServicios += preguntas.length;
        }
      })
    );

    // Contar reviews
    let contadorReviews = 0;
    await Promise.all(
      productos.map(async (producto) => {
        const reviews = await ReviewProducto.findAll({
          where: { id_producto: producto.id },
        });
        if (reviews.length > 0) {
          contadorReviews += reviews.length;
        }
      })
    );

    // Contar productos
    const totalProductos = productos.length;

    // Contar servicios
    const totalServicios = servicios.length;

    return res.status(200).json({
      totalVentas: contadorVentas,
      totalPreguntas: contadorPreguntasProductos,
      totalPreguntas2: contadorPreguntasServicios,
      totalReviews: contadorReviews,
      totalProductos: totalProductos,
      totalServicios: totalServicios,
    });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};
