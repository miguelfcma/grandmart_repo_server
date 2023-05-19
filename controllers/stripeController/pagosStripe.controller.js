import Stripe from "stripe";
import { Pago } from "../../models/ordenesModel/PagosModel.js";
const stripe = new Stripe(
  "sk_test_51N3lEpIscKwQt1dmqfoVi1rN404FrHRQzwp9VFwD2nVUOzsPZVUqA2obVP2frQLCZz96d7i0vRm7XFirRtFb5DeB00rHg6zK3S"
);

export const checkout = async ({ id_card, amount, description, id_usuario, id_orden }) => {
  try {
    const payment = await stripe.paymentIntents.create({
      amount,
      currency: "MXN",
      description,
      payment_method: id_card,
      confirm: true,
    });

    if (payment.status !== "succeeded") {
      throw new Error("El pago no se ha procesado correctamente");
    } else {
      // Guardar los datos de pago en la tabla usando Sequelize
      const nuevoPago = await Pago.create({
        usuario_id: id_usuario,
        orden_id: id_orden,
        monto: amount,
        id_pago_stripe: payment.id,
        fecha_pago: new Date(),
      });

      // Mapear los estados de Stripe a sus equivalentes en español
      const estadosEnEspaniol = {
        requires_payment_method: "Pendiente",
        requires_confirmation: "Procesando",
        requires_action: "Procesando",
        processing: "Procesando",
        succeeded: "Procesado",
        canceled: "Cancelado",
        payment_intent_not_found: "Fallido",
      };

      // Actualizar el estado del pago basado en la respuesta de Stripe
      nuevoPago.estado = estadosEnEspaniol[payment.status] || "Desconocido";
      await nuevoPago.save();

      return payment; // Devuelve el resultado del pago
    }
  } catch (error) {
    throw new Error(error.message); // Lanza el error para ser capturado en crearOrden
  }
};

