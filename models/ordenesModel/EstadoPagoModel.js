import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const EstadoPago = sequelizeDB.define(
  "estado_pagos",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    id_orden: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
    pagado: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
    },
    metodo_pago: {
      type: DataTypes.STRING(255),
      allowNull: false,
    },
    referencia_pago: {
      type: DataTypes.STRING(255),
      allowNull: false,
    },
    detalles_pago: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    fecha_pago: {
      type: DataTypes.DATE,
      allowNull: true,
    },
  },
  { timestamps: true }
);

