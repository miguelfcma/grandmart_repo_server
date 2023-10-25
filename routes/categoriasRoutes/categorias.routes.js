import { Router } from "express";
import {
  getCategoria,
  getCategorias,
  deleteCategoria,
  updateCategoria,
  createCategoria,
} from "../../controllers/categoriasControllers/categorias.controllers.js";

const router = Router();

// Ruta para obtener todas las categorías
router.get("/categorias", getCategorias);

// Ruta para obtener una categoría por su ID
router.get("/categorias/:id", getCategoria);

// Ruta para crear una nueva categoría
router.post("/categorias", createCategoria);

// Ruta para actualizar una categoría por su ID
router.put("/categorias/:id", updateCategoria);

// Ruta para eliminar una categoría por su ID
router.delete("/categorias/:id", deleteCategoria);

export default router;
