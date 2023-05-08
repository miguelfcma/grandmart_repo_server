import { DenunciaBuzon } from "../../models/buzonModel/BuzonModel.js";

// Obtener todas las denuncias
export const getAllDenuncias = async (req, res) => {
  try {
    const denuncias = await DenunciaBuzon.findAll();
    res.json(denuncias);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Obtener denuncia por ID
export const getDenunciaById = async (req, res) => {
  try {
    const denuncia = await DenunciaBuzon.findByPk(req.params.id);
    if (denuncia) {
      res.json(denuncia);
    } else {
      res.status(404).json({ message: "Denuncia no encontrada" });
    }
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Crear una nueva denuncia
export const createDenuncia = async (req, res) => {
  try {
    const { motivo, descripcion, id_usuario } = req.body;
    const denuncia = await DenunciaBuzon.create({
      motivo,
      descripcion,
      id_usuario,
    });
    res.json(denuncia);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Delete a message by ID
export const deleteDenuncia = async (req, res) => {
  try {
    const denuncia = await  DenunciaBuzon.findByPk(req.params.id);
    if (denuncia) {
      await denuncia.destroy();
      res.json({ message: "Denuncia eliminada correctamente" });
    } else {
      res.status(404).json({ message: "Denuncia no encontrada" });
    }
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
// Get all messages by user ID
export const getDenunciasByUserId = async (req, res) => {
  try {
    const denuncias = await DenunciaBuzon.findAll({
      where: { id_usuario: req.params.id },
    });
    res.json(denuncias);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
