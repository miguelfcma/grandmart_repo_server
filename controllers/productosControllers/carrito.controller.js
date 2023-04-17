import { Carrito_compra_detalles } from "../../models/productosModel/CarritoCompraDetallesModel.js";
import { Carritos_compras } from "../../models/productosModel/CarritoComprasModel.js";

export const agregarProductoAlCarrito = async (req, res) => {
  try {
    const { id_producto, cantidad, id_usuario } = req.body;

    // Buscar el carrito de compras del usuario
    let carrito = await Carritos_compras.findOne({
      where: { id_usuario: id_usuario },
    });

    // Si no existe el carrito de compras, se crea uno nuevo
    if (!carrito) {
      carrito = await Carritos_compras.create({
        id_usuario: id_usuario,
        fecha_creacion: new Date(),
      });
    }

    // Buscar si el producto ya está en el carrito de compras
    const detalle = await Carrito_compra_detalles.findOne({
      where: { id_carrito_compra: carrito.id, id_producto: id_producto },
    });

    if (detalle) {
      // Si el producto ya está en el carrito, se actualiza la cantidad
      detalle.cantidad += cantidad;
      await detalle.save();
    } else {
      // Si el producto no está en el carrito, se agrega como un nuevo detalle
      await Carrito_compra_detalles.create({
        id_carrito_compra: carrito.id,
        id_producto: id_producto,
        cantidad: cantidad,
      });
    }

    // Actualizar el total del carrito de compras
    const detalles = await Carrito_compra_detalles.findAll({
      where: { id_carrito_compra: carrito.id },
    });
    const total = detalles.reduce(
      (total, detalle) => total + detalle.cantidad * detalle.precio,
      0
    );
    carrito.total = total;
    await carrito.save();

    // Devolver el carrito de compras actualizado
    res.status(200).json(carrito);
  } catch (error) {
    console.error(error);

    res
      .status(500)
      .json({ message: "Error al agregar el producto al carrito de compras" });
  }
};

export const actualizarCantidadProductoEnCarrito = async (req, res) => {
  try {
    const id_producto = req.params.id_producto;
    const { cantidad, id_usuario } = req.body;

    // Buscar el carrito de compras del usuario
    const carrito = await Carritos_compras.findOne({ where: { id_usuario } });

    if (!carrito) {
      return res
        .status(404)
        .json({ mensaje: "No se encontró el carrito de compras del usuario" });
    }

    // Buscar el detalle del carrito de compras correspondiente al producto
    const detalleCarrito = await Carrito_compra_detalles.findOne({
      where: { id_carrito_compra: carrito.id, id_producto },
    });

    if (!detalleCarrito) {
      return res.status(404).json({
        mensaje: "No se encontró el producto en el carrito de compras",
      });
    }

    // Actualizar la cantidad del detalle y el total del carrito de compras
    detalleCarrito.cantidad = cantidad;
    await detalleCarrito.save();


    await carrito.save();

    // Devolver una respuesta con el detalle del carrito actualizado
    return res
      .status(200)
      .json({ mensaje: "Cantidad del producto actualizada", detalleCarrito });
  } catch (error) {
    console.error(error);
    console.log(error);
    return res.status(500).json({
      mensaje: "Ocurrió un error al actualizar la cantidad del producto",
    });
  }
};

export const obtenerCarritoDeCompras = async (req, res) => {
  try {
    const id_usuario = req.params.id_usuario;

    // Buscar el carrito de compras del usuario
    const carrito = await Carritos_compras.findOne({ where: { id_usuario } });

    if (!carrito) {
      return res
        .status(404)
        .json({ mensaje: "No se encontró el carrito de compras del usuario" });
    }

    // Buscar los detalles del carrito de compras
    const detallesCarrito = await Carrito_compra_detalles.findAll({
      where: { id_carrito_compra: carrito.id },
    });

    const respuesta = {
      carrito,
      detalles: detallesCarrito,
    };

    return res.status(200).json(respuesta);
  } catch (error) {
    console.error(error);
    console.log(error);
    return res.status(500).json({
      mensaje: "Hubo un error al obtener el carrito de compras del usuario",
    });
  }
};

export const eliminarProductoDelCarrito = async (req, res) => {
  try {
    const id_producto = req.params.id_producto;
    const id_usuario = req.body.id_usuario; // Se asume que el usuario está autenticado y su id se encuentra en el token

    // Buscar el carrito de compras del usuario
    const carrito = await Carritos_compras.findOne({ where: { id_usuario } });

    if (!carrito) {
      return res
        .status(404)
        .json({ mensaje: "No se encontró el carrito de compras del usuario" });
    }

    // Eliminar el detalle del carrito de compras que corresponde al producto a eliminar
    const detalleCarrito = await Carrito_compra_detalles.findOne({
      where: { id_producto, id_carrito_compra: carrito.id },
    });

    if (!detalleCarrito) {
      return res.status(404).json({
        mensaje: "El producto no se encontró en el carrito de compras",
      });
    }

    await detalleCarrito.destroy();

    // Actualizar el total del carrito de compras
    const detallesCarrito = await Carrito_compra_detalles.findAll({
      where: { id_carrito_compra: carrito.id },
    });
    let totalCarrito = 0;

    detallesCarrito.forEach((detalle) => {
      totalCarrito += detalle.cantidad * detalle.precio_unitario;
    });

    carrito.total = totalCarrito;
    await carrito.save();

    // Devolver una respuesta con el detalle del carrito actualizado
    return res.json(detallesCarrito);
  } catch (error) {
    console.error(error);
    console.log(error);
    return res.status(500).json({ mensaje: "Error en el servidor" });
  }
};

export const vaciarCarrito = async (req, res) => {
  try {
    const id_usuario = req.body.id_usuario; // Se asume que el usuario está autenticado y su id se encuentra en el token

    // Buscar el carrito de compras del usuario
    const carrito = await Carritos_compras.findOne({ where: { id_usuario } });

    if (!carrito) {
      return res
        .status(404)
        .json({ mensaje: "No se encontró el carrito de compras del usuario" });
    }

    // Eliminar todos los detalles del carrito de compras correspondientes al usuario
    await Carrito_compra_detalles.destroy({
      where: { id_carrito_compra: carrito.id },
    });

    // Actualizar el total del carrito de compras
    carrito.total = 0;
    await carrito.save();

    return res
      .status(200)
      .json({ mensaje: "El carrito de compras ha sido vaciado exitosamente" });
  } catch (error) {
    console.error(error);
    console.log(error);
    return res
      .status(500)
      .json({ mensaje: "Ocurrió un error al vaciar el carrito de compras" });
  }
};
