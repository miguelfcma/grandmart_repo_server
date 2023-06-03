import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import bcrypt from "bcryptjs";
import nodemailer from "nodemailer";

function generarContrasena() {
  const longitud = 8;
  const caracteres =
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  let contrasena = "";

  while (true) {
    for (let i = 0; i < longitud; i++) {
      const indiceAleatorio = Math.floor(Math.random() * caracteres.length);
      contrasena += caracteres[indiceAleatorio];
    }

    // Verificar si la contrasena cumple con todas las condiciones
    const cumpleRequisitoLongitud = contrasena.length >= 7;
    const tieneNumero = /\d/.test(contrasena);
    const noContieneEspacios = !contrasena.includes(" ");

    if (cumpleRequisitoLongitud && tieneNumero && noContieneEspacios) {
      break;
    }

    contrasena = ""; // Restablecer la contrasena si no cumple con las condiciones
  }

  return contrasena;
}

export const enviarCorreo = async (req, res) => {
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
      // Si el usuario existe, crear una nueva contrasena aleatoria
      const nuevaContrasena = generarContrasena();
      console.log("contrasena: " + nuevaContrasena);
      const contraseñaEncriptada = bcrypt.hashSync(nuevaContrasena, 10);
      const actualizarUsuario = await existenciaUsuario.update({
        password: contraseñaEncriptada,
      });

      // Crear un transportador reutilizable usando SMTP
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
        from: "Grandmart <grandmarthtd@gmail.com>",
        to: email,
        subject: "Recuperación de contraseña GRANDMART",
        text: "Contenido del correo electrónico en texto plano",
        html: `
        <!DOCTYPE html>
        <html>
        <head>
          <title>Recuperación de contraseña GRANDMART</title>
          <style>
            .card {
              background-color: #f1f1f1;
              border-radius: 10px;
              box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
              width: 300px;
              margin: 0 auto;
              padding: 20px;
              text-align: center;
            }
            .header {
              background-color: #1c6bc3;
              border-radius: 10px;
              color: #fff;
              font-size: 24px;
              padding: 10px;
              margin-bottom: 20px;
            }
            .card p {
              margin: 10px 0;
            }
            .card .logo-container {
              display: flex;
              justify-content: center;
              align-items: center;
              margin-top: 20px;
            }
            .card .logo-container img {
              max-width: 100%;
              max-height: 100px;
            }
          </style>
        </head>
        <body>
          <div class="card">
            <div class="header">
              Recuperación de contraseña GRANDMART
            </div>
            <div>
              <p>Correo: ${email}</p>
              <p>Tu nueva contraseña es: <strong>${nuevaContrasena}</strong></p>
            </div>
            <div class="logo-container">
              <img src="https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/src%2Flogo.png?alt=media&token=6c393680-5c89-4708-a0d3-f8ffcb0fc379" alt="Logo de GRANDMART" />
            </div>
          </div>
        </body>
        </html>
        
        
          `,
      });

      console.log("Correo electronico enviado: %s", info.messageId);

      res.status(200).send("Correo electronico enviado correctamente");
    }
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};
