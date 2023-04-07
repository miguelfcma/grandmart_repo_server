import { Router } from "express";
import {
  createReview,
  deleteReviewById,
  getReviewsByServiceId,
  updateReviewById,
  getAvgRatingByServiceId,
} from "../../controllers/serviciosControllers/reviewsServicios.controllers.js";

const router = Router();

// POST /api/reviews - create a new review
router.post("servicio-review/", createReview);

// DELETE /api/reviews/:id - delete a review by its id
router.delete("servicio-review/:id", deleteReviewById);

// GET /api/reviews/service/:id_servicio - get all reviews for a service by its id
router.get("servicio-review/service/:id_servicio", getReviewsByServiceId);

// PUT /api/reviews/:id - update a review by its id
router.put("servicio-review/:id", updateReviewById);

// GET /api/reviews/service/:id_servicio/avg-rating - get the average rating for a service by its id
router.get(
  "servicio-review/service/:id_servicio/avg-rating",
  getAvgRatingByServiceId
);

export default router;
