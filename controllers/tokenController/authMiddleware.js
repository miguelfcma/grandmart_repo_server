import jwt from "jsonwebtoken"

// Middleware para verificar el token JWT
export const verificarToken = (req, res, next) => {
  // Verificar si el encabezado Authorization está presente
  const authHeader = req.headers.authorization;
  if (!authHeader) {
    return res.status(401).json({ error: 'Falta el encabezado Authorization' });
  }

  // Verificar si el encabezado Authorization tiene el formato correcto
  const parts = authHeader.split(' ');
  if (parts.length !== 2 || parts[0] !== 'Bearer') {
    return res.status(401).json({ error: 'Formato de encabezado Authorization incorrecto' });
  }

  // Extraer el token JWT del encabezado Authorization
  const token = parts[1];

  // Verificar el token JWT
  try {
    const decoded = jwt.verify(token, 'secreto');
    req.userId = decoded.userId;
    next();
  } catch (error) {
    return res.status(401).json({ message: 'Token JWT inválido' });
  }
};

// Ruta que responde cuando el token es válido
export function tokenValido(req, res) {
  res.status(200).json({ message: "Acceso permitido" });
}
