import { CuentaBancaria } from "../../models/usuariosModel/CuentaBancariaModel.js";

// Crear una nueva cuenta bancaria
export const crearCuentaBancaria = async (req, res) => {
  try {
    const { usuario_id, nombre_titular, numero_cuenta, banco } = req.body;
    console.log(req.body);

    // Verificar si el usuario ya tiene una cuenta bancaria registrada
    const cuentaBancariaExistente = await CuentaBancaria.findOne({
      where: { usuario_id },
    });
    if (cuentaBancariaExistente) {
      return res
        .status(400)
        .json({
          error: "Este usuario ya tiene una cuenta bancaria registrada.",
        });
    }

    const cuentaBancaria = await CuentaBancaria.create({
      usuario_id,
      nombre_titular,
      numero_cuenta,
      banco,
    });
    res
      .status(201)
      .json({ message: "Cuenta bancaria creada exitosamente", cuentaBancaria });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Obtener una cuenta bancaria por su ID de usuario
export const obtenerCuentaBancariaPorIdUsuario = async (req, res) => {
  const { id_usuario } = req.params;
  try {
    const cuentaBancaria = await CuentaBancaria.findOne({
      where: { usuario_id: id_usuario },
    });
    if (!cuentaBancaria) {
      res.status(404).json({ message: "Cuenta bancaria no encontrada" });
      return;
    }
    res.status(200).json(cuentaBancaria);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Actualizar una cuenta bancaria
export const actualizarCuentaBancaria = async (req, res) => {
  try {
    const { id_usuario } = req.params;
    const cuentaBancaria = await CuentaBancaria.findOne({
      where: { usuario_id: id_usuario },
    });
    if (!cuentaBancaria) {
      res.status(404).json({ message: "Cuenta bancaria no encontrada" });
      return;
    }
    const { nombre_titular, numero_cuenta, banco } = req.body;
    await cuentaBancaria.update({
      nombre_titular,
      numero_cuenta,
      banco,
    });
    res.status(200).json({
      message: "Cuenta bancaria actualizada exitosamente",
      cuentaBancaria,
    });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Eliminar una cuenta bancaria
export const eliminarCuentaBancaria = async (req, res) => {
  try {
    const { id_usuario } = req.params;
    const cuentaBancaria = await CuentaBancaria.findOne({
      where: { usuario_id: id_usuario },
    });
    if (!cuentaBancaria) {
      res.status(404).json({ message: "Cuenta bancaria no encontrada" });
      return;
    }
    await cuentaBancaria.destroy();
    res.status(200).json({ message: "Cuenta bancaria eliminada exitosamente" });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};
