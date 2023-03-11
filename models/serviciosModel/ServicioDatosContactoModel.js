import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const DatosContactoServicio = sequelizeDB.define(
    "datosContactoServicio",
    {
      id: {
        type: DataTypes.BIGINT(20).UNSIGNED,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
      },
      telefono1: {
        type: DataTypes.STRING(22),
        allowNull: false,
      },
      telefono2: {
        type: DataTypes.STRING(22),
        allowNull: false,
      },
      email: {
        type: DataTypes.STRING(66),
        allowNull: false,
      },
    },
    { timestamps: true }
  );