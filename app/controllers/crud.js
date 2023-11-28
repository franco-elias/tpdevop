const conexion = require('../database/db');

exports.save = (req,res)=>{
  

    let data ={CUIL:req.body.cuil, Nombre:req.body.user, Apellido:req.body.apellido, DNI:req.body.dni,
        Tipodocumento:req.body.origen, email:req.body.email, Imagen_rostro: req.body.Imagen_rostro,
        Fecha_nacimiento:req.body.nacimiento, Direccion:req.body.direccion, CodLocalidad:req.body.localidad,
        Pais_residencia:req.body.paisresi, estado:req.body.estado};
        
        let sql = "INSERT INTO Usuario SET ?";

        conexion.query(sql, data, function(error, results){
            if(error){
                throw error;
            }else{
                res.redirect('/usuarios');
            }
    
        });
    }


exports.update = (req, res) => {
    console.log('Received PUT request');
    console.log('req.params:', req.params);
    console.log('req.body:', req.body);
    let CUIL = req.body.cuil;
    let data = {
        Nombre: req.body.user,
        Apellido: req.body.apellido,
        DNI: req.body.dni,
        Tipodocumento: req.body.origen,
        email: req.body.email,
        Fecha_nacimiento: req.body.nacimiento,
        Direccion: req.body.direccion,
        CodLocalidad: req.body.localidad,
        Pais_residencia: req.body.paisresi,
        estado: req.body.estado
    };

    console.log(CUIL);

    console.log(data);

    let sql = "UPDATE Usuario SET ? WHERE CUIL = ?";
    console.log('SQL Query:', sql);

    conexion.query(sql, [ data, CUIL], function (error, results) {
        console.log(results);
        if (error) {
            // Manejar el error de manera adecuada, por ejemplo, enviando un mensaje al cliente
            console.error("Error al actualizar el usuario:", error);
            res.status(500).send("Error interno del servidor");
        } else {
            res.redirect('/usuarios');
        }
    });
};