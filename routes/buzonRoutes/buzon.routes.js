import { Router } from "express";
import {
  createDenuncia,
  getDenunciasByIdProducto,
  getProductosConDenunciasByUsuarioId,
  getAllDenuncias,
  eliminarDenuncia,
  actualizarDenunciaARevisada
} from "../../controllers/buzonDenunciasControllers/buzonDenuncias.controller.js";

const router = Router();

// Ruta para crear una nuevo denuncia
router.post("/buzon-denuncias", createDenuncia);

// Ruta para obtener todas las denuncias asociadas a un producto
router.get(
  "/producto-denuncias/producto/:id_producto",
  getDenunciasByIdProducto
);

router.get(
  "/producto-denuncias/productos-denuncias/:id_usuario",
  getProductosConDenunciasByUsuarioId
);

router.get(
  "/producto-denuncias-todas/",
  getAllDenuncias
);

router.put("/producto-denuncias/actualizar/:id_denuncia", actualizarDenunciaARevisada);

// Ruta para eliminar una denuncia por su ID
router.delete("/producto-denuncias/eliminar/:id_denuncia", eliminarDenuncia);

export default router;
