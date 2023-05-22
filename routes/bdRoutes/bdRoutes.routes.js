import { Router } from "express";
import { createBackup } from "../../controllers/bdControllers/createdBackup.controller.js";
import { restoreBackup,listBackupFiles,deleteBackupFile,downloadBackupFile} from "../../controllers/bdControllers/restoredBackup.controller.js";
import { verificarToken } from "../../controllers/tokenController/authMiddleware.js";
const router = Router();

router.post('/backup-bd', createBackup);
router.post('/restore-bd/:filename', restoreBackup); 
router.get('/restore-bd', listBackupFiles); 
router.post('/restore-bd/download/:filename',verificarToken, downloadBackupFile); 
router.post('/restore-bd/delete/:filename',deleteBackupFile); 

export default router;
