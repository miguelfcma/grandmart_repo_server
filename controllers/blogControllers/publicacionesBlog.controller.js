import { PublicacionBlog } from "../../models/blogModel/PublicacionesBlogModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import { ComentarioBlog } from "../../models/blogModel/ComentariosBlogModel.js";
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
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para obtener todas las publicaciones
export const getPublicaciones = async (req, res) => {
  try {
    const publicaciones = await PublicacionBlog.findAll();

    const publicacionesConUsuario = await Promise.all(
      publicaciones.map(async (publicacion) => {
        const usuario = await Usuario.findByPk(publicacion.id_usuario, {
          attributes: ["id", "nombre"],
        });
        return { ...publicacion.toJSON(), usuario };
      })
    );

    res.status(200).json(publicacionesConUsuario);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
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
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
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
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

/// Función para eliminar una publicación por su id y el id del usuario
export const deletePublicacionPorIdUsuario = async (req, res) => {
  try {
    const id_usuario = req.params.id_usuario;
    const id_publicacionBlog = req.body.id;
    console.log(id_publicacionBlog);
    const publicacion = await PublicacionBlog.findOne({
      where: { id: id_publicacionBlog, id_usuario: id_usuario },
    });

    if (publicacion) {
      const comentarios = await ComentarioBlog.findAll({
        where: { id_publicacionBlog: id_publicacionBlog },
      });
      await Promise.all(
        comentarios.map(async (comentario) => {
          await comentario.destroy();
        })
      );
      await publicacion.destroy();
      return res
        .status(204)
        .json({ message: "Publicación y comentarios eliminados exitosamente" });
    } else {
      return res.status(404).json({ message: "Publicación no encontrada" });
    }
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};
