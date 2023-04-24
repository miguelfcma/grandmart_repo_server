import { Router } from "express";

import {
  obtenerFavoritos,
  agregarProductoAFavoritos,
  eliminarProductoFavorito,
} from "../../controllers/productosControllers/favoritosProductos.controller.js";

const router = Router();

router.get('/favoritos/:id_usuario', obtenerFavoritos);
router.post('/favoritos/:id_usuario', agregarProductoAFavoritos);
router.post('/favoritos-eliminar/:id_usuario', eliminarProductoFavorito);


export default router;
