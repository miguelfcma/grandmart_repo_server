import { PublicacionBlog } from "../../models/blogModel/PublicacionesBlogModel.js";

// Función para crear una nueva publicación
export const createPublicacion = async (req, res) => {
  try {
    const { titulo, descripcion, id_usuario } = req.body;
    const publicacion = await PublicacionBlog.create({
      titulo,
      descripcion,
      id_usuario,
    });
    res.status(201).json(publicacion);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al crear la publicación" });
  }
};

// Función para obtener todas las publicaciones
export const getPublicaciones = async (req, res) => {
  try {
    const publicaciones = await PublicacionBlog.findAll();
    res.status(200).json(publicaciones);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al obtener las publicaciones" });
  }
};

// Función para obtener las publicaciones por id de usuario
export const getPublicacionesPorIdUsuario = async (req, res) => {
  try {
    const id_usuario = req.params.id_usuario;
    const publicaciones = await PublicacionBlog.findAll({
      where: {
        id_usuario: id_usuario,
      },
    });
    res.status(200).json(publicaciones);
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ message: "Error al obtener las publicaciones del usuario" });
  }
};

// Función para actualizar una publicación por su id y el id del usuario
export const updatePublicacionPorIdUsuario = async (req, res) => {
  try {
    const id = req.params.id;
    const id_usuario = req.params.id_usuario;
    const { titulo, descripcion } = req.body;
    const [numRows, publicacion] = await PublicacionBlog.update(
      { titulo, descripcion },
      {
        where: { id, id_usuario },
        returning: true,
      }
    );
    if (numRows > 0) {
      res.status(200).json(publicacion[0]);
    } else {
      res.status(404).json({ message: "Publicación no encontrada" });
    }
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ message: "Error al actualizar la publicación del usuario" });
  }
};

// Función para eliminar una publicación por su id y el id del usuario
export const deletePublicacionPorIdUsuario = async (req, res) => {
  try {
    const id = req.params.id;
    const id_usuario = req.params.id_usuario;
    const numRows = await PublicacionBlog.destroy({
      where: { id, id_usuario },
    });
    if (numRows > 0) {
      res.status(204).send();
    } else {
      res.status(404).json({ message: "Publicación no encontrada" });
    }
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ message: "Error al eliminar la publicación del usuario" });
  }
};
