import { Router } from "express";
import {
  crearPregunta,
  crearRespuesta,
  getPreguntasByIdProducto,
  getProductosConPreguntasByUsuarioId,
  eliminarPregunta,
  actualizarPregunta,
  getTodosProductosConPreguntas,
} from "../../controllers/productosControllers/preguntasProducto.controller.js";

const router = Router();

// Ruta para crear una nueva pregunta
router.post("/producto-preguntas", crearPregunta);

// Ruta para crear una nueva respuesta para una pregunta
router.post("/producto-preguntas/:id/respuesta", crearRespuesta);

// Ruta para obtener todas las preguntas asociadas a un producto
router.get(
  "/producto-preguntas/producto/:id_producto",
  getPreguntasByIdProducto
);

// Ruta para obtener todos los productos con preguntas por parte de un usuario
router.get(
  "/producto-preguntas/productos-preguntas/:id_usuario",
  getProductosConPreguntasByUsuarioId
);

// Ruta para eliminar una pregunta por su ID
router.delete("/producto-preguntas/:id", eliminarPregunta);

// Ruta para actualizar una pregunta por su ID
router.put("/producto-preguntas/:id", actualizarPregunta);

// Ruta para obtener todas las preguntas de todos los productos
router.get("/producto-preguntas-all/", getTodosProductosConPreguntas);

export default router;
