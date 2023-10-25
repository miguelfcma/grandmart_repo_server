import { ReviewProducto } from "../../models/productosModel/ReviewsProductosModel.js";
import { Producto } from "../../models/productosModel/ProductoModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import { enviarCorreo } from "../CorreoController/enviarCorreo.controllers.js";
import sequelize from "sequelize";

// Función para crear una nueva revisión de un producto
export const createReview = async (req, res) => {
  const { titulo, comentario, calificacion, id_producto, id_usuario } =
    req.body;

  try {
    // Verificar si el usuario ya ha dejado una revisión para el producto
    const existingReview = await ReviewProducto.findOne({
      where: { id_usuario, id_producto },
    });
    if (existingReview) {
      return res.status(400).json({
        message: "El usuario ya ha dejado una revisión para este producto",
      });
    }

    // Crear una nueva revisión
    const newReview = await ReviewProducto.create({
      titulo,
      comentario,
      calificacion,
      id_producto,
      id_usuario,
    });

    // Obtener el producto y su vendedor
    const producto = await Producto.findByPk(id_producto);
    const usuarioVendedor = await Usuario.findByPk(producto.id_usuario, {
      attributes: [
        "id",
        "nombre",
        "apellidoPaterno",
        "apellidoMaterno",
        "email",
      ],
    });

    // Construir el contenido del correo en formato HTML
    const contenido = `
        <h2>Se ha dejado una nueva revisión en tu producto</h2>
        <hr />
        <h3>Producto:</h3>
        <p>Descripción: ${producto.id}</p>
        <p>Nombre: ${producto.nombre}</p>
        <hr />
        <h3>Opinión del usuario:</h3>
        <p>Título: ${titulo}</p>
        <p>Comentario: ${comentario}</p>
        <p>Calificación: ${calificacion}</p>
    `;

    // Enviar el correo al vendedor del producto
    const emailVendedor = usuarioVendedor.email;
    const asunto = "GrandMart Marketplace";
    const header = "Notificación de nueva revisión";
    await enviarCorreo(emailVendedor, asunto, header, contenido);
    res.status(201).json({
      message: "La revisión ha sido creada correctamente",
      review: newReview,
    });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para eliminar una revisión de un producto por su ID
export const deleteReviewById = async (req, res) => {
  const { id } = req.params;
  try {
    const deletedReview = await ReviewProducto.destroy({ where: { id } });
    if (deletedReview === 0) {
      return res.status(404).json({ message: "Revisión no encontrada" });
    }
    res
      .status(200)
      .json({ message: "La revisión ha sido eliminada correctamente" });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para obtener revisiones por ID de producto
export const getReviewsByProductId = async (req, res) => {
  const { id_producto } = req.params;
  try {
    const reviews = await ReviewProducto.findAll({ where: { id_producto } });
    if (reviews.length === 0) {
      res
        .status(404)
        .json({ message: "No se encontraron revisiones para este producto" });
    } else {
      res.status(200).json({
        message: "Las revisiones han sido obtenidas correctamente",
        reviews,
      });
    }
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para actualizar una revisión de un producto por su ID
export const updateReviewById = async (req, res) => {
  const { id } = req.params;
  const { titulo, comentario, calificacion } = req.body;
  try {
    const [updatedRowsCount, updatedRows] = await ReviewProducto.update(
      { titulo, comentario, calificacion },
      { where: { id }, returning: true }
    );
    if (updatedRowsCount === 0) {
      return res.status(404).json({ message: "Revisión no encontrada" });
    }
    res.status(200).json({
      message: "La revisión ha sido actualizada correctamente",
      review: updatedRows[0],
    });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para obtener el promedio de calificación de un producto por su ID
export const getAvgRatingByProductId = async (req, res) => {
  const { id_producto } = req.params;
  try {
    const avgRating = await ReviewProducto.findOne({
      attributes: [
        [sequelize.fn("AVG", sequelize.col("calificacion")), "avgRating"],
      ],
      where: { id_producto },
    });
    if (avgRating && avgRating.dataValues.avgRating) {
      res.json(avgRating);
    } else {
      res.status(404).json({ message: "No hay revisiones para este producto" });
    }
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para obtener una revisión específica por ID de usuario e ID de producto
export const getReviewByUserAndProduct = async (req, res) => {
  const { id_usuario, id_producto } = req.params;
  try {
    const review = await ReviewProducto.findOne({
      where: { id_usuario, id_producto },
    });
    if (review) {
      res.status(200).json({ message: "Revisión encontrada", review });
    } else {
      res.status(404).json({ message: "Revisión no encontrada" });
    }
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para obtener productos del usuario con revisiones asociadas
export const getProductosConReviewsByUsuarioId = async (req, res) => {
  try {
    const { id_usuario } = req.params;

    // Buscar productos del usuario por su ID de usuario
    const productos = await Producto.findAll({ where: { id_usuario } });

    if (productos.length === 0) {
      return res.status(404).json({
        message: "No se encontraron productos para el usuario especificado",
      });
    }

    const productosConReviews = await Promise.all(
      productos.map(async (producto) => {
        // Buscar revisiones asociadas al producto
        const reviews = await ReviewProducto.findAll({
          where: { id_producto: producto.id },
        });

        if (reviews.length > 0) {
          // Si el producto tiene revisiones asociadas, agregarlas como propiedad al objeto de producto
          return { producto: producto.toJSON(), reviews };
        } else {
          // Si el producto no tiene revisiones asociadas, devolver null
          return null;
        }
      })
    );

    // Filtrar los productos nulos (que no tienen revisiones asociadas)
    const productosConReviewsFiltrados = productosConReviews.filter(
      (producto) => producto !== null
    );

    res.status(200).json(productosConReviewsFiltrados);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para obtener todos los productos con revisiones
export const getTodosProductosConReviews = async (req, res) => {
  try {
    // Buscar todos los productos
    const productos = await Producto.findAll();

    if (productos.length === 0) {
      return res.status(404).json({
        message: "No se encontraron productos",
      });
    }

    const productosConReviews = await Promise.all(
      productos.map(async (producto) => {
        // Buscar revisiones asociadas al producto
        const reviews = await ReviewProducto.findAll({
          where: { id_producto: producto.id },
        });

        if (reviews.length > 0) {
          // Si el producto tiene revisiones asociadas, agregarlas como propiedad al objeto de producto
          return { producto: producto.toJSON(), reviews };
        } else {
          // Si el producto no tiene revisiones asociadas, devolver null
          return null;
        }
      })
    );

    // Filtrar los productos nulos (que no tienen revisiones asociadas)
    const productosConReviewsFiltrados = productosConReviews.filter(
      (producto) => producto !== null
    );

    res.status(200).json(productosConReviewsFiltrados);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

// Función para buscar una revisión por ID de producto e ID de usuario
export const getReviewByProductIdAndUserId = async (req, res) => {
  const { id_producto, id_usuario } = req.params;
  try {
    const review = await ReviewProducto.findOne({
      where: { id_producto, id_usuario },
    });
    if (review) {
      res.status(200).json({ message: "Revisión encontrada", review });
    } else {
      res.status(404).json({ message: "Revisión no encontrada" });
    }
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};
