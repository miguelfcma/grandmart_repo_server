import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";
 
// Definición del modelo de datos para la tabla "direccion_envios"
export const DireccionEnvio = sequelizeDB.define(
  "direccion_envios",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    estado: {
      type: DataTypes.STRING(255),
      allowNull: false,
    },
    descripcion: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    nombre_ine: {
      type: DataTypes.STRING(255),
      allowNull: true,
    },
    calle2: {
      type: DataTypes.STRING(255),
      allowNull: true,
    },
    calle: {
      type: DataTypes.STRING(255),
      allowNull: true,
    },
    postal: {
      type: DataTypes.STRING(10),
      allowNull: true,
    },
    colonia: {
      type: DataTypes.STRING(255),
      allowNull: true,
    },
    numeroInterior: {
      type: DataTypes.STRING(10),
      allowNull: true,
    },
    calle1: {
      type: DataTypes.STRING(255),
      allowNull: true,
    },
    municipio_alcaldia: {
      type: DataTypes.STRING(255),
      allowNull: true,
    },
    numeroExterior: {
      type: DataTypes.STRING(10),
      allowNull: true,
    },
  },
  { timestamps: true }
);
