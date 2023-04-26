import { Sequelize } from "sequelize";
import { DB_HOST, DB_USER, DB_PASSWORD, DB_NAME } from "../../config.js";
import fs from "fs";

export async function createBackup(req, res) {
  try {
    console.log("Iniciando creación de respaldo...");

    const createDatabaseQuery = `CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;\n\n`;
    const useDatabaseQuery = `USE \`${DB_NAME}\`;\n\n`;

    const sequelize = new Sequelize(DB_NAME, DB_USER, DB_PASSWORD, {
      host: DB_HOST,
      dialect: "mysql",
    });

    await sequelize.authenticate(); // Verificar la conexión a la base de datos
    console.log("Conexión a la base de datos establecida.");

    const filename = "backup-grandmart";

    // Obtener la lista de tablas
    const tables = await sequelize.query("SHOW TABLES", {
      type: sequelize.QueryTypes.SHOWTABLES,
    });

    let backup = "";
    backup += createDatabaseQuery;
    backup += useDatabaseQuery;
    // Generar la estructura de cada tabla
    for (const table of tables) {
      // Agregar DROP TABLE IF EXISTS
      backup += `DROP TABLE IF EXISTS \`${table}\`;\n`;

      // Obtener la estructura de la tabla
      const [createTable] = await sequelize.query(
        `SHOW CREATE TABLE \`${table}\``,
        {
          type: sequelize.QueryTypes.SHOWCREATE,
        }
      );
      backup += createTable[0]["Create Table"] + ";\n\n";
    }

    // Generar los datos de cada tabla
    for (const table of tables) {
      // Obtener los datos de la tabla
      const rows = await sequelize.query(`SELECT * FROM \`${table}\``, {
        type: sequelize.QueryTypes.SELECT,
      });

      console.log(rows);
      if (typeof rows !== "undefined") {
        if (rows.length > 0) {
          // Validar si rows tiene al menos un registro
          const keys = Object.keys(rows[0]); // Obtener las keys de la primera fila
          console.log(keys);
          const values = rows.map(
            (row) =>
              `(${keys.map((key) => sequelize.escape(row[key])).join(", ")})`
          );
          console.log(values);
          backup += `INSERT INTO \`${table}\` (\`${keys.join(
            "`, `"
          )}\`) VALUES\n${values.join(",\n")};\n\n`;
        } else {
          console.log(`No se encontraron registros en la tabla ${table}`);
        }
      } else {
        console.log(`undefined`);
      }
    }

    // Guardar el archivo SQL
    fs.writeFileSync(`${filename}.sql`, backup);

    console.log("Respaldo creado exitosamente.");

    res.setHeader("Content-Type", "application/sql");
    res.setHeader(
      "Content-Disposition",
      `attachment; filename=${filename}.sql`
    );
    fs.createReadStream(`${filename}.sql`).pipe(res);

    await sequelize.close();
  } catch (error) {
    console.error(error);
    res.status(500).send(`Error: ${error}`);
  }
}
