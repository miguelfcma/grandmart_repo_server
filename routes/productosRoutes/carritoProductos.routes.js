import { Router } from "express";

import {
    agregarProductoAlCarrito, actualizarCantidadProductoEnCarrito, obtenerCarritoDeCompras, eliminarProductoDelCarrito,vaciarCarrito
} from "../../controllers/productosControllers/carrito.controller.js";

const router = Router();

// Rutas para agregar productos al carrito
router.post('/carrito',  agregarProductoAlCarrito);

// Rutas para actualizar la cantidad de productos en el carrito
router.put('/carrito/:id_producto',  actualizarCantidadProductoEnCarrito);

// Rutas para obtener el carrito de compras
router.get('/carrito/:id_usuario',  obtenerCarritoDeCompras);

// Rutas para eliminar productos del carrito
router.post('/carrito/eliminar-producto/:id_producto',  eliminarProductoDelCarrito);
// Ruta para vaciar el carrito
router.delete("/carrito/vaciar/:id_usuario", vaciarCarrito);

export default router;
