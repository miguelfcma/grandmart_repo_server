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
  updateDatosContactoServicio,
} from "../../controllers/serviciosControllers/servicios.controllers.js";

const router = Router();

// Ruta para obtener todos los servicios
router.get("/servicios", getServicios);

// Ruta para obtener un servicio por su ID
router.get("/servicios/:id", getServicio);

// Ruta para crear un nuevo servicio
router.post("/servicios", createServicio);

// Ruta para actualizar un servicio por su ID
router.put("/servicios/:id", updateServicio);

// Ruta para eliminar un servicio por su ID
router.delete("/servicios/:id", deleteServicio);

// Ruta para obtener servicios de un usuario específico
router.get("/servicios/user/:id_usuario", getServiciosByUsuarioId);

// Ruta para crear datos de contacto para un servicio
router.post("/servicios/datos-contacto", createDatosContactoServicio);

// Ruta para obtener datos de contacto de un servicio por su ID
router.get("/servicios/datos-contacto/:id", obtenerDatosContactoServicio);

// Ruta para actualizar datos de contacto de un servicio por su ID
router.put("/servicios/datos-contacto/:id", updateDatosContactoServicio);

export default router;
