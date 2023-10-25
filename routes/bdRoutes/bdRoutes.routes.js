import { Router } from "express";
import { createBackup } from "../../controllers/bdControllers/createdBackup.controller.js";
import {
  restoreBackup,
  listBackupFiles,
  deleteBackupFile,
  downloadBackupFile,
} from "../../controllers/bdControllers/restoredBackup.controller.js";
import { verificarToken } from "../../controllers/tokenController/authMiddleware.js";

const router = Router();

// Ruta para crear una copia de seguridad de la base de datos
router.post("/backup-bd", createBackup);

// Ruta para restaurar una copia de seguridad de la base de datos utilizando un nombre de archivo específico
router.post("/restore-bd/:filename", restoreBackup);

// Ruta para listar los archivos de copias de seguridad disponibles
router.get("/restore-bd", listBackupFiles);

// Ruta para descargar una copia de seguridad de la base de datos utilizando un nombre de archivo específico
router.post("/restore-bd/download/:filename", downloadBackupFile);

// Ruta para eliminar un archivo de copia de seguridad específico
router.post("/restore-bd/delete/:filename", deleteBackupFile);

export default router;
