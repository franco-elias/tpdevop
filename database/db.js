const mysql = require('mysql2');

var conexion = mysql.createConnection({
    host:'sistema-bicicleta-db',
    port:3306,
    user:'root',
    password:'qwert123',
    database:'SistemaBicicleta' 
})

conexion.connect(function (error) {
    if(error){

        throw error;   
    }else{
        console.log("conexion exitosa a la base de Datos");
    }
})

module.exports = conexion;

