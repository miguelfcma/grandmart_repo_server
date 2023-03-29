import { Router } from "express";

import {
  createImgUsuario,
  getImgUsuarioByUserId,
  deleteImgUsuarioByUserId,
  updateImgUsuarioByUserId,
} from "../../controllers/usuariosControllers/imagenesUsuario.controllers.js";

const router = Router();

// Ruta para crear una nueva imagen de usuario
router.post("/usuario-images", createImgUsuario);

// Ruta para obtener la imagen de un usuario por su ID de usuario
router.get("/usuario-images-by-user/:id_usuario", getImgUsuarioByUserId);

// Ruta para eliminar una imagen de usuario por su ID de usuario
router.delete("/usuario-images-by-user/:id_usuario", deleteImgUsuarioByUserId);

// Ruta para actualizar una imagen de usuario por su ID de usuario
router.put("/usuario-images-by-user/:id_usuario", updateImgUsuarioByUserId);


export default router;