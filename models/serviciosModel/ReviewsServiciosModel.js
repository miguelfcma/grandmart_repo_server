import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const ReviewServicio = sequelizeDB.define(
  "reviewsServicios",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    titulo: {
      type: DataTypes.STRING(150),
      allowNull: false,
    },
    comentario: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    calificacion: { type: DataTypes.SMALLINT(6), allowNull: false },
  },
  { timestamps: true }
);
