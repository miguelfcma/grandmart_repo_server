import { ImagenServicio } from "../../models/serviciosModel/ImagenesServiciosModel.js";

export const createImgServicio = async (req, res) => {
  const { url, id_servicio, es_portada } = req.body;

  try {
    const newImgServicio = await ImagenServicio.create({
      url,
      id_servicio,
      es_portada,
    });

    res
      .status(201)
      .json({ message: "Url de imagen de servicio creada correctamente" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};

export const getImgServicio = async (req, res) => {
  const { id } = req.params;

  try {
    const imagenServicio = await ImagenServicio.findOne({
      where: { id_servicio: id, es_portada: true },
    });

    if (imagenServicio) {
      res.status(200).json(imagenServicio);
    } else {
      res.status(404).json({ message: "Imagen de servicio no encontrada" });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};

export const deleteImgServicio = async (req, res) => {
  const { id } = req.params;

  try {
    const imagenServicio = await ImagenServicio.findByPk(id);

    if (imagenServicio) {
      await imagenServicio.destroy();
      res
        .status(200)
        .json({ message: "Imagen de servicio eliminada correctamente" });
    } else {
      res.status(404).json({ message: "Imagen de servicio no encontrada" });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};

export const getImagenesServicio = async (req, res) => {
  const { id_servicio } = req.params;

  try {
    const imagenesServicio = await ImagenServicio.findAll({
      where: { id_servicio: id_servicio, es_portada: false },
    });

    res.status(200).json(imagenesServicio);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};

export const getAllImagenesServicio = async (req, res) => {
  const { id_servicio } = req.params;

  try {
    const imagenesServicio = await ImagenServicio.findAll({
      where: { id_servicio: id_servicio },
      attributes: ["url"],
    });

    res.status(200).json(imagenesServicio);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};

export const getPortada = async (req, res) => {
  const { id_servicio } = req.params;

  try {
    const portadaServicio = await ImagenServicio.findOne({
      where: { id_servicio: id_servicio, es_portada: true },
    });

    if (portadaServicio) {
      res.status(200).json(portadaServicio);
    } else {
      res.status(404).json({ message: "Imagen de portada no encontrada" });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};

export const updateImgServicio = async (req, res) => {
  const { id } = req.params;
  const { url, id_servicio, es_portada } = req.body;

  try {
    const imagenServicio = await ImagenServicio.findByPk(id);

    if (imagenServicio) {
      imagenServicio.url = url || imagenServicio.url;
      imagenServicio.id_servicio = id_servicio || imagenServicio.id_servicio;
      imagenServicio.es_portada = es_portada || imagenServicio.es_portada;

      await imagenServicio.save();

      res
        .status(200)
        .json({ message: "Imagen de servicio actualizada correctamente" });
    } else {
      res.status(404).json({ message: "Imagen de servicio no encontrada" });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};
