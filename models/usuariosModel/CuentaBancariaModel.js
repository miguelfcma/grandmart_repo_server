import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";
export const CuentaBancaria = sequelizeDB.define(
  "cuenta_bancaria",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    nombre_titular: {
      type: DataTypes.STRING(255),
      allowNull: false,
    },
    numero_cuenta: {
      type: DataTypes.STRING(255),
      allowNull: false,
    },
    banco: {
      type: DataTypes.STRING(255),
      allowNull: false,
    },
    usuario_id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      autoIncrement: false,
      allowNull: false,
    },
  },
  { tableName: "cuenta_bancaria", timestamps: true }
);
