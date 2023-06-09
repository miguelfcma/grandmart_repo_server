import { Router } from "express";
import {
  crearOrden,
  obtenerDetalleOrden,
  obtenerTodasLasOrdenes,
  eliminarOrden,
  cambiarEstadoOrden,
} from "../../controllers/ordenesControllers/ordenes.controllers.js";

const router = Router();

// Rutas para agregar productos al carrito
router.post("/ordenes", crearOrden);
router.get("/ordenes-all/", obtenerTodasLasOrdenes);

router.put("/ordenes/estado/:id_orden", cambiarEstadoOrden);

router.get("/ordenes/detalles/:id_orden", obtenerDetalleOrden);
router.delete("/ordenes/eliminar/:id_orden", eliminarOrden);

/**
 * 
// Rutas para agregar productos al carrito
router.post("/ordenes", crearOrden);
router.get("/ordenes-all/", obtenerTodasLasOrdenes);
router.get("/ordenes/usuario/:id_usuario", obtenerOrdenesUsuario);
router.put("/ordenes/:id_orden", actualizarEstadoOrden);
router.get("/ordenes/detalles/:id_orden", obtenerDetalleOrden);
router.get("/ordenes/direccion/:id_orden", obtenerDireccionEnvioOrden)
router.get("/ordenes/pedidos/:id_usuario", obtenerPedidosPorUsuario)
// Ruta para verificar si el usuario tiene una dirección de envío registrada
router.get("/ordenes/verificacion-direccion-envio/:id_usuario", verificacionDireccionEnvio);


 */
export default router;
