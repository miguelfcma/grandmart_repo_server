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


