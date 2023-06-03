import { Sequelize } from "sequelize";
import { DB_HOST, DB_USER, DB_PASSWORD, DB_NAME } from "../../config.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import bcrypt from "bcryptjs";
import fs from "fs";

export async function createBackup(req, res) {
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

    console.log("Iniciando creación de respaldo...");

    const createDatabaseQuery = `CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;\n\n`;
    const useDatabaseQuery = `USE \`${DB_NAME}\`;\n\n`;

    const sequelize = new Sequelize(DB_NAME, DB_USER, DB_PASSWORD, {
      host: DB_HOST,
      dialect: "mysql",
    });

    await sequelize.authenticate(); // Verificar la conexión a la base de datos
    console.log("Conexión a la base de datos establecida.");

    const now = new Date();
    const year = now.getFullYear();
    const month = now.getMonth() + 1;
    const day = now.getDate();
    const hours = now.getHours();
    const minutes = now.getMinutes();
    const seconds = now.getSeconds();

    const dateFormatted = `${year}-${month.toString().padStart(2, "0")}-${day
      .toString()
      .padStart(2, "0")}`; // Formato: AAAA-MM-DD
    const timeFormatted = `${hours.toString().padStart(2, "0")}-${minutes
      .toString()
      .padStart(2, "0")}-${seconds.toString().padStart(2, "0")}`; // Formato: HH-MM-SS
    const filename = `GrandMart_db_${dateFormatted}_${timeFormatted}`;

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
    fs.writeFileSync(`backups-database/${filename}.sql`, backup);

    console.log("Respaldo creado exitosamente.");
    await sequelize.close();

    res.status(200).send({ message: "Archivo SQL creado exitosamente." });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
}
