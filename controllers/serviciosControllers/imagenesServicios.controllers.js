import { ImagenServicio } from "../../models/serviciosModel/ImagenesServiciosModel.js";

// Función para crear una imagen de servicio
export const createImgServicio = async (req, res) => {
  const { url, id_servicio, es_portada } = req.body;

  try {
    // Crear una nueva imagen de servicio
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

// Función para crear imágenes de servicio
export const createImagenes = async (req, res) => {
  const id_servicio = req.body.id_servicio;
  const imagenes = req.body.imagenes;
  try {
    // Crear imágenes de servicio
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

// Función para eliminar una imagen de servicio por su ID
export const deleteImgServicio = async (req, res) => {
  const { id } = req.params;

  try {
    // Buscar y eliminar la imagen de servicio
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

// Función para obtener todas las imágenes de un servicio por su ID
export const getAllImagenesPorIdServicio = async (req, res) => {
  try {
    // Obtener todas las imágenes de un servicio por su ID de servicio
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

// Función para obtener la imagen de portada de un servicio por su ID de servicio
export const getPortada = async (req, res) => {
  const { id_servicio } = req.params;

  try {
    // Obtener la imagen de portada de un servicio
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

// Función para actualizar una imagen de servicio por su ID
export const updateImgServicio = async (req, res) => {
  const { id } = req.params;
  const { url, id_servicio, es_portada } = req.body;

  try {
    // Actualizar una imagen de servicio
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
