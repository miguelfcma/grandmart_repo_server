import { Usuario } from "../../models/usuariosModel/UsuarioModel.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken"
// Obtener todos los usuarios
export const getUsuarios = async (req, res) => {
  try {
    const usuarios = await Usuario.findAll();
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
    const usuario = await Usuario.findByPk(req.params.id);
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
    email,
    sexo,
    fechaNacimiento,
    telefono,
    password,
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
      email,
      sexo,
      fechaNacimiento,
      telefono,
      password,
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
    console.log(req.body);

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

    // Verificar la contraseña
    // Desencripta la contraseña y compara
    const contrasenaValida = bcrypt.compareSync(password, usuario.password);
    if (!contrasenaValida) {
      return res
        .status(400)
        .json({ message: "Credenciales de inicio de sesión incorrectas" });
    }

    // Crear el token de sesión
    const token = jwt.sign({ userId: usuario.id }, 'secreto', { expiresIn: '1h' });

    // Si se encontró el usuario y la contraseña es válida, incluir el token y el atributo "tipoUsuario" en la respuesta
    return res.status(200).json({
      message: "Inicio de sesión exitoso",
      token,
      usuario: {
        id: usuario.id,
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
