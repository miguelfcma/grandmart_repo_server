import app from "./app.js";
import { sequelizeDB } from "./database/db.js";
import { PORT } from "./config.js";


async function main() {
  try {
    await sequelizeDB.sync({ force: false });
    app.listen(PORT, () => {
      console.log(`Servidor escuchando en el puerto ${PORT}`);
    });
  } catch (error) {
    console.log("Conexión a la base de datos incompleta ", error);
  }
}

main();

/* 
import "./models/productosModel/ProductoModel.js";
import  "./models/productosModel/FavoritoProductoModel.js";
import  "./models/productosModel/ImagenesProductoModel.js";
import  "./models/productosModel/ReviewsProductosModel.js";
import  "./models/productosModel/PreguntasProductoModel.js";
import "./models/productosModel/CarritoProductosModel.js";
import  "./models/ordenesModel/EstadoPedidoModel.js";
import  "./models/ordenesModel/EstadoPagoModel.js";
import  "./models/ordenesModel/OrdenModel.js";
import "./models/ordenesModel/ProductosOrdenModel.js";




import  "./models/usuariosModel/UsuarioModel.js";
import  "./models/usuariosModel/ImagenesUsuariosModel.js";
import  "./models/usuariosModel/DomicilioUsuarioModel.js";

import  "./models/serviciosModel/ImagenesServiciosModel.js";
import  "./models/serviciosModel/PreguntasServiciosModel.js";
import "./models/serviciosModel/ReviewsServiciosModel.js";
import  "./models/serviciosModel/ServicioModel.js";
import  "./models/serviciosModel/UbicacionServiciosModel.js";



import "./models/buzonModel/ImagenBuzonModel.js";
import  "./models/blogModel/PublicacionesBlogModel.js";
import "./models/blogModel/ComentariosBlogModel.js";
import  "./models/blogModel/ImagenesBlogModel.js";

import "./models/serviciosModel/ServicioDatosContactoModel.js";
import "./models/categoriasModel/CategoriaModel.js";

import "./models/foreignKeys/foreignKeys.js"
*/
