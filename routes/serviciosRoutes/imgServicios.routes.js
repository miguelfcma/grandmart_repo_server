import { Router } from "express";

import {
  createImgServicio,
  getImgServicio,
  getPortada,
  getImagenesServicio,
  deleteImgServicio,
  updateImgServicio,
  getAllImagenesServicio
} from "../../controllers/serviciosControllers/imagenesServicios.controllers.js";

const router = Router();

// Ruta para crear una nueva imagen de servicio
router.post("/service-images", createImgServicio);

// Ruta para obtener la imagen de un servicio por su ID
router.get("/service-images/:id", getImgServicio);

// Ruta para obtener la imagen de portada de un servicio por su ID
router.get("/service-images/portada/:id_servicio", getPortada);

// Ruta para obtener todas las imágenes de un servicio por su ID de servicio
router.get("/service-images/servicio/:id_servicio", getImagenesServicio);

// Ruta para eliminar una imagen de servicio por su ID
router.delete("/service-images/:id", deleteImgServicio);

// Ruta para actualizar una imagen de servicio por su ID
router.put("/service-images/:id", updateImgServicio);

// Ruta para obtener todas las imágenes de un servicio por su ID de servicio
router.get("/service-images-all/servicio/:id_servicio", getAllImagenesServicio);

export default router;
