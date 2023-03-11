import { ImagenUsuario } from "../../models/usuariosModel/ImagenesUsuarios.js";
import path from "path";
import { Console } from "console";
// Crear una nueva imagen de usuario
export const createImagenUsuario = async (req, res) => {
  try {
    // Obtenemos los datos de la imagen subida desde el objeto req.file
    const { filename, mimetype, size, path: filePath } = req.file;

    // Obtenemos el id del usuario desde el objeto req.body
    //const { id } = req.body;
    const id = 34;
    // Creamos un nuevo objeto ImagenUsuario con los datos de la imagen y el id del usuario
    const nuevaImagen = await ImagenUsuario.create({
      nombre: filename,
      ruta: filePath,
      tipo_archivo: mimetype,
      tamano_archivo: size,
      id_usuario: id,
    });

    res.status(201).json({ mensaje: "Imagen creada", imagen: nuevaImagen });
  } catch (error) {
    console.log(error);
    res.status(500).json({ mensaje: "Error al crear la imagen" });
  }
};

// Obtener todas las imágenes de usuario
export const getImagenesUsuario = async (req, res) => {
  try {
    const imagenes = await ImagenUsuario.findAll();
    if (imagenes.length === 0) {
      return res.status(404).json({ message: "No se encontraron imagenes" });
    }
    res.status(200).json(imagenes);
  } catch (error) {
    console.log(error);
    res.status(500).json({ mensaje: "Error al obtener las imágenes" });
  }
};

// Obtener una imagen de usuario por ID
export const getImagenUsuarioById = async (req, res) => {
  try {
    const imagen = await ImagenUsuario.findByPk(req.params.id);

    //Construir la ruta completa de la imagen en el servidor
    const rutaImagen = path.join(
      path.dirname(new URL(import.meta.url).pathname).substring(4),
      "..",
      "..",
      imagen.ruta
    );
    console.log(rutaImagen);
    res.sendFile(rutaImagen, { root: "/" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ mensaje: "Error al obtener la imagen" });
  }
};

// Actualizar una imagen de usuario por ID
export const updateImagenUsuarioById = async (req, res) => {
  try {
    const { nombre, ruta, tipo_archivo, tamano_archivo, id_usuario } = req.body;
    const imagenActualizada = await ImagenUsuario.update(
      { nombre, ruta, tipo_archivo, tamano_archivo, id_usuario },
      { where: { id: req.params.id } }
    );
    res
      .status(200)
      .json({ mensaje: "Imagen actualizada", imagen: imagenActualizada });
  } catch (error) {
    console.log(error);
    res.status(500).json({ mensaje: "Error al actualizar la imagen" });
  }
};