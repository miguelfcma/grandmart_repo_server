import express from "express";
import cors from "cors";

// Rutas de usuarios
import usuariosRoutes from "./routes/usuariosRoutes/usuarios.routes.js";
import imagenUsuariosRoutes from "./routes/usuariosRoutes/imagenUsuario.routes.js";
import domicilioUsuarioRoutes from "./routes/usuariosRoutes/domicilioUsuario.routes.js";

// Rutas de categorias
import categoriaRoutes from "./routes/categoriasRoutes/categorias.routes.js";

// Rutas de productos
import productoRoutes from "./routes/productosRoutes/productos.routes.js";
import imagenesProductosRoutes from "./routes/productosRoutes/imgProductos.routes.js";
import preguntasProductosRoutes from "./routes/productosRoutes/preguntasProducto.routes.js";
import reviewsProductoRoutes from "./routes/productosRoutes/reviewsProducto.routes.js";

// Rutas de servicios
import serviciosRoutes from "./routes/serviciosRoutes/servicios.routes.js";
import imagenesServiciosRoutes from "./routes/serviciosRoutes/imgServicios.routes.js";
import preguntasServiciosRoutes from "./routes/serviciosRoutes/preguntasServicios.routes.js";
import reviewsServiciosRoutes from "./routes/serviciosRoutes/reviewsServicio.routes.js";

// Rutas de blog
import publicacionBlogRoutes from "./routes/blogRoutes/publicacionBlog.routes.js";
import comentarioBlogRoutes from "./routes/blogRoutes/comentarioBlog.routes.js";
import imagenBlogRoutes from "./routes/blogRoutes/imagenBlog.routes.js";

// Rutas de buzon
import buzonRoutes from "./routes/buzonRoutes/buzon.routes.js";

// Rutas de recuperacion de contraseña
import recoveryPassRoutes from "./routes/RecoveryPassRoutes/recoveryPass.routes.js";

// Rutas de la base de datos
import bdRoutes from "./routes/bdRoutes/bdRoutes.routes.js";

//Rutas de carrito de productos
import carritoProductosRoutes from "./routes/productosRoutes/carritoProductos.routes.js";
//Rutas de favoritos
import favoritosProductosRoutes from "./routes/productosRoutes/favoritosProductos.routes.js";

//ordenes
import ordenesRoutes from "./routes/ordenesRoutes/ordenes.routes.js";
//Envios
import enviosRoutes from "./routes/ordenesRoutes/envios.routes.js";

//Compras
import comprasRoutes from "./routes/ordenesRoutes/compras.routes.js";

//Ventas
import ventasRoutes from "./routes/ordenesRoutes/ventas.routes.js";
//pagos
import pagosRoutes from "./routes/ordenesRoutes/pagos.routes.js";

//
import tokenRoutes from "./routes/verificacionTokenRoutes/verificacionToken.routes.js";
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

//Rutas de usuarios
app.use(usuariosRoutes);
app.use(imagenUsuariosRoutes);
app.use(domicilioUsuarioRoutes);

//Rutas de categorias
app.use(categoriaRoutes);

//Rutas de productos
app.use(productoRoutes);
app.use(imagenesProductosRoutes);
app.use(preguntasProductosRoutes);
app.use(reviewsProductoRoutes);

//Rutas de Servicios
app.use(serviciosRoutes);
app.use(imagenesServiciosRoutes);
app.use(preguntasServiciosRoutes);
app.use(reviewsServiciosRoutes);

//Rutas de blog
app.use(publicacionBlogRoutes);
app.use(comentarioBlogRoutes);
app.use(imagenBlogRoutes);
//Rutas de buzon
app.use(buzonRoutes);

//Rutas de Recuperacion de contraseña
app.use(recoveryPassRoutes);

//Rutas de carrito de productos
app.use(carritoProductosRoutes);
//Rutas de favoritos
app.use(favoritosProductosRoutes);
// Rutas de la base de datos
app.use(bdRoutes);

//ordenes

app.use(ordenesRoutes);

//Envios

app.use(enviosRoutes);
//Ventas
app.use(ventasRoutes);

//Compras
app.use(comprasRoutes);
//pagos
app.use(pagosRoutes);
app.use(tokenRoutes);
//  STATIC FILES

//  EXPORT THE APP
export default app;
