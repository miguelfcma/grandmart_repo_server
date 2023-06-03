import { ReviewServicio } from "../../models/serviciosModel/ReviewsServiciosModel.js";

// Crear una nueva review de un servicio
export const createReview = async (req, res) => {
  const { titulo, comentario, calificacion, id_servicio, id_usuario } =
    req.body;
  try {
    const newReview = await ReviewServicio.create({
      titulo,
      comentario,
      calificacion,
      id_servicio,
      id_usuario,
    });
    res.json(newReview);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Eliminar una review de un servicio por su id
export const deleteReviewById = async (req, res) => {
  const { id } = req.params;
  try {
    const deletedReview = await ReviewServicio.destroy({ where: { id } });
    if (deletedReview === 0) {
      return res.status(404).json({ message: "Review no encontrada" });
    }
    res.json({ message: "Review eliminada correctamente" });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Obtener todas las reviews de un servicio por su id
export const getReviewsByServiceId = async (req, res) => {
  const { id_servicio } = req.params;
  try {
    const reviews = await ReviewServicio.findAll({ where: { id_servicio } });
    res.json(reviews);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Actualizar una review de un servicio por su id
export const updateReviewById = async (req, res) => {
  const { id } = req.params;
  const { titulo, comentario, calificacion } = req.body;
  try {
    const [updatedRowsCount, updatedRows] = await ReviewServicio.update(
      { titulo, comentario, calificacion },
      { where: { id }, returning: true }
    );
    if (updatedRowsCount === 0) {
      return res.status(404).json({ message: "Review no encontrada" });
    }
    res.json(updatedRows[0]);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Obtener el promedio de calificación de un servicio por su id
export const getAvgRatingByServiceId = async (req, res) => {
  const { id_servicio } = req.params;
  try {
    const avgRating = await ReviewServicio.findOne({
      attributes: [
        [sequelize.fn("AVG", sequelize.col("calificacion")), "avgRating"],
      ],
      where: { id_servicio },
    });
    res.json(avgRating);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};
