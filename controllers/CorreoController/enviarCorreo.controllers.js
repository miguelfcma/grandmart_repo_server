import nodemailer from "nodemailer";

export const enviarCorreo = async (email, subject, header, contenido) => {
  try {
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
      subject: subject,
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
          ${header}
          </div>
          <div>
          ${contenido}
              </div>
          <div class="logo-container">
            <img src="https://firebasestorage.googleapis.com/v0/b/grandmart-51065.appspot.com/o/src%2Flogo.png?alt=media&token=6c393680-5c89-4708-a0d3-f8ffcb0fc379" alt="Logo de GRANDMART" />
          </div>
        </div>
      </body>
      </html>
      
      
        `,
    });

    console.log("Correo electrónico enviado: %s", info.messageId);
  } catch (error) {
    console.log(error);
  }
};
