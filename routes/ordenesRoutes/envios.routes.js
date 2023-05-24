import { Router } from "express";
import {
  obtenerDireccionEnvioOrden,
  verificacionDireccionEnvio,
  obtenerInformacionEnvio,
  cambiarEstadoEnvio,
} from "../../controllers/ordenesControllers/ordenes.controllers.js";

const router = Router();
router.get("/envio/:id_orden", obtenerInformacionEnvio);
router.get("/envio/direccion/:id_orden", obtenerDireccionEnvioOrden);

router.put("/envio/estado/:id_envio", cambiarEstadoEnvio);

router.get("/direccion/verificacion/:id_usuario", verificacionDireccionEnvio);



export default router;
