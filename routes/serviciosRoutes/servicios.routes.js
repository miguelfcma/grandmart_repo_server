import { Router } from "express";
import { getServicios, getServicio, createServicio, updateServicio, deleteServicio } from "../../controllers/serviciosControllers/servicios.controllers.js";

const router = Router();

router.get("/servicios", getServicios);

router.get("/servicios/:id", getServicio);

router.post("/servicios", createServicio);

router.put("/servicios/:id", updateServicio);

router.delete("/servicios/:id", deleteServicio);

export default router;
