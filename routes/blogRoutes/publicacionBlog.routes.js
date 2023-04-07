// Importar Express y el controlador de comentarios del blog
import { Router } from "express";
import {
  createPublicacion,
  deletePublicacionPorIdUsuario,
  updatePublicacionPorIdUsuario,
  getPublicaciones,
  getPublicacionesPorIdUsuario,
} from "../../controllers/blogControllers/publicacionesBlog.controller.js";
// Crear una instancia de Router
const router = Router();

// Definir las rutas para las diferentes funciones del controlador de publicaciones
router.post("/blog-publicaciones", createPublicacion);
router.delete("/blog-publicaciones/:idUsuario", deletePublicacionPorIdUsuario);
router.put("/blog-publicaciones/:idUsuario", updatePublicacionPorIdUsuario);
router.get("/blog-publicaciones", getPublicaciones);
router.get("/blog-publicaciones/:idUsuario", getPublicacionesPorIdUsuario);

// Exportar el router para que pueda ser utilizado por la aplicación principal
export default router;
