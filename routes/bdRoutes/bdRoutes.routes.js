import { Router } from "express";
import { createBackup } from "../../controllers/bdControllers/createdBackup.controller.js";
import { restoreBackup,listBackupFiles,deleteBackupFile,downloadBackupFile} from "../../controllers/bdControllers/restoredBackup.controller.js";
import { verificarToken } from "../../controllers/tokenController/authMiddleware.js";
const router = Router();

router.post('/backup-bd',verificarToken, createBackup);
router.post('/restore-bd/:filename',verificarToken, restoreBackup); 
router.get('/restore-bd', verificarToken,listBackupFiles); 
router.post('/restore-bd/download/:filename',verificarToken, downloadBackupFile); 
router.post('/restore-bd/delete/:filename',verificarToken, deleteBackupFile); 

export default router;
