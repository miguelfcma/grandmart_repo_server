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
      motivo: {
        type: DataTypes.STRING(150),
        allowNull: false,
      },
      descripcion: {
        type: DataTypes.STRING(1500),
        allowNull: false,
      },
      fecha: {
        type: DataTypes.DATE,
        allowNull: false,
        defaultValue: DataTypes.NOW,
      },
      id_usuario: {
        type: DataTypes.BIGINT(20).UNSIGNED,
        allowNull: false,
      }
    },
    { timestamps: true }
  );
