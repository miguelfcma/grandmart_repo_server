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
    res.status(201).json(domicilioUsuario);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

export const deleteDomicilioUsuarioByUserId = async (req, res) => {
  try {
    const { id_usuario } = req.params;
    await DomicilioUsuario.destroy({ where: { id_usuario } });
    res.status(204).end();
  } catch (error) {
    res.status(500).json({ error: error.message });
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
    res.status(200).json(updatedDomicilioUsuario);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

export const getDomicilioUsuarioByUserId = async (req, res) => {
  try {
    const { id_usuario } = req.params;
    const domicilioUsuario = await DomicilioUsuario.findOne({
      where: { id_usuario },
    });
    res.status(200).json(domicilioUsuario);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
