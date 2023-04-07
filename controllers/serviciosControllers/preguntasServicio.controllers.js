import { PreguntaServicio } from '../../models/serviciosModel/PreguntasServiciosModel.js';

// Crear una nueva pregunta
export const crearPregunta = async (req, res) => {
  try {
    const { pregunta, id_servicio, id_usuario } = req.body;
    const nuevaPregunta = await PreguntaServicio.create({
      pregunta,
      id_servicio,
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
    const pregunta = await PreguntaServicio.findOne({ where: { id } });
    pregunta.respuesta = respuesta;
    await pregunta.save();
    res.status(200).json(pregunta);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};

// Obtener todas las preguntas asociadas a un servicio
export const getPreguntasByIdServicio = async (req, res) => {
  try {
    const { id_servicio } = req.params;
    const preguntas = await PreguntaServicio.findAll({ where: { id_servicio } });
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
    const pregunta = await PreguntaServicio.findOne({ where: { id } });
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
    const { pregunta, id_servicio, id_usuario } = req.body;
    const preguntaActualizada = await PreguntaServicio.update(
      { pregunta, id_servicio, id_usuario },
      { where: { id } }
    );
    res.status(200).json(preguntaActualizada);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};
