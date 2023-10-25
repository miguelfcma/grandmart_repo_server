import { Router } from "express";
import {
  obtenerComprasUsuario,
  cancelarOrden,
} from "../../controllers/ordenesControllers/ordenes.controllers.js";

const router = Router();

// Ruta para obtener las compras de un usuario por su ID
router.get("/compras/:id_usuario", obtenerComprasUsuario);

// Ruta para cancelar una orden de compra por su ID
router.post("/compras/cancelar/:id_orden", cancelarOrden);

export default router;
