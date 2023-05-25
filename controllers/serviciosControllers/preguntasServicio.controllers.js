import { PreguntaServicio } from '../../models/serviciosModel/PreguntasServiciosModel.js';
import { Servicio } from "../../models/serviciosModel/ServicioModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
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

    if (preguntas.length === 0) {
      return res.status(404).json({ message: "No se encontraron preguntas" });
    }
    const preguntasConUsuarioYServicio = await Promise.all(preguntas.map(async pregunta => {
      const servicio = await Servicio.findByPk(pregunta.id_servicio, { attributes: ['id', 'titulo'] });
      const usuario = await Usuario.findByPk(pregunta.id_usuario, { attributes: ['id', 'nombre'] });
      return { ...pregunta.toJSON(), servicio, usuario };
    }));    

    res.status(200).json(preguntasConUsuarioYServicio);
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


// Obtener servicios del usuario con preguntas asociadas
export const getServiciosConPreguntasByUsuarioId = async (req, res) => {
  try {
    const { id_usuario } = req.params;

    // Buscar servicios del usuario por su ID de usuario
    const servicios = await Servicio.findAll({ where: { id_usuario } });

    if (servicios.length === 0) {
      return res.status(404).json({ message: "No se encontraron servicios para el usuario especificado" });
    }

    const serviciosConPreguntas = await Promise.all(servicios.map(async servicio => {
      // Buscar preguntas asociadas al servicio
      const preguntas = await PreguntaServicio.findAll({ where: { id_servicio: servicio.id } });

      if (preguntas.length > 0) {
        // Si el servicio tiene preguntas asociadas, agregarlas como propiedad al objeto de servicio
        return { servicio: servicio.toJSON(), preguntas };
      } else {
        // Si el servicio no tiene preguntas asociadas, devolver null
        return null;
      }
    }));

    // Filtrar los servicios nulos (que no tienen preguntas asociadas)
    const serviciosConPreguntasFiltrados = serviciosConPreguntas.filter(servicio => servicio !== null);

    res.status(200).json(serviciosConPreguntasFiltrados);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};


export const getTodosServiciosConPreguntas = async (req, res) => {
  try {
    // Buscar servicios del usuario por su ID de usuario
    const servicios = await Servicio.findAll();

    if (servicios.length === 0) {
      return res.status(404).json({ message: "No se encontraron servicios " });
    }

    const serviciosConPreguntas = await Promise.all(
      servicios.map(async (servicio) => {
        // Buscar preguntas asociadas al servicio
        const preguntas = await PreguntaServicio.findAll({
          where: { id_servicio: servicio.id },
        });

        if (preguntas.length > 0) {
          // Si el servicio tiene preguntas asociadas, agregarlas como propiedad al objeto de servicio
          return { servicio: servicio.toJSON(), preguntas };
        } else {
          // Si el servicio no tiene preguntas asociadas, devolver null
          return null;
        }
      })
    );

    // Filtrar los servicios nulos (que no tienen preguntas asociadas)
    const serviciosConPreguntasFiltrados = serviciosConPreguntas.filter(
      (servicio) => servicio !== null
    );

    res.status(200).json(serviciosConPreguntasFiltrados);
  } catch (error) {
    console.error(error);
    res.status(500).send("Error interno del servidor");
  }
};