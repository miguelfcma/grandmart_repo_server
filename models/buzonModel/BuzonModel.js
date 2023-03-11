import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const MensajeBuzon = sequelizeDB.define(
    "mensajeBuzon",
    {
      id: {
        type: DataTypes.BIGINT(20).UNSIGNED,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
      },
      titulo: {
        type: DataTypes.STRING(150),
        allowNull: false,
      },
      mensaje: {
        type: DataTypes.STRING(1500),
        allowNull: false,
      },
    },
    { timestamps: true }
  );
