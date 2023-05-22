import { CuentaBancaria } from "../../models/usuariosModel/CuentaBancariaModel.js";

// Crear una nueva cuenta bancaria
export const crearCuentaBancaria = async (req, res) => {
  try {
    const { usuario_id, nombre_titular, numero_cuenta, banco } = req.body;
    const cuentaBancaria = await CuentaBancaria.create({
      usuario_id,
      nombre_titular,
      numero_cuenta,
      banco,
    });
    res.status(200).json({ message: "Cuenta bancaria creada exitosamente", cuentaBancaria });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al crear la cuenta bancaria" });
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
    console.error(error);
    res.status(500).json({ message: "Error al obtener la cuenta bancaria" });
  }
};

// Actualizar una cuenta bancaria
export const actualizarCuentaBancaria = async (req, res) => {
    try {
        const { id_usuario } = req.params;
      const cuentaBancaria = await CuentaBancaria.findOne({ where: { usuario_id: id_usuario } });
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
      res.status(200).json({ message: "Cuenta bancaria actualizada exitosamente", cuentaBancaria });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Error al actualizar la cuenta bancaria" });
    }
  };
  
  export const eliminarCuentaBancaria = async (req, res) => {
    try {
        const { id_usuario } = req.params;
      const cuentaBancaria = await CuentaBancaria.findOne({ where: { usuario_id: id_usuario } });
      if (!cuentaBancaria) {
        res.status(404).json({ message: "Cuenta bancaria no encontrada" });
        return;
      }
      await cuentaBancaria.destroy();
      res.status(200).json({ message: "Cuenta bancaria eliminada exitosamente" });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Error al eliminar la cuenta bancaria" });
    }
  };
  