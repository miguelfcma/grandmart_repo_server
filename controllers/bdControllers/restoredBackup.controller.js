import { Sequelize } from "sequelize";
import { DB_HOST, DB_USER, DB_PASSWORD, DB_NAME } from "../../config.js";
import fs from "fs";

export async function restoreBackup(req, res) {
  try {
    console.log("Iniciando ejecución de archivo SQL...");

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

    const filename = "backup-grandmart";
    const sqlFilePath = `${filename}.sql`;

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
