import { ImagenProducto } from "../../models/productosModel/ImagenesProductoModel.js";

export const createImgProducto = async (req, res) => {
    const { url, id_producto } = req.body;
  console.log(req.body)
    try {
    
      const newImgProducto = await ImagenProducto.create({ url, id_producto });
  
      res.status(201).json({ message: "url de imagen de producto creada correctamente" });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: error.message });
    }
  };
  

  export const getImgProducto = async (req, res) => {
    const { id } = req.params;
    console.log(id)
    try {
        const imagenProducto = await ImagenProducto.findOne({
            where: { id_producto: id},
          });
        if (imagenProducto) {
            res.status(200).json(imagenProducto);
        } else {
            res.status(404).json({ message: "Imagen de producto no encontrada" });
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: error.message });
    }
};