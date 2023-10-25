
// Configuración de la conexión a la base de datos MySQL utilizando la biblioteca Sequelize en JavaScript.
import { DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, DB_PORT } from '../config.js';
import { Sequelize } from 'sequelize';

// Crear una instancia de Sequelize para conectar a la base de datos MySQL
export const sequelizeDB = new Sequelize(DB_NAME, DB_USER, DB_PASSWORD, {
  host: DB_HOST,      // Host de la base de datos
  port: DB_PORT,      // Puerto en el que se ejecuta la base de datos
  dialect: 'mysql',  // Tipo de base de datos (en este caso, MySQL)
});
