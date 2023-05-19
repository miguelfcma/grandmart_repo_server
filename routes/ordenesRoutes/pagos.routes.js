import { Router } from "express";
import {
  obtenerTodosLosPagos,
  obtenerPagoPorIdOrden,
  obtenerPagosPorIdUsuario,
} from "../../controllers/ordenesControllers/ordenes.controllers.js";

const router = Router();

router.get("/pagos/todos", obtenerTodosLosPagos);
router.get("/pagos/orden/:id_orden", obtenerPagoPorIdOrden);
router.get("/pagos/usuario/:id_usuario", obtenerPagosPorIdUsuario);

export default router;
