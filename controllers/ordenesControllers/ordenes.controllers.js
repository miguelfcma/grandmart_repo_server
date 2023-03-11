import { pool } from "../../database/db.js";

export const getProductos = (req, res) => {
  res.send("Obteniendo productos");
};

export const getProducto = (req, res) => {
  res.send("Obteniendo un producto");
};

export const createProducto = async (req, res) => {
  
  res.send("Creando Tarea")
};

export const updateProducto = (req, res) => {
  res.send("Actualizando un producto");
};

export const deleteProducto = (req, res) => {
  res.send("Eliminando un producto");
};
