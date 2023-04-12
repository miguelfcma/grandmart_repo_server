import express from "express";
import {
  createReview,
  deleteReviewById,
  getReviewsByProductId,
  updateReviewById,
  getAvgRatingByProductId,
} from "../../controllers/productosControllers/reviewsProducto.controller.js";

const router = express.Router();
// Crear una nueva review de un producto
router.post("/producto-review/", createReview);

// Eliminar una review de un producto por su id
router.delete("/producto-review/:id", deleteReviewById);

// Obtener todas las reviews de un producto por su id
router.get("/producto-review/:id_producto", getReviewsByProductId);

// Actualizar una review de un producto por su id
router.put("/producto-review/:id", updateReviewById);

// Obtener el promedio de calificación de un producto por su id
router.get("/producto-review/:id_producto/avg-rating", getAvgRatingByProductId);

export default router;