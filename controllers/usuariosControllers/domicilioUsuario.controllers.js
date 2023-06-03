import { DomicilioUsuario } from "../../models/usuariosModel/DomicilioUsuarioModel.js";

export const createDomicilioUsuario = async (req, res) => {
  try {
    const data = req.body;

    // Buscar si el usuario ya tiene una dirección registrada
    const domicilioUsuarioExistente = await DomicilioUsuario.findOne({
      where: { id_usuario: data.id_usuario },
    });

    if (domicilioUsuarioExistente) {
      return res
        .status(400)
        .json({ error: "Este usuario ya tiene una dirección registrada." });
    }

    // Crear una nueva dirección
    const domicilioUsuario = await DomicilioUsuario.create(data);
    res
      .status(201)
      .json({
        message: "Dirección de usuario creada exitosamente.",
        data: domicilioUsuario,
      });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

export const deleteDomicilioUsuarioByUserId = async (req, res) => {
  try {
    const { id_usuario } = req.params;
    await DomicilioUsuario.destroy({ where: { id_usuario } });
    res
      .status(204)
      .json({ message: "Dirección de usuario eliminada exitosamente." });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

export const updateDomicilioUsuarioByUserId = async (req, res) => {
  try {
    const { id_usuario } = req.params;
    const data = req.body;
    await DomicilioUsuario.update(data, { where: { id_usuario } });
    const updatedDomicilioUsuario = await DomicilioUsuario.findOne({
      where: { id_usuario },
    });
    res
      .status(200)
      .json({
        message: "Dirección de usuario actualizada exitosamente.",
        data: updatedDomicilioUsuario,
      });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

export const getDomicilioUsuarioByUserId = async (req, res) => {
  try {
    const { id_usuario } = req.params;
    const domicilioUsuario = await DomicilioUsuario.findOne({
      where: { id_usuario },
    });

    if (domicilioUsuario) {
      res
        .status(200)
        .json({
          message: "Dirección de usuario obtenida exitosamente.",
          data: domicilioUsuario,
        });
    } else {
      res
        .status(404)
        .json({ error: "No se encontró la dirección del usuario." });
    }
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};
