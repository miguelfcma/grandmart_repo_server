import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";
// Definición del modelo de datos para la tabla "carrito_compra_detalles"
export const Carrito_compra_detalles  = sequelizeDB.define(
  "carrito_compra_detalles",
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
    id_carrito_compra: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
    cantidad: {
        type: DataTypes.INTEGER(11),
        allowNull: false,
      },
  },
  { timestamps: true }
);
