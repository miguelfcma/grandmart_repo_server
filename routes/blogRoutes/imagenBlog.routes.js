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

// Ruta para crear una nueva imagen relacionada con una publicación de blog
router.post("/blog-imagenes", createImagen);

// Ruta para actualizar una imagen por el ID de la publicación del blog
router.put("/blog-imagenes/:id_publicacionBlog", updateImagenPorIdPublicacion);

// Ruta para eliminar una imagen por el ID de la publicación del blog
router.delete(
  "/blog-imagenes/:id_publicacionBlog",
  deleteImagenPorIdPublicacion
);

// Ruta para obtener imágenes por el ID de la publicación del blog
router.get("/blog-imagenes/:id_publicacionBlog", getImagenesPorIdPublicacion);

// Nueva ruta para registrar múltiples imágenes relacionadas con una publicación
router.post("/blog-imagenes/multiple", createImagenes);

// Nueva ruta para obtener la imagen de portada por el ID de la publicación del blog
router.get(
  "/blog-imagenes/portada/:id_publicacionBlog",
  getImagenPortadaPorIdPublicacion
);

// Exportar el router para que pueda ser utilizado por la aplicación principal
export default router;
