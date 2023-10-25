import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";
// Definición del modelo de datos para la tabla "imagenesProducto"
export const ImagenProducto = sequelizeDB.define(
    "imagenesProducto",
    {
      id: {
        type: DataTypes.BIGINT(20).UNSIGNED,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
      },
      url: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      id_producto: {
        type: DataTypes.BIGINT(20).UNSIGNED,
        allowNull: false,
      },
      es_portada: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
      },
     
    },
    { timestamps: true }
  );
