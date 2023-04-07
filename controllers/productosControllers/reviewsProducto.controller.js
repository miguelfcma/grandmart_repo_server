import { ReviewProducto } from '../../models/productosModel/ReviewsProductosModel.js';

// Crear una nueva review de un producto
export const createReview = async (req, res) => {
  const { titulo, comentario, calificacion, id_producto, id_usuario } = req.body;
  try {
    const newReview = await ReviewProducto.create({ titulo, comentario, calificacion, id_producto, id_usuario });
    res.json(newReview);
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: 'Error en el servidor' });
  }
};

// Eliminar una review de un producto por su id
export const deleteReviewById = async (req, res) => {
  const { id } = req.params;
  try {
    const deletedReview = await ReviewProducto.destroy({ where: { id } });
    if (deletedReview === 0) {
      return res.status(404).json({ message: 'Review no encontrada' });
    }
    res.json({ message: 'Review eliminada correctamente' });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: 'Error en el servidor' });
  }
};

// Obtener todas las reviews de un producto por su id
export const getReviewsByProductId = async (req, res) => {
  const { id_producto } = req.params;
  try {
    const reviews = await ReviewProducto.findAll({ where: { id_producto } });
    res.json(reviews);
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: 'Error en el servidor' });
  }
};

// Actualizar una review de un producto por su id
export const updateReviewById = async (req, res) => {
  const { id } = req.params;
  const { titulo, comentario, calificacion } = req.body;
  try {
    const [updatedRowsCount, updatedRows] = await ReviewProducto.update({ titulo, comentario, calificacion }, { where: { id }, returning: true });
    if (updatedRowsCount === 0) {
      return res.status(404).json({ message: 'Review no encontrada' });
    }
    res.json(updatedRows[0]);
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: 'Error en el servidor' });
  }
};

// Obtener el promedio de calificación de un producto por su id
export const getAvgRatingByProductId = async (req, res) => {
    const { id_producto } = req.params;
    try {
      const avgRating = await ReviewProducto.findOne({
        attributes: [[sequelize.fn('AVG', sequelize.col('calificacion')), 'avgRating']],
        where: { id_producto },
      });
      res.json(avgRating);
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: 'Error en el servidor' });
    }
  };