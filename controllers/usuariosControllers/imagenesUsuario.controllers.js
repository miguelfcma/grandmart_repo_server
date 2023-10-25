import { ImagenUsuario } from "../../models/usuariosModel/ImagenesUsuarios.js";

// Esta función crea un nuevo avatar de usuario.
export const createImgUsuario = async (req, res) => {
  const { url, id_usuario } = req.body;

  try {
    const newImgUsuario = await ImagenUsuario.create({ url, id_usuario });

    res.status(201).json({ message: "Avatar de usuario creado correctamente" });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Esta función obtiene el avatar de un usuario por su ID.
export const getImgUsuarioByUserId = async (req, res) => {
  const { id_usuario } = req.params;

  try {
    const imagenUsuario = await ImagenUsuario.findOne({
      where: { id_usuario },
    });

    if (imagenUsuario) {
      res.status(200).json(imagenUsuario);
    } else {
      res.status(404).json({ message: "Avatar de usuario no encontrado" });
    }
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Esta función elimina el avatar de un usuario por su ID.
export const deleteImgUsuarioByUserId = async (req, res) => {
  const { id_usuario } = req.params;

  try {
    const imagenUsuario = await ImagenUsuario.findOne({
      where: { id_usuario },
    });

    if (imagenUsuario) {
      await imagenUsuario.destroy();
      res
        .status(200)
        .json({ message: "Avatar de usuario eliminado correctamente" });
    } else {
      res.status(404).json({ message: "Avatar de usuario no encontrado" });
    }
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Esta función actualiza el avatar de un usuario por su ID.
export const updateImgUsuarioByUserId = async (req, res) => {
  const { id_usuario } = req.params;
  const { url } = req.body;

  try {
    const imagenUsuario = await ImagenUsuario.findOne({
      where: { id_usuario },
    });

    if (imagenUsuario) {
      imagenUsuario.url = url || imagenUsuario.url;

      await imagenUsuario.save();

      res
        .status(200)
        .json({ message: "Imagen de usuario actualizada correctamente" });
    } else {
      res.status(404).json({ message: "Imagen de usuario no encontrada" });
    }
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};
