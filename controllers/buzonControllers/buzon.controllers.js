import { MensajeBuzon } from "../../models/buzonModel/BuzonModel.js";

// Get all messages
export const getAllMensajes = async (req, res) => {
  try {
    const mensajes = await MensajeBuzon.findAll();
    res.json(mensajes);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get a message by ID
export const getMensajeById = async (req, res) => {
  try {
    const mensaje = await MensajeBuzon.findByPk(req.params.id);
    if (mensaje) {
      res.json(mensaje);
    } else {
      res.status(404).json({ message: "Mensaje no encontrado" });
    }
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Create a new message
export const createMensaje = async (req, res) => {
  try {
    const { motivo, descripcion, id_usuario } = req.body;
    const mensaje = await MensajeBuzon.create({
      motivo,
      descripcion,
      id_usuario,
    });
    res.json(mensaje);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Update a message by ID
export const updateMensaje = async (req, res) => {
  try {
    const mensaje = await MensajeBuzon.findByPk(req.params.id);
    if (mensaje) {
      const { motivo, descripcion, id_usuario } = req.body;
      await mensaje.update({
        motivo,
        descripcion,
        id_usuario,
      });
      res.json(mensaje);
    } else {
      res.status(404).json({ message: "Mensaje no encontrado" });
    }
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Delete a message by ID
export const deleteMensaje = async (req, res) => {
  try {
    const mensaje = await MensajeBuzon.findByPk(req.params.id);
    if (mensaje) {
      await mensaje.destroy();
      res.json({ message: "Mensaje eliminado correctamente" });
    } else {
      res.status(404).json({ message: "Mensaje no encontrado" });
    }
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
// Get all messages by user ID
export const getMensajesByUserId = async (req, res) => {
  try {
    const mensajes = await MensajeBuzon.findAll({
      where: { id_usuario: req.params.id },
    });
    res.json(mensajes);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
