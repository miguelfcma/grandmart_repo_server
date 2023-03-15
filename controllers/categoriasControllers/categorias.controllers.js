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
    console.error(error);
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
    console.error(error);
    return res.status(500).json({ message: error.message });
  }
};

export const createCategoria = async (req, res) => {
  const { nombre, id_parent } = req.body;

  try {
    const existingCategoria = await Categoria.findOne({ where: { nombre } });

    if (existingCategoria) {
      return res.status(400).json({ message: "La categoría ya existe" });
    }
    if (id_parent) {
      const existingCategoriaPadre = await Categoria.findOne({
        where: { id: id_parent},
      });

      if (!existingCategoriaPadre) {
        return res
          .status(400)
          .json({ message: "La categoria padre no existe" });
      }
    }
    const newCategoria = await Categoria.create({ nombre, id_parent });

    res.status(201).json({ message: "Categoría creada correctamente" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};

export const updateCategoria = async (req, res) => {
  const { nombre, id_parent } = req.body;
  try {
    // Verificar existencia
    const categoria = await Categoria.findByPk(req.params.id);
    console.log(req.params.id);
    console.log(nombre);
    console.log(id_parent);
    if (!categoria) {
      return res.status(404).json({ message: "La categoría no existe" });
    }

    // Verificar si la categoría no puede ser hija de sí misma
    if (id_parent && id_parent === req.params.id) {
      return res
        .status(400)
        .json({ message: "La categoría no puede ser su propia hija" });
    }

    // Verificar si la categoría no puede ser hija de una de sus hijas
    if (id_parent) {
      const categoriaPadre = await Categoria.findByPk(id_parent);
      if (categoriaPadre && categoriaPadre.id_parent === categoria.id) {
        return res.status(400).json({
          message: "La categoría no puede ser hija de una de sus hijas",
        });
      }
    }

    // Actualizar la categoría con los nuevos valores
    const updateCategoria = await categoria.update({
      nombre,
      id_parent,
    });

    // Enviar una respuesta exitosa
    res.status(200).json({ message: "Categoría actualizada correctamente" });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: error.message });
  }
};

export const deleteCategoria = async (req, res) => {
  const { id } = req.params;

  try {
    // Verifica si la categoría existe
    const categoria = await Categoria.findByPk(id);
    if (!categoria) {
      return res.status(404).json({ message: "No se encontró la categoría" });
    }

    // Verifica si la categoría tiene subcategorías o es el padre de otras categorías
    const categoriasHijas = await Categoria.findAll({
      where: { id_parent: id },
    });
    if (categoriasHijas.length > 0) {
      return res.status(400).json({
        message:
          "No se puede eliminar la categoría porque " +
          (categoriasHijas[0].id_parent === id ? "es el padre" : "tiene") +
          " subcategorías",
      });
    }

    // Elimina la categoría
    await Categoria.destroy({
      where: { id },
    });
    
    // Envía una respuesta HTTP vacía con un estado de "sin contenido"
    res.status(204).send();

  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: error.message });
  }
};

