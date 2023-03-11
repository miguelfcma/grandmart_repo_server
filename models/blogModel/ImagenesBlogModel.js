import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const ImagenBlog = sequelizeDB.define(
  "imagenesBlog",

  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    titulo: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    contenido: { type: DataTypes.BLOB, allowNull: false },
    extension: { type: DataTypes.STRING(4), allowNull: false },
  },
  { timestamps: true }
);


