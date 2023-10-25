import { Router } from "express";
import { enviarCorreo } from "../../controllers/ControladorRecuperarContraseña/recuperarContraseña.controller.js";

const router = Router();

// Ruta para enviar un correo de recuperación de contraseña
router.post("/send-email", enviarCorreo);

export default router;
