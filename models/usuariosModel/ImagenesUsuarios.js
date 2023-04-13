import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const ImagenUsuario = sequelizeDB.define(
  "imagenesusuario",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    url: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    es_portada: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
    },
    id_usuario: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      autoIncrement: false,
      allowNull: false,
    },
  },
  { timestamps: true }
);

