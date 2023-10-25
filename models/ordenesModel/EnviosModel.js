import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";
// Definición del modelo de datos para la tabla "envios"
export const Envio = sequelizeDB.define(
  "envios",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    orden_id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
    direccion_envio_id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
    estado: {
      type: DataTypes.ENUM(
        "Pendiente",
        "En tránsito",
        "Entregado",
        "Retrasado",
        "Devuelto",
        "Cancelado"
      ),
      allowNull: false,
      defaultValue: "Pendiente",
    },
    fechaEntrega: {
      type: DataTypes.DATE,
    },
  },
  {
    tableName: "envios",
    timestamps: true,
  }
);
