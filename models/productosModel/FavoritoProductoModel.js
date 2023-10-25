import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

// Definición del modelo de datos para la tabla "FavoritosProductos"
export const FavoritosProductos = sequelizeDB.define(
  "FavoritosProductos",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    id_producto: {
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

