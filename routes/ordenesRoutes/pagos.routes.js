import { Router } from "express";
import {
  obtenerTodosLosPagos,
  obtenerPagoPorIdOrden,
  obtenerPagosPorIdUsuario,
} from "../../controllers/ordenesControllers/ordenes.controllers.js";

const router = Router();

// Ruta para obtener todos los pagos
router.get("/pagos/todos", obtenerTodosLosPagos);

// Ruta para obtener un pago por ID de orden
router.get("/pagos/orden/:id_orden", obtenerPagoPorIdOrden);

// Ruta para obtener pagos por ID de usuario
router.get("/pagos/usuario/:id_usuario", obtenerPagosPorIdUsuario);


export default router;
