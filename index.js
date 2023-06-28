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
    console.log(`Conexión a la base de datos incompleta `, error);
  }
}

main();

