import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";
import { Orden } from "./OrdenModel.js";
// Modelo de Detalle de Orden
export const DetalleOrden = sequelizeDB.define(
  "orden_detalles",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    cantidad: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1,
    },
    precio_unitario: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false,
      defaultValue: 0,
    },
    id_producto: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
    id_orden: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
  },
  { timestamps: true }
);
