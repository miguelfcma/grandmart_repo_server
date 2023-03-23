import { DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, DB_PORT } from '../config.js';
import { Sequelize } from 'sequelize';

export const sequelizeDB = new Sequelize(DB_NAME, DB_USER, DB_PASSWORD, {
  host: DB_HOST,
  port: DB_PORT,
  dialect: 'mysql',
});
