import { Router } from "express";

import {
  getProducto,
  getProductos,
  createProducto,
  updateProducto,
  deleteProducto,
  getProductosByUser
} from "../../controllers/productosControllers/productos.controller.js";

const router = Router();

router.get("/productos", getProductos);

router.get("/productos/:id", getProducto);

router.post("/productos", createProducto);

router.put("/productos/:id", updateProducto);

router.delete("/productos/:id", deleteProducto);

router.get('/productos/user/:id_usuario', getProductosByUser); 


export default router;
