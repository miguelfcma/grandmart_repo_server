import { Router } from "express";

import {
  createImgProducto,
  getImgProducto,
  getPortada,
  getImagenes,
  deleteImgProducto,
  updateImgProducto,
} from "../../controllers/productosControllers/imagenesProducto.controller.js";

const router = Router();

// Ruta para crear una nueva imagen de producto
router.post("/product-images", createImgProducto);

// Ruta para obtener la imagen de un producto por su ID
router.get("/product-images/:id", getImgProducto);

// Ruta para obtener la imagen de portada de un producto por su ID
router.get("/product-images/portada/:id", getPortada);

// Ruta para obtener todas las imágenes de un producto por su ID
router.get("/product-images/producto/:id", getImagenes);

// Ruta para eliminar una imagen de producto por su ID
router.delete("/product-images/:id", deleteImgProducto);

// Ruta para actualizar una imagen de producto por su ID
router.put("/product-images/:id", updateImgProducto);

export default router;
