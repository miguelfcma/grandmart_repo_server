import { Router } from "express";

import {
  createImgServicio,
  createImagenes,
  deleteImgServicio,
  getImagenesPorIdServicio,
  getPortada,
  updateImgServicio,
} from "../../controllers/serviciosControllers/imagenesServicios.controllers.js";

const router = Router();

// Rutas para las imágenes de servicio
router.post("/servicio-imagenes/", createImgServicio);
router.post("/servicio-imagenes/multiple", createImagenes);
router.get("/servicio-imagenes/:id_servicio", getImagenesPorIdServicio);
router.get("/servicio-imagenes/portada/:id_servicio", getPortada);
router.put("/servicio-imagenes/:id", updateImgServicio);
router.delete("/servicio-imagenes/:id", deleteImgServicio);


export default router;