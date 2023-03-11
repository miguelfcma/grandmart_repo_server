//se importa Squelize es decir toda la libreria y no solo una instancia de la misma
import { Sequelize } from "sequelize";

export const sequelizeDB = new Sequelize("grandmart_db", "root", "", {
  host: "localhost",
  dialect: "mysql",
});
