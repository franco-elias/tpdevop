const express = require('express');
const router = express.Router();
const conexion = require('./database/db');





router.get('/', (req,res)=>{
   
    conexion.query(`SELECT * From Pais p inner join Usuario u on(p.IdPais = u.Pais_residencia) inner join Localidad l on(u.CodLocalidad=l.IdLocalidad) `,  
    (error,results)=>{
        if(error){
            throw error;    
        }else{
         
            res.render('index', {results:results});
            
        }
    })
});

router.get('/usuarios', (req, res) => {
    res.redirect('/');
});



// Ruta para la página de disponibilidad de rodados
router.get('/disponibilidad', (req, res) => {
    conexion.query(
        `SELECT 
        COUNT(DISTINCT d.idRodado) AS Cantidad_Rodados_Disponibles, p.nombre
        
    FROM  Puesto p INNER JOIN Anclaje a ON (p.idPuesto = a.idPuesto)
    INNER JOIN Disponibilidad d ON (a.idAnclaje = d.idAnclaje) INNER JOIN
    Rodados r ON (d.idRodado = r.idRodado)
    WHERE
        d.hora_estado = '13:00:00' AND a.idEstadosAnclaje = 1
    GROUP BY d.idRodado, p.nombre;`,
        (error, rodados) => {
            if (error) {
                throw error;
            } else {
                
                res.render('disponibilidad', { rodados: rodados});
            }
        }
    );
   

  
});

// Ruta para la página de disponibilidad de Anclaje
router.get('/anclajes', (req, res) => {
    conexion.query(
        `SELECT 
        COUNT(DISTINCT a.idAnclaje) AS cantidad, p.nombre
        
    FROM  Puesto p INNER JOIN Anclaje a ON (p.idPuesto = a.idPuesto)
    INNER JOIN Disponibilidad d ON (a.idAnclaje = d.idAnclaje) 
    WHERE
        d.hora_estado = '13:00:00' AND a.idEstadosAnclaje = 2 AND 
        d.fecha_estado = '2021-04-12'
    GROUP BY a.idAnclaje, p.nombre;`,
        (error, anclaje) => {
            if (error) {
                throw error;
            } else {
                
                res.render('anclajes', { anclaje: anclaje});
            }
        }
    );
   

  
});






//rutas para editar registros
router.get('/edit/:CUIL', (req,res)=> {

    let CUIL = req.params.CUIL;
   

    let sql = "SELECT * FROM Usuario  WHERE CUIL=?";
       
    conexion.query(sql,[CUIL], function(error, results){
        if(error){
            throw(error);
        }else{
            res.render('edit', {datos:results[0]});
            console.log(results[0].CUIL);
           
        }
        
    });
    
});

router


//Rutas para crear registros
router.get('/create', (req,res)=>{
    res.render('create');
})

const crudController = require('./controllers/crud');
router.post('/save', crudController.save);
router.put('/update', crudController.update);

//RUTA ELIMINAR

router.get('/delete/:CUIL', (req, res)=>{
    const CUIL = req.params.CUIL;
    conexion.query('DELETE FROM Usuario WHERE CUIL = ?', [CUIL], (error, results)=>{

        if(error){
            throw error;
        }else{
            res.redirect('/');
        }


    });
    
    
})



module.exports = router;