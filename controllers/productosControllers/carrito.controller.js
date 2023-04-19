import { Carrito_compra_detalles } from "../../models/productosModel/CarritoCompraDetallesModel.js";
import { Carritos_compras } from "../../models/productosModel/CarritoComprasModel.js";
import { Producto } from "../../models/productosModel/ProductoModel.js";

export const agregarProductoAlCarrito = async (req, res) => {
  try {
    const { id_producto, id_usuario } = req.body;

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
    let detalle = await Carrito_compra_detalles.findOne({
      where: { id_carrito_compra: carrito.id, id_producto: id_producto },
    });

    // Verificar si hay suficiente stock de producto
    const producto = await Producto.findOne({ where: { id: id_producto } });
    if (!producto) {
      return res.status(404).json({ mensaje: "No se encontró el producto" });
    }

    if (detalle) {
      // Si el producto ya está en el carrito, se actualiza la cantidad
      if (producto.stock >= detalle.cantidad + 1) {
        detalle.cantidad += 1;
        await detalle.save();
      } else {
        return res
          .status(400)
          .json({ mensaje: "No hay suficiente stock del producto" });
      }
    } else {
      // Si el producto no está en el carrito, se agrega como un nuevo detalle
      if (producto.stock >= 1) {
        detalle = await Carrito_compra_detalles.create({
          id_carrito_compra: carrito.id,
          id_producto: id_producto,
          cantidad: 1,
        });
      } else {
        return res
          .status(400)
          .json({ mensaje: "No hay suficiente stock del producto" });
      }
    }

    // Actualizar el total del carrito de compras
    const detalles = await Carrito_compra_detalles.findAll({
      where: { id_carrito_compra: carrito.id },
    });

    await carrito.save();

    // Buscar el producto correspondiente al detalle del carrito de compras
    const productoDetalles = await Producto.findByPk(detalle.id_producto, {
      attributes: ["id", "nombre", "precio"],
    });

    const respuesta = {
      mensaje: "Producto agregado",
      detalle: { ...detalle.toJSON(), producto: productoDetalles }, // Combinar el detalle del carrito de compras con el producto encontrado
    };

    return res.status(200).json(respuesta);
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
    const { id_usuario, accion } = req.body; // Eliminar el parámetro 'cantidad'

    // Buscar el carrito de compras del usuario
    const carrito = await Carritos_compras.findOne({ where: { id_usuario } });

    if (!carrito) {
      return res
        .status(404)
        .json({ mensaje: "No se encontró el carrito de compras del usuario" });
    }

    // Buscar el detalle del producto en el carrito de compras
    const detalle = await Carrito_compra_detalles.findOne({
      where: { id_carrito_compra: carrito.id, id_producto: id_producto },
    });

    if (!detalle) {
      return res.status(404).json({
        mensaje: "No se encontró el producto en el carrito de compras",
      });
    }

    // Verificar si hay suficiente stock de producto
    const producto = await Producto.findOne({ where: { id: id_producto } });
    if (!producto) {
      return res.status(404).json({ mensaje: "No se encontró el producto" });
    }

    // Actualizar la cantidad del producto en el carrito de compras
    if (accion === "incrementar") {
      if (detalle.cantidad + 1 > producto.stock) {
        return res
          .status(400)
          .json({ mensaje: "No hay suficiente stock del producto" });
      }
      detalle.cantidad += 1;
    } else if (accion === "decrementar") {
      if (detalle.cantidad - 1 < 1) {
        return res.status(400).json({ mensaje: "La cantidad mínima es 1" });
      }
      detalle.cantidad -= 1;
    } else {
      return res.status(400).json({ mensaje: "Acción inválida" });
    }

    await detalle.save();
    // Buscar el producto correspondiente al detalle del carrito de compras
    const productoDetalles = await Producto.findByPk(detalle.id_producto, {
      attributes: ["id", "nombre", "precio"],
    });

    const respuesta = {
      mensaje: "Cantidad de producto actualizada",
      detalle: { ...detalle.toJSON(), producto: productoDetalles }, // Combinar el detalle del carrito de compras con el producto encontrado
    };

    return res.status(200).json(respuesta);
  } catch (error) {
    console.error(error);

    res.status(500).json({
      mensaje:
        "Error al actualizar la cantidad del producto en el carrito de compras",
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

    const detallesCarritoConProducto = await Promise.all(
      detallesCarrito.map(async (datalle) => {
        const producto = await Producto.findByPk(datalle.id_producto, {
          attributes: ["id", "nombre", "precio"],
        });
        return { ...datalle.toJSON(), producto };
      })
    );

    const respuesta = {
      carrito,
      detalleCarrito: detallesCarritoConProducto,
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
    const id_usuario = req.body.id_usuario;


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

    // Devolver una respuesta con el detalle del carrito actualizado
    const detallesCarritoConProducto = await Promise.all(
      detallesCarrito.map(async (datalle) => {
        const producto = await Producto.findByPk(datalle.id_producto, {
          attributes: ["id", "nombre", "precio"],
        });
        return { ...datalle.toJSON(), producto };
      })
    );

    const respuesta = {
      mensaje: "Producto eliminado del carrito",
      detalleCarrito: detallesCarritoConProducto,
    };

    return res.status(200).json(respuesta);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ mensaje: "Error en el servidor" });
  }
};

export const vaciarCarrito = async (req, res) => {
  try {
    const id_usuario = req.params.id_usuario; // Se asume que el usuario está autenticado y su id se encuentra en el token

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
