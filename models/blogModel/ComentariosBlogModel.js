import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const ComentarioBlog = sequelizeDB.define(
  "comentariosBlogs",
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
    id_usuario: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      autoIncrement: false,
      allowNull: false,
    },
    id_publicacionBlog: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      autoIncrement: false,
      allowNull: false,
    },
  },
  { timestamps: true }
);


