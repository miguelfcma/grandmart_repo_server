import { ComentarioBlog } from "../../models/blogModel/ComentariosBlogModel.js";

// Función para crear un nuevo comentario
export async function createComentario(req, res) {
  const { comentario, id_usuario, id_publicacionBlog } = req.body;

  try {
    const nuevoComentario = await ComentarioBlog.create({
      comentario,
      id_usuario,
      id_publicacionBlog,
    });
    res.status(201).json(nuevoComentario);
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: "Error al crear el comentario" });
  }
}
// Función para obtener los comentarios por id de publicación
export async function getComentariosPorIdPublicacion(req, res) {
    const { id_publicacionBlog } = req.params;
    try {
      const comentarios = await ComentarioBlog.findAll({
        where: { id_publicacionBlog: id_publicacionBlog },
      });
      res.status(200).json(comentarios);
    } catch (error) {
      console.error(error);
      res.status(500).json({ mensaje: "Error al obtener los comentarios" });
    }
  }
  

// Función para actualizar un comentario por su id y el id del usuario
export async function updateComentarioPorIdUsuario(req, res) {
  const { id, id_usuario, comentario } = req.body;

  try {
    const [numRows, comentarioActualizado] = await ComentarioBlog.update(
      { comentario },
      {
        where: { id, id_usuario },
        returning: true,
      }
    );
    if (numRows > 0) {
      res.status(200).json(comentarioActualizado[0]);
    } else {
      res.status(404).json({ mensaje: "Comentario no encontrado" });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: "Error al actualizar el comentario" });
  }
}

// Función para eliminar un comentario por su id y el id del usuario
export async function deleteComentarioPorIdUsuario(req, res) {
  const { id, id_usuario } = req.body;

  try {
    const numRows = await ComentarioBlog.destroy({
      where: { id, id_usuario },
    });
    if (numRows > 0) {
      res.status(200).json({ mensaje: "Comentario eliminado correctamente" });
    } else {
      res.status(404).json({ mensaje: "Comentario no encontrado" });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: "Error al eliminar el comentario" });
  }
}
