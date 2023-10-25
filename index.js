// Importar la aplicación Express desde el archivo 'app.js'
import app from "./app.js";

// Importar la instancia de la base de datos Sequelize desde el archivo 'db.js'
import { sequelizeDB } from "./database/db.js";

// Importar el puerto de la configuración desde el archivo 'config.js'
import { PORT } from "./config.js";

// Función principal asíncrona que inicializa la aplicación
async function main() {
  try {
    // Sincronizar la base de datos con el modelo de datos definido (no forzar la eliminación de tablas)
    await sequelizeDB.sync({ force: false });

    // Iniciar el servidor Express y escuchar las solicitudes en el puerto especificado
    app.listen(PORT, () => {
      console.log(`Servidor escuchando en el puerto ${PORT}`);
    });
  } catch (error) {
    // Manejar errores en caso de que la conexión a la base de datos falle
    console.log(`Conexión a la base de datos incompleta `, error);
  }
}

// Llamar a la función principal para iniciar la aplicación
main();
