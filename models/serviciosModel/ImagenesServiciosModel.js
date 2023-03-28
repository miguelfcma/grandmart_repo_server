import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const ImagenServicio = sequelizeDB.define(
  "imagenesServicio",
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
    id_servicio: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
    es_portada: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
    },
  },
  { timestamps: true }
);
