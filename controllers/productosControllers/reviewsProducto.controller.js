import { ReviewProducto } from "../../models/productosModel/ReviewsProductosModel.js";
import { Producto } from "../../models/productosModel/ProductoModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import sequelize from "sequelize";

// Crear una nueva review de un producto
export const createReview = async (req, res) => {
  const { titulo, comentario, calificacion, id_producto, id_usuario } =
    req.body;
  try {
    // Verificar si el usuario ya ha dejado una revisión para el producto
    const existingReview = await ReviewProducto.findOne({
      where: { id_usuario, id_producto },
    });
    if (existingReview) {
      return res
        .status(400)
        .json({
          message: "El usuario ya ha dejado una revisión para este producto",
        });
    }

    // Crear una nueva revisión
    const newReview = await ReviewProducto.create({
      titulo,
      comentario,
      calificacion,
      id_producto,
      id_usuario,
    });
    res
      .status(201)
      .json({
        message: "La revisión ha sido creada correctamente",
        review: newReview,
      });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Error en el servidor" });
  }
};

// Eliminar una review de un producto por su id
export const deleteReviewById = async (req, res) => {
  const { id } = req.params;
  try {
    const deletedReview = await ReviewProducto.destroy({ where: { id } });
    if (deletedReview === 0) {
      return res.status(404).json({ message: "Review no encontrada" });
    }
    res
      .status(200)
      .json({ message: "La revisión ha sido eliminada correctamente" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Error en el servidor" });
  }
};

export const getReviewsByProductId = async (req, res) => {
  const { id_producto } = req.params;
  try {
    const reviews = await ReviewProducto.findAll({ where: { id_producto } });
    if (reviews.length === 0) {
      res
        .status(404)
        .json({ message: "No se encontraron revisiones para este producto" });
    } else {
      res
        .status(200)
        .json({
          message: "Las revisiones han sido obtenidas correctamente",
          reviews,
        });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Error en el servidor" });
  }
};

// Actualizar una review de un producto por su id
export const updateReviewById = async (req, res) => {
  const { id } = req.params;
  const { titulo, comentario, calificacion } = req.body;
  try {
    const [updatedRowsCount, updatedRows] = await ReviewProducto.update(
      { titulo, comentario, calificacion },
      { where: { id }, returning: true }
    );
    if (updatedRowsCount === 0) {
      return res.status(404).json({ message: "Review no encontrada" });
    }
    res
      .status(200)
      .json({
        message: "La revisión ha sido actualizada correctamente",
        review: updatedRows[0],
      });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Error en el servidor" });
  }
};

// Obtener el promedio de calificación de un producto por su id
export const getAvgRatingByProductId = async (req, res) => {
  const { id_producto } = req.params;
  try {
    const avgRating = await ReviewProducto.findOne({
      attributes: [
        [sequelize.fn("AVG", sequelize.col("calificacion")), "avgRating"],
      ],
      where: { id_producto },
    });
    if (avgRating && avgRating.dataValues.avgRating) {
      res.json(avgRating);
    } else {
      res.status(404).json({ message: "No hay reviews para este producto" });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Error en el servidor" });
  }
};

// Obtener una review específica por id_usuario e id_producto
export const getReviewByUserAndProduct = async (req, res) => {
  const { id_usuario, id_producto } = req.params;
  try {
    const review = await ReviewProducto.findOne({
      where: { id_usuario, id_producto },
    });
    if (review) {
      res.status(200).json({ message: "Review encontrada", review });
    } else {
      res.status(404).json({ message: "Review no encontrada" });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Error en el servidor" });
  }
};

// Obtener productos del usuario con preguntas asociadas
export const getProductosConReviewsByUsuarioId = async (req, res) => {
  try {
    const { id_usuario } = req.params;

    // Buscar productos del usuario por su ID de usuario
    const productos = await Producto.findAll({ where: { id_usuario } });

    if (productos.length === 0) {
      return res
        .status(404)
        .json({
          message: "No se encontraron productos para el usuario especificado",
        });
    }

    const productosConReviews = await Promise.all(
      productos.map(async (producto) => {
        // Buscar preguntas asociadas al producto
        const reviews = await ReviewProducto.findAll({
          where: { id_producto: producto.id },
        });

        if (reviews.length > 0) {
          // Si el producto tiene preguntas asociadas, agregarlas como propiedad al objeto de producto
          return { producto: producto.toJSON(), reviews };
        } else {
          // Si el producto no tiene preguntas asociadas, devolver null
          return null;
        }
      })
    );

    // Filtrar los productos nulos (que no tienen preguntas asociadas)
    const productosConReviewsFiltrados = productosConReviews.filter(
      (producto) => producto !== null
    );

    res.status(200).json(productosConReviewsFiltrados);
  } catch (error) {
    console.error(error);
    res.status(500).send("Error interno del servidor");
  }
};


export const getTodosProductosConReviews= async (req, res) => {
  try {

    // Buscar productos del usuario por su ID de usuario
    const productos = await Producto.findAll( );

    if (productos.length === 0) {
      return res
        .status(404)
        .json({
          message: "No se encontraron productos",
        });
    }

    const productosConReviews = await Promise.all(
      productos.map(async (producto) => {
        // Buscar preguntas asociadas al producto
        const reviews = await ReviewProducto.findAll({
          where: { id_producto: producto.id },
        });

        if (reviews.length > 0) {
          // Si el producto tiene preguntas asociadas, agregarlas como propiedad al objeto de producto
          return { producto: producto.toJSON(), reviews };
        } else {
          // Si el producto no tiene preguntas asociadas, devolver null
          return null;
        }
      })
    );

    // Filtrar los productos nulos (que no tienen preguntas asociadas)
    const productosConReviewsFiltrados = productosConReviews.filter(
      (producto) => producto !== null
    );

    res.status(200).json(productosConReviewsFiltrados);
  } catch (error) {
    console.error(error);
    res.status(500).send("Error interno del servidor");
  }
};
