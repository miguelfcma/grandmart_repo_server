import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";
// Definición del modelo de datos para la tabla "usuarios"
export const Usuario = sequelizeDB.define(
  "usuarios",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    nombre: {
      type: DataTypes.STRING(50),
      allowNull: false,
    },
    apellidoPaterno: {
      type: DataTypes.STRING(50),
      allowNull: false,
    },
    apellidoMaterno: {
      type: DataTypes.STRING(50),
      allowNull: false,
    },
    email: {
      type: DataTypes.STRING(66),
      allowNull: false,
    },
    sexo: {
      type: DataTypes.STRING(1),
      allowNull: false,
    },
    fechaNacimiento: {
      type: DataTypes.DATEONLY,
      allowNull: false,
    },
    telefono: {
      type: DataTypes.STRING(22),
      allowNull: false,
    },
    password: {
      type: DataTypes.STRING(100),
      allowNull: false,
    },
    tipoUsuario: {
      type: DataTypes.TINYINT,
      allowNull: false,
    },
  },
  { timestamps: true }
);