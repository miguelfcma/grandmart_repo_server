import { FavoritosProductos } from "../../models/productosModel/FavoritoProductoModel.js";
import { Producto } from "../../models/productosModel/ProductoModel.js";
export const obtenerFavoritos = async (req, res) => {
  const { id_usuario } = req.params;
  try {
    const favoritos = await FavoritosProductos.findAll({
      where: { id_usuario: id_usuario },
    });

    if (favoritos.length === 0) {
      return res.status(404).json({
        message: "No se encontraron favoritos para el usuario especificado",
      });
    }
    const favoritosConProducto = await Promise.all(
      favoritos.map(async (favorito) => {
        const producto = await Producto.findByPk(favorito.id_producto, {
          attributes: ["id", "nombre", "precio", "id_usuario"],
        });
        return { ...favorito.toJSON(), producto };
      })
    );
    res
      .status(200)
      .json({ message: "Favoritos obtenidos correctamente", data: favoritosConProducto });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al obtener favoritos", error });
  }
};


export const agregarProductoAFavoritos = async (req, res) => {
  const { id_usuario } = req.params;
  const { id_producto } = req.body.data;
  console.log(id_usuario,id_producto )

  try {
    const favoritoExistente = await FavoritosProductos.findOne({
      where: { id_producto, id_usuario },
    });
    if (favoritoExistente) {
      res.status(409).json({ message: "El producto ya está en favoritos" });
    } else {
      const nuevoFavorito = await FavoritosProductos.create({
        id_producto,
        id_usuario,
      });
      res.status(201).json({
        message: "Producto agregado a favoritos correctamente",
        data: nuevoFavorito,
      });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al agregar favorito", error });
  }
};

export const eliminarProductoFavorito = async (req, res) => {
  const { id_usuario } = req.params;
  const { id_producto } = req.body.data;
console.log("webos")
  try {
    const favorito = await FavoritosProductos.findOne({
      where: { id_producto: id_producto, id_usuario: id_usuario },
    });
    if (!favorito) {
      res.status(404).json({ message: "Favorito no encontrado" });
    } else {
      await favorito.destroy();
      res.status(200).json({ message: "Favorito eliminado correctamente" });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al eliminar favorito", error });
  }
};
