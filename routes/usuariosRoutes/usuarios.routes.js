import { Router } from "express";

// Importamos los controladores que manejan las distintas rutas de usuarios
import { getUsuario, getUsuarios, deleteUsuario, createUsuario, updateUsuario, getUsuarioLogin, getContrasenaUsuarioByUserId, updateContrasenaUsuarioByUserId } from "../../controllers/usuariosControllers/usuarios.controllers.js";

// Creamos una nueva instancia del Router de Express
const router = Router();

// Rutas disponibles:
// Obtiene todos los usuarios
router.get("/usuarios", getUsuarios);

// Obtiene un usuario por su ID
router.get("/usuarios/:id", getUsuario);

// Crea un nuevo usuario
router.post("/usuarios", createUsuario);

// Actualiza un usuario existente por su ID
router.put("/usuarios/:id", updateUsuario);

// Borra un usuario existente por su ID
router.delete("/usuarios/:id", deleteUsuario);

// Ruta para que un usuario inicie sesión
router.post("/usuarios/login", getUsuarioLogin);

// Ruta para obtener la contraseña
router.get("/contrasena-usuario/:id_usuario", getContrasenaUsuarioByUserId);

// Ruta para actualizar la contraseña
router.put("/contrasena-usuario/:id_usuario", updateContrasenaUsuarioByUserId);

// Exportamos el router creado para ser utilizado por nuestra aplicación
export default router;
