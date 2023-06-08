import { Router } from "express";
import {
  getServicios,
  getServicio,
  createServicio,
  updateServicio,
  deleteServicio,
  getServiciosByUsuarioId,
  createDatosContactoServicio,
  obtenerDatosContactoServicio,
  updateDatosContactoServicio
} from "../../controllers/serviciosControllers/servicios.controllers.js";

const router = Router();

router.get("/servicios", getServicios);

router.get("/servicios/:id", getServicio);

router.post("/servicios", createServicio);

router.put("/servicios/:id", updateServicio);

router.delete("/servicios/:id", deleteServicio);

router.get("/servicios/user/:id_usuario", getServiciosByUsuarioId);


router.post("/servicios/datos-contacto", createDatosContactoServicio);

router.get("/servicios/datos-contacto/:id", obtenerDatosContactoServicio);

router.put("/servicios/datos-contacto/:id", updateDatosContactoServicio);

export default router;
