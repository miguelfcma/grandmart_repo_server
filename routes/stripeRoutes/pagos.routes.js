import { Router } from "express";
const router = Router();

import { checkout } from "../../controllers/stripeController/pagosStripe.controller.js";

router.post("/stripe/pagos", checkout);

export default router;
