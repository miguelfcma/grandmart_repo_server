import { ImagenProducto } from "../../models/productosModel/ImagenesProductoModel.js";

// Función para crear una nueva imagen de producto
export const createImgProducto = async (req, res) => {
  const { url, id_producto, es_portada } = req.body;
  console.log(req.body);
  try {
    // Crear una nueva imagen de producto
    const newImgProducto = await ImagenProducto.create({
      url,
      id_producto,
      es_portada,
    });

    res
      .status(201)
      .json({ message: "Url de imagen de producto creada correctamente" });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para crear múltiples imágenes de producto
export const createImagenes = async (req, res) => {
  const id_producto = req.body.id_producto;
  const imagenes = req.body.imagenes;
  try {
    // Crear varias imágenes de producto a partir de una lista de URL
    const results = await Promise.all(
      imagenes.map(async (imagen, index) => {
        const es_portada = index === 0 ? true : false;
        const imagenProducto = await ImagenProducto.create({
          url: imagen,
          id_producto,
          es_portada,
        });
        return imagenProducto;
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

// Función para obtener la galería de imágenes de un producto por su ID
export const getGaleriaImagenesByProductId = async (req, res) => {
  const { id_producto } = req.params;

  try {
    // Buscar y devolver todas las imágenes que no son portada
    const imagenesProducto = await ImagenProducto.findAll({
      where: { id_producto: id_producto, es_portada: false },
    });

    res.status(200).json(imagenesProducto);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para obtener todas las imágenes de un producto por su ID
export const getAllImagenesByProductId = async (req, res) => {
  const { id_producto } = req.params;

  try {
    // Buscar y devolver todas las imágenes de un producto
    const imagenesProducto = await ImagenProducto.findAll({
      where: { id_producto: id_producto },
      attributes: ["url"],
    });

    res.status(200).json(imagenesProducto);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para obtener la imagen de portada de un producto por su ID
export const getPortadaByProductId = async (req, res) => {
  const { id_producto } = req.params;

  try {
    // Buscar y devolver la imagen de portada de un producto
    const portadaProducto = await ImagenProducto.findOne({
      where: { id_producto: id_producto, es_portada: true },
    });

    if (portadaProducto) {
      res.status(200).json(portadaProducto);
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
