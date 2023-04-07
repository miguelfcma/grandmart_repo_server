import { Producto } from "../../models/productosModel/ProductoModel.js";
import { Op } from "sequelize";

export const getProducto = async (req, res) => {
  try {
    const producto = await Producto.findByPk(req.params.id);
    if (!producto) {
      return res.status(404).json({ message: "Producto no encontrado" });
    }
    return res.status(200).json(producto);
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Ocurrió un error al obtener el producto." });
  }
};

export const getProductos = async (req, res) => {
  try {
    const productos = await Producto.findAll({
      attributes: ['id','nombre', 'precio', 'stock', 'descripcion', 'marca', 'modelo', 'color', 'estado', 'id_categoria', 'id_usuario'],
    });
    if (productos.length === 0) {
      return res.status(404).json({ message: "No se encontraron productos" });
    }
    return res.status(200).json(productos);
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Ocurrió un error al obtener los productos." });
  }
};


export const createProducto = async (req, res) => {
  console.log(req.body)
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
        .json({ message: "Este producto ya está registrado en su cuenta." });
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
    return res
      .status(201)
      .json({
        message: "Producto creado exitosamente.",
        producto: newProducto,
      });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ocurrió un error al crear el producto." });
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
  } = req.body;
  try {
    const producto = await Producto.findByPk(req.params.id);
    if (!producto) {
      return res.status(404).json({ message: "No se encontró el producto" });
    }
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
    });
    return res
      .status(200)
      .json({
        message: "Producto actualizado exitosamente.",
        producto: updateProducto,
      });
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Ocurrió un error al actualizar el producto." });
  }
};

export const deleteProducto = async (req, res) => {
  try {
    const producto = await Producto.findByPk(req.params.id);
    if (!producto) {
      return res.status(404).json({ message: "No se encontró el producto" });
    }
    await producto.destroy();
    return res
      .status(200)
      .json({ message: "El producto fue eliminado exitosamente." });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};


export const getProductosByUser = async (req, res) => {
  try {
    const productos = await Producto.findAll({
      where: {
        id_usuario: req.params.id_usuario
      },
      attributes: ['id', 'nombre', 'precio', 'stock', 'descripcion', 'marca', 'modelo', 'color', 'estado', 'id_categoria', 'id_usuario'],
    });
    if (productos.length === 0) {
      return res.status(404).json({ message: "No se encontraron productos del usuario" });
    }
    return res.status(200).json(productos);
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Ocurrió un error al obtener los productos del usuario." });
  }
};
