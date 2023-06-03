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
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};
export const createImagenes = async (req, res) => {
  const id_servicio = req.body.id_servicio;
  const imagenes = req.body.imagenes;
  try {
    const results = await Promise.all(
      imagenes.map(async (imagen, index) => {
        const es_portada = index === 0 ? true : false;
        const imagenServicio = await ImagenServicio.create({
          url: imagen,
          id_servicio,
          es_portada,
        });
        return imagenServicio;
      })
    );

    res.status(201).json({
      message: "Imágenes creadas correctamente",
      data: results,
    });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
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
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

export const getAllImagenesPorIdServicio = async (req, res) => {
  try {
    const imagenes = await ImagenServicio.findAll({
      where: {
        id_servicio: req.params.id_servicio,
      },
      attributes: ["url"],
    });
    res.status(200).json(imagenes);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
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
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
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
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};
