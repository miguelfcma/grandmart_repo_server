import { Servicio } from "../../models/serviciosModel/ServicioModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import { Categoria } from "../../models/categoriasModel/CategoriaModel.js";
import { Op } from "sequelize";

export const getServicio = async (req, res) => {
  try {
    const servicio = await Servicio.findByPk(req.params.id);
    if (!servicio) {
      return res.status(404).json({ message: "Servicio no encontrado" });
    }

    const servicioConCategoriaYUsuario = await Promise.all(servicio.map(async servicio => {
      const categoria = await Categoria.findByPk(servicio.id_categoria, { attributes: ['id', 'nombre'] });
      const usuario = await Usuario.findByPk(servicio.id_usuario, { attributes: ['id', 'nombre'] });
      return { ...servicio.toJSON(), categoria, usuario };
    }));



    return res.status(200).json(servicioConCategoriaYUsuario);
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Ocurrió un error al obtener el servicio." });
  }
};

export const getServicios = async (req, res) => {
  try {
    const servicios = await Servicio.findAll({
      attributes: ['id', 'titulo', 'descripcion', 'precio', 'id_categoria', 'id_usuario'],
    });
    if (servicios.length === 0) {
      return res.status(404).json({ message: "No se encontraron servicios" });
    }

    const serviciosConCategoriaYUsuario = await Promise.all(servicios.map(async servicio => {
      const categoria = await Categoria.findByPk(servicio.id_categoria, { attributes: ['id', 'nombre'] });
      const usuario = await Usuario.findByPk(servicio.id_usuario, { attributes: ['id', 'nombre'] });
      return { ...servicio.toJSON(), categoria, usuario };
    }));

    
    return res.status(200).json(serviciosConCategoriaYUsuario);
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Ocurrió un error al obtener los servicios." });
  }
};

export const createServicio = async (req, res) => {
  console.log(req.body)
  const {
    titulo,
    descripcion,
    precio,
    id_categoria,
    id_usuario,
  } = req.body;
 
  try {
    // validar la existencia de id_categoria
    const categoria = await Categoria.findByPk(id_categoria);
    if (!categoria) {
      return res
        .status(400)
        .json({ message: "La categoría especificada no existe." });
    }

    // validar la existencia de id_usuario
    const usuario = await Usuario.findByPk(id_usuario);
    if (!usuario) {
      return res
        .status(400)
        .json({ message: "El usuario especificado no existe." });
    }

    const existenciaServicio = await Servicio.findOne({
      where: {
        [Op.and]: [{ titulo: titulo }, { id_usuario: id_usuario }],
      },
    });
    if (existenciaServicio) {
      return res
        .status(400)
        .json({ message: "Este servicio ya está registrado en su cuenta." });
    }
    const newServicio = await Servicio.create({
      titulo,
      descripcion,
      precio,
      id_categoria,
      id_usuario,
    });
    return res
      .status(201)
      .json({
        message: "Servicio creado exitosamente.",
        servicio: newServicio,
      });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ocurrió un error al crear el servicio." });
  }
};


export const updateServicio = async (req, res) => {
  const {
    titulo,
    descripcion,
    precio,
    id_categoria,
    id_usuario,
  } = req.body;
  try {
    const servicio = await Servicio.findByPk(req.params.id);
    if (!servicio) {
      return res.status(404).json({ message: "No se encontró el servicio" });
    }
    const updateServicio = await servicio.update({
      titulo,
      descripcion,
      precio,
      id_categoria,
      id_usuario,
    });
    return res
      .status(200)
      .json({
        message: "Servicio actualizado exitosamente.",
        servicio: updateServicio,
      });
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Ocurrió un error al actualizar el servicio." });
  }
};

export const deleteServicio = async (req, res) => {
  try {
    const servicio = await Servicio.findByPk(req.params.id);
    if (!servicio) {
      return res.status(404).json({ message: "No se encontró el servicio" });
    }
    await servicio.destroy();
    return res
      .status(200)
      .json({ message: "El servicio fue eliminado exitosamente." });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const getServiciosByUsuarioId = async (req, res) => {
  try {
    const servicios = await Servicio.findAll({
      where: { id_usuario: req.params.id_usuario },
      attributes: ['id', 'titulo', 'descripcion', 'precio', 'id_categoria', 'id_usuario'],
    });
    if (servicios.length === 0) {
      return res.status(404).json({ message: "No se encontraron servicios para este usuario" });
    }
    return res.status(200).json(servicios);
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Ocurrió un error al obtener los servicios." });
  }
};
