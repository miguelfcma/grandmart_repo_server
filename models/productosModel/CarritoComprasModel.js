import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";
import { Carrito_compra_detalles } from "./CarritoCompraDetallesModel.js";


export const Carritos_compras = sequelizeDB.define(
  "carritos_compras",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    id_usuario: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
    fecha_creacion: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
  },
  { timestamps: true }
);
