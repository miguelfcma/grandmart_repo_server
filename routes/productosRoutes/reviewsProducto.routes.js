import express from "express";
import {
  createReview,
  deleteReviewById,
  getReviewsByProductId,
  updateReviewById,
  getAvgRatingByProductId,
  getProductosConReviewsByUsuarioId,
  getTodosProductosConReviews,
  getReviewByProductIdAndUserId,
} from "../../controllers/productosControllers/reviewsProducto.controller.js";

const router = express.Router();

// Ruta para crear una nueva revisión de un producto
router.post("/producto-review/", createReview);

// Ruta para eliminar una revisión de un producto por su ID
router.delete("/producto-review/:id", deleteReviewById);

// Ruta para obtener todas las revisiones de un producto por su ID
router.get("/producto-review/:id_producto", getReviewsByProductId);

// Ruta para actualizar una revisión de un producto por su ID
router.put("/producto-review/:id", updateReviewById);

// Ruta para obtener el promedio de calificación de un producto por su ID
router.get("/producto-review/:id_producto/avg-rating", getAvgRatingByProductId);

// Ruta para obtener todos los productos con revisiones de un usuario
router.get("/productos-reviews/:id_usuario", getProductosConReviewsByUsuarioId);

// Ruta para obtener todos los productos con revisiones
router.get("/productos-reviews-todas/", getTodosProductosConReviews);

// Ruta para obtener la revisión de un producto por ID de usuario y ID de producto
router.get(
  "/producto-review/user/:id_usuario/product/:id_producto",
  getReviewByProductIdAndUserId
);

export default router;
