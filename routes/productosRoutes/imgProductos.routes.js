import { Router } from "express";

import {
  createImgProducto,
  getImgProducto,
  getPortada,
  getImagenesProduct,
  deleteImgProducto,
  updateImgProducto,
  getAllImagenesProduct
} from "../../controllers/productosControllers/imagenesProducto.controller.js";

const router = Router();

// Ruta para crear una nueva imagen de producto
router.post("/product-images", createImgProducto);

// Ruta para obtener la imagen de un producto por su ID
router.get("/product-images/:id", getImgProducto);

// Ruta para obtener la imagen de portada de un producto por su ID
router.get("/product-images/portada/:id_producto", getPortada);

// Ruta para obtener todas las imágenes de un producto por su ID deprudcto
router.get("/product-images/producto/:id_producto", getImagenesProduct);

// Ruta para eliminar una imagen de producto por su ID
router.delete("/product-images/:id", deleteImgProducto);

router.put("/product-images/:id", updateImgProducto);
//
router.get("/product-images-all/producto/:id_producto", getAllImagenesProduct);

export default router;
