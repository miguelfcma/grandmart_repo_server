import { Router } from "express";

import { enviarCorreo } from "../../controllers/ControladorRecuperarContraseña/recuperarContraseña.controller.js";

const router = Router();

router.post("/send-email", enviarCorreo);


export default router;