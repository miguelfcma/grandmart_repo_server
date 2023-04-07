import { PreguntaProducto } from "../../models/productosModel/PreguntasProductoModel.js";

// Crear una nueva pregunta
export const crearPregunta = async (req, res) => {
  try {
    const { pregunta, id_producto, id_usuario } = req.body;
    const nuevaPregunta = await ProductoPregunta.create({
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
    const pregunta = await ProductoPregunta.findOne({ where: { id } });
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
    const preguntas = await ProductoPregunta.findAll({ where: { id_producto } });
    res.status(200).json(preguntas);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};

// Eliminar una pregunta por su ID
export const eliminarPregunta = async (req, res) => {
  try {
    const { id } = req.params;
    const pregunta = await ProductoPregunta.findOne({ where: { id } });
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
    const preguntaActualizada = await ProductoPregunta.update(
      { pregunta, id_producto, id_usuario },
      { where: { id } }
    );
    res.status(200).json(preguntaActualizada);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};
