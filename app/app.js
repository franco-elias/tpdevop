const express = require('express');
const app = express();
const methodOverride = require('method-override');

app.use(methodOverride('_method'));
app.set('view engine', 'ejs');

app.use(express.urlencoded({ extended: false }));

app.use(methodOverride('_method'));

app.use(express.json());


app.use('/', require('./router'));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor en ejecución en http://localhost:${PORT}`);
});

/*    
DB_HOST: sistema-bicicleta-db
DB_PORT: 3306
DB_USER: root
DB_PASSWORD: qwert123
DB_NAME: SistemaBicicleta  */
