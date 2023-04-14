import { ImagenBlog } from "../../models/blogModel/ImagenesBlogModel.js";

// Función para crear una nueva imagen
export const createImagen = async (req, res) => {
  try {
    const imagen = await ImagenBlog.create({
      url: req.body.url,
      id_publicacionBlog: req.body.id_publicacionBlog,
    });
    res.status(201).json(imagen);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al crear la imagen" });
  }
};

export const createImagenes = async (req, res) => {
  const id_publicacionBlog = req.body.id_publicacionBlog;
  const imagenes = req.body.imagenes;
  try {
    const results = await Promise.all(
      imagenes.map(async (imagen, index) => {
        const es_portada = index === 0 ? true : false;
        const imagenBlog = await ImagenBlog.create({
          url: imagen,
          id_publicacionBlog,
          es_portada,
        });
        return imagenBlog;
      })
    );

    res.status(201).json({
      message: "Imágenes creadas correctamente",
      data: results,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: "Error al crear las imágenes",
      error: error,
    });
  }
};

// Función para obtener las imágenes por id de publicación
export const getImagenesPorIdPublicacion = async (req, res) => {
  try {
    const imagenes = await ImagenBlog.findAll({
      where: {
        id_publicacionBlog: req.params.id_publicacionBlog,
      },
    });
    res.status(200).json(imagenes);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al obtener las imágenes" });
  }
};

// Función para actualizar una imagen por su id y el id de la publicación
export const updateImagenPorIdPublicacion = async (req, res) => {
  try {
    const [numRows, imagen] = await ImagenBlog.update(
      { url: req.body.url },
      {
        where: {
          id: req.params.id,
          id_publicacionBlog: req.body.id_publicacionBlog,
        },
        returning: true,
      }
    );
    if (numRows > 0) {
      res.status(200).json(imagen[0]);
    } else {
      res.status(404).json({ message: "Imagen no encontrada" });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al actualizar la imagen" });
  }
};

// Función para eliminar una imagen por su id y el id de la publicación
export const deleteImagenPorIdPublicacion = async (req, res) => {
  try {
    const numRows = await ImagenBlog.destroy({
      where: {
        id: req.params.id,
        id_publicacionBlog: req.body.id_publicacionBlog,
      },
    });
    if (numRows > 0) {
      res.status(200).json({ message: "Imagen eliminada exitosamente" });
    } else {
      res.status(404).json({ message: "Imagen no encontrada" });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al eliminar la imagen" });
  }
};

// Función para obtener la imagen de portada por id de publicación
export const getImagenPortadaPorIdPublicacion = async (req, res) => {
  try {
    const imagen = await ImagenBlog.findOne({
      where: {
        id_publicacionBlog: req.params.id_publicacionBlog,
        es_portada: true,
      },
    });
    res.status(200).json(imagen);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al obtener la imagen de portada" });
  }
};
