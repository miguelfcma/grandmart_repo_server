import { Router } from "express";
import {
  crearOrden,
  obtenerOrdenesUsuario,
  actualizarEstadoOrden,
  obtenerDetalleOrden,
  obtenerTodasLasOrdenes
} from "../../controllers/ordenesControllers/ordenes.controllers.js";

const router = Router();

// Rutas para agregar productos al carrito
router.post("/ordenes", crearOrden);
router.get("/ordenes-all/", obtenerTodasLasOrdenes);
router.get("/ordenes/:id_usuario", obtenerOrdenesUsuario);
router.put("/ordenes/:id_orden", actualizarEstadoOrden);
router.get("/ordenes/detalles/:id_orden", obtenerDetalleOrden);

export default router;
