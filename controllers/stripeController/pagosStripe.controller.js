import Stripe from "stripe";
import { Pago } from "../../models/ordenesModel/PagosModel.js";
const stripe = new Stripe(
  "sk_test_51N3lEpIscKwQt1dmqfoVi1rN404FrHRQzwp9VFwD2nVUOzsPZVUqA2obVP2frQLCZz96d7i0vRm7XFirRtFb5DeB00rHg6zK3S"
);

export const checkout = async (req, res) => {
  const { id, amount, description, id_usuario, id_orden } = req.body;
  try {
    const payment = await stripe.paymentIntents.create({
      amount,
      currency: "MXN",
      description,
      payment_method: id,
      confirm: true,
    });

    // Guardar los datos de pago en la tabla usando Sequelize
    const nuevoPago = await Pago.create({
      usuario_id: id_usuario, // suponiendo que tienes un usuario autenticado
      orden_id: id_orden, // suponiendo que tienes una orden relacionada
      monto: amount,
      id_pago_stripe: payment.id,
      fecha_pago: new Date(),
    });

    // Mapear los estados de Stripe a sus equivalentes en español
    const estadosEnEspañol = {
      requires_payment_method: "Pendiente",
      requires_confirmation: "Procesando",
      requires_action: "Procesando",
      processing: "Procesando",
      succeeded: "Procesado",
      canceled: "Cancelado",
      payment_intent_not_found: "Fallido",
    };

    // Actualizar el estado del pago basado en la respuesta de Stripe
    nuevoPago.estado = estadosEnEspañol[payment.status] || "Desconocido";
    await nuevoPago.save();

    console.log(payment);

    return res.status(200).json({ message: "Successful Payment" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: error.message });
  }
};