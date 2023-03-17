import { ImagenProducto } from "../../models/productosModel/ImagenesProductoModel.js";

export const createImgProducto = async (req, res) => {
  const { url, id_producto, es_portada } = req.body;

  try {
    const newImgProducto = await ImagenProducto.create({ url, id_producto, es_portada });

    res.status(201).json({ message: "Url de imagen de producto creada correctamente" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};

export const getImgProducto = async (req, res) => {
  const { id } = req.params;

  try {
    const imagenProducto = await ImagenProducto.findOne({
      where: { id_producto: id, es_portada: true },
    });

    if (imagenProducto) {
      res.status(200).json(imagenProducto);
    } else {
      res.status(404).json({ message: "Imagen de producto no encontrada" });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};

export const deleteImgProducto = async (req, res) => {
  const { id } = req.params;

  try {
    const imagenProducto = await ImagenProducto.findByPk(id);

    if (imagenProducto) {
      await imagenProducto.destroy();
      res.status(200).json({ message: "Imagen de producto eliminada correctamente" });
    } else {
      res.status(404).json({ message: "Imagen de producto no encontrada" });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};

export const getImagenes = async (req, res) => {
  const { id_producto } = req.params;

  try {
    const imagenesProducto = await ImagenProducto.findAll({
      where: { id_producto: id_producto, es_portada: false },
    });

    res.status(200).json(imagenesProducto);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};

export const getPortada = async (req, res) => {
  const { id_producto } = req.params;

  try {
    const portadaProducto = await ImagenProducto.findOne({
      where: { id_producto: id_producto, es_portada: true },
    });

    if (portadaProducto) {
      res.status(200).json(portadaProducto);
    } else {
      res.status(404).json({ message: "Imagen de portada no encontrada" });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};
export const updateImgProducto = async (req, res) => {
  const { id } = req.params;
  const { url, id_producto, es_portada } = req.body;

  try {
    const imagenProducto = await ImagenProducto.findByPk(id);

    if (imagenProducto) {
      imagenProducto.url = url || imagenProducto.url;
      imagenProducto.id_producto = id_producto || imagenProducto.id_producto;
      imagenProducto.es_portada = es_portada || imagenProducto.es_portada;

      await imagenProducto.save();

      res.status(200).json({ message: "Imagen de producto actualizada correctamente" });
    } else {
      res.status(404).json({ message: "Imagen de producto no encontrada" });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};
