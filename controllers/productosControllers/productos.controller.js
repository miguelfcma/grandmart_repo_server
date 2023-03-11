import { Producto } from "../../models/productosModel/ProductoModel.js";
import { Op } from "sequelize";

export const getProducto = async (req, res) => {
  try {
    const producto = await Producto.findByPk(req.params.id);
    //Verificación de existencia
    if (!producto) {
      return res.status(404).json({ message: "Producto no encontrado" });
    }
    res.json(producto);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const getProductos = async (req, res) => {
  try {
    const productos = await Producto.findAll();
    //Validación de existencia
    if (productos.length === 0) {
      return res.status(404).json({ message: "No se encontraron productos" });
    }
    res.json(productos);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const createProducto = async (req, res) => {
  const {
    nombre,
    precio,
    stock,
    descripcion,
    marca,
    modelo,
    color,
    estado,
    id_categoria,
    id_usuario,
  } = req.body;
  try {
    const existenciaProducto = await Producto.findOne({
      where: {
        [Op.and]: [{ nombre: nombre }, { id_usuario: id_usuario }],
      },
    });
    if (existenciaProducto) {
      return res
        .status(400)
        .json({ message: "Este producto ya esta registrado en su cuenta" });
    }
    const newProducto = await Producto.create({
      nombre,
      precio,
      stock,
      descripcion,
      marca,
      modelo,
      color,
      estado,
      id_categoria,
      id_usuario,
    });
    res.json(newProducto);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const updateProducto = async (req, res) => {
  const {
    nombre,
    precio,
    stock,
    descripcion,
    marca,
    modelo,
    color,
    estado,
    id_categoria,
    id_usuario,
  } = req.body; // Obtiene los nuevos valores desde el cuerpo de la solicitud
  try {
    //Verifica existencia
    const producto = await Producto.findByPk(req.params.id);
    if (!producto) {
      return res.status(404).json({ message: "No se encontró el producto" });
    }
    // Actualiza la categoría con los nuevos valores
    const updateProducto = await producto.update({
      nombre,
      precio,
      stock,
      descripcion,
      marca,
      modelo,
      color,
      estado,
      id_categoria,
      id_usuario,
    });

    // Envía una respuesta exitosa
    res
      .status(200)
      .json({ updateProducto, message: "Producto actualizado correctamente" });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const deleteProducto = async (req, res) => {
  try {
    //Verifica existencia
    const producto = await Producto.findByPk(req.params.id);
    if (!producto) {
      return res.status(404).json({ message: "No se encontró el producto" });
    }
    //realiza la eliminacion
    await producto.destroy();
    res.json({ message: "El producto fue eliminado con éxito" });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};
