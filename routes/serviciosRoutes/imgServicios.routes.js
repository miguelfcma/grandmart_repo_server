import { Router } from "express";
import {
  createImgServicio,
  createImagenes,
  deleteImgServicio,
  getAllImagenesPorIdServicio,
  getPortada,
  updateImgServicio,
} from "../../controllers/serviciosControllers/imagenesServicios.controllers.js";

const router = Router();

// Ruta para crear una nueva imagen de servicio
router.post("/servicio-images/", createImgServicio);

// Ruta para agregar múltiples imágenes a un servicio
router.post("/servicio-imagenes/multiple", createImagenes);

// Ruta para obtener todas las imágenes de un servicio por su ID de servicio
router.get("/servicio-images/todas/:id_servicio", getAllImagenesPorIdServicio);

// Ruta para obtener la imagen de portada de un servicio por su ID
router.get("/servicio-imagenes/portada/:id_servicio", getPortada);

// Ruta para actualizar una imagen de servicio por su ID
router.put("/servicio-imagenes/:id", updateImgServicio);

// Ruta para eliminar una imagen de servicio por su ID
router.delete("/servicio-imagenes/:id", deleteImgServicio);

export default router;
