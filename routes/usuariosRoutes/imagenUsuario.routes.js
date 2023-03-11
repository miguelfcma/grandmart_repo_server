import { Router } from "express";
import multer from "multer";
import path from "path";
import { v4 as uuidv4 } from "uuid";

// Importación del controlador para manejar las imágenes del usuario
import { createImagenUsuario, getImagenesUsuario, getImagenUsuarioById} from "../../controllers/usuariosControllers/imagenesUsuario.controllers.js";

// Creación del objeto router que se utilizará para definir la ruta
const router = Router();


// Configuración de Multer para el almacenamiento de las imágenes
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "public/avatars/"); // Directorio donde se almacenarán las imágenes
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = uuidv4(); // Generación de un ID único para el nombre de la imagen
    const fileExtension = path.extname(file.originalname); // Obtención de la extensión del archivo original
    const newFileName = `${uniqueSuffix}${fileExtension}`; // Nuevo nombre de la imagen
    cb(null, newFileName);
  },
});

// Creación del objeto upload que utilizará la configuración de Multer definida anteriormente
const upload = multer({ storage: storage });


// Definición de la ruta POST para manejar las solicitudes de carga de imágenes
router.post("/imagenes", upload.single("imagen"), createImagenUsuario);
/*upload.single("imagen"): Este es un middleware proporcionado por Multer que procesa los datos enviados en la solicitud POST. En este caso, el método .single se utiliza para indicar que se espera un solo archivo, que se identifica mediante el campo "imagen".*/

// Definición de la ruta PUT para manejar las solicitudes de actualización de imágenes
//router.put("/imagenes/:id", updateImagenUsuarioById);
// Definición de la ruta GET para obtener una imagen de usuario por ID
router.get("/imagenes/:id", getImagenUsuarioById);

router.get("/imagenes/", getImagenesUsuario);

// Definición de la ruta DELETE para eliminar una imagen de usuario por ID
//router.delete("/imagenes/:id", deleteImagenUsuarioById);
// Exportación del objeto router para que pueda ser utilizado por la aplicación
export default router;
