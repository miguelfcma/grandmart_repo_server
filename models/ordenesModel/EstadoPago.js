import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const EstadoPago = sequelizeDB.define(
  "estadoPago",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    estado: { type: DataTypes.STRING(50), allowNull: false },
    
  },
  { timestamps: true }
);
