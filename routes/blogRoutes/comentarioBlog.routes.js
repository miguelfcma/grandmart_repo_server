// Importar Express y el controlador de comentarios del blog
import { Router } from "express";
import {
  createComentario,
  getComentariosPorIdPublicacion,
  deleteComentarioPorIdUsuario,
  updateComentarioPorIdUsuario
} from "../../controllers/blogControllers/comentariosBlog.controller.js";

// Crear una instancia de Router
const router = Router();

// Definir las rutas para las diferentes funciones del controlador de comentarios
router.post("/blog-comentarios", createComentario);
router.get("/blog-comentarios/:id_publicacionBlog", getComentariosPorIdPublicacion);
router.delete("/blog-comentarios/:idUsuario", deleteComentarioPorIdUsuario);
router.put("/blog-comentarios/:idUsuario", updateComentarioPorIdUsuario);

// Exportar el router para que pueda ser utilizado por la aplicación principal
export default router;
