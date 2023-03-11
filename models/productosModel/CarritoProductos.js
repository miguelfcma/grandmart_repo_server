import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const CarritoProductos = sequelizeDB.define(
  "carritoProductos",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    cantidad: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    precio: {
      type: DataTypes.DOUBLE(10, 2),
      allowNull: false,
    },
  },
  { timestamps: true }
);
