import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import bcrypt from "bcryptjs";
import nodemailer from "nodemailer";

function generatePassword() {
  const length = 8;
  const chars =
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  let password = "";

  while (true) {
    for (let i = 0; i < length; i++) {
      const randomIndex = Math.floor(Math.random() * chars.length);
      password += chars[randomIndex];
    }

    // Verificar si la contraseña cumple con todas las condiciones
    const meetsLengthRequirement = password.length >= 7;
    const hasNumber = /\d/.test(password);
    const hasNoSpaces = !password.includes(" ");

    if (meetsLengthRequirement && hasNumber && hasNoSpaces) {
      break;
    }

    password = ""; // Restablecer la contraseña si no cumple con las condiciones
  }

  return password;
}

export const sendEmail = async (req, res) => {
  const { email } = req.body;
  console.log("correo:", email);
  try {
    // Buscar si el usuario ya existe
    const existenciaUsuario = await Usuario.findOne({
      where: { email: email },
    });

    if (!existenciaUsuario) {
      res.status(404).json({ message: "Correo inexistente" });
    } else {
      // Si el usuario existe, crear una nueva contraseña aleatoria
      const newPassword = generatePassword();
      console.log("contraseña: " + newPassword);
      const hashedPassword = bcrypt.hashSync(newPassword, 10);
      const updateUsuario = await existenciaUsuario.update({
        password: hashedPassword,
      });

      /* Crear un transportador reutilizable usando SMTP
      let transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        port: 587,
        secure: false,
        auth: {
          user: "grandmarthtd@gmail.com",
          pass: "vvzasstdylohpkyn",
        },
      });


      let info = await transporter.sendMail({
        from: '"Grandmart" <grandmarthtd@gmail.com>',
        to: email, 
        subject: "Recuperación de contraseña GRANDMART",
        text: "Contenido del correo electrónico en texto plano",
        html: `<p>Correo: ${email}</p><br><p>Tu nueva contraseña es: ${newPassword}</p>`,
      });

      console.log("Correo electrónico enviado: %s", info.messageId);
      */
      res.status(200).send("Correo electrónico enviado correctamente");
    }
  } catch (error) {
    console.error(error);
    res.status(500).send("Ha ocurrido un error en el servidor");
  }
};
