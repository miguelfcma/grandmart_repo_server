import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const Orden = sequelizeDB.define(
  "ordenes",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    total: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false,
      defaultValue: 0,
    },
    estado_orden: {
      type: DataTypes.ENUM("pendiente", "en proceso", "enviado", "entregado","cancelado"),
      allowNull: false,
      defaultValue: "pendiente",
    },
    id_usuario: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
  },
  { timestamps: true }
);
