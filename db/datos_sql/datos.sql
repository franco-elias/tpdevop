

use SistemaBicicleta;



create table Pais(
	IdPais int auto_increment not null,
    nombrePais varchar(60),
    constraint PK_ID_pais primary key(IdPais)
    
);
/*Table Localidad*/
create table Localidad(
	IdLocalidad int auto_increment not null,
    nombreLocalidad varchar(60),
    constraint PK_LOC primary key (IdLocalidad)
);

/* Crear TIpo  */

create table TipoDocumento(
	
    id_documento int not  null,
    descripcion varchar(20) not null,
    pais_origen int  not null,
    constraint PK_ID_DOC primary key(id_documento),
    constraint FK_P_Origen foreign key (pais_origen) references Pais(idPais)
);

create table EstadoUsuario(
	idEstado int not null,
	descripcion varchar(20),
	constraint PK_ESTADO_USUARIO primary key(idEstado)
);
/*Tipo de usuario*/

create table TipoUsuario(
	idTipoUsuario varchar (1), 
    descripcion varchar(20),
    constraint PK_IDT_Usuario primary key (idTipoUsuario)
);


/*Table Usuario*/

create table Usuario(
	CUIL bigint not null,
	Nombre varchar(30) not null,
    Apellido varchar(30) not null,
    DNI int not null,
    Tipodocumento int not null, 
	email varchar (250),
    Imagen_rostro blob Null,
    Fecha_nacimiento datetime null,
    Direccion varchar(60) not null,
    CodLocalidad int  not null,
    Pais_residencia int not null,
    estado int not null,
    constraint PK_CUIL primary key (CUIL),
	constraint foreign key (Tipodocumento) references TipoDocumento (id_documento),
    constraint FK_pais_residencia foreign key (Pais_residencia) references Pais(IdPais),
	constraint FK_codLoc foreign key ( CodLocalidad) references Localidad(IdLocalidad),
    constraint FK_COD_ESTADO foreign key (estado) references  EstadoUsuario(idEstado)
);



/* Accesos*/
create table Acceso(
	idAcceso varchar(10) not null, 
    CUIL bigint  not null,
    `Password` varchar(20),
    email varchar(250),
    idTipoUsuario varchar(1) not null,
    constraint PK_ID_Access primary key (idAcceso),
    constraint FK_CUIL foreign key (CUIL) references Usuario(CUIL),
    constraint FK_ID_TIPO_USer foreign key (idTipoUsuario) references TipoUsuario(idTipoUsuario)
);

/*Tabla Puestos*/

create table Puesto(
	idPuesto varchar(15) not null,
    nombre varchar(60) not null,
    direccion varchar (60), 
    idLocalidad int not null,
    longitud varchar (20) not null,
    laitud varchar(20) not null,
    constraint PK_PUESTO primary key (idPuesto),
    constraint FK_Localidad foreign key(idLocalidad) references Localidad(IdLocalidad)
);



create table TipoModelo(
	idModelo int not null,
    descripcion varchar(40),
    constraint PK_TIPO_MODEL primary key (idModelo)
);
-- Causa Danios

create table causa(
	idcausa int not null,
    detalle varchar(50),
    constraint PK_CAUSA primary key (idcausa)
);

-- Registro Danios

create table RegistrosRodados(
	idRegistro int auto_increment not null,
    IdCausa int not null,
    Evoluvion_estado varchar(200),
    TipoReparacion varchar(200) null,
    fechaHoraIncio datetime null,
    fechaHoraFin datetime null,
    constraint PK_id_Reg_rod primary key(idRegistro),
    constraint FK_CAUSA foreign key (IdCausa) references causa(idcausa)
);


-- Estado de Rodados
create table EstadoRodados(
	idEstadoRodado int not null,
    DescripcionEstdo varchar (20)not null ,
    
	constraint primary key (idEstadoRodado)
       
);



/*Tabla Rodados*/

create table Rodados(
	idRodado varchar(10) not null,
	idModelo int not null,
    idEstadoRodado int not null,
    idRegistros int not null,
    nombre varchar(10),
    descripcion varchar(20),
   
    constraint PK_ID_RODADOS primary key(idRodado),
    constraint FK_ROD_MOD foreign key(idModelo) references TipoModelo(idModelo),
    constraint FK_Estado_Rodad foreign key(idEstadoRodado) references EstadoRodados(idEstadoRodado),
    constraint FK_ERGISTROS_ESTADO foreign key(idRegistros) references RegistrosRodados(idRegistro) 
);

  

create table EstadosAnclaje(
	IdEstadoAnclaje int not null,
	nombreestado varchar(15) not null,
    
    constraint PK_Id_estado primary key (idEstadoAnclaje)
);


create table Anclaje(
	idAnclaje varchar(10) not null,
	idEstadosAnclaje int not null,
    nombre varchar (20) not null,
	descripcion varchar (20) not null,
    idPuesto varchar(15) not null,
	
    constraint PK_ID_ANCL primary key (idAnclaje),
    constraint FK_PUEST foreign key(idPuesto) references Puesto(idPuesto),
    constraint FK_Estado_Anclaje foreign key(idEstadosAnclaje) references EstadosAnclaje(IdEstadoAnclaje)  
    
);



create table Disponibilidad(
	-- idDisponibilidad int auto_increment not null,
	idRodado varchar(10) not null,
    idAnclaje varchar(10)not null,
	
    fecha_estado date,
    hora_estado  time,
    constraint PK_DISPON primary key (idRodado, idAnclaje),
    constraint FK_ANCLAJE foreign key(idAnclaje) references Anclaje(idAnclaje),
	
    constraint FK_Rodado foreign key(idRodado) references Rodados(idRodado)
   
);


create table Viaje(
	 idViaje varchar(20) not null,
     fechaincio date not null,
     horainico time not null,
     fechafin date null,
     horafin time null,
     idAnclajeinicio varchar (10)  null,
     idAnclajeDestino varchar (10)  null,
     idCuil bigint not null,
     constraint PK_VIAJE primary key (idViaje),         

     constraint FK_Ancalaje_Init foreign key(idAnclajeinicio) references Disponibilidad(idAnclaje),
     constraint FK_Ancalje_FIN foreign key(idAnclajeDestino) references  Anclaje(IdAnclaje),
     constraint FK_Usuario foreign key(idCuil) references Usuario(CUIL)
     
);

/*Datos Pais*/
insert into Pais values(1, "Argentina");
insert into Pais values(2, "Brasil");
insert into Pais values(3, "Canada");
insert into Pais values(4, "Uruguay");
insert into Pais values(5, "Venezuela");
insert into Pais values(6, "Colombia");

/*Datos Localidades*/

insert into Localidad values(1001, "Capital Federal");
insert into Localidad values(1002, "Moreno");
insert into Localidad values(1003, "La Plata");
insert into Localidad values(1004, "Quilmes");
insert into Localidad values(1005, "Bernal");


/*Datos DNI*/

insert into TipoDocumento values(1, 'EXTRANJERO', 3);
insert into TipoDocumento values(2, 'NATIVO', 1);

/* Usuarios estados*/
insert into EstadoUsuario values(1, 'activo');
insert into EstadoUsuario values(2, 'Inactico');
insert into EstadoUsuario values(3, 'Sin Validar');



/*Datos Usuarios*/

insert into Usuario values(24298764567,'JONES','TERRY',29876456 ,1, null, null, '1982-04-01',"Aguirre 2674", 1001, 3, 1);
insert into Usuario values(20300988999,"JUAN","MESSA",30098899 ,2, null, null, '1983-05-26',"Aguirre 2674", 1001, 1, 1);
insert into Usuario values(22292344986,"RUBERTO","SANCHEZ",29234498 ,2, null, null, '1982-09-01',"Aguirre 2674", 1001, 1, 1);
insert into Usuario values(26297765427,"JAIME","COLL",29776542 ,2, null, null, '1982-12-20',"Aguirre 2674", 1001, 1, 1);
insert into Usuario values(22358764563,"BERNARDO","FLORES",35876456 ,2, null, null, '1970-04-12',"Aguirre 2674", 1001, 1, 1);
insert into Usuario values(28299964567,"CARLOS","TORRES",29996458 ,2, null, null, '1982-10-08',"Aguirre 2674", 1001, 1, 1);
insert into Usuario values(22307645674,"RAMIRO","MALO",30764567 ,2, null, null, '1984-04-15',"Aguirre 2674", 1001, 1, 1);
insert into Usuario values(23298764266,"DARIO","PEDERNERA",29876426 ,2, null, null, '1981-08-24',"Aguirre 2674", 1001, 1, 1);
insert into Usuario values(28308764564,"FEDRICO","PEREZ",30876456 ,2, null, null, '1983-03-18',"Aguirre 2674", 1001, 1, 1);
insert into Usuario values(20277764553,"CARLOS","FLORES",227776455 ,2, null, null, '1925-07-11',"Aguirre 2674", 1001, 1, 1);


insert into TipoUsuario values('A', 'diario');
insert into TipoUsuario values('B', 'turistuco');
insert into TipoUsuario values('C', 'ejercicio');

/*Dato Accesos*/

insert into Acceso values('A1', 24298764567, "passsword", "jones@imeil.com", 'A');
insert into Acceso values('A2', 20300988999, "passsword", "j2023@imeil.com", 'B');
insert into Acceso values('A3', 22292344986, "passsword", "uhola@imeil.com", 'A');
insert into Acceso values('A4', 26297765427, "passsword", "uquetal@imeil.com", 'A');
insert into Acceso values('A5', 22358764563, "passsword", "usuario3@imeil.com", 'C');
insert into Acceso values('A6', 22307645674, "passsword", "usuario4@imeil.com", 'C');
insert into Acceso values('A7', 28299964567, "passsword", "usuario5@imeil.com", 'B');


/*	Table Puestos*/
    
insert into Puesto values ('54BAEcobici', 'Acuña de Figueroa', 'Lavalle 4015', 1001, '-58.4220694', '-34.5982097');
insert into Puesto values ('61BAEcobici', 'AV.ALVAREZ JONTE Y BENITO JUAREZ', 'Benito Juarez 2205', 1001, '-58.5046629161428', '-34.6188086776509');
insert into Puesto values ('111BAEcobici', 'MACACHA GUEMES', 'Machaca Guemes 350', 1001, '-58.3646858', '-34.6054877');
insert into Puesto values ('1134BAEcobici', 'SOLDADO DE LA FRONTERA', 'Soldado de la Frontera 4999', 1001, '58.4659', '-34.68294');
insert into Puesto values ('151BAEcobici', 'AIME PAINÉ', 'Villaflor, Azucena & Paine, Aime', 1001, '-58.361285', '-34.6118145');
insert into Puesto values ('64BAEcobici', 'RIOBAMBA', 'Riobamba 1264 & Juncal', 1001, '-58.3941087', '-34.5936508');
insert into Puesto values ('453BAEcobici', 'Plaza de la Bandera', 'Av. Gaona 5181', 1001, '-58.4944854', '-34.6294802');
insert into Puesto values ('79BAEcobici', 'AZUCENA VILLAFLOR', 'Villaflor, Azucena & Dealessi, Pierina', '1001', '-58.36393', '-34.61189');
insert into Puesto values ('134BAEcobici', 'SOLDADO DE LA FRONTERA', 'Soldado de la Frontera 4999', 1001, '-58.4659', '-34.68294');
insert into Puesto values ('91BAEcobici', 'Pasco', '708 Pasco & Chile', 1001, '-58.397602', '-34.6174482');

-- Modelos

insert into TipoModelo values(1, 'FIT');
insert into TipoModelo values (2, 'ICONIC');

-- tipo causa

insert into causa values(1, 'sin causa, rodado activo');
insert into causa values(2, 'Desprfecto de fabrica');
insert into causa values(3, 'inoperancia del usuario');
insert into causa values(4, 'no se sabe');
insert into causa values(5, 'deterioro con eltimepo');



/*
	Registros
*/    

insert into RegistrosRodados values (1, 1, null, null, '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (2, 4, 'cadena rota', 'se compro la cadena nueva, etapa final',  '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (3, 2, 'Piñon Roto', 'esperadno la pieza',  '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (4, 3, 'Se sale la cadena', null,  '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (5, 2, 'orquillla rota', 'comprar orquilla, epreando pieza',  '2019-04-12 8:00:00', null);
insert into RegistrosRodados values (6, 2, 'orquillla rota', 'comprar orquilla, epreando pieza',  '2019-05-10 10:00:00', null);
insert into RegistrosRodados values (7, 2, 'orquillla rota', 'comprar orquilla, epreando pieza',  '2018-03-1 12:00:00', null);
insert into RegistrosRodados values (8, 2, null, null,  '2019-04-14 8:00:00', null);
insert into RegistrosRodados values (9, 2, 'Piñon Roto', 'Comprar nuevo, epreando pieza',  '2020-05-08 18:32:00', null);
insert into RegistrosRodados values (10, 2, 'Piñon Roto', 'Comprar nuevo, epreando pieza',  '2020-06-08 18:32:00', null);
insert into RegistrosRodados values (11, 1, null, null, '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (12, 1, null, null, '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (13, 1, null, null, '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (14, 1, null, null, '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (15, 1, null, null, '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (16, 1, null, null, '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (17, 1, null, null, '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (18, 1, null, null, '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (19, 1, null, null, '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (20, 1, null, null, '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (21, 1, null, null, '2020-04-12 13:00:00', null);
insert into RegistrosRodados values (22, 1, null, null, '2020-04-12 13:00:00', null);



-- Estado Rodados 


insert into EstadoRodados values (1, 'activo');
insert into EstadoRodados values (2, 'Desperfetco');
insert into EstadoRodados values (3, 'En reparacion');
insert into EstadoRodados values (4, 'inactivo');
									

/* 
	Rodados 

*/

insert into Rodados values('ECO-1', 1, 1, 11, 'Urbano1', 'Rodado Ecologico');
insert into Rodados values('ECO-3', 1, 1, 12, 'Urbano2', 'Rodado Ecologico'); 
insert into Rodados values('ECO-4', 1, 1, 13, 'Urbano3', 'Rodado Ecologico'); 
insert into Rodados values('DEP-1', 2, 1, 14, 'Urbano-D1', 'Rodado deportivo');
insert into Rodados values('DEP-2', 2, 1, 15, 'Urbano-D2', 'Rodado deportivo');
insert into Rodados values('ECO-5', 2, 1, 16, 'Urbano4', 'Rodado Ecologico'); 
insert into Rodados values('DEP-3', 2, 1, 17, 'Urbano-D3', 'Rodado deportivo');
insert into Rodados values('ECO-6', 1, 1, 18, 'Urbano5', 'Rodado Ecologico'); 
insert into Rodados values('ECO-7', 1, 1, 19, 'Urbano6', 'Rodado Ecologico'); 
insert into Rodados values('ECO-8', 1, 1, 20, 'Urbano7', 'Rodado Ecologico'); 
insert into Rodados values('ECO-9', 1 ,1, 21, 'Urbano8', 'Rodado Ecologico'); 
insert into Rodados values('ECO-10', 1, 1, 22, 'Urbano9', 'Rodado Ecologico'); 
insert into Rodados values('ECO-11', 1, 3, 2, 'Urbano7', 'Rodado Ecologico'); 
insert into Rodados values('ECO-12', 1, 2, 11, 'Urbano1', 'Rodado Ecologico');



-- estados Anclaje

insert into EstadosAnclaje values('1', 'NO DIPSONIBLE');
insert into EstadosAnclaje values('2','DISPONIBLE');
insert into EstadosAnclaje values('3','LIBRE');
insert into EstadosAnclaje values('4','RESERVADO'); 

/*	Anclaje 	*/

insert into Anclaje values(1,1, 'AA1', 'anclaje1', '54BAEcobici'); 
insert into Anclaje values(2,2, 'AA2', 'anclaje2', '54BAEcobici');
insert into Anclaje values(3,1, 'AA3', 'anclaje3', '54BAEcobici');
insert into Anclaje values(4,1, 'AA4', 'anclaje4', '54BAEcobici');
insert into Anclaje values(5,1,  'AA5', 'anclaje5', '54BAEcobici');
insert into Anclaje values(6,1, 'BB1', 'anclaje1', '61BAEcobici');
insert into Anclaje values(7,1, 'BB2', 'anclaje2', '61BAEcobici');
insert into Anclaje values(8,1, 'BB3', 'anclaje3', '61BAEcobici');
insert into Anclaje values(9,2, 'BB4', 'anclaje4', '61BAEcobici');
insert into Anclaje values(10,1,  'CC1', 'anclaje1', '111BAEcobici');
insert into Anclaje values(11,1, 'CC2', 'anclaje2', '111BAEcobici');
insert into Anclaje values(12,1, 'CC3', 'anclaje3', '111BAEcobici');
insert into Anclaje values(13,1,  'CC4', 'anclaje4', '111BAEcobici');
insert into Anclaje values(14,1,  'DD1', 'anclaje1', '1134BAEcobici');
insert into Anclaje values(15,1,  'DD2', 'anclaje2', '1134BAEcobici');
insert into Anclaje values(16,2,  'DD3', 'anclaje3', '1134BAEcobici');
insert into Anclaje values(17,2,  'EE1', 'anclaje1', '151BAEcobici');
insert into Anclaje values(18,2,  'EE2', 'anclaje2', '151BAEcobici');
insert into Anclaje values(19,1,  'FF1', 'anclaje1', '64BAEcobici');
insert into Anclaje values(20,3,  'FF2', 'anclaje2', '64BAEcobici');
insert into Anclaje values(21,3,  'FF3', 'anclaje3', '64BAEcobici');
insert into Anclaje values(22,3,  'GG1', 'anclaje1', '453BAEcobici');
insert into Anclaje values(23,1,  'GG2', 'anclaje2', '453BAEcobici');
insert into Anclaje values(24,1,  'GG3', 'anclaje2', '453BAEcobici');
insert into Anclaje values(25,1,  'HH1', 'anclaje2', '79BAEcobici');
insert into Anclaje values(26,2,  'HH2', 'anclaje2', '79BAEcobici');
insert into Anclaje values(27,1,  'HH3', 'anclaje2', '79BAEcobici');
insert into Anclaje values(28,2,  'II1', 'anclaje2', '134BAEcobici');
insert into Anclaje values(29,1,  'II2', 'anclaje2', '134BAEcobici');
insert into Anclaje values(30,3,  'II3', 'anclaje2', '134BAEcobici');
insert into Anclaje values(31,3,  'JJ1', 'anclaje2', '91BAEcobici'); 
insert into Anclaje values(32,3,  'JJ2', 'anclaje2', '91BAEcobici'); 
insert into Anclaje values(33,3,  'jj3', 'anclaje2', '91BAEcobici'); 
insert into Anclaje values(34,1, 'AA1', 'anclaje1', '54BAEcobici');
insert into Anclaje values(35,1, 'BB1', 'anclaje1', '61BAEcobici'); 
insert into Anclaje values(36,2, 'BB1', 'anclaje1', '61BAEcobici'); 

-- Disponibilidad

insert into Disponibilidad values('ECO-1', 1, '2021-04-12', '13:00:00');
insert into Disponibilidad values( 'ECO-1',6, '2021-04-12', '13:30:00');
insert into Disponibilidad values('ECO-3',3, '2021-04-12', '13:00:00');
insert into Disponibilidad values('ECO-3',8,  '2021-04-12', '14:00:00');
insert into Disponibilidad values('ECO-4',10  ,  '2021-04-12', '16:00:00');
insert into Disponibilidad values('ECO-4',14,  '2021-04-12', '19:00:00');
insert into Disponibilidad values('DEP-1',17,  '2021-04-12', '13:00:00');
insert into Disponibilidad values('DEP-1',19,  '2021-04-12', '15:10:00');
insert into Disponibilidad values('DEP-2',29,  '2021-04-12', '13:00:00');
insert into Disponibilidad values('ECO-5', 5, '2021-04-12', '13:00:00');
insert into Disponibilidad values('DEP-3', 15, '2021-04-12', '15:00:00');
insert into Disponibilidad values('ECO-6', 9 , '2021-04-12', '13:00:00');
insert into Disponibilidad values('ECO-7', 18, '2021-04-12', '13:00:00');
insert into Disponibilidad values('ECO-1', 34, '2021-04-12', '15:00:00');
insert into Disponibilidad values('ECO-1',35, '2021-04-12', '16:00:00');
insert into Disponibilidad values('ECO-10', 31, '2022-01-12', '16:00:00');
insert into Disponibilidad values('ECO-1', 36, '2022-01-12', '18:30:00');

/*
insert into Disponibilidad values(1, 'ECO-1', 1, '2021-04-12', '13:00:00');
insert into Disponibilidad values(2, 'ECO-1',6, '2021-04-12', '13:30:00');
insert into Disponibilidad values(3, 'ECO-3',3, '2021-04-12', '13:00:00');
insert into Disponibilidad values(4, 'ECO-3',8,  '2021-04-12', '14:00:00');
insert into Disponibilidad values(5, 'ECO-4',10  ,  '2021-04-12', '16:00:00');
insert into Disponibilidad values(6, 'ECO-4',14,  '2021-04-12', '19:00:00');
insert into Disponibilidad values(7, 'DEP-1',17,  '2021-04-12', '13:00:00');
insert into Disponibilidad values(8, 'DEP-1',19,  '2021-04-12', '15:10:00');
insert into Disponibilidad values(9, 'DEP-2',29,  '2021-04-12', '13:00:00');
insert into Disponibilidad values(10,'ECO-5', 5, '2021-04-12', '13:00:00');
insert into Disponibilidad values(11,'DEP-3', 15, '2021-04-12', '15:00:00');
insert into Disponibilidad values(12,'ECO-6', 9 , '2021-04-12', '13:00:00');
insert into Disponibilidad values(13, 'ECO-7', 18, '2021-04-12', '13:00:00');
insert into Disponibilidad values(14,'ECO-1', 34, '2021-04-12', '15:00:00');
insert into Disponibilidad values(15,'ECO-1',35, '2021-04-12', '16:00:00');
insert into Disponibilidad values(17,'ECO-10', 31, '2022-01-12', '16:00:00');
insert into Disponibilidad values(16,'ECO-1', 36, '2022-01-12', '18:30:00');
*/
/* 
	Viajes
*/

insert into Viaje values('13103591BAE', '2021-04-12', '13:00:00', '2021-04-12', '13:30:00', 1, 7, 24298764567);
insert into Viaje values('13103015BAE', '2021-04-12', '13:00:00', '2021-04-12', '14:00:00', 3 , 9, 20300988999);
insert into Viaje values('13100479BAE', '2021-04-12', '15:00:00', '2021-04-12', '19:00:00',10, 6, 22292344986); 
-- insert into Viaje values('13103019BAE', '2021-04-12', '13:40:00', '2021-04-12', '15:10:00', 7, 8, 28299964567);
insert into Viaje values('13103542BAE', '2021-04-12', '13:55:00', '2021-04-12', null, 9, null, 22307645674);
insert into Viaje values('13103697BAE', '2021-04-12', '13:30:00', '2021-04-12', '14:00:00', 15 , 14, 28308764564);
insert into Viaje values('13103581BAE', '2021-04-12', '15:00:00', '2021-04-12', '18:30:00', 6, 33, 24298764567);
insert into Viaje values('14103581BAE', '2022-01-12', '15:00:00', '2022-01-12', '18:30:00', 8, 16, 24298764567);