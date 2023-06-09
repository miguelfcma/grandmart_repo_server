import { Servicio } from "../../models/serviciosModel/ServicioModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import { Categoria } from "../../models/categoriasModel/CategoriaModel.js";
import { Op } from "sequelize";
import { DatosContactoServicio } from "../../models/serviciosModel/ServicioDatosContactoModel.js";

export const getServicio = async (req, res) => {
  try {
    const servicio = await Servicio.findByPk(req.params.id);
    if (!servicio) {
      return res.status(404).json({ message: "Servicio no encontrado" });
    }

    const servicioConCategoriaYUsuario = await Promise.all(
      servicio.map(async (servicio) => {
        const categoria = await Categoria.findByPk(servicio.id_categoria, {
          attributes: ["id", "nombre"],
        });
        const usuario = await Usuario.findByPk(servicio.id_usuario, {
          attributes: ["id", "nombre"],
        });
        return { ...servicio.toJSON(), categoria, usuario };
      })
    );

    return res.status(200).json(servicioConCategoriaYUsuario);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

export const getServicios = async (req, res) => {
  try {
    const servicios = await Servicio.findAll({
      attributes: [
        "id",
        "titulo",
        "descripcion",
        "precio",
        "id_categoria",
        "id_usuario",
      ],
    });
    if (servicios.length === 0) {
      return res.status(404).json({ message: "No se encontraron servicios" });
    }

    const serviciosConCategoriaYUsuario = await Promise.all(
      servicios.map(async (servicio) => {
        const categoria = await Categoria.findByPk(servicio.id_categoria, {
          attributes: ["id", "nombre"],
        });
        const usuario = await Usuario.findByPk(servicio.id_usuario, {
          attributes: ["id", "nombre"],
        });
        return { ...servicio.toJSON(), categoria, usuario };
      })
    );

    return res.status(200).json(serviciosConCategoriaYUsuario);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

export const createServicio = async (req, res) => {
  const { titulo, descripcion, precio, id_categoria, id_usuario } = req.body;

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
    return res.status(201).json({
      message: "Servicio creado exitosamente.",
      servicio: newServicio,
    });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

export const updateServicio = async (req, res) => {
  const { titulo, descripcion, precio, id_categoria, id_usuario } = req.body;
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
    return res.status(200).json({
      message: "Servicio actualizado exitosamente.",
      servicio: updateServicio,
    });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
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
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

export const getServiciosByUsuarioId = async (req, res) => {
  try {
    const servicios = await Servicio.findAll({
      where: { id_usuario: req.params.id_usuario },
      attributes: [
        "id",
        "titulo",
        "descripcion",
        "precio",
        "id_categoria",
        "id_usuario",
      ],
    });
    if (servicios.length === 0) {
      return res
        .status(404)
        .json({ message: "No se encontraron servicios para este usuario" });
    }
    return res.status(200).json(servicios);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

export const createDatosContactoServicio = async (req, res) => {
  try {
    const datosContacto = req.body;
    console.log(datosContacto);
    const nuevoDatosContacto = await DatosContactoServicio.create(
      datosContacto
    );
    return res.status(201).json({
      message: "Datos de contacto del servicio creados exitosamente.",
      datosContacto: nuevoDatosContacto,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      message:
        "Ha ocurrido un error en el servidor al crear los datos de contacto del servicio.",
    });
  }
};

export const obtenerDatosContactoServicio = async (req, res) => {
  try {
    const id = req.params.id;
    const datosContacto = await DatosContactoServicio.findOne({
      where: { id_servicio: id },
    });
    if (!datosContacto) {
      return res.status(404).json({
        message: "Datos de contacto del servicio no encontrados.",
      });
    }
    return res.status(200).json(datosContacto);
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      message:
        "Ha ocurrido un error en el servidor al obtener los datos de contacto del servicio.",
    });
  }
};

export const updateDatosContactoServicio = async (req, res) => {
  const {
    telefono1,
    telefono2,
    email,
    estado,
    municipio_alcaldia,
    colonia,
    calle,
    numeroExterior,
    numeroInterior,
    descripcion,
  } = req.body;
  const id_servicio = req.params.id;
  try {
    const datosContacto = await DatosContactoServicio.findOne({
      where: { id_servicio },
    });
    if (!datosContacto) {
      return res.status(404).json({
        message: "No se encontraron los datos de contacto del servicio",
      });
    }
    const updatedDatosContacto = await datosContacto.update({
      telefono1,
      telefono2,
      email,
      estado,
      municipio_alcaldia,
      colonia,
      calle,
      numeroExterior,
      numeroInterior,
      descripcion,
      id_servicio,
    });
    return res.status(200).json({
      message: "Datos de contacto del servicio actualizados exitosamente.",
      datosContacto: updatedDatosContacto,
    });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};
