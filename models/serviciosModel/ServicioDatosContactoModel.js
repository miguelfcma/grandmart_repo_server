import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";
// Definición del modelo de datos para la tabla "datosContactoServicio"
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
      allowNull: true,
    },
    email: {
      type: DataTypes.STRING(66),
      allowNull: true,
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
    numeroExterior: {
      type: DataTypes.STRING(10),
      allowNull: true,
    },
    numeroInterior: {
      type: DataTypes.STRING(10),
      allowNull: true,
    },
    descripcion: { type: DataTypes.TEXT },
    id_servicio: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: false,
      autoIncrement: false,
      allowNull: false,
    },
  },
  { timestamps: true }
);
