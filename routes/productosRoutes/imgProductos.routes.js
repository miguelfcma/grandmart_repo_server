import { Router } from "express";

import {
  createImgProducto,
  getAllImagenesByProductId,
  getPortadaByProductId,
  getGaleriaImagenesByProductId,
} from "../../controllers/productosControllers/imagenesProducto.controller.js";

const router = Router();

// Ruta para crear una nueva imagen de producto
router.post("/product-images", createImgProducto);

// Ruta para obtener la imagen de portada de un producto por su ID
router.get("/product-images/portada/:id_producto", getPortadaByProductId);

// Ruta para obtener todas las imágenes de una galería de un producto por su ID de producto
router.get("/product-images/galeria/:id_producto", getGaleriaImagenesByProductId);

// Ruta para obtener todas las imágenes de un producto por su ID de producto
router.get("/product-images/todas/:id_producto", getAllImagenesByProductId);

export default router;
