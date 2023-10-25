import { Router } from "express";
import {
  obtenerFavoritos,
  agregarProductoAFavoritos,
  eliminarProductoFavorito,
} from "../../controllers/productosControllers/favoritosProductos.controller.js";

const router = Router();

// Ruta para obtener los productos favoritos por ID de usuario
router.get('/favoritos/:id_usuario', obtenerFavoritos);

// Ruta para agregar un producto a la lista de favoritos por ID de usuario
router.post('/favoritos/:id_usuario', agregarProductoAFavoritos);

// Ruta para eliminar un producto de la lista de favoritos por ID de usuario
router.post('/favoritos-eliminar/:id_usuario', eliminarProductoFavorito);

export default router;
