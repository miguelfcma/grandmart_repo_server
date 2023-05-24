import { Router } from "express";
import {

  obtenerComprasUsuario,
  cancelarOrden
} from "../../controllers/ordenesControllers/ordenes.controllers.js";

const router = Router();


router.get("/compras/:id_usuario", obtenerComprasUsuario);
router.post("/compras/cancelar/:id_orden", cancelarOrden);




export default router;
