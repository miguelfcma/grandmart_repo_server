import { DetalleOrden } from "../../models/ordenesModel/OrdenDetallesModel.js";
import { Orden } from "../../models/ordenesModel/OrdenModel.js";
import { Carrito_compra_detalles } from "../../models/productosModel/CarritoCompraDetallesModel.js";
import { Carritos_compras } from "../../models/productosModel/CarritoComprasModel.js";
import { Producto } from "../../models/productosModel/ProductoModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import { DomicilioUsuario } from "../../models/usuariosModel/DomicilioUsuarioModel.js";
import { DireccionEnvio } from "../../models/ordenesModel/DireccionEnvioModel.js";
import { Envio } from "../../models/ordenesModel/EnviosModel.js";

import { checkout } from "../stripeController/pagosStripe.controller.js";
import { Pago } from "../../models/ordenesModel/PagosModel.js";
//Funciones de ordenes
export const obtenerTodasLasOrdenes = async (req, res) => {
  try {
    // Buscar todas las órdenes
    const ordenes = await Orden.findAll();

    return res.status(200).json(ordenes);
  } catch (error) {
    console.error("Error al obtener todas las órdenes:", error);
    return res
      .status(500)
      .json({ error: "Error al obtener todas las órdenes" });
  }
};

// Función para crear una nueva orden
export const crearOrden = async (req, res) => {
  const { id_usuario, id_card, amount, description } = req.body; // Obtener el id de usuario desde el cuerpo de la solicitud
  console.log(id_usuario, id_card, amount, description);

  try {
    const direccion_envio = await DomicilioUsuario.findOne({
      where: { id_usuario },
      attributes: [
        "id",
        "nombre_ine",
        "postal",
        "estado",
        "municipio_alcaldia",
        "colonia",
        "calle",
        "numeroExterior",
        "numeroInterior",
        "calle1",
        "calle2",
        "descripcion",
      ],
    });

    if (!direccion_envio) {
      return res.status(400).json({
        error: "El usuario no tiene una dirección de envío registrada",
      });
    }

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

    if (detallesCarrito.length === 0) {
      return res
        .status(400)
        .json({ error: "El carrito de compra no tiene detalles" });
    }

    // Crear una nueva orden
    const nuevaOrden = await Orden.create({
      total: 0,
      id_usuario,
    });

    // Validacion de existencia de productos y validacion de stock
    let total = 0;
    for (const detalleCarrito of detallesCarrito) {
      const producto = await Producto.findByPk(detalleCarrito.id_producto);
      if (!producto) {
        // Eliminar la orden y los detalles de la orden creados
        await DetalleOrden.destroy({ where: { id_orden: nuevaOrden.id } });
        await nuevaOrden.destroy();
        return res.status(400).json({
          error: `El producto con id ${detalleCarrito.id_producto} no existe`,
        });
      }

      if (detalleCarrito.cantidad > producto.stock) {
        // Eliminar la orden y los detalles de la orden creados
        await DetalleOrden.destroy({ where: { id_orden: nuevaOrden.id } });
        await nuevaOrden.destroy();
        return res.status(400).json({
          message: `No hay suficiente stock disponible para el producto con id ${detalleCarrito.id_producto}`,
        });
      }
    }
    const paymentResult = await checkout({
      id_card,
      amount,
      description,
      id_usuario,
      id_orden: nuevaOrden.id,
    });

    if (paymentResult.error) {
      // Eliminar la orden y los detalles de la orden creados
      await DetalleOrden.destroy({ where: { id_orden: nuevaOrden.id } });
      await nuevaOrden.destroy();

      return res.status(400).json({
        message: "Hubo un problema con el pago",
      });
    }

    for (const detalleCarrito of detallesCarrito) {
      const producto = await Producto.findByPk(detalleCarrito.id_producto);

      producto.stock -= detalleCarrito.cantidad;
      total += producto.precio * detalleCarrito.cantidad;

      await producto.save();

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

    // Crear una nueva dirección de envío en la tabla de DireccionEnvio
    const nuevaDireccionEnvio = await DireccionEnvio.create({
      nombre_ine: direccion_envio.nombre_ine,
      postal: direccion_envio.postal,
      estado: direccion_envio.estado,
      municipio_alcaldia: direccion_envio.municipio_alcaldia,
      colonia: direccion_envio.colonia,
      calle: direccion_envio.calle,
      numeroExterior: direccion_envio.numeroExterior,
      numeroInterior: direccion_envio.numeroInterior,
      calle1: direccion_envio.calle1,

      calle2: direccion_envio.calle2,
      descripcion: direccion_envio.descripcion,
    });

    nuevaOrden.total = total;
    const nuevoEnvio = await Envio.create({
      orden_id: nuevaOrden.id,
      direccion_envio_id: nuevaDireccionEnvio.id,
    });
    await nuevaOrden.save();

    return res.status(201).json(nuevaOrden);
  } catch (error) {
    console.error("Error al crear la orden:", error);

    return res.status(500).json({ error: "Error al crear la orden" });
  }
};

export const eliminarOrden = async (req, res) => {
  const { id_orden } = req.params;

  try {
    const orden = await Orden.findOne({
      where: { id: id_orden },
    });

    if (!orden) {
      return res
        .status(404)
        .json({ error: `La orden con id ${id_orden} no existe` });
    }

    const detallesOrden = await DetalleOrden.findAll({
      where: { id_orden },
    });

    const envio = await Envio.findOne({ where: { orden_id: id_orden } });
    const direccion_envio = await DireccionEnvio.findByPk(
      envio.direccion_envio_id
    );
    const pago = await Pago.findOne({ where: { orden_id: id_orden } });
    if (direccion_envio) {
      if (envio) {
        await envio.destroy();
      }
      await direccion_envio.destroy();
    }
   

    if (pago) {
      await pago.destroy();
    }
    if (detallesOrden.length) {
      for (const detalle of detallesOrden) {
        await detalle.destroy();
      }
    }

    await orden.destroy();

    return res.status(200).json(orden);
  } catch (error) {
    console.error("Error al eliminar la orden", error);
    return res.status(500).json({ error: "Error al eliminar la orden" });
  }
};

export const obtenerDetalleOrden = async (req, res) => {
  const { id_orden } = req.params; // Obtener el id de la orden desde los parámetros de la URL

  try {
    const orden = await Orden.findOne({
      where: { id: id_orden },
    });

    // Buscar los detalles de la orden por el ID de la orden
    const detallesOrden = await DetalleOrden.findAll({
      where: { id_orden },
    });

    // Devolver una respuesta con el detalle del carrito actualizado
    const detallesOrdenConProducto = await Promise.all(
      detallesOrden.map(async (datalle) => {
        const producto = await Producto.findByPk(datalle.id_producto, {
          attributes: ["id", "nombre", "precio"],
        });
        return { ...datalle.toJSON(), producto };
      })
    );

    const respuesta = {
      message: "Detalles econtrados ",
      orden: orden,
      detallesOrden: detallesOrdenConProducto,
    };

    return res.status(200).json(respuesta);
  } catch (error) {
    console.error("Error al obtener los detalles de la orden:", error);
    return res
      .status(500)
      .json({ error: "Error al obtener los detalles de la orden" });
  }
};
//Compras funciones
export const obtenerComprasUsuario = async (req, res) => {
  const { id_usuario } = req.params; // Obtener el id de usuario desde los parámetros de la URL

  try {
    // Buscar todas las órdenes asociadas al usuario
    const ordenes = await Orden.findAll({
      where: { id_usuario },
    });

    return res.status(200).json(ordenes);
  } catch (error) {
    console.error("Error al obtener las órdenes del usuario:", error);
    return res
      .status(500)
      .json({ error: "Error al obtener las órdenes del usuario" });
  }
};

////Ventas funciones

export const obtenerVentasPorUsuario = async (req, res) => {
  const { id_usuario } = req.params;

  try {
    const ordenes = await Orden.findAll();

    const ventas = await Promise.all(
      ordenes.map(async (orden) => {
        const detalles = await DetalleOrden.findAll({
          where: { id_orden: orden.id },
        });

        const productosPromises = detalles.map(async (detalle) => {
          const producto = await Producto.findOne({
            where: { id: detalle.id_producto, id_usuario: id_usuario },
            attributes: ["id", "nombre", "precio"],
          });

          return {
            producto,
            cantidad: detalle.cantidad, // Agrega la cantidad del detalle
          };
        });

        const productosDetalles = await Promise.all(productosPromises);
        const productosFiltrados = productosDetalles.filter(
          (detalle) => detalle.producto !== null
        );
        let totalVenta = 0;

        productosFiltrados.forEach((detalle) => {
          const { producto, cantidad } = detalle;
          const subtotal = producto.precio * cantidad; // Multiplica precio por cantidad
          totalVenta += subtotal;
          detalle.subtotal = subtotal; // Agrega el subtotal al detalle
        });

        // Verifica si al menos uno de los productos filtrados es válido
        if (productosFiltrados.length > 0) {
          return {
            orden,
            totalVenta,
            productos: productosFiltrados,
          };
        }
      })
    );

    // Filtra los elementos indefinidos de ventas
    const ventasFiltradas = ventas.filter((venta) => venta !== undefined);

    return res.status(200).json(ventasFiltradas);
  } catch (error) {
    console.error("Error al obtener productosPedidos:", error);
    return res.status(500).json({ error: "Error al obtener productosPedidos" });
  }
};

///Funciones de envio

export const obtenerDireccionEnvioOrden = async (req, res) => {
  const { id_orden } = req.params; // Obtener el id de la orden desde los parámetros de la URL
  try {
    const envio = await Envio.findOne({ where: { orden_id: id_orden } });

    // Buscar la dirección de envío en base al ID de orden
    const direccion_envio = await DireccionEnvio.findByPk(
      envio.direccion_envio_id
    );

    // Verificar si se encontró la dirección de envío
    if (direccion_envio) {
      // Enviar la dirección de envío como respuesta con un mensaje de éxito y código de estado 200
      return res.status(200).json({
        message: "Dirección de envío encontrada",
        direccion_envio,
      });
    } else {
      // Si no se encontró la dirección de envío, enviar una respuesta de error con código de estado 404
      return res.status(404).json({
        error:
          "No se encontró la dirección de envío para la orden proporcionada",
      });
    }
  } catch (error) {
    console.error("Error al obtener la dirección de envío de la orden:", error);
    // Enviar una respuesta de error con código de estado 500
    return res
      .status(500)
      .json({ error: "Error al obtener la dirección de envío de la orden" });
  }
};
export const obtenerInformacionEnvio = async (req, res) => {
  const { id_orden } = req.params; // Obtener el id de la orden desde los parámetros de la URL
  try {
    const envio = await Envio.findOne({ where: { orden_id: id_orden } });

    if (envio) {
      // Buscar la dirección de envío en base al ID de orden
      const direccion_envio = await DireccionEnvio.findByPk(
        envio.direccion_envio_id
      );

      // Verificar si se encontró la dirección de envío
      if (direccion_envio) {
        // Enviar la dirección de envío como respuesta con un mensaje de éxito y código de estado 200
        return res.status(200).json({
          message: "Información de envío econtrada",
          envio,
          direccion_envio,
        });
      } else {
        // Si no se encontró la dirección de envío, enviar una respuesta de error con código de estado 404
        return res.status(404).json({
          error:
            "No se encontró la dirección de envío para la orden proporcionada",
        });
      }
    } else {
      return res.status(404).json({
        error: "No se encontró la información de envío",
      });
    }
  } catch (error) {
    console.error("Error al obtener la dirección de envío de la orden:", error);
    // Enviar una respuesta de error con código de estado 500
    return res
      .status(500)
      .json({ error: "Error al obtener la dirección de envío de la orden" });
  }
};

export const verificacionDireccionEnvio = async (req, res) => {
  const { id_usuario } = req.params;

  if (!id_usuario) {
    return res.status(400).json({
      error: "Falta el parámetro 'id_usuario' en la solicitud",
    });
  }

  try {
    const direccion_envio = await DomicilioUsuario.findOne({
      where: { id_usuario },
    });

    if (!direccion_envio) {
      return res.status(400).json({
        error: "El usuario no tiene una dirección de envío registrada",
      });
    }

    return res.status(200).json({
      message: "El usuario tiene una dirección de envío registrada",
      direccion_envio: direccion_envio, // Agregar la dirección de envío a la respuesta
    });
  } catch (error) {
    console.error("Error al obtener la dirección de envío:", error);
    return res
      .status(500)
      .json({ error: "Error al obtener la dirección de envío" });
  }
};

////Funciones de pagos

export const obtenerTodosLosPagos = async (req, res) => {
  try {
    const pagos = await Pago.findAll();

    if (pagos.length === 0) {
      return res.status(404).json({
        error: "No se encontrarón pagos registrados",
      });
    }
    return res.status(200).json({ message: "Pagos encontrados", pagos });
  } catch (error) {
    console.error("Error al obtener la dirección de envío de la orden:", error);
    // Enviar una respuesta de error con código de estado 500
    return res
      .status(500)
      .json({ error: "Error al obtener la dirección de envío de la orden" });
  }
};

export const obtenerPagoPorIdOrden = async (req, res) => {
  const { id_orden } = req.params; // Obtener el id de la orden desde los parámetros de la URL
  try {
    const pago = await Pago.findOne({ where: { orden_id: id_orden } });

    if (pago) {
      return res
        .status(200)
        .json({ message: "Información de pago encontrada", pago });
    } else {
      return res.status(404).json({
        error: "No se encontró la información de pago encontrada",
      });
    }
  } catch (error) {
    console.error("Error al obtener la dirección de envío de la orden:", error);
    // Enviar una respuesta de error con código de estado 500
    return res
      .status(500)
      .json({ error: "Error al obtener la dirección de envío de la orden" });
  }
};

export const obtenerPagosPorIdUsuario = async (req, res) => {
  const { id_usuario } = req.params; // Obtener el id de la orden desde los parámetros de la URL
  try {
    const pagos = await Pago.findAll({ where: { usuario_id: id_usuario } });

    if (pagos.length === 0) {
      return res.status(404).json({
        error: "No se encontrarón pagos registrados",
      });
    }
    return res.status(200).json({ message: "Pagos encontrados", pagos });
  } catch (error) {
    console.error("Error al obtener la dirección de envío de la orden:", error);
    // Enviar una respuesta de error con código de estado 500
    return res
      .status(500)
      .json({ error: "Error al obtener la dirección de envío de la orden" });
  }
};
///cambiar los estados
export const cambiarEstadoEnvio = async (req, res) => {
  const { id_envio } = req.params; // Obtener el id del envío desde los parámetros de la URL
  const { nuevoEstado } = req.body; // Obtener el nuevo estado del envío desde el cuerpo de la solicitud

  try {
    // Buscar el envío por su ID
    const envio = await Envio.findByPk(id_envio);

    if (!envio) {
      return res
        .status(404)
        .json({ error: `El envío con id ${id_envio} no existe` });
    }

    if (envio.estado === "Cancelado") {
      return res.status(400).json({
        error: "La envío esta cancelado y no se puede cambiar su estado",
      });
    } else if (envio.estado === nuevoEstado) {
      return res.status(400).json({
        error: `El estado de envío ya tiene el estado ${nuevoEstado} y no se puede cambiar su estado nuevamente`,
      });
    }

    // Actualizar el estado del envío
    envio.estado = nuevoEstado;

    await envio.save();

    return res.status(200).json(envio);
  } catch (error) {
    console.error("Error al cambiar el estado del envío:", error);
    return res
      .status(500)
      .json({ error: "Error al cambiar el estado del envío" });
  }
};

export const cambiarEstadoOrden = async (req, res) => {
  const { id_orden } = req.params; // Obtener el id del envío desde los parámetros de la URL
  const { nuevoEstado } = req.body; // Obtener el nuevo estado del envío desde el cuerpo de la solicitud
  try {
    const orden = await Orden.findByPk(id_orden);

    if (!orden) {
      return res
        .status(404)
        .json({ error: `La orden con id ${id_orden} no existe` });
    }

    if (orden.estado_orden === "Cancelada") {
      return res.status(400).json({
        error: "La orden ya está cancelada y no se puede cambiar su estado",
      });
    } else if (orden.estado_orden === nuevoEstado) {
      return res.status(400).json({
        error: `La orden ya tiene el estado ${nuevoEstado} y no se puede cambiar su estado nuevamente`,
      });
    }

    const detallesOrden = await DetalleOrden.findAll({ where: { id_orden } });

    if (nuevoEstado === "Cancelada") {
      // Restablecer el stock de los productos en los detalles de la orden
      for (const detalle of detallesOrden) {
        const producto = await Producto.findByPk(detalle.id_producto);

        if (producto) {
          producto.stock += detalle.cantidad;
          await producto.save();
        }
      }
    }

    orden.estado_orden = nuevoEstado;
    await orden.save();

    return res.status(200).json({ message: "Estado de la orden actualizado" });
  } catch (error) {
    console.error("Error al cambiar el estado de la orden:", error);
    return res
      .status(500)
      .json({ error: "Error al cambiar el estado de la orden" });
  }
};

export const cancelarOrden = async (req, res) => {
  const { id_orden } = req.params; // Obtener el id de la orden desde los parámetros de la URL

  try {
    const orden = await Orden.findByPk(id_orden);
    const envio = await Envio.findOne({ where: { orden_id: id_orden } });

    if (!orden) {
      return res
        .status(404)
        .json({ error: `La orden con id ${id_orden} no existe` });
    }
    if (orden.estado_orden === "Cancelada") {
      return res.status(400).json({
        error: "La orden ya está cancelada y no se puede cambiar su estado",
      });
    }
    if (orden.estado_orden !== "Pendiente") {
      return res.status(400).json({
        error: "La orden no está en estado 'Pendiente' y no se puede cancelar",
      });
    }
    if (envio.estado !== "Pendiente") {
      return res.status(400).json({
        error: "El envío no está en estado 'Pendiente' y no se puede cancelar",
      });
    }

    const detallesOrden = await DetalleOrden.findAll({ where: { id_orden } });

    // Restablecer el stock de los productos en los detalles de la orden
    for (const detalle of detallesOrden) {
      const producto = await Producto.findByPk(detalle.id_producto);

      if (producto) {
        producto.stock += detalle.cantidad;
        await producto.save();
      }
    }

    orden.estado_orden = "Cancelada";
    await orden.save();

    return res.status(200).json({ message: "Orden cancelada" });
  } catch (error) {
    console.error("Error al cancelar la orden:", error);
    return res.status(500).json({ error: "Error al cancelar la orden" });
  }
};
