import express from "express";
import cors from "cors";
import serviciosRoutes from "./routes/serviciosRoutes/servicios.routes.js";
import productoRoutes from "./routes/productosRoutes/productos.routes.js";
import usuariosRoutes from "./routes/usuariosRoutes/usuarios.routes.js";
import imagenUsuariosRoutes from "./routes/usuariosRoutes/imagenUsuario.routes.js";
import categoriaRoutes from "./routes/categoriasRoutes/categorias.routes.js";
import morgan from "morgan";
import path from "path";
//  INITIALIZATIONS
const app = express();

//  SETTINGS
// Configuración de CORS
app.use(cors());

//  MIDDLAWARES
//esto permitira que cada vez que se envia algo al servidor en formato json
//el servidor podra leerlo e interpretarlo guardandolo en req.body
app.use(express.json());
app.use(morgan("dev"));

//  GLOBAL VARIABLES

//  ROUTES

app.use(usuariosRoutes);
app.use(categoriaRoutes);
app.use(imagenUsuariosRoutes);
app.use(productoRoutes);
app.use(serviciosRoutes);

//  STATIC FILES

//  EXPORT THE APP
export default app;