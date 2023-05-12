import { DenunciaBuzon } from "../../models/buzonModel/BuzonModel.js";
import { Producto } from "../../models/productosModel/ProductoModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";

// Crear una nueva denuncia
export const createDenuncia = async (req, res) => {
  try {
    const { motivo, descripcion, id_usuario, id_producto } = req.body;
    console.log(req.body)
    const denuncia = await DenunciaBuzon.create({
      motivo,
      descripcion,
      id_usuario,
      id_producto
    });
    res.status(201).json(denuncia);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Obtener todas las denuncias asociadas a un producto
export const getDenunciasByIdProducto = async (req, res) => {
  try {
    const { id_producto } = req.params;
    const denuncias = await DenunciaBuzon.findAll({ where: { id_producto } });

    if (denuncias.length === 0) {
      return res.status(404).json({ message: "No se encontraron denuncias" });
    }
    const denunciasConUsuarioYProducto = await Promise.all(denuncias.map(async motivo => {
      const producto = await Producto.findByPk(motivo.id_producto, { attributes: ['id', 'nombre'] });
      const usuario = await Usuario.findByPk(motivo.id_usuario, { attributes: ['id', 'nombre'] });
      return { ...motivo.toJSON(), producto, usuario };
    }));

    res.status(200).json(denunciasConUsuarioYProducto);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};

// Get all messages by user ID
export const getDenunciasByUserId = async (req, res) => {
  try {
    const denuncias = await DenunciaBuzon.findAll({
      where: { id_usuario: req.params.id },
    });
    res.json(denuncias);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Obtener productos del usuario con denuncias asociadas
export const getProductosConDenunciasByUsuarioId = async (req, res) => {
  try {
    const { id_usuario } = req.params;

    // Buscar productos del usuario por su ID de usuario
    const productos = await Producto.findAll({ where: { id_usuario } });

    if (productos.length === 0) {
      return res.status(404).json({ message: "No se encontraron productos para el usuario especificado" });
    }

    const productosConDenuncias = await Promise.all(productos.map(async producto => {
      // Buscar denuncias asociadas al producto
      const denuncias = await DenunciaBuzon.findAll({ where: { id_producto: producto.id } });

      if (denuncias.length > 0) {
        // Si el producto tiene denuncias asociadas, agregarlas como propiedad al objeto de producto
        return { ...producto.toJSON(), denuncias };
      } else {
        // Si el producto no tiene denuncias asociadas, devolver null
        return null;
      }
    }));

    // Filtrar los productos nulos (que no tienen denuncias asociadas)
    const productosConDenunciasFiltrados = productosConDenuncias.filter(producto => producto !== null);

    res.status(200).json(productosConDenunciasFiltrados);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};

//  Eliminar una denuncia por su ID
export const eliminarDenuncia = async (req, res) => {
  try {
    const denuncia = await  DenunciaBuzon.findByPk(req.params.id);
    if (denuncia) {
      await denuncia.destroy();
      res.json({ message: "Denuncia eliminada correctamente" });
    } else {
      res.status(404).json({ message: "Denuncia no encontrada" });
    }
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Obtener todas las denuncias
export const getAllDenuncias = async (req, res) => {
  try {
    const denuncias = await DenunciaBuzon.findAll();
    return res.status(200).json(denuncias);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

