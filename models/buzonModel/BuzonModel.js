import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const DenunciaBuzon = sequelizeDB.define(
  "denunciaBuzons",
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
    revisar: {
      type: DataTypes.TINYINT(1),
      defaultValue: 0,
    },
    id_usuario: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
    id_producto: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
  },
  {
    timestamps: true,
    freezeTableName: true, // se desactiva la pluralización del nombre de la tabla
  }
);
