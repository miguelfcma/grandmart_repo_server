import { Router } from "express";

import {
  verificarToken,
  tokenValido,
} from "../../controllers/tokenController/authMiddleware.js";

const router = Router();

// Ruta para verificar un token
router.get("/api/verificacion/token", verificarToken, tokenValido);

export default router;
