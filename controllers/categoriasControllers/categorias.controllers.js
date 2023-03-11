import { Categoria } from "../../models/categoriasModel/CategoriaModel.js";

export const getCategoria = async (req, res) => {
  try {
    const categoria = await Categoria.findByPk(req.params.id);
    //Verificación de existencia
    if (!categoria) {
      return res.status(404).json({ message: "Categoria no encontrada" });
    }
    res.json(categoria);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const getCategorias = async (req, res) => {
  try {
    const categorias = await Categoria.findAll();
    //Validación de existencia
    if (categorias.length === 0) {
      return res.status(404).json({ message: "No se encontraron categorias" });
    }
    res.status(200).json(categorias);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const createCategoria = async (req, res) => {
  const { nombre, id_parent } = req.body;
  try {
    // Buscar si la categoría ya existe
    const existingCategoria = await Categoria.findOne({
      where: { nombre: nombre },
    });

    // Si la categoría no existe, crear una nueva
    if (!existingCategoria) {
      const newCategoria = await Categoria.create({
        nombre,
        id_parent,
      });
      res.status(200).json(newCategoria);
    } else {
      // Si la categoría ya existe, devolver un mensaje de error
      return res.status(400).json({ message: "La categoría ya existe" });
    }
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const updateCategoria = async (req, res) => {
  const { nombre, id_parent } = req.body; // Obtiene los nuevos valores desde el cuerpo de la solicitud
  try {
    //Verifica existencia
    const categoria = await Categoria.findByPk(req.params.id);
    if (!categoria) {
      return res.status(404).json({ message: "No se encontró la categoría" });
    }
    // Actualiza la categoría con los nuevos valores
    const updateCategoria = await categoria.update({
      nombre,
      id_parent,
    });

    // Envía una respuesta exitosa
    res
      .status(200)
      .json(updateCategoria,{ message: "Categoría actualizada correctamente" });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const deleteCategoria = async (req, res) => {
  try {
    const categoria = await Categoria.findByPk(req.params.id);
    //Verifica existencia
    if (!categoria) {
      return res.status(404).json({ message: "No se encontró la categoría" });
    }
    //realiza la eliminacion
    await categoria.destroy();
    res.status(200).json({ message: "La categoría fue eliminada con éxito" });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};
