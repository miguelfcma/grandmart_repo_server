import { Router } from "express";

// Importamos los controladores que manejan las distintas rutas de usuarios
import {
  getUsuario,
  getUsuarios,
  deleteUsuario,
  createUsuario,
  updateUsuario,
  getUsuarioLogin,
  actualizarPerfilUsuario,
  actualizarContrasenaUsuario,
  eliminarCuentaUsuario,
} from "../../controllers/usuariosControllers/usuarios.controllers.js";

import { informacionContada } from "../../controllers/usuariosControllers/dashInfo.controller.js";
// Creamos una nueva instancia del Router de Express
const router = Router();

// Rutas disponibles:
// Obtiene todos los usuarios
router.get("/usuarios", getUsuarios);

// Crea un nuevo usuario
router.post("/usuarios", createUsuario);

// Actualiza un usuario existente por su ID
router.put("/usuarios/:id", updateUsuario);

// Borra un usuario existente por su ID
router.delete("/usuarios/:id", deleteUsuario);

// Ruta para que un usuario inicie sesión
router.post("/usuarios/login", getUsuarioLogin);
////////////////////////////////////////////////////////////////////////////
router.put("/usuario-perfil/:id", actualizarPerfilUsuario);
router.get("/usuario-perfil/:id", getUsuario);
////////////////////////////////////////////////////////////////////////////
router.put("/contrasena-usuario-actualizar/:id", actualizarContrasenaUsuario);
////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
router.get("/dashinformacion/:id_usuario", informacionContada);
export default router;
