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
} from "../../controllers/usuariosControllers/usuarios.controllers.js";

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

router.put("/usuario-perfil/:id", actualizarPerfilUsuario);

// Obtiene un usuario por su ID
router.get("/usuario-perfil/:id", getUsuario);

export default router;
