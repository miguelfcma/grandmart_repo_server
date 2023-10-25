import { Router } from "express";

import {
  getProductoById,
  getProductos,
  createProducto,
  updateProducto,
  deleteProducto,
  getProductosByUser
} from "../../controllers/productosControllers/productos.controller.js";

const router = Router();

// Ruta para obtener todos los productos
router.get("/productos", getProductos);

// Ruta para obtener un producto por su ID
router.get("/productos/:id_producto", getProductoById);

// Ruta para crear un nuevo producto
router.post("/productos", createProducto);

// Ruta para actualizar un producto por su ID
router.put("/productos/:id", updateProducto);

// Ruta para eliminar un producto por su ID
router.delete("/productos/:id", deleteProducto);

// Ruta para obtener todos los productos de un usuario
router.get('/productos/user/:id_usuario', getProductosByUser); 

export default router;
