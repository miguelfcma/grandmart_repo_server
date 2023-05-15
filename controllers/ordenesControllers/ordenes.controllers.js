import { DetalleOrden } from "../../models/ordenesModel/OrdenDetallesModel.js";
import { Orden } from "../../models/ordenesModel/OrdenModel.js";
import { Carrito_compra_detalles } from "../../models/productosModel/CarritoCompraDetallesModel.js";
import { Carritos_compras } from "../../models/productosModel/CarritoComprasModel.js";
import { Producto } from "../../models/productosModel/ProductoModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import { DomicilioUsuario } from "../../models/usuariosModel/DomicilioUsuarioModel.js";
import { DireccionEnvio } from "../../models/ordenesModel/DireccionEnvioModel.js";
import { Envio } from "../../models/ordenesModel/EnviosModel.js";
export const obtenerTodasLasOrdenes = async (req, res) => {
  try {
    // Buscar todas las órdenes
    const ordenes = await Orden.findAll();

    /* Crear un arreglo para almacenar las órdenes con los detalles de orden
    const ordenesConDetallesOrden = await Promise.all(
      ordenes.map(async (orden) => {
        // Buscar los detalles de orden para cada orden
        const detallesOrden = await DetalleOrden.findAll({
          where: { id_orden: orden.id },
          attributes: ["id", "cantidad", "precio_unitario", "id_producto", "id_orden"],
        });
        
        // Convertir la orden y los detalles de orden a objetos JSON
        const ordenJSON = orden.toJSON();
        const detallesOrdenJSON = detallesOrden.map(d => d.toJSON());
        // Agregar los detalles de orden a la orden
        ordenJSON.detallesOrden = detallesOrdenJSON;
        return ordenJSON;
      })
    );
*/
    return res.status(200).json(ordenes);
  } catch (error) {
    console.error("Error al obtener todas las órdenes:", error);
    return res
      .status(500)
      .json({ error: "Error al obtener todas las órdenes" });
  }
};

export const obtenerDireccionEnvioOrden = async (req, res) => {
  const { id_orden } = req.params; // Obtener el id de la orden desde los parámetros de la URL
  try {
    // Buscar la dirección de envío en base al ID de orden
    const direccion_envio = await DireccionEnvio.findOne({
      where: { id_orden },
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

    // Verificar si se encontró la dirección de envío
    if (direccion_envio) {
      // Enviar la dirección de envío como respuesta con un mensaje de éxito y código de estado 200
      return res
        .status(200)
        .json({ message: "Dirección de envío encontrada", direccion_envio });
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

// Función para crear una nueva orden
export const crearOrden = async (req, res) => {
  const { id_usuario } = req.body; // Obtener el id de usuario desde el cuerpo de la solicitud

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

    // Crear una nueva orden
    const nuevaOrden = await Orden.create({
      total: 0,
      id_usuario,
    });

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

    // Calcular el costo total de los productos en el carrito
    let total = 0;
    for (const detalleCarrito of detallesCarrito) {
      const producto = await Producto.findByPk(detalleCarrito.id_producto);

      if (!producto) {
        return res.status(400).json({
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
    const nuevoEnvio = await Envio.create({
      orden_id: nuevaOrden.id,
      direccion_envio_id: nuevaDireccionEnvio.id,
    });
    
    // Eliminar el carrito de compra
    //await carrito.destroy();

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
    return res
      .status(500)
      .json({ error: "Error al obtener las órdenes del usuario" });
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
    if (estado_orden === "entregado") {
      orden.fechaEntrega = new Date(); // Registrar la fecha de entrega como la fecha y hora actuales
    }
    await orden.save();

    return res.status(200).json(orden);
  } catch (error) {
    console.error("Error al actualizar el estado de la orden:", error);
    return res
      .status(500)
      .json({ error: "Error al actualizar el estado de la orden" });
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

export const obtenerPedidosPorUsuario = async (req, res) => {
  const { id_usuario } = req.params;
  try {
    const detallesOrden = await DetalleOrden.findAll();
    const detallesOrdenConProducto = await Promise.all(
      detallesOrden.map(async (detalle) => {
        const orden = await Orden.findByPk(detalle.id_orden); // Obtener la orden relacionada
        const producto = await Producto.findByPk(detalle.id_producto, {
          attributes: ["id", "nombre", "precio", "id_usuario"],
        });
        return { ...detalle.toJSON(), producto, orden };
      })
    );
    const detallesOrdenFiltrados = detallesOrdenConProducto.filter(
      (detalles) => detalles.orden.id_usuario === parseInt(id_usuario)
    );

    const respuesta = {
      message: "ProductosPedidos encontrados",
      productosPedidos: detallesOrdenFiltrados,
    };

    return res.status(200).json(respuesta);
  } catch (error) {
    console.error("Error al obtener productosPedidos:", error);
    return res.status(500).json({ error: "Error al obtener productosPedidos" });
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
