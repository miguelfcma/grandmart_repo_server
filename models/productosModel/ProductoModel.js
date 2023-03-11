//Creacion del modelo de productos

//importamos los  tipos de datos que sequelize tiene para poder definir los atributos de cada modelo
import { DataTypes } from "sequelize";
//importamos la conexiion con la base de datos
import { sequelizeDB } from "../../database/db.js";


export const Producto = sequelizeDB.define(
  "productos",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    nombre: {
      type: DataTypes.STRING(150),
      allowNull: false,
    },
    precio: { type: DataTypes.DOUBLE(10, 2), allowNull: false },
    stock: { type: DataTypes.INTEGER(11), allowNull: false },
    descripcion: { type: DataTypes.TEXT },
    marca: { type: DataTypes.STRING(60), allowNull: false },
    modelo: { type: DataTypes.STRING(60), allowNull: false },
    color: { type: DataTypes.STRING(50), allowNull: false },
    estado: { type: DataTypes.STRING(50), allowNull: false },
    id_categoria: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: false,
      autoIncrement: false,
      allowNull: false,
    },

    id_usuario: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: false,
      autoIncrement: false,
      allowNull: false,
    },
  },
  { timestamps: true }
);
