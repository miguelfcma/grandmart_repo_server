import { Router } from "express";

import {
  createImgProducto,
  createImagenes,
  getAllImagenesByProductId,
  getPortadaByProductId,
  getGaleriaImagenesByProductId,
} from "../../controllers/productosControllers/imagenesProducto.controller.js";

const router = Router();

// Ruta para crear una nueva imagen de producto
router.post("/product-images", createImgProducto);

router.post("/producto-imagenes/multiple", createImagenes);

// Ruta para obtener todas las imágenes de un producto por su ID de producto
router.get("/product-images/todas/:id_producto", getAllImagenesByProductId);

// Ruta para obtener la imagen de portada de un producto por su ID
router.get("/product-images/portada/:id_producto", getPortadaByProductId);

// Ruta para obtener todas las imágenes de una galería de un producto por su ID de producto
router.get("/product-images/galeria/:id_producto", getGaleriaImagenesByProductId);



export default router;
