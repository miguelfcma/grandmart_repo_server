import { ImagenProducto } from "../../models/productosModel/ImagenesProductoModel.js";

export const createImgProducto = async (req, res) => {
  const { url, id_producto, es_portada } = req.body;
console.log(req.body)
  try {
    const newImgProducto = await ImagenProducto.create({ url, id_producto, es_portada });

    res.status(201).json({ message: "Url de imagen de producto creada correctamente" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};


export const getGaleriaImagenesByProductId = async (req, res) => {
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

export const getAllImagenesByProductId = async (req, res) => {
  const { id_producto } = req.params;

  try {
    const imagenesProducto = await ImagenProducto.findAll({
      where: { id_producto: id_producto },
      attributes: ['url'],
    });

    res.status(200).json(imagenesProducto);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};

export const getPortadaByProductId = async (req, res) => {
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
