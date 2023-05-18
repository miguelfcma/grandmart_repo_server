import { PreguntaProducto } from "../../models/productosModel/PreguntasProductoModel.js";
import { Producto } from "../../models/productosModel/ProductoModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
// Crear una nueva pregunta
export const crearPregunta = async (req, res) => {
  try {
    const { pregunta, id_producto, id_usuario } = req.body;
    const nuevaPregunta = await PreguntaProducto.create({
      pregunta,
      id_producto,
      id_usuario,
    });
    res.status(201).json(nuevaPregunta);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};

// Crear una nueva respuesta para una pregunta
export const crearRespuesta = async (req, res) => {
  try {
    const { id } = req.params;
    const { respuesta } = req.body;
    const pregunta = await PreguntaProducto.findOne({ where: { id } });
    pregunta.respuesta = respuesta;
    await pregunta.save();
    res.status(200).json(pregunta);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};

// Obtener todas las preguntas asociadas a un producto
export const getPreguntasByIdProducto = async (req, res) => {
  try {
    const { id_producto } = req.params;
    const preguntas = await PreguntaProducto.findAll({ where: { id_producto } });

    if (preguntas.length === 0) {
      return res.status(404).json({ message: "No se encontraron preguntas" });
    }
    const preguntasConUsuarioYProducto = await Promise.all(preguntas.map(async pregunta => {
      const producto = await Producto.findByPk(pregunta.id_producto, { attributes: ['id', 'nombre'] });
      const usuario = await Usuario.findByPk(pregunta.id_usuario, { attributes: ['id', 'nombre'] });
      return { ...pregunta.toJSON(), producto, usuario };
    }));

    res.status(200).json(preguntasConUsuarioYProducto);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};

// Eliminar una pregunta por su ID
export const eliminarPregunta = async (req, res) => {
  try {
    const { id } = req.params;
    const pregunta = await PreguntaProducto.findOne({ where: { id } });
    if (!pregunta) {
      return res.status(404).send('Pregunta no encontrada');
    }
    await pregunta.destroy();
    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};

// Actualizar una pregunta por su ID
export const actualizarPregunta = async (req, res) => {
  try {
    const { id } = req.params;
    const { pregunta, id_producto, id_usuario } = req.body;
    const preguntaActualizada = await PreguntaProducto.update(
      { pregunta, id_producto, id_usuario },
      { where: { id } }
    );
    res.status(200).json(preguntaActualizada);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};

// Obtener productos del usuario con preguntas asociadas
export const getProductosConPreguntasByUsuarioId = async (req, res) => {
  try {
    const { id_usuario } = req.params;

    // Buscar productos del usuario por su ID de usuario
    const productos = await Producto.findAll({ where: { id_usuario } });

    if (productos.length === 0) {
      return res.status(404).json({ message: "No se encontraron productos para el usuario especificado" });
    }

    const productosConPreguntas = await Promise.all(productos.map(async producto => {
      // Buscar preguntas asociadas al producto
      const preguntas = await PreguntaProducto.findAll({ where: { id_producto: producto.id } });

      if (preguntas.length > 0) {
        // Si el producto tiene preguntas asociadas, agregarlas como propiedad al objeto de producto
        return { producto: producto.toJSON(), preguntas };
      } else {
        // Si el producto no tiene preguntas asociadas, devolver null
        return null;
      }
    }));

    // Filtrar los productos nulos (que no tienen preguntas asociadas)
    const productosConPreguntasFiltrados = productosConPreguntas.filter(producto => producto !== null);

    res.status(200).json(productosConPreguntasFiltrados);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};