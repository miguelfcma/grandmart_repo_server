import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
// Obtener todos los usuarios
export const getUsuarios = async (req, res) => {
  try {
    const usuarios = await Usuario.findAll({
      attributes: [
        "id",
        "nombre",
        "apellidoPaterno",
        "apellidoMaterno",
        "email",
        "sexo",
        "fechaNacimiento",
        "telefono",
        "tipoUsuario",
      ],
    });
    //Validación de existencia
    if (usuarios.length === 0) {
      return res.status(404).json({ message: "No se encontraron usuarios" });
    }
    res.status(200).json(usuarios);
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: error.message });
  }
};

// Obtener un usuario por id
export const getUsuario = async (req, res) => {
  try {
    const usuario = await Usuario.findByPk(req.params.id, {
      attributes: [
        "id",
        "nombre",
        "apellidoPaterno",
        "apellidoMaterno",
        "sexo",
        "fechaNacimiento",
        "telefono",
      ],
    });
    if (!usuario) {
      return res.status(404).json({ message: "Usuario no encontrado" });
    }
    res.status(200).json(usuario);
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: error.message });
  }
};

// Crear un nuevo usuario
export const createUsuario = async (req, res) => {
  const {
    nombre,
    apellidoPaterno,
    apellidoMaterno,
    email,
    sexo,
    fechaNacimiento,
    telefono,
    password,
    tipoUsuario,
  } = req.body;
  try {
    // Buscar si el usuario ya existe
    const existenciaUsuario = await Usuario.findOne({
      where: { email: email },
    });

    // Si el usuario no existe, crea el registro
    const hashedPassword = bcrypt.hashSync(password, 10);
    if (!existenciaUsuario) {
      const newUsuario = await Usuario.create({
        nombre,
        apellidoPaterno,
        apellidoMaterno,
        email,
        sexo,
        fechaNacimiento,
        telefono,
        password: hashedPassword,
        tipoUsuario,
      });
      res.status(201).json({ message: "Usuario creado correctamente" });
    } else {
      // Si el usuario ya existe, devolver un message de error
      return res
        .status(400)
        .json({ message: "El email ya ha sido vinculado a otro perfil!" });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: error.message });
  }
};

// Actualizar un usuario existente
export const updateUsuario = async (req, res) => {
  const {
    nombre,
    apellidoPaterno,
    apellidoMaterno,

    sexo,
    fechaNacimiento,
    telefono,

    tipoUsuario,
  } = req.body;
  try {
    const usuario = await Usuario.findByPk(req.params.id);
    if (!usuario) {
      res.status(404).json({ message: "Usuario no encontrado" });
    }
    // Actualiza el registro usuario con los nuevos valores
    const updateUsuario = await usuario.update({
      nombre,
      apellidoPaterno,
      apellidoMaterno,

      sexo,
      fechaNacimiento,
      telefono,

      tipoUsuario,
    });

    // Envía una respuesta exitosa
    res.status(200).json({ message: "Usuario actualizado correctamente" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: error.message });
  }
};

// Eliminar un usuario existente
export const deleteUsuario = async (req, res) => {
  try {
    const usuario = await Usuario.findByPk(req.params.id);
    //Verifica existencia
    if (!usuario) {
      res.status(404).json({ message: "Usuario no encontrado" });
    }
    await usuario.destroy();
    res.status(200).json({ message: "Usuario eliminado correctamente" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: error.message });
  }
};

export const getUsuarioLogin = async (req, res) => {
  try {
    const { email, password } = req.body;

    // Buscar un usuario con el email recibido
    const usuario = await Usuario.findOne({
      where: { email },
    });
    // IF USUARIO == NULL
    if (!usuario) {
      return res
        .status(400)
        .json({ message: "Credenciales de inicio de sesión incorrectas" });
    }

    // Verificar la contrasena
    // Desencripta la contrasena y compara
    const contrasenaValida = bcrypt.compareSync(password, usuario.password);
    if (!contrasenaValida) {
      return res
        .status(400)
        .json({ message: "Credenciales de inicio de sesión incorrectas" });
    }

    // Crear el token de sesión
    const token = jwt.sign({ userId: usuario.id }, "secreto", {
      expiresIn: "8h",
    });

    // Si se encontró el usuario y la contrasena es válida, incluir el token y el atributo "tipoUsuario" en la respuesta
    return res.status(200).json({
      message: "Inicio de sesión exitoso",
      token,
      usuario: {
        id: usuario.id,
        nombre: usuario.nombre,
        apellidoPaterno: usuario.apellidoPaterno,
        apellidoMaterno: usuario.apellidoMaterno,
        email: usuario.email,
        tipoUsuario: usuario.tipoUsuario,
      },
    });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ message: "Ha ocurrido un error en el servidor" });
  }
};

export const actualizarPerfilUsuario = async (req, res) => {
  console.log(req.body);
  const {
    nombre,
    apellidoPaterno,
    apellidoMaterno,
    sexo,
    fechaNacimiento,
    telefono,
  } = req.body;
  try {
    const usuario = await Usuario.findByPk(req.params.id);
    if (!usuario) {
      res.status(404).json({ message: "Usuario no encontrado" });
    }
    // Actualiza el registro usuario con los nuevos valores
    const updateUsuario = await usuario.update({
      nombre,
      apellidoPaterno,
      apellidoMaterno,
      sexo,
      fechaNacimiento,
      telefono,
    });

    // Envía una respuesta exitosa
    res.status(200).json({
      message: "Usuario actualizado correctamente",
      usuario: updateUsuario,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: error.message });
  }
};
export const actualizarContrasenaUsuario = async (req, res) => {
  console.log(req.body)
  const { contrasenaActual, nuevaContrasena } = req.body;
 
  const usuarioId = req.params.id;

  try {
    const usuario = await Usuario.findByPk(usuarioId);
    if (!usuario) {
      return res.status(404).json({ message: "Usuario no encontrado" });
    }

    // Verificar si la contrasena actual coincide con la almacenada en el usuario
    const esContrasenaValida = await bcrypt.compare(
      contrasenaActual,
      usuario.password
    );
    if (!esContrasenaValida) {
      return res
        .status(400)
        .json({ message: "La contraseña actual no es correcta" });
    }

    // Encriptar la nueva contrasena
    const nuevaContrasenaEncriptada = await bcrypt.hash(nuevaContrasena, 10);

    // Actualizar la contrasena del usuario con la nueva contrasena encriptada
    usuario.password = nuevaContrasenaEncriptada;
    await usuario.save();

    // Envía una respuesta exitosa
    return res
      .status(200)
      .json({ message: "contraseña actualizada correctamente" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: error.message });
  }
};
