import { Router } from "express";
import {
  crearOrden,
  obtenerDetalleOrden,
  obtenerTodasLasOrdenes,
  eliminarOrden,
  cambiarEstadoOrden,
  obtenerInfoPago,
} from "../../controllers/ordenesControllers/ordenes.controllers.js";

const router = Router();
// Ruta para crear una nueva orden
router.post("/ordenes", crearOrden);

// Ruta para obtener todas las órdenes
router.get("/ordenes-all/", obtenerTodasLasOrdenes);

// Ruta para cambiar el estado de una orden
router.put("/ordenes/estado/:id_orden", cambiarEstadoOrden);

// Ruta para obtener los detalles de una orden específica
router.get("/ordenes/detalles/:id_orden", obtenerDetalleOrden);

// Ruta para eliminar una orden
router.delete("/ordenes/eliminar/:id_orden", eliminarOrden);

// Ruta para obtener información de pago de una orden
router.get("/ordenes/infopago/:id_orden", obtenerInfoPago);

export default router;
