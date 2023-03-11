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
  },
  { timestamps: true }
);

