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
    calificacion: {
      type: DataTypes.TINYINT(1),
      allowNull: false,
      validate: {
        min: 1, // calificación mínima de 1
        max: 5, // calificación máxima de 5
        isInt: true, // asegurarse de que el valor sea un número entero
      },
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
