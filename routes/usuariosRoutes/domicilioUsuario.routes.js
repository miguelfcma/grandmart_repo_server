import { Router } from "express";

import {
  createDomicilioUsuario,
  deleteDomicilioUsuarioByUserId,
  updateDomicilioUsuarioByUserId,
  getDomicilioUsuarioByUserId
} from "../../controllers/usuariosControllers/domicilioUsuario.controllers.js";

// Creamos una nueva instancia del Router de Express
const router = Router();

// Ruta para crear una nueva dirección de usuario
router.post("/domicilio-usuario", createDomicilioUsuario);

// Ruta para obtener la dirección de un usuario por su ID
router.get("/domicilio-usuario/:id_usuario", getDomicilioUsuarioByUserId);

// Ruta para eliminar una dirección de usuario por su ID
router.delete("/domicilio-usuario/:id_usuario", deleteDomicilioUsuarioByUserId);

// Ruta para actualizar una dirección de usuario por su ID
router.put("/domicilio-usuario/:id_usuario", updateDomicilioUsuarioByUserId);

// Exportamos el router para que pueda ser usado en la aplicación
export default router;
