import { DenunciaBuzon } from "../../models/buzonModel/BuzonModel.js";
import { DenunciaBuzonServicio } from "../../models/buzonModel/BuzonModelServicio.js";
import { Producto } from "../../models/productosModel/ProductoModel.js";
import { Servicio } from "../../models/serviciosModel/ServicioModel.js";
import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";

// Crear una nueva denuncia para producto
export const createDenuncia = async (req, res) => {
  try {
    const { motivo, descripcion, id_usuario, id_producto } = req.body;
    console.log(req.body)
    const denuncia = await DenunciaBuzon.create({
      motivo,
      descripcion,
      id_usuario,
      id_producto
    });
    res.status(201).json(denuncia);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Crear una nueva denuncia para servicio
export const createDenunciaServicio = async (req, res) => {
  try {
    const { motivo, descripcion, id_usuario, id_servicio } = req.body;
    console.log(req.body)
    const denuncia = await DenunciaBuzonServicio.create({
      motivo,
      descripcion,
      id_usuario,
      id_servicio
    });
    res.status(201).json(denuncia);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Obtener todas las denuncias asociadas a un producto
export const getDenunciasByIdProducto = async (req, res) => {
  try {
    const { id_producto } = req.params;
    const denuncias = await DenunciaBuzon.findAll({ where: { id_producto } });

    if (denuncias.length === 0) {
      return res.status(404).json({ message: "No se encontraron denuncias" });
    }
    const denunciasConUsuarioYProducto = await Promise.all(denuncias.map(async motivo => {
      const producto = await Producto.findByPk(motivo.id_producto, { attributes: ['id', 'nombre'] });
      const usuario = await Usuario.findByPk(motivo.id_usuario, { attributes: ['id', 'nombre'] });
      return { ...motivo.toJSON(), producto, usuario };
    }));

    res.status(200).json(denunciasConUsuarioYProducto);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};

// Obtener todas las denuncias asociadas a un servicio
export const getDenunciasByIdServicio = async (req, res) => {
  try {
    const { id_servicio } = req.params;
    const denuncias = await DenunciaBuzonServicio.findAll({ where: { id_servicio } });

    if (denuncias.length === 0) {
      return res.status(404).json({ message: "No se encontraron denuncias" });
    }
    const denunciasConUsuarioYServicio = await Promise.all(denuncias.map(async motivo => {
      const servicio = await Servicio.findByPk(motivo.id_servicio, { attributes: ['id', 'titulo'] });
      const usuario = await Usuario.findByPk(motivo.id_usuario, { attributes: ['id', 'nombre'] });
      return { ...motivo.toJSON(), servicio, usuario };
    }));

    res.status(200).json(denunciasConUsuarioYServicio);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};


// Obtener todas las denuncias por usser ID
export const getDenunciasByUserId = async (req, res) => {
  try {
    const denuncias = await DenunciaBuzon.findAll({
      where: { id_usuario: req.params.id },
    });
    res.json(denuncias);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Obtener productos del usuario con denuncias asociadas
export const getProductosConDenunciasByUsuarioId = async (req, res) => {
  try {
    const { id_usuario } = req.params;

    // Buscar productos del usuario por su ID de usuario
    const productos = await Producto.findAll({ where: { id_usuario } });

    if (productos.length === 0) {
      return res.status(404).json({ message: "No se encontraron productos para el usuario especificado" });
    }

    const productosConDenuncias = await Promise.all(productos.map(async producto => {
      // Buscar denuncias asociadas al producto
      const denuncias = await DenunciaBuzon.findAll({ where: { id_producto: producto.id } });

      if (denuncias.length > 0) {
        // Si el producto tiene denuncias asociadas, agregarlas como propiedad al objeto de producto
        return { ...producto.toJSON(), denuncias };
      } else {
        // Si el producto no tiene denuncias asociadas, devolver null
        return null;
      }
    }));

    // Filtrar los productos nulos (que no tienen denuncias asociadas)
    const productosConDenunciasFiltrados = productosConDenuncias.filter(producto => producto !== null);

    res.status(200).json(productosConDenunciasFiltrados);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};

// Obtener productos del usuario con denuncias asociadas
export const getServiciosConDenunciasByUsuarioId = async (req, res) => {
  try {
    const { id_usuario } = req.params;

    // Buscar productos del usuario por su ID de usuario
    const servicios = await Servicio.findAll({ where: { id_usuario } });

    if (servicios.length === 0) {
      return res.status(404).json({ message: "No se encontraron productos para el usuario especificado" });
    }

    const serviciosConDenuncias = await Promise.all(servicios.map(async servicio => {
      // Buscar denuncias asociadas al servicio
      const denuncias = await DenunciaBuzonServicio.findAll({ where: { id_servicio: servicio.id } });

      if (denuncias.length > 0) {
        // Si el servicio tiene denuncias asociadas, agregarlas como propiedad al objeto de producto
        return { ...servicio.toJSON(), denuncias };
      } else {
        // Si el servicio no tiene denuncias asociadas, devolver null
        return null;
      }
    }));

    // Filtrar los servicios nulos (que no tienen denuncias asociadas)
    const serviciosConDenunciasFiltrados = serviciosConDenuncias.filter(servicio => servicio !== null);

    res.status(200).json(serviciosConDenunciasFiltrados);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
};

//  Eliminar una denuncia por su ID
export const eliminarDenuncia = async (req, res) => {
  const { id_denuncia } = req.params;
  
  try {
    // Buscar la denuncia por su ID
    const denuncia = await DenunciaBuzon.findByPk(id_denuncia);
    if (denuncia) {
      await denuncia.destroy();
      res.json({ message: "Denuncia eliminada correctamente" });
    } else {
      res.status(404).json({ message: "Denuncia no encontrada" });
    }
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

//  Eliminar una denuncia por su ID
export const eliminarDenunciaServicio = async (req, res) => {
  const { id_denuncia } = req.params;
  
  try {
    // Buscar la denuncia por su ID
    const denuncia = await DenunciaBuzonServicio.findByPk(id_denuncia);
    if (denuncia) {
      await denuncia.destroy();
      res.json({ message: "Denuncia eliminada correctamente" });
    } else {
      res.status(404).json({ message: "Denuncia no encontrada" });
    }
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Obtener todas las denuncias
export const getAllDenuncias = async (req, res) => {
  try {
    const denuncias = await DenunciaBuzon.findAll();

    const denunciasConUsuarioYProducto = await Promise.all(denuncias.map(async motivo => {
      const producto = await Producto.findByPk(motivo.id_producto, { attributes: ['id', 'nombre', 'id_usuario'] });

      const usuario = await Usuario.findByPk(motivo.id_usuario, { attributes: ['id', 'nombre', 'apellidoPaterno', 'apellidoMaterno'] });

      const usuarioProducto = await Usuario.findByPk(producto.id_usuario, { attributes: ['id', 'nombre', 'apellidoPaterno', 'apellidoMaterno'] });
      return { ...motivo.toJSON(), producto, usuario,usuarioProducto };
    }));
    return res.status(200).json(denunciasConUsuarioYProducto);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

// Obtener todas las denuncias
export const getAllDenunciasServicio = async (req, res) => {
  try {
    const denuncias = await DenunciaBuzonServicio.findAll();

    const denunciasConUsuarioYServicio = await Promise.all(denuncias.map(async motivo => {
      const servicio = await Servicio.findByPk(motivo.id_servicio, { attributes: ['id', 'titulo', 'id_usuario'] });

      const usuario = await Usuario.findByPk(motivo.id_usuario, { attributes: ['id', 'nombre', 'apellidoPaterno', 'apellidoMaterno'] });

      const usuarioServicio = await Usuario.findByPk(servicio.id_usuario, { attributes: ['id', 'nombre', 'apellidoPaterno', 'apellidoMaterno'] });
      return { ...motivo.toJSON(), servicio, usuario,usuarioServicio };
    }));
    return res.status(200).json(denunciasConUsuarioYServicio);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const actualizarDenunciaARevisada = async (req, res) => {
  const { id_denuncia } = req.params;
  
  try {
    // Buscar la denuncia por su ID
    const denuncia = await DenunciaBuzon.findByPk(id_denuncia);
    if (!denuncia) {
      return res
        .status(404)
        .json({ error: `La denuncia con id ${id_denuncia} no existe` });
    }
    // Actualizar el estado de la denuncia
    if (denuncia.revisar === false) {
        denuncia.revisar = 1;
    } else{
      return res.status(400).json({ error: "La denuncia ya ha sido revisada "})
    }
    await denuncia.save();

    return res.status(200).json(denuncia);
  } catch (error) {
    console.error("Error al actualizar el estado de la denuncia:", error.message);
    return res
      .status(500)
      .json({ error: "Error al actualizar el estado de la denuncia" });
  }
};

export const actualizarDenunciaARevisadaServicio = async (req, res) => {
  const { id_denuncia } = req.params;
  
  try {
    // Buscar la denuncia por su ID
    const denuncia = await DenunciaBuzonServicio.findByPk(id_denuncia);
    if (!denuncia) {
      return res
        .status(404)
        .json({ error: `La denuncia con id ${id_denuncia} no existe` });
    }
    // Actualizar el estado de la denuncia
    if (denuncia.revisar === false) {
        denuncia.revisar = 1;
    } else{
      return res.status(400).json({ error: "La denuncia ya ha sido revisada "})
    }
    await denuncia.save();

    return res.status(200).json(denuncia);
  } catch (error) {
    console.error("Error al actualizar el estado de la denuncia:", error.message);
    return res
      .status(500)
      .json({ error: "Error al actualizar el estado de la denuncia" });
  }
};




