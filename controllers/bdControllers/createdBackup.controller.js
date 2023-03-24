import {
  DB_HOST,
  DB_USER,
  DB_PASSWORD,
  DB_NAME,
  DB_PORT,
} from "../../config.js"; // Importar constantes de configuración de la base de datos desde un archivo de configuración externo
import { exec } from "child_process"; // Importar la función exec desde el módulo child_process para ejecutar comandos del sistema operativo

import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import bcrypt from "bcryptjs";

export async function createBackup(req, res) {
  try {
    const { email, password } = req.body;
    // Buscar un usuario con el email recibido
    console.log(email+"  "+password)
    const usuario = await Usuario.findOne({
      where: { email },
    });
    // IF USUARIO == NULL
    if (!usuario) {
      return res
        .status(400)
        .json({ message: "Credenciales de inicio de sesión incorrectas" });
    }

    // Verificar la contraseña
    // Desencripta la contraseña y compara
    const contrasenaValida = bcrypt.compareSync(password, usuario.password);
    if (!contrasenaValida) {
      return res
        .status(400)
        .json({ message: "Credenciales de inicio de sesión incorrectas" });
    }
    const filename = "backup-grandmart" 
    let command = `"C:\\xampp\\mysql\\bin\\mysqldump" -h ${DB_HOST} -u ${DB_USER}`; // Comenzar a construir el comando para realizar una copia de seguridad de la base de datos utilizando mysqldump
    if (DB_PASSWORD) {
      command += ` -p${DB_PASSWORD}`; // Si se proporciona una contraseña para la base de datos, agregarla al comando
    }
    command += ` ${DB_NAME} > "C:\\backups_grandmart\\${filename}.sql"`; // Completar el comando especificando el nombre de la base de datos y la ruta donde se guardará la copia de seguridad
    exec(command, (error, stdout, stderr) => {
      // Ejecutar el comando utilizando la función exec
      if (error) {
        // Si ocurre un error al ejecutar el comando
        console.error(`exec error: ${error}`); // Registrar el error en la consola
        res.status(500).send(`Error: ${error}`); // Enviar una respuesta con un código de estado 500 y un mensaje de error
        return;
      }
      res.setHeader("Content-Type", "application/sql"); // Establecer el encabezado Content-Type de la respuesta como application/sql
      res.sendFile(`C:\\backups_grandmart\\${filename}.sql`); // Enviar el archivo de copia de seguridad como respuesta
    });
  } catch (error) {
    // Si ocurre un error en cualquier otro lugar del código
    console.error(error); // Registrar el error en la consola
    res.status(500).send(`Error: ${error}`); // Enviar una respuesta con un código de estado 500 y un mensaje de error
  }
}
