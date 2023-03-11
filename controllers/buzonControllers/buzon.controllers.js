import { pool } from "../../database/db.js";

export const getProductos = async (req, res) => {
  try {
    const [result] = await pool.query("SELECT * FROM categorias");
    if (result.length === 0) {
      return res.status(404).json({ message: "No hay productos disponibles" });
    }
    res.json(result);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const getProducto = async (req, res) => {
  try {
    const [result] = await pool.query(
      "SELECT * FROM productos WHERE id_producto = ?",
      [req.params.id]
    );
    if (result.length === 0) {
      return res.status(404).json({ message: "Producto no encontrado" });
    }
    res.json(result[0]);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const createProducto = async (req, res) => {
  try {
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
    const result = await pool.query(
      "INSERT INTO productos(nombre, precio, stock, descripcion, marca, modelo, color, estado, categorias_id_categoria, usuarios_id_usuario) VALUES(?,?,?,?,?,?,?,?,?,?)",
      [
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
      ]
    );

    res.json({
      nombre,
    });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const updateProducto = async (req, res) => {
  try {
    const [result] = await pool.query(
      "UPDATE productos SET ? WHERE id_producto = ?",
      [req.body, req.params.id]
    );
    res.json(result);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const deleteProducto = async (req, res) => {
  try {
    const [result] = await pool.query(
      "DELETE FROM productos WHERE id_producto = ?",
      [req.params.id]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Producto no econtrado" });
    }

    return res.sendStatus(204);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};
