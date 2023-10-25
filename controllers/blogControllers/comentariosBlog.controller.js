import { ComentarioBlog } from "../../models/blogModel/ComentariosBlogModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";

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
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
}
// Función para obtener los comentarios por id de publicación
export async function getComentariosPorIdPublicacion(req, res) {
  const { id_publicacionBlog } = req.params;
  console.log(id_publicacionBlog);
  try {
    if (!id_publicacionBlog) {
      res.status(404).json({ message: "Error el id es indefinido" });
    }

    const comentarios = await ComentarioBlog.findAll({
      where: { id_publicacionBlog: id_publicacionBlog },
    });

    const comentarioConUsuario = await Promise.all(
      comentarios.map(async (comentario) => {
        const usuario = await Usuario.findByPk(comentario.id_usuario, {
          attributes: ["id", "nombre"],
        });
        return { ...comentario.toJSON(), usuario };
      })
    );

    res.status(200).json(comentarioConUsuario);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
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
      res.status(404).json({ message: "Comentario no encontrado" });
    }
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
}

// Función para eliminar un comentario por su id y el id del usuario

export async function deleteComentarioPorIdUsuario(req, res) {
  const { id_usuario, id } = req.params;
  console.log(id_usuario);
  try {
    const comentario = await ComentarioBlog.findOne({
      where: { id, id_usuario },
    });

    if (comentario) {
      await comentario.destroy();
      res.status(200).json({ message: "Comentario eliminado correctamente" });
    } else {
      res.status(404).json({ message: "Comentario no encontrado" });
    }
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
}

