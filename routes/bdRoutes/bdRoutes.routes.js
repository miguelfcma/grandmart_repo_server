import { Router } from "express";
import { createBackup } from "../../controllers/bdControllers/createdBackup.controller.js";
import { verificarToken } from "../../controllers/tokenController/authMiddleware.js";
const router = Router();

router.post('/backup', verificarToken,createBackup);

export default router;
