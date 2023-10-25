import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";
// Definición del modelo de datos para la tabla "preguntasServicio"
export const PreguntaServicio = sequelizeDB.define(
  "preguntasServicio",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    pregunta: {
      type: DataTypes.STRING(1500),
      allowNull: false,
    },
    respuesta: {
      type: DataTypes.STRING(2000),
      allowNull: true,
    },
    id_servicio: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
    id_usuario: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
  },
  { timestamps: true }
);
