import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const Servicio = sequelizeDB.define(
  "servicios",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    titulo: {
      type: DataTypes.STRING(60),
      allowNull: false,
    },
    descripcion: { type: DataTypes.TEXT },
    precio: { type: DataTypes.DOUBLE(10, 2), allowNull: false },
    id_categoria: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: false,
      autoIncrement: false,
      allowNull: false,
    },

    id_usuario: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: false,
      autoIncrement: false,
      allowNull: false,
    },
  },
  { timestamps: true }
);
