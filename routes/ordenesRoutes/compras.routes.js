import { Router } from "express";
import {

  obtenerOrdenesUsuario,

} from "../../controllers/ordenesControllers/ordenes.controllers.js";

const router = Router();


router.get("/compras/:id_usuario", obtenerOrdenesUsuario);




export default router;
