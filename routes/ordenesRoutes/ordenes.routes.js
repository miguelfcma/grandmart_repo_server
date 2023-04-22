import { Router } from "express";
import {
  crearOrden,
  obtenerOrdenesUsuario,
  actualizarEstadoOrden,
  obtenerDetalleOrden,
  obtenerTodasLasOrdenes,
  obtenerDireccionEnvioOrden,
  obtenerPedidosPorUsuario
} from "../../controllers/ordenesControllers/ordenes.controllers.js";

const router = Router();

// Rutas para agregar productos al carrito
router.post("/ordenes", crearOrden);
router.get("/ordenes-all/", obtenerTodasLasOrdenes);
router.get("/ordenes/usuario/:id_usuario", obtenerOrdenesUsuario);
router.put("/ordenes/:id_orden", actualizarEstadoOrden);
router.get("/ordenes/detalles/:id_orden", obtenerDetalleOrden);
router.get("/ordenes/direccion/:id_orden", obtenerDireccionEnvioOrden)
router.get("/ordenes/pedidos/:id_usuario", obtenerPedidosPorUsuario)

export default router;
