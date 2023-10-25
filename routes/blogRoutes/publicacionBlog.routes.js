// Importar Express y el controlador de publicaciones del blog
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

// Ruta para crear una nueva publicación de blog
router.post("/blog-publicaciones", createPublicacion);

// Ruta para eliminar una publicación por el ID de usuario
router.post(
  "/blog-publicaciones/elminar/:id_usuario",
  deletePublicacionPorIdUsuario
);

// Ruta para actualizar una publicación por el ID de usuario
router.put("/blog-publicaciones/:idUsuario", updatePublicacionPorIdUsuario);

// Ruta para obtener todas las publicaciones
router.get("/blog-publicaciones", getPublicaciones);

// Ruta para obtener las publicaciones por el ID de usuario
router.get("/blog-publicaciones/:idUsuario", getPublicacionesPorIdUsuario);

// Exportar el router para que pueda ser utilizado por la aplicación principal
export default router;
