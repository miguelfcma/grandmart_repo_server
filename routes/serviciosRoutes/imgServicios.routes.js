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

// Rutas para las imágenes de servicio
router.post("/servicio-images/", createImgServicio);
router.post("/servicio-imagenes/multiple", createImagenes);
router.get("/servicio-images/todas/:id_servicio", getAllImagenesPorIdServicio);
router.get("/servicio-imagenes/portada/:id_servicio", getPortada);
router.put("/servicio-imagenes/:id", updateImgServicio);
router.delete("/servicio-imagenes/:id", deleteImgServicio);


export default router;