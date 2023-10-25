import { Router } from "express";
import { obtenerVentasPorUsuario } from "../../controllers/ordenesControllers/ordenes.controllers.js";

const router = Router();

// Ruta para obtener las ventas por ID de usuario
router.get("/ventas/:id_usuario", obtenerVentasPorUsuario);

export default router;
