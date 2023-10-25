// Importar Express y el controlador de denuncias
import { Router } from "express";
import {
  createDenuncia,
  getDenunciasByIdProducto,
  getProductosConDenunciasByUsuarioId,
  getAllDenuncias,
  eliminarDenuncia,
  actualizarDenunciaARevisada,
  createDenunciaServicio,
  getDenunciasByIdServicio,
  getServiciosConDenunciasByUsuarioId,
  getAllDenunciasServicio,
  eliminarDenunciaServicio,
  actualizarDenunciaARevisadaServicio,
} from "../../controllers/buzonDenunciasControllers/buzonDenuncias.controller.js";

const router = Router();

// Ruta para crear una nueva denuncia de producto
router.post("/buzon-denuncias", createDenuncia);

// Ruta para crear una nueva denuncia de servicio
router.post("/buzon-denuncias/servicio", createDenunciaServicio);

// Ruta para obtener todas las denuncias asociadas a un producto
router.get(
  "/producto-denuncias/producto/:id_producto",
  getDenunciasByIdProducto
);

// Ruta para obtener todas las denuncias asociadas a un servicio
router.get(
  "/producto-denuncias/servicio/:id_servicio",
  getDenunciasByIdServicio
);

// Ruta para obtener productos con denuncias asociadas por ID de usuario
router.get(
  "/producto-denuncias/productos-denuncias/:id_usuario",
  getProductosConDenunciasByUsuarioId
);

// Ruta para obtener servicios con denuncias asociadas por ID de usuario
router.get(
  "/servicio-denuncias/servicios-denuncias/:id_usuario",
  getServiciosConDenunciasByUsuarioId
);

// Ruta para obtener todas las denuncias de productos
router.get("/producto-denuncias-todas/", getAllDenuncias);

// Ruta para obtener todas las denuncias de servicios
router.get("/servicio-denuncias-todas/", getAllDenunciasServicio);

// Ruta para actualizar una denuncia a revisada por su ID de denuncia
router.put(
  "/producto-denuncias/actualizar/:id_denuncia",
  actualizarDenunciaARevisada
);

// Ruta para actualizar una denuncia de servicio a revisada por su ID de denuncia
router.put(
  "/servicio-denuncias/actualizar/:id_denuncia",
  actualizarDenunciaARevisadaServicio
);

// Ruta para eliminar una denuncia de producto por su ID de denuncia
router.delete("/producto-denuncias/eliminar/:id_denuncia", eliminarDenuncia);

// Ruta para eliminar una denuncia de servicio por su ID de denuncia
router.delete(
  "/servicio-denuncias/eliminar/:id_denuncia",
  eliminarDenunciaServicio
);

export default router;
