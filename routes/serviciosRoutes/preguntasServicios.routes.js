import { Router } from "express";
import {
  crearPregunta,
  crearRespuesta,
  getPreguntasByIdServicio,
  getServiciosConPreguntasByUsuarioId,
  eliminarPregunta,
  actualizarPregunta,
  getTodosServiciosConPreguntas,
} from "../../controllers/serviciosControllers/preguntasServicio.controllers.js";

const router = Router();
// Ruta para crear una nueva pregunta para un servicio
router.post("/servicio-preguntas", crearPregunta);

// Ruta para crear una nueva respuesta para una pregunta de un servicio
router.post("/servicio-preguntas/:id/respuesta", crearRespuesta);

// Ruta para obtener todas las preguntas asociadas a un servicio
router.get(
  "/servicio-preguntas/servicio/:id_servicio",
  getPreguntasByIdServicio
);

router.get(
  "/servicio-preguntas/servicios-preguntas/:id_usuario",
  getServiciosConPreguntasByUsuarioId
);

// Ruta para eliminar una pregunta de un servicio por su ID
router.delete("/servicio-preguntas/:id", eliminarPregunta);

// Ruta para actualizar una pregunta de un servicio por su ID
router.put("/servicio-preguntas/:id", actualizarPregunta);

router.get("/servicio-preguntas-all/", getTodosServiciosConPreguntas);

export default router;
