const express = require('express');
const mysql = require('mysql');
const app = express();

const credentials = {
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'grandmart_db'
}

app.use(express.json());

app.post('http://127.0.0.1:5173/login', (req, res) => {
    const { email, password} = req.body;
    const values = [email, password];
    const connection = mysql.createConnection(credentials);
  
    connection.query('SELECT * FROM usuarios WHERE email = ? AND password = ?', values, (err, result) => {
      if (err) {
        res.status(500).send(err);
      } else {
        if (result.length > 0) {
          res.status(200).send({
            id: result[0].id,
            nombre: result[0].nombre,
            email: result[0].email
          });
        } else {
          res.status(400).send('Usuario no existe');
        }
      }
    });
  
    connection.end();
  });
  
