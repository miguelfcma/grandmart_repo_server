import { DetalleOrden } from "../../models/ordenesModel/OrdenDetallesModel.js";
import { Orden } from "../../models/ordenesModel/OrdenModel.js";
import { Carrito_compra_detalles } from "../../models/productosModel/CarritoCompraDetallesModel.js";
import { Carritos_compras } from "../../models/productosModel/CarritoComprasModel.js";
import { Producto } from "../../models/productosModel/ProductoModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";

// Función para crear una nueva orden
export const crearOrden = async (req, res) => {
  const { id_usuario } = req.body; // Obtener el id de usuario desde el cuerpo de la solicitud

  try {
    // Obtener el carrito de compra del usuario
    const carrito = await Carritos_compras.findOne({ where: { id_usuario } });

    if (!carrito) {
      return res
        .status(400)
        .json({ error: "El usuario no tiene un carrito de compra" });
    }

    // Obtener los detalles del carrito de compra
    const detallesCarrito = await Carrito_compra_detalles.findAll({
      where: { id_carrito_compra: carrito.id },
    });

    // Crear una nueva orden
    const nuevaOrden = await Orden.create({
      total: 0, // El total se actualizará después de calcular el costo total de los productos en el carrito
      estado_orden: "pendiente",
      id_usuario,
    });

    // Calcular el costo total de los productos en el carrito
    let total = 0;
    for (const detalleCarrito of detallesCarrito) {
      const producto = await Producto.findByPk(detalleCarrito.id_producto);

      if (!producto) {
        return res
          .status(400)
          .json({
            error: `El producto con id ${detalleCarrito.id_producto} no existe`,
          });
      }

      total += producto.precio * detalleCarrito.cantidad;

      // Crear un nuevo detalle de orden
      await DetalleOrden.create({
        cantidad: detalleCarrito.cantidad,
        precio_unitario: producto.precio,
        id_producto: detalleCarrito.id_producto,
        id_orden: nuevaOrden.id,
      });

      // Eliminar el detalle de carrito de compra
      await detalleCarrito.destroy();
    }
    // Actualizar el total de la orden
    nuevaOrden.total = total;
    await nuevaOrden.save();

    // Eliminar el carrito de compra
    await carrito.destroy();

    return res.status(201).json(nuevaOrden);
  } catch (error) {
    console.error("Error al crear la orden:", error);
    return res.status(500).json({ error: "Error al crear la orden" });
  }
};


export const obtenerOrdenesUsuario = async (req, res) => {
  const { id_usuario } = req.params; // Obtener el id de usuario desde los parámetros de la URL

  try {
    // Buscar todas las órdenes asociadas al usuario
    const ordenes = await Orden.findAll({
      where: { id_usuario },
    });

    return res.status(200).json(ordenes);
  } catch (error) {
    console.error("Error al obtener las órdenes del usuario:", error);
    return res.status(500).json({ error: "Error al obtener las órdenes del usuario" });
  }
};


export const actualizarEstadoOrden = async (req, res) => {
  const { id_orden } = req.params; // Obtener el id de la orden desde los parámetros de la URL
  const { estado_orden } = req.body; // Obtener el nuevo estado de la orden desde el cuerpo de la solicitud

  try {
    // Buscar la orden por su ID
    const orden = await Orden.findByPk(id_orden);

    if (!orden) {
      return res
        .status(404)
        .json({ error: `La orden con id ${id_orden} no existe` });
    }

    // Actualizar el estado de la orden
    orden.estado_orden = estado_orden;
    await orden.save();

    return res.status(200).json(orden);
  } catch (error) {
    console.error("Error al actualizar el estado de la orden:", error);
    return res.status(500).json({ error: "Error al actualizar el estado de la orden" });
  }
};


export const obtenerDetalleOrden = async (req, res) => {
  const { id_orden } = req.params; // Obtener el id de la orden desde los parámetros de la URL

  try {
    // Buscar los detalles de la orden por el ID de la orden
    const detallesOrden = await DetalleOrden.findAll({
      where: { id_orden },
    });

    return res.status(200).json(detallesOrden);
  } catch (error) {
    console.error("Error al obtener los detalles de la orden:", error);
    return res.status(500).json({ error: "Error al obtener los detalles de la orden" });
  }
};
