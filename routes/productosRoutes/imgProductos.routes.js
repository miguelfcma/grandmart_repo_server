import { Router } from "express";

import {
  createImgProducto,
  getImgProducto
} from "../../controllers/productosControllers/imagenesProducto.controller.js";

const router = Router();

//router.get("/productos", getProductos);

router.get("/product-images/:id", getImgProducto);

router.post("/product-images", createImgProducto);

//router.put("/productos/:id", updateProducto);

//router.delete("/productos/:id", deleteProducto);



export default router;