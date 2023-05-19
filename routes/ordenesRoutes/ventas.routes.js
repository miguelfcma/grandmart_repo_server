import { Router } from "express";
import { obtenerVentasPorUsuario } from "../../controllers/ordenesControllers/ordenes.controllers.js";

const router = Router();

router.get("/ventas/:id_usuario", obtenerVentasPorUsuario);

export default router;
