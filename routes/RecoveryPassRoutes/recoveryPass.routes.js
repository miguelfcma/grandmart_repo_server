import { Router } from "express";

import { sendEmail } from "../../controllers/RecoveryPassController/recoveryPass.controller.js";

const router = Router();

router.post("/send-email", sendEmail);


export default router;