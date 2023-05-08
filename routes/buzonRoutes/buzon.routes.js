import { Router } from "express";
import {
  getAllDenuncias,
  getDenunciaById,
  createDenuncia,
  deleteDenuncia,
  getDenunciasByUserId
} from "../../controllers/buzonDenunciasControllers/buzonDenuncias.controller.js";

const router = Router();

// Ruta para obtener todos los mensajes
router.get("/buzon-denuncias", getAllDenuncias);

// Ruta para obtener un mensaje por su ID
router.get("/buzon-denuncias/:id", getDenunciaById);

// Ruta para crear un nuevo mensaje
router.post("/buzon-denuncias", createDenuncia);

// Ruta para eliminar un mensaje por su ID
router.delete("/buzon-denuncias/:id", deleteDenuncia);

// Ruta para obtener todos los mensajes por el ID del usuario
router.get("/buzon-denuncias/usuario/:id", getDenunciasByUserId);

export default router;
