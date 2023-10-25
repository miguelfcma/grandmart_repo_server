// Importar Express y el controlador de comentarios del blog
import { Router } from "express";
import {
  createComentario,
  getComentariosPorIdPublicacion,
  deleteComentarioPorIdUsuario,
  updateComentarioPorIdUsuario,
} from "../../controllers/blogControllers/comentariosBlog.controller.js";

// Crear una instancia de Router
const router = Router();

// Definir las rutas para las diferentes funciones del controlador de comentarios

// Ruta para crear un nuevo comentario en el blog
router.post("/blog-comentarios", createComentario);

// Ruta para obtener comentarios por el ID de la publicación del blog
router.get("/blog-comentarios/:id_publicacionBlog", getComentariosPorIdPublicacion);

// Ruta para eliminar un comentario por el ID del usuario y el ID del comentario
router.delete("/blog-comentarios/:id_usuario/:id", deleteComentarioPorIdUsuario);

// Ruta para actualizar un comentario por el ID del usuario
router.put("/blog-comentarios/:idUsuario", updateComentarioPorIdUsuario);

// Exportar el router para que pueda ser utilizado por la aplicación principal
export default router;
