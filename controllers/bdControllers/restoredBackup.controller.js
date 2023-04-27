import { Sequelize } from "sequelize";
import { DB_HOST, DB_USER, DB_PASSWORD, DB_NAME } from "../../config.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import bcrypt from "bcryptjs";
import fs from "fs";

import path from "path";
// Listar los nombres de los archivos SQL en la carpeta de backups
export function listBackupFiles(req, res) {
  try {
    const backupDir = path.join(process.cwd(), "backups-database");
    // Leer el contenido de la carpeta de backups
    fs.readdir(backupDir, (err, files) => {
      if (err) {
        console.error(err);
        return res.status(500).send("Error al leer la carpeta de backups.");
      }

      // Filtrar los archivos que tienen extensión SQL
      const sqlFiles = files.filter((file) => path.extname(file) === ".sql");

      res.status(200).json(sqlFiles);
    });
  } catch (error) {
    console.error(error);
    return res.status(500).send("Error al listar los archivos de backups.");
  }
}

// Eliminar un archivo SQL en la carpeta de backups
export async function deleteBackupFile(req, res) {
  try {
    const { email, password } = req.body;

    // Buscar un usuario con el email recibido
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

    const backupDir = path.join(process.cwd(), "backups-database");
    const { filename } = req.params;
    console.log(filename);
    // Verificar si el archivo existe
    const filePath = path.join(backupDir, `${filename}`);
    if (!fs.existsSync(filePath)) {
      return res.status(404).send("El archivo no existe.");
    }

    // Eliminar el archivo
    fs.unlink(filePath, (err) => {
      if (err) {
        console.error(err);
        return res.status(500).send("Error al eliminar el archivo.");
      }

      res.status(200).send("Archivo eliminado exitosamente.");
    });
  } catch (error) {
    console.error(error);
    return res.status(500).send("Error al eliminar el archivo de backup.");
  }
}

export async function restoreBackup(req, res) {
  try {
    const { email, password } = req.body;

    // Buscar un usuario con el email recibido
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

    console.log("Iniciando ejecución de archivo SQL...");
    const filename = req.params.filename;
    const sequelize = new Sequelize(DB_NAME, DB_USER, DB_PASSWORD, {
      host: DB_HOST,
      dialect: "mysql",
      define: {
        charset: "utf8mb4",
        collate: "utf8mb4_unicode_ci",
      },
      dialectOptions: {
        charset: "utf8mb4",
        collate: "utf8mb4_unicode_ci",
        useUTC: false,
        timezone: "America/Mexico_City",
        multipleStatements: true,
        flags: {
          // Desactivar las notas SQL
          raw: true,
        },
      },
    });

    await sequelize.authenticate(); // Verificar la conexión a la base de datos
    console.log("Conexión a la base de datos establecida.");

    const sqlFilePath = `backups-database/${filename}`;

    // Leer el contenido del archivo SQL
    const sqlContent = fs.readFileSync(sqlFilePath, "utf8");

    // Desactivar la verificación de claves únicas y foráneas
    await sequelize.query("SET unique_checks = 0;");
    await sequelize.query("SET foreign_key_checks = 0;");

    // Establecer el modo SQL para evitar la creación automática de valores en cero
    await sequelize.query("SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';");

    // Ejecutar el contenido del archivo SQL
    await sequelize.query(sqlContent, {
      type: sequelize.QueryTypes.RAW,
    });

    console.log("Archivo SQL ejecutado exitosamente.");

    // Activar nuevamente la verificación de claves únicas y foráneas
    await sequelize.query("SET unique_checks = 1;");
    await sequelize.query("SET foreign_key_checks = 1;");

    res.status(200).send("Archivo SQL ejecutado exitosamente.");

    await sequelize.close();
  } catch (error) {
    console.error(error);
    res.status(500).send(`Error: ${error}`);
  }
}
export async function downloadBackupFile(req, res) {
  const { email, password } = req.body;
  console.log(email, password, "...............................");
  // Buscar un usuario con el email recibido
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

  try {
    const backupDir = path.join(process.cwd(), "backups-database");
    const { filename } = req.params;

    // Verificar si el archivo existe
    const filePath = path.join(backupDir, `${filename}`);
    if (!fs.existsSync(filePath)) {
      return res.status(404).send("El archivo no existe.");
    }

    // Descargar el archivo
    res.download(filePath);
  } catch (error) {
    console.error(error);
    return res.status(500).send("Error al descargar el archivo de backup.");
  }
}
