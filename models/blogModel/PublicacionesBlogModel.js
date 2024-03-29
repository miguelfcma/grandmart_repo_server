import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";
// Definir el modelo de datos para la tabla "publicacionesBlogs"
export const PublicacionBlog = sequelizeDB.define(
  "publicacionesBlogs",
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
    descripcion: { type: DataTypes.TEXT },
    id_usuario: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      autoIncrement: false,
      allowNull: false,
    },
  },
  { timestamps: true }
);
