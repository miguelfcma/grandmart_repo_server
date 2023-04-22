import { Router } from "express";
import {
  crearPregunta,
  crearRespuesta,
  getPreguntasByIdProducto,
  eliminarPregunta,
  actualizarPregunta,
  getProductosConPreguntasByUsuarioId
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

router.get(
    "/producto-preguntas/productos-preguntas/:id_usuario",
    getProductosConPreguntasByUsuarioId
  );
// Ruta para eliminar una pregunta por su ID
router.delete("/producto-preguntas/:id", eliminarPregunta);

// Ruta para actualizar una pregunta por su ID
router.put("/producto-preguntas/:id", actualizarPregunta);
export default router;
