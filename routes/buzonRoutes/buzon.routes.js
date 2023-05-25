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

// Ruta para crear una nuevo denuncia
router.post("/buzon-denuncias", createDenuncia);

// Ruta para crear una nuevo denuncia para servicio
router.post("/buzon-denuncias/servicio", createDenunciaServicio);

// Ruta para obtener todas las denuncias asociadas a un producto
router.get(
  "/producto-denuncias/producto/:id_producto",
  getDenunciasByIdProducto
);

router.get(
  "/producto-denuncias/servicio/:id_servicio",
  getDenunciasByIdServicio
);

router.get(
  "/producto-denuncias/productos-denuncias/:id_usuario",
  getProductosConDenunciasByUsuarioId
);

router.get(
  "/servicio-denuncias/servicios-denuncias/:id_usuario",
  getServiciosConDenunciasByUsuarioId
);

router.get(
  "/producto-denuncias-todas/",
  getAllDenuncias
);

router.get(
  "/servicio-denuncias-todas/",
  getAllDenunciasServicio
);

router.put("/producto-denuncias/actualizar/:id_denuncia", actualizarDenunciaARevisada);

router.put("/servicio-denuncias/actualizar/:id_denuncia", actualizarDenunciaARevisadaServicio);

// Ruta para eliminar una denuncia por su ID
router.delete("/producto-denuncias/eliminar/:id_denuncia", eliminarDenuncia);

// Ruta para eliminar una denuncia por su ID
router.delete("/servicio-denuncias/eliminar/:id_denuncia", eliminarDenunciaServicio);

export default router;
