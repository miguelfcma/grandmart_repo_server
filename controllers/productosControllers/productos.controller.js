import { Producto } from "../../models/productosModel/ProductoModel.js";
import { Categoria } from "../../models/categoriasModel/CategoriaModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import { Op } from "sequelize";

// Función para obtener un producto por su ID
export const getProductoById = async (req, res) => {
  try {
    const { id_producto } = req.params;
    const producto = await Producto.findByPk(id_producto);
    if (!producto) {
      return res.status(404).json({ message: "Producto no encontrado" });
    }

    const categoria = await Categoria.findByPk(producto.id_categoria, {
      attributes: ["id", "nombre"],
    });
    const usuario = await Usuario.findByPk(producto.id_usuario, {
      attributes: ["id", "nombre"],
    });

    const productoConCategoriaYUsuario = {
      ...producto.toJSON(),
      categoria,
      usuario,
    };

    return res.status(200).json(productoConCategoriaYUsuario);
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para obtener todos los productos con sus categorías y usuarios asociados
export const getProductos = async (req, res) => {
  try {
    const productos = await Producto.findAll({
      attributes: [
        "id",
        "nombre",
        "precio",
        "stock",
        "descripcion",
        "marca",
        "modelo",
        "color",
        "estado",
        "id_categoria",
        "id_usuario",
      ],
    });
    if (productos.length === 0) {
      return res.status(404).json({ message: "No se encontraron productos" });
    }

    const productosConCategoriaYUsuario = await Promise.all(
      productos.map(async (producto) => {
        const categoria = await Categoria.findByPk(producto.id_categoria, {
          attributes: ["id", "nombre"],
        });
        const usuario = await Usuario.findByPk(producto.id_usuario, {
          attributes: ["id", "nombre"],
        });
        return { ...producto.toJSON(), categoria, usuario };
      })
    );

    return res.status(200).json(productosConCategoriaYUsuario);
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para crear un nuevo producto
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
    return res.status(201).json({
      message: "Producto creado exitosamente.",
      producto: newProducto,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para actualizar un producto por su ID
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
    return res.status(200).json({
      message: "Producto actualizado exitosamente.",
      producto: updateProducto,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para eliminar un producto por su ID
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
    console.log(error);
    return res.status(500).json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para obtener productos de un usuario por su ID
export const getProductosByUser = async (req, res) => {
  try {
    const productos = await Producto.findAll({
      where: {
        id_usuario: req.params.id_usuario,
      },
      attributes: [
        "id",
        "nombre",
        "precio",
        "stock",
        "descripcion",
        "marca",
        "modelo",
        "color",
        "estado",
        "id_categoria",
        "id_usuario",
      ],
    });
    if (productos.length === 0) {
      return res
        .status(404)
        .json({ message: "No se encontraron productos del usuario" });
    }
    return res.status(200).json(productos);
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ha ocurrido un error en el servidor" });
  }
};
