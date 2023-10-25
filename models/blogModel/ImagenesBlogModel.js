import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";
// Definir el modelo de datos para la tabla "imagenesBlogs"
export const ImagenBlog = sequelizeDB.define(
  "imagenesBlogs",

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
    id_publicacionBlog: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    }
  },
  { timestamps: true }
);


