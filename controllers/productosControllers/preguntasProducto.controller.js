import { PreguntaProducto } from "../../models/productosModel/PreguntasProductoModel.js";
import { Producto } from "../../models/productosModel/ProductoModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import { enviarCorreo } from "../CorreoController/enviarCorreo.controllers.js";
// Función para crear una nueva pregunta
export const crearPregunta = async (req, res) => {
  try {
    const { pregunta, id_producto, id_usuario } = req.body;
    const nuevaPregunta = await PreguntaProducto.create({
      pregunta,
      id_producto,
      id_usuario,
    });

    if (pregunta) {
      // Buscar el producto relacionado a la pregunta
      const producto = await Producto.findByPk(id_producto);
      if (!producto) {
        return res.status(404).json({ message: "Producto no encontrado" });
      }

      const usuarioVendedor = await Usuario.findByPk(producto.id_usuario, {
        attributes: [
          "id",
          "nombre",
          "apellidoPaterno",
          "apellidoMaterno",
          "email",
        ],
      });

      if (!usuarioVendedor) {
        return res
          .status(404)
          .json({ message: "Usuario vendedor no encontrado" });
      }
      // Buscar al usuario que hizo la pregunta
      const usuarioPregunta = await Usuario.findByPk(id_usuario, {
        attributes: [
          "id",
          "nombre",
          "apellidoPaterno",
          "apellidoMaterno",
          "email",
        ],
      });

      const email = usuarioVendedor.email;
      const subject = "GrandMart Marketplace";
      const header = "Notificación de nueva pregunta";

      const contenido = `
      <h2>Tienes una nueva pregunta</h2>
      <p>
        Usuario: <strong>${usuarioPregunta.id} ${usuarioPregunta.nombre} ${usuarioPregunta.apellidoPaterno} ${usuarioPregunta.apellidoMaterno}</strong>
      </p>
      <p>
        Producto: <strong>${producto.id} ${producto.nombre}</strong>
      </p>
      <hr />
      <p>Pregunta: <strong>${pregunta}</p></strong>
    `;

      await enviarCorreo(email, subject, header, contenido);
    }

    res.status(201).json({ message: "Pregunta creada correctamente" });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para crear una nueva respuesta para una pregunta
export const crearRespuesta = async (req, res) => {
  try {
    const { id } = req.params;
    const { respuesta } = req.body;
    // Buscar la pregunta por su ID
    const pregunta = await PreguntaProducto.findOne({ where: { id } });

    if (!pregunta) {
      return res.status(404).json({ message: "Pregunta no encontrada" });
    }
    // Actualizar la respuesta de la pregunta
    pregunta.respuesta = respuesta;
    await pregunta.save();

    // Obtener información del usuario que hizo la pregunta
    const usuarioPregunta = await Usuario.findByPk(pregunta.id_usuario, {
      attributes: ["id", "nombre", "email"],
    });

    // Obtener información del producto al que se refiere la pregunta
    const producto = await Producto.findByPk(pregunta.id_producto, {
      attributes: ["id", "nombre"],
    });

    const email = usuarioPregunta.email;
    const subject = "Respuesta a tu pregunta";
    const header = "Respuesta recibida";
    const contenido = `
      <h2>Tu pregunta ha sido respondida</h2>
      <p>Pregunta: ${pregunta.pregunta}</p>
      <p>Respuesta: ${pregunta.respuesta}</p>
      <p>Producto: ${producto.id} ${producto.nombre}</p>
    `;

    await enviarCorreo(email, subject, header, contenido);

    res.status(200).json(pregunta);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para obtener todas las preguntas asociadas a un producto

export const getPreguntasByIdProducto = async (req, res) => {
  try {
    const { id_producto } = req.params;
    const preguntas = await PreguntaProducto.findAll({
      where: { id_producto },
    });

    if (preguntas.length === 0) {
      return res.status(404).json({ message: "No se encontraron preguntas" });
    }
    const preguntasConUsuarioYProducto = await Promise.all(
      preguntas.map(async (pregunta) => {
        const producto = await Producto.findByPk(pregunta.id_producto, {
          attributes: ["id", "nombre"],
        });
        const usuario = await Usuario.findByPk(pregunta.id_usuario, {
          attributes: ["id", "nombre"],
        });
        return { ...pregunta.toJSON(), producto, usuario };
      })
    );

    res.status(200).json(preguntasConUsuarioYProducto);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para eliminar una pregunta por su ID
export const eliminarPregunta = async (req, res) => {
  try {
    const { id } = req.params;
    const pregunta = await PreguntaProducto.findOne({ where: { id } });
    if (!pregunta) {
      return res.status(404).send("Pregunta no encontrada");
    }
    await pregunta.destroy();
    res.status(204).send();
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para actualizar una pregunta por su ID
export const actualizarPregunta = async (req, res) => {
  try {
    const { id } = req.params;
    const { pregunta, id_producto, id_usuario } = req.body;
    // Función para actualizar una pregunta por su ID
    const preguntaActualizada = await PreguntaProducto.update(
      { pregunta, id_producto, id_usuario },
      { where: { id } }
    );
    res.status(200).json(preguntaActualizada);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para obtener productos del usuario con preguntas asociadas

export const getProductosConPreguntasByUsuarioId = async (req, res) => {
  try {
    const { id_usuario } = req.params;

    // Buscar productos del usuario por su ID de usuario
    const productos = await Producto.findAll({ where: { id_usuario } });

    if (productos.length === 0) {
      return res.status(404).json({
        message: "No se encontraron productos para el usuario especificado",
      });
    }

    const productosConPreguntas = await Promise.all(
      productos.map(async (producto) => {
        // Buscar preguntas asociadas al producto
        const preguntas = await PreguntaProducto.findAll({
          where: { id_producto: producto.id },
        });

        if (preguntas.length > 0) {
          // Si el producto tiene preguntas asociadas, agregarlas como propiedad al objeto de producto
          return { producto: producto.toJSON(), preguntas };
        } else {
          // Si el producto no tiene preguntas asociadas, devolver null
          return null;
        }
      })
    );

    // Filtrar los productos nulos (que no tienen preguntas asociadas)
    const productosConPreguntasFiltrados = productosConPreguntas.filter(
      (producto) => producto !== null
    );

    res.status(200).json(productosConPreguntasFiltrados);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};
// Función para obtener todos los productos con preguntas asociadas

export const getTodosProductosConPreguntas = async (req, res) => {
  try {
    // Buscar productos del usuario por su ID de usuario
    const productos = await Producto.findAll();

    if (productos.length === 0) {
      return res.status(404).json({ message: "No se encontraron productos " });
    }

    const productosConPreguntas = await Promise.all(
      productos.map(async (producto) => {
        // Buscar preguntas asociadas al producto
        const preguntas = await PreguntaProducto.findAll({
          where: { id_producto: producto.id },
        });

        if (preguntas.length > 0) {
          // Si el producto tiene preguntas asociadas, agregarlas como propiedad al objeto de producto
          return { producto: producto.toJSON(), preguntas };
        } else {
          // Si el producto no tiene preguntas asociadas, devolver null
          return null;
        }
      })
    );

    // Filtrar los productos nulos (que no tienen preguntas asociadas)
    const productosConPreguntasFiltrados = productosConPreguntas.filter(
      (producto) => producto !== null
    );

    res.status(200).json(productosConPreguntasFiltrados);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};
