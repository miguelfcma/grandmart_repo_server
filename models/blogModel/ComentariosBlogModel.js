import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const ComentarioBlog = sequelizeDB.define(
  "comentariosBlog",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    comentario: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
  },
  { timestamps: true }
);


