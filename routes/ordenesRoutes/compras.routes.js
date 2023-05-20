import { Router } from "express";
import {

  obtenerComprasUsuario,

} from "../../controllers/ordenesControllers/ordenes.controllers.js";

const router = Router();


router.get("/compras/:id_usuario", obtenerComprasUsuario);




export default router;
