import { Router } from "express";
import {
  getCategoria,
  getCategorias,
  deleteCategoria,
  updateCategoria,
  createCategoria,
} from "../../controllers/categoriasControllers/categorias.controllers.js";
const router = Router();

router.get("/categorias", getCategorias);

router.get("/categorias/:id", getCategoria);

router.post("/categorias", createCategoria);

router.put("/categorias/:id", updateCategoria);

router.delete("/categorias/:id", deleteCategoria);

export default router;
