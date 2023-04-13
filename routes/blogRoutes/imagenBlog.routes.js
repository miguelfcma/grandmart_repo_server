// Importar Express y el controlador de imágenes del blog
import { Router } from "express";
import {
  createImagen,
  updateImagenPorIdPublicacion,
  deleteImagenPorIdPublicacion,
  getImagenesPorIdPublicacion,
  getImagenPortadaPorIdPublicacion,
  createImagenes,
} from "../../controllers/blogControllers/imagenesBlog.controller.js";

// Crear una instancia de Router
const router = Router();
// Definir las rutas para las diferentes funciones del controlador de imágenes
router.post("/blog-imagenes", createImagen);
router.put("/blog-imagenes/:id_publicacionBlog", updateImagenPorIdPublicacion);
router.delete("/blog-imagenes/:id_publicacionBlog", deleteImagenPorIdPublicacion);
router.get("/blog-imagenes/:id_publicacionBlog", getImagenesPorIdPublicacion);

// Nueva ruta para el registro de múltiples imágenes
router.post("/blog-imagenes/multiple", createImagenes);

// Nueva ruta para obtener la imagen de portada
router.get(
  "/blog-imagenes/portada/:id_publicacionBlog",
  getImagenPortadaPorIdPublicacion
);

// Exportar el router para que pueda ser utilizado
// Exportar el router para que pueda ser utilizado por la aplicación principal
export default router;
