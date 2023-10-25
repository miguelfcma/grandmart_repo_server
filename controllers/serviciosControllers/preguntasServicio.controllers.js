import { PreguntaServicio } from "../../models/serviciosModel/PreguntasServiciosModel.js";
import { Servicio } from "../../models/serviciosModel/ServicioModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import { enviarCorreo } from "../CorreoController/enviarCorreo.controllers.js";

// Función para crear una nueva pregunta
export const crearPregunta = async (req, res) => {
  try {
    const { pregunta, id_servicio, id_usuario } = req.body;
    // Crear una nueva pregunta
    const nuevaPregunta = await PreguntaServicio.create({
      pregunta,
      id_servicio,
      id_usuario,
    });

    if (pregunta) {
      const servicio = await Servicio.findByPk(id_servicio);
      if (!servicio) {
        return res.status(404).json({ message: "Servicio no encontrado" });
      }

      const usuarioVendedor = await Usuario.findByPk(servicio.id_usuario, {
        attributes: ["email"],
      });

      if (!usuarioVendedor) {
        return res
          .status(404)
          .json({ message: "Usuario vendedor no encontrado" });
      }

      const usuarioPregunta = await Usuario.findByPk(servicio.id_usuario, {
        attributes: ["id", "nombre", "apellidoPaterno", "apellidoMaterno"],
      });

      // Construir el contenido del correo en formato HTML
      const email = usuarioVendedor.email;
      const subject = "GrandMart Marketplace";
      const header = "Notificación de nueva pregunta";
      const contenido = `
        <h2>Tienes una nueva pregunta</h2>
        <p>
          Usuario: <strong>${usuarioPregunta.id} ${usuarioPregunta.nombre} ${usuarioPregunta.apellidoPaterno} ${usuarioPregunta.apellidoMaterno}</strong>
        </p>
        <p>
          Servicio: <strong>${servicio.id} ${servicio.titulo}</strong>
        </p>
        <hr />
        <p>Pregunta: <strong>${pregunta}</strong></p>
      `;

      // Enviar un correo al vendedor del servicio
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
    const pregunta = await PreguntaServicio.findOne({ where: { id } });

    if (!pregunta) {
      return res.status(404).json({ message: "Pregunta no encontrada" });
    }

    // Establecer la respuesta y guardarla
    pregunta.respuesta = respuesta;
    await pregunta.save();

    // Obtener información del usuario que hizo la pregunta
    const usuarioPregunta = await Usuario.findByPk(pregunta.id_usuario, {
      attributes: ["id", "nombre", "email"],
    });
    // Obtener información del servicio al que se refiere la pregunta
    const servicio = await Servicio.findByPk(pregunta.id_servicio, {
      attributes: ["id", "titulo"],
    });

    // Construir el contenido del correo en formato HTML
    const email = usuarioPregunta.email;
    const subject = "Respuesta a tu pregunta de servicio";
    const header = "Respuesta recibida";
    const contenido = `
      <h2>Tu pregunta de servicio ha sido respondida</h2>
      <p>Pregunta: ${pregunta.pregunta}</p>
      <p>Respuesta: ${pregunta.respuesta}</p>
      <p>Servicio: ${servicio.id} ${servicio.titulo}</p>
    `;

    // Enviar un correo al usuario que hizo la pregunta
    await enviarCorreo(email, subject, header, contenido);

    res.status(200).json(pregunta);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para obtener todas las preguntas asociadas a un servicio
export const getPreguntasByIdServicio = async (req, res) => {
  try {
    const { id_servicio } = req.params;
    // Obtener todas las preguntas asociadas a un servicio por su ID de servicio
    const preguntas = await PreguntaServicio.findAll({
      where: { id_servicio },
    });

    if (preguntas.length === 0) {
      return res.status(404).json({ message: "No se encontraron preguntas" });
    }

    // Obtener información del usuario que hizo la pregunta y del servicio asociado a cada pregunta
    const preguntasConUsuarioYServicio = await Promise.all(
      preguntas.map(async (pregunta) => {
        const servicio = await Servicio.findByPk(pregunta.id_servicio, {
          attributes: ["id", "titulo"],
        });
        const usuario = await Usuario.findByPk(pregunta.id_usuario, {
          attributes: ["id", "nombre"],
        });
        return { ...pregunta.toJSON(), servicio, usuario };
      })
    );
    res.status(200).json(preguntasConUsuarioYServicio);
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
    // Buscar y eliminar la pregunta por su ID
    const pregunta = await PreguntaServicio.findOne({ where: { id } });
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
    const { pregunta, id_servicio, id_usuario } = req.body;
    // Actualizar una pregunta por su ID
    const preguntaActualizada = await PreguntaServicio.update(
      { pregunta, id_servicio, id_usuario },
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

// Función para obtener servicios del usuario con preguntas asociadas
export const getServiciosConPreguntasByUsuarioId = async (req, res) => {
  try {
    const { id_usuario } = req.params;
    // Buscar servicios del usuario por su ID de usuario
    const servicios = await Servicio.findAll({ where: { id_usuario } });

    if (servicios.length === 0) {
      return res.status(404).json({
        message: "No se encontraron servicios para el usuario especificado",
      });
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
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para obtener todos los servicios con preguntas asociadas
export const getTodosServiciosConPreguntas = async (req, res) => {
  try {
    // Buscar todos los servicios
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
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};
