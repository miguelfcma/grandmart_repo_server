import { DataTypes } from "sequelize";
import { sequelizeDB } from "../../database/db.js";
// Definición del modelo de datos para la tabla "Pago"
export const Pago = sequelizeDB.define(
  "Pago",
  {
    id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    usuario_id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
    orden_id: {
      type: DataTypes.BIGINT(20).UNSIGNED,
      allowNull: false,
    },
    monto: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false,
    },
    id_pago_stripe: {
        type: DataTypes.STRING,
        allowNull: false,
      },
    estado: {
      type: DataTypes.ENUM(
        "Pendiente",
        "Procesando",
        "Procesado",
        "Rechazado",
        "Cancelado",
        "Reembolsado",
        "Fallido"
      ),
      allowNull: false,
      defaultValue: "Pendiente",
    },
    fecha_pago: {
     
      type: DataTypes.DATE,
      allowNull: false, 
    },
  },
  {
    tableName: "pago",
    timestamps: true,
  }
);
