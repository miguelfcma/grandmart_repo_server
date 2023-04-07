import { Router } from "express";
import { createBackup } from "../../controllers/bdControllers/createdBackup.controller.js";
import { restoreBackup } from "../../controllers/bdControllers/restoredBackup.controller.js";
import { verificarToken } from "../../controllers/tokenController/authMiddleware.js";
const router = Router();

router.post('/backup-bd', verificarToken, createBackup);
router.post('/restore-bd', restoreBackup); 

export default router;
