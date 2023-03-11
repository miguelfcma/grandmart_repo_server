import { Servicio } from "../../models/serviciosModel/ServicioModel.js";
import { Op } from "sequelize";

export const getServicio = async (req, res) => {
  try {
    const servicio = await Servicio.findByPk(req.params.id);
    //Verificación de existencia
    if (!servicio) {
      return res.status(404).json({ message: "Servicio no encontrado" });
    }
    res.json(servicio);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const getServicios = async (req, res) => {
  try {
    const servicios = await Servicio.findAll();
    //Validación de existencia
    if (servicios.length === 0) {
      return res.status(404).json({ message: "No se encontraron servicios" });
    }
    res.json(servicios);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const createServicio = async (req, res) => {
  const { titulo, descripcion, precio, id_categoria, id_usuario } = req.body;
  try {
    const existenciaServicio = await Servicio.findOne({
      where: {
        [Op.and]: [{ titulo: titulo }, { id_usuario: id_usuario }],
      },
    });
    if (existenciaServicio) {
      return res
        .status(400)
        .json({ message: "Este Servicio ya esta registrado en su cuenta" });
    }
    const newServicio = await Servicio.create({
      titulo,
      descripcion,
      precio,
      id_categoria,
      id_usuario,
    });
    res
      .status(200)
      .json({ newServicio, message: "Servicio registrado correctamente" });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const updateServicio = async (req, res) => {
  const { titulo, descripcion, precio, id_categoria, id_usuario } = req.body;
  try {
    const existenciaServicio = await Servicio.findByPk(req.body.id);
    if (!existenciaServicio) {
      return res.status(404).json({ message: "No se encontró el servicio" });
    }
    const newServicio = await Servicio.update({
      titulo,
      descripcion,
      precio,
      id_categoria,
      id_usuario,
    });
    res
      .status(200)
      .json({ newServicio, message: "Servicio actualizado correctamente" });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const deleteServicio = async (req, res) => {
  try {
    //Verifica existencia
    const servicio = await Servicio.findByPk(req.params.id);
    if (!servicio) {
      return res.status(404).json({ message: "No se encontró el servicio" });
    }
    //realiza la eliminacion
    await servicio.destroy();
    res.json({ message: "El servicio fue eliminado con éxito" });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};
