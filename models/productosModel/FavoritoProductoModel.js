import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";


export const FavoritosProducto = sequelizeDB.define(
  "favoritosProducto",
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

