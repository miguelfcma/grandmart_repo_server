import Stripe from 'stripe';
const stripe = new Stripe('sk_test_51N3lEpIscKwQt1dmqfoVi1rN404FrHRQzwp9VFwD2nVUOzsPZVUqA2obVP2frQLCZz96d7i0vRm7XFirRtFb5DeB00rHg6zK3S');

export const checkout = async (req, res) => {
  const { id, amount, description } = req.body;
  try {
    const payment = await stripe.paymentIntents.create({
      amount,
      currency: "MXN",
      description,
      payment_method: id,
      confirm: true, //confirm the payment at the same time
    });

    console.log(payment);

    return res.status(200).json({ message: "Successful Payment" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: error.message });
  }
};
