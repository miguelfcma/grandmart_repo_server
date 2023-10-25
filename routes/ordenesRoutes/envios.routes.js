import { Router } from "express";
import {
  obtenerDireccionEnvioOrden,
  verificacionDireccionEnvio,
  obtenerInformacionEnvio,
  cambiarEstadoEnvio,
} from "../../controllers/ordenesControllers/ordenes.controllers.js";

const router = Router();

// Ruta para obtener información de envío de una orden por su ID
router.get("/envio/:id_orden", obtenerInformacionEnvio);

// Ruta para obtener la dirección de envío de una orden por su ID
router.get("/envio/direccion/:id_orden", obtenerDireccionEnvioOrden);

// Ruta para cambiar el estado de envío de una orden por su ID de envío
router.put("/envio/estado/:id_envio", cambiarEstadoEnvio);

// Ruta para verificar la dirección de envío de un usuario por su ID de usuario
router.get("/direccion/verificacion/:id_usuario", verificacionDireccionEnvio);

export default router;
