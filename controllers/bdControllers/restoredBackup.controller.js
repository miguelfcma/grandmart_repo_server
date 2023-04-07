import { DB_HOST, DB_USER, DB_PASSWORD, DB_NAME } from "../../config.js";
import { exec } from "child_process";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import bcrypt from "bcryptjs";
import fs from "fs";
import multer from "multer"; // Importa el módulo multer para manejar archivos en las solicitudes HTTP

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'C:\\backups_grandmart\\') // Especifica la carpeta donde se guardarán los archivos
  },
  filename: (req, file, cb) => {
    cb(null, file.originalname) // Utiliza el nombre original del archivo
  }
});

const upload = multer({ storage }).single('backupFile'); // Crea el middleware de multer para manejar el archivo

export async function restoreBackup(req, res) {
  try {
    const { email, password } = req.query;
    const usuario = await Usuario.findOne({
      where: { email },
    });
    const contrasenaValida = bcrypt.compareSync(password, usuario.password);
    if (!usuario || !contrasenaValida) {
      return res
        .status(400)
        .json({ message: "Credenciales de inicio de sesión incorrectas" });
    }
    upload(req, res, (err) => {
      if (err instanceof multer.MulterError) {
        return res.status(500).json({ message: "Error al subir el archivo" });
      } else if (err) {
        return res.status(500).json({ message: "Error en el servidor" });
      }
      const filePath = req.file.path; // Obtiene la ruta del archivo subido desde el objeto req.file
      const sql = fs.readFileSync(filePath, "utf8");
      let command = `"C:\\xampp\\mysql\\bin\\mysql" -h ${DB_HOST} -u ${DB_USER}`;
      if (DB_PASSWORD) {
        command += ` -p${DB_PASSWORD}`;
      }
      command += ` ${DB_NAME} < "${filePath}"`;
      
      exec(command, (error, stdout, stderr) => {
        if (error) {
          console.error(`exec error: ${error}`);
          res.status(500).send(`Error: ${error}`);
          return;
        }
        res.status(200).json({ message: "Base de datos restaurada con éxito" });
      });
    });
  } catch (error) {
    console.error(error);
    res.status(500).send(`Error: ${error}`);
  }
}
