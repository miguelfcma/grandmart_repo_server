// Importar Express y el controlador de imágenes del blog
import { Router } from "express";
import {
  createImagen,
  updateImagenPorIdPublicacion,
  deleteImagenPorIdPublicacion,
  getImagenesPorIdPublicacion,
} from "../../controllers/blogControllers/imagenesBlog.controller.js";

// Crear una instancia de Router
const router = Router();

// Definir las rutas para las diferentes funciones del controlador de imágenes
router.post("/blog-imagenes", createImagen);
router.put("/blog-imagenes/:idPublicacion", updateImagenPorIdPublicacion);
router.delete("/blog-imagenes/:idPublicacion", deleteImagenPorIdPublicacion);
router.get("/blog-imagenes/:idPublicacion", getImagenesPorIdPublicacion);

// Exportar el router para que pueda ser utilizado por la aplicación principal
export default router;
