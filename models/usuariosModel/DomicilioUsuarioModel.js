import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";

export const DomicilioUsuario = sequelizeDB.define(
  "domicilioUsuario",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    nombre_ine: {
      type: DataTypes.STRING(150),
      allowNull: false,
    },
    postal: {
      type: DataTypes.STRING(6),
      allowNull: false,
    },
    estado: {
      type: DataTypes.STRING(100),
      allowNull: false,
    },
    municipio_alcaldia: {
      type: DataTypes.STRING(100),
      allowNull: false,
    },
    colonia: {
      type: DataTypes.STRING(100),
      allowNull: false,
    },
    calle: {
      type: DataTypes.STRING(50),
      allowNull: false,
    },
    numeroExterior: { type: DataTypes.STRING(5), allowNull: false },
    numeroInterior: { type: DataTypes.STRING(5), allowNull: true },
    calle1: {
      type: DataTypes.STRING(50),
      allowNull: false,
    },
    calle2: {
      type: DataTypes.STRING(50),
      allowNull: true,
      
    },
    descripcion: { type: DataTypes.TEXT},
  },
  { timestamps: true }
);
