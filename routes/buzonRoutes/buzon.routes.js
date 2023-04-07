import { Router } from "express";
import {
  getAllMensajes,
  getMensajeById,
  createMensaje,
  updateMensaje,
  deleteMensaje,
  getMensajesByUserId
} from "../../controllers/buzonControllers/buzon.controllers.js";

const router = Router();

// Ruta para obtener todos los mensajes
router.get("/buzon-mensajes", getAllMensajes);

// Ruta para obtener un mensaje por su ID
router.get("/buzon-mensajes/:id", getMensajeById);

// Ruta para crear un nuevo mensaje
router.post("/buzon-mensajes", createMensaje);

// Ruta para actualizar un mensaje por su ID
router.put("/buzon-mensajes/:id", updateMensaje);

// Ruta para eliminar un mensaje por su ID
router.delete("/buzon-mensajes/:id", deleteMensaje);

// Ruta para obtener todos los mensajes por el ID del usuario
router.get("/buzon-mensajes/usuario/:id", getMensajesByUserId);

export default router;
