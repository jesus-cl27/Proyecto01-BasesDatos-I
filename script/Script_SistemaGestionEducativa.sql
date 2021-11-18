--creacion de la base de datos
create database SistemaGestionEducativa
go
--indicamos que vamos a trabajar en esa base de datos
use  SistemaGestionEducativa
go
--drop database SistemaGestionEducativa;
--creacion de las tablas
--se agregar algunas tablas
create table Materia
(
	Nombre varchar(50) not null PRIMARY KEY
);
go
--procedimiento almacenado para hacer inserts en la tabla Materia
create procedure dbo.AgregarMateria
(
	@nombre varchar(50)
)
as
begin
	insert into Materia values(@nombre)
end
go
--se ejecuta el procedimiento almacenado que realiza inserts.
execute dbo.AgregarMateria'Matematicas';
go
execute dbo.AgregarMateria'Ciencias';
go
execute dbo.AgregarMateria'Estudios Sociales';
go
execute dbo.AgregarMateria 'Precalculo';
go
execute dbo.AgregarMateria 'Biologia';
go
execute dbo.AgregarMateria 'Civica';
go
create table Grado
(
	Numero int not null PRIMARY KEY
);
go
--procedimiento almacenado para hacer inserts en la tabla Grado
create procedure dbo.AgregarGrado
(
	@num int
)
as
begin
	insert into Grado values(@num)
end
go
--se ejecuta el procedimiento almacenado que realiza inserts.
execute dbo.AgregarGrado 1;
go
execute dbo.AgregarGrado 2;
go
execute dbo.AgregarGrado 3;
go
create table GradoMateria
(
	NumeroGrado int not null,
	NombreMateria varchar(50) not null,
	PRIMARY KEY(NumeroGrado,NombreMateria),
	FOREIGN KEY(NumeroGrado) REFERENCES Grado(Numero),
	FOREIGN KEY(NombreMateria) REFERENCES Materia(Nombre),
);
go
--procedimiento almacenado para hacer inserts en la tabla MateriaGrado
create procedure dbo.Agregar_GradoMateria
(
	@Grado int,
	@Materia varchar(50)
)
as
begin
	insert into GradoMateria values(@Grado,@Materia)
end
go
--se ejecuta el procedimiento almacenado que realiza inserts.
execute dbo.Agregar_GradoMateria
	@Grado = 1,
	@Materia= 'Matematicas';
	
go
execute dbo.Agregar_GradoMateria
	@Grado = 1,
	@Materia= 'Ciencias';
	
go
execute dbo.Agregar_GradoMateria
	@Grado = 1,
	@Materia= 'Estudios Sociales';
	
go
execute dbo.Agregar_GradoMateria 2,'Precalculo';
go
execute dbo.Agregar_GradoMateria 2,'Biologia';
go
execute dbo.Agregar_GradoMateria 2,'Civica';
go
create table TipoEvaluacion
(
	Nombre varchar(50) not null PRIMARY KEY
);
go
--procedimiento almacenado para hacer inserts en la tabla TipoEvaluacion
create procedure dbo.AgregarTipoEvaluacion
(
	@nombre varchar(50)
)
as
begin
	insert into TipoEvaluacion values(@nombre)
end
go
execute dbo.AgregarTipoEvaluacion 'Proyecto';
go
execute dbo.AgregarTipoEvaluacion 'Tarea';
go
execute dbo.AgregarTipoEvaluacion 'Quiz';
go
execute dbo.AgregarTipoEvaluacion 'Examen';
go
execute dbo.AgregarTipoEvaluacion 'Asistencia';
go

--Tabla Usuario
--no permite nulos
create table Usuario
(
	Cedula int not null UNIQUE,
	NombrePila varchar(50) not null,
	Apellido1 varchar(50) not null,
	Apellido2 varchar(50) not null,
	Rol varchar(20) not null,
	Sexo varchar(1) not null,
	FechaNacimiento date not null,
	Edad int not null,
	Provincia varchar(50) not null,
	Residencia varchar(50) not null,
	Telefono int not null,
	FechaCreacion datetime not null,
	PRIMARY KEY(Cedula),
	CONSTRAINT chk_Cedula CHECK(Cedula >= 100000000 and Cedula <= 999999999),  --validacion de cedula de 9 digitos
	CONSTRAINT chk_Sexo CHECK(Sexo = 'F' or Sexo = 'M'),  --solo F o M para indicar el sexo
	CONSTRAINT chk_Telefono CHECK(Telefono >= 10000000 and Telefono <= 99999999)  ---validacion de un numero de telefono de 8 digitos
);
go
alter table Usuario add Password varchar(20) not null;
go
--para obtener la fecha actual de forma automatica al realizar un insert.
ALTER TABLE Usuario ADD CONSTRAINT DF_Usuario DEFAULT GETDATE() FOR FechaCreacion
--tabla PeriodoLectivo
--no permite nulos
create table PeriodoLectivo
(
	NumeroPeriodo int not null,
	Anno int not null,
	FechaInicio date not null,
	FechaFinal date not null,
	NotaMinima int not null,
	Estado varchar(50) not null,
	PRIMARY KEY(NumeroPeriodo,Anno),  --llaves primarias
	CONSTRAINT chk_AnnoPeriodo CHECK(Anno between 1800 and 2500)   --Se le da un rango al Anno
);
go
create procedure dbo.AgregarPeriodoLectivo_Grado
(
	@NumPeriodo int,
	@Anno int,
	@FechaIni date,
	@FechaFin date,
	@NotaMin int,
	@Estado varchar(50),
	@NumGrado int
)
as
begin
	insert into PeriodoLectivo values(@NumPeriodo,@Anno,@FechaIni,@FechaFin,@NotaMin,@Estado)

	insert into GradoPeriodo values(@NumGrado,@NumPeriodo,@Anno) 
end
go
execute AgregarPeriodoLectivo_Grado 1,2020,'2020-02-10','2020-06-20',70,'activo',1
go
execute AgregarPeriodoLectivo_Grado 2,2020,'2020-07-10','2020-11-25',70,'activo',2
go
create table GradoPeriodo
(
	NumeroGrado int not null,
	NumeroPeriodo int not null,
	AnnoPeriodo int not null,
	PRIMARY KEY(NumeroGrado,NumeroPeriodo,AnnoPeriodo),
	FOREIGN KEY (NumeroGrado) REFERENCES Grado(Numero),
	FOREIGN KEY (NumeroPeriodo,AnnoPeriodo) REFERENCES PeriodoLectivo(NumeroPeriodo,Anno)
);
go

--tabla Profesor
--no permite nulos
create table Profesor
(
	Cedula int not null UNIQUE,
	Nombre varchar(50) not null,
	Salario bigint not null,
	PRIMARY KEY(Cedula), --llave primaria
	FOREIGN KEY(Cedula) REFERENCES Usuario(Cedula), --llave foranea
	CONSTRAINT chk_Salario CHECK(Salario >= 0), --validar que el salario no sea un numero negativo
);
go

--tabla HistoricoSalarial
--no se permiten nulos
create table HistoricoSalarial
(
	CedulaProfesor int not null,
	FechaInicio date not null,
	FechaFin date not null,
	Monto bigint not null,
	PRIMARY KEY(CedulaProfesor,FechaInicio),   --llaves primarias
	FOREIGN KEY(CedulaProfesor) REFERENCES Profesor(Cedula),  --llave foranea
	CONSTRAINT chk_MontoSalario CHECK(Monto >= 0) --validar que el monto no sea un numero negativo
);
go

--tabla Padre
--no permite nulos
create table Padre
(
	Cedula int not null UNIQUE,
	Nombre varchar(50) not null,
	ProfesionOficio varchar(50) not null,
	NombreConyugue varchar(50) not null,
	TelefonoConyugue int not null,
	PRIMARY KEY (Cedula),   --llaves primarias
	FOREIGN KEY (Cedula) REFERENCES Usuario(Cedula),  --llaves foraneas
	CONSTRAINT chk_TelefonoConyugue CHECK (TelefonoConyugue >= 10000000 and TelefonoConyugue <= 99999999)  --validacion del numero de telefono de 8 digitos
);
go
--tabla Estudiante
--no se permite nulos
create table Estudiante
(
	Cedula int not null UNIQUE,
	Nombre varchar(50) not null,
	CedulaPadre int not null,
	NombrePadre varchar(50) not null,
	GradoActual varchar(50) not null,
	PRIMARY KEY (Cedula),   --llaves primarias
	FOREIGN KEY (Cedula) REFERENCES Usuario(Cedula),   --llaves foraneas
	FOREIGN KEY (CedulaPadre) REFERENCES Padre(Cedula),    --llaves foraneas
);
go
--correccion de errores en la tabla
------
--columna o atributo innecesario
alter table Estudiante drop column NombrePadre ;
go
--tipo de dato era erroneo.
alter table Estudiante alter column GradoActual int;
go
--tabla Grupo
--no se permiten nulos
create table Grupo
(
	Codigo int not null , 
	NombreMateria varchar(50) not null,
	NumeroPeriodo int not null,
	Anno int not null,
	CedulaProfesor int not null,
	NombreProfesor varchar(50) not null,
	Cupo int not null,
	Estado varchar(50) not null,
	CostoMensualidad int not null,
	CostoMatricula int not null,
	PRIMARY KEY (Codigo,NombreMateria,NumeroPeriodo,Anno),   --llave primaria
	FOREIGN KEY (NombreMateria) REFERENCES Materia(Nombre),
	FOREIGN KEY (NumeroPeriodo,Anno) REFERENCES PeriodoLectivo(NumeroPeriodo,Anno),  --llaves foraneas
	FOREIGN KEY (CedulaProfesor) REFERENCES Profesor(Cedula),  --llaves foraneas
	CONSTRAINT chk_Cupo CHECK (Cupo >=0),  --validar que el cupo sea mayor o igual a cero
);
go
--columna o atributo innecesario
alter table Grupo drop column NombreProfesor ;
go
--drop table Grupo;
--tabla Matricula
--no permite nulos
create table Matricula
(
	NumeroGrado int not null,
	NumeroPeriodo int not null,
	AnnoPeriodo int not null,
	CedulaEstudiante int not null,
	Estado varchar(50)
	PRIMARY KEY (NumeroGrado,NumeroPeriodo,AnnoPeriodo,CedulaEstudiante),   --llave primaria
	FOREIGN KEY (CedulaEstudiante) REFERENCES Estudiante(Cedula),  --llave foranea
	FOREIGN KEY (NumeroGrado,NumeroPeriodo,AnnoPeriodo) REFERENCES GradoPeriodo(NumeroGrado,NumeroPeriodo,AnnoPeriodo),  --llaves foraneas
);
go
create table GrupoMatricula
(
	
	NumeroGrado int not null,
	NumeroPeriodo int not null,
	AnnoPeriodo int not null,
	CedulaEstudiante int not null,
	CodigoGrupo int not null,
	NombreMateria varchar(50) not null,
	Estado varchar(50) not null,
	PRIMARY KEY (NumeroGrado,NumeroPeriodo,AnnoPeriodo,CedulaEstudiante,CodigoGrupo,NombreMateria),   --llave primaria
	FOREIGN KEY (NumeroGrado,NumeroPeriodo,AnnoPeriodo,CedulaEstudiante) REFERENCES Matricula(NumeroGrado,NumeroPeriodo,AnnoPeriodo,CedulaEstudiante),
	--FOREIGN KEY (CodigoGrupo) REFERENCES Grupo(Codigo),
);
go
alter table GrupoMatricula add foreign key (CodigoGrupo) references Grupo(Codigo)
go
create table EvaluacionGrupo
(
	NumeroPeriodo int not null,
	AnnoPeriodo int not null,
	NombreMateria varchar(50) not null,
	CodigoGrupo int not null,
	NombreEvaluacion varchar(50) not null,
	Peso decimal(5,2) not null,
	PRIMARY KEY (NumeroPeriodo,AnnoPeriodo,NombreMateria,CodigoGrupo,NombreEvaluacion),
	FOREIGN KEY (NombreEvaluacion) REFERENCES TipoEvaluacion(Nombre),
	FOREIGN KEY (CodigoGrupo,NombreMateria,NumeroPeriodo,AnnoPeriodo) REFERENCES Grupo(Codigo,NombreMateria,NumeroPeriodo,Anno),
);
go
create table EvaluacionGrupoEstudiante
(
	NumeroGrado int not null,
	NumeroPeriodo int not null,
	AnnoPeriodo int not null,
	NombreMateria varchar(50) not null,
	CodigoGrupo int not null,
	CedulaEstudiante int not null,
	NombreEvaluacion varchar(50) not null,
	Nota decimal(5,2) not null,
	PRIMARY KEY (NumeroGrado,NumeroPeriodo,AnnoPeriodo,NombreMateria,CodigoGrupo,CedulaEstudiante,NombreEvaluacion),
	FOREIGN KEY (NumeroGrado,NumeroPeriodo,AnnoPeriodo,CedulaEstudiante,CodigoGrupo,NombreMateria) REFERENCES GrupoMatricula(NumeroGrado,NumeroPeriodo,AnnoPeriodo,CedulaEstudiante,CodigoGrupo,NombreMateria),
	FOREIGN KEY (NombreEvaluacion) REFERENCES TipoEvaluacion(Nombre),
);
go

create table Factura
(
	Codigo int not null,
	CedulaUsuario int not null,
	MontoTotal int not null,
	MontoTotalIva int not null,
	FechaCreacion datetime not null,
	PRIMARY KEY(Codigo),
	FOREIGN KEY(CedulaUsuario) REFERENCES Usuario(Cedula),
);
--para obtener la fecha actual de forma automatica al realizar un insert.
ALTER TABLE Factura ADD CONSTRAINT DF_Factura DEFAULT GETDATE() FOR FechaCreacion
go
create table Cobro
(
	CodigoFactura int not null,
	NumeroGrado int not null,
	NumeroPeriodo int not null,
	AnnoPeriodo int not null,
	CedulaEstudiante int not null,
	CodigoGrupo int not null,
	NombreMateria varchar(50) not null,
	TipoCobro varchar(50) not null,
	Monto int not null,
	Estado bit not null,
	PRIMARY KEY(CodigoFactura,CodigoGrupo,TipoCobro),
	FOREIGN KEY (CodigoFactura) REFERENCES Factura(Codigo),
	FOREIGN KEY (NumeroGrado,NumeroPeriodo,AnnoPeriodo,CedulaEstudiante,CodigoGrupo,NombreMateria) REFERENCES GrupoMatricula(NumeroGrado,NumeroPeriodo,AnnoPeriodo,CedulaEstudiante,CodigoGrupo,NombreMateria),
	constraint chk_TipoCobro check (TipoCobro = 'mensualidad' or TipoCobro = 'matricula')
);
-- procedimientos almacenados
go

create procedure dbo.Agregar_Usuario_Padre
	@Cedula int,
	@NombrePila varchar(50),
	@Ap1 varchar(50),
	@Ap2 varchar(50),
	@Rol varchar(20),
	@Sexo varchar(1),
	@FechaNac date,
	@Edad int,
	@Provincia varchar(50),
	@Residencia varchar(50),
	@Telefono int,
	--@FechaCreacion datetime,
	@Password varchar(20),
	@Profesion varchar(50),
	@NombreConyugue varchar(50),
	@TelefonoConyugue int
as
begin
	insert into dbo.Usuario(Cedula,NombrePila,Apellido1,Apellido2,Rol,Sexo,FechaNacimiento,Edad,Provincia,Residencia,Telefono,Password) values(@Cedula,@NombrePila,@Ap1,@Ap2,@Rol,@Sexo,@FechaNac,@Edad,@Provincia,@Residencia,@Telefono,@Password)
	insert into dbo.Padre values(@Cedula,@NombrePila,@Profesion,@NombreConyugue,@TelefonoConyugue)
end
go
execute dbo.Agregar_Usuario_Padre
	@Cedula = 701110283,
	@NombrePila ='Carlos',
	@Ap1 = 'Cruz',
	@Ap2 = 'Mesen',
	@Rol ='Padre',
	@Sexo ='M',
	@FechaNac = '1973-10-16',
	@Edad = 48,
	@Provincia = 'Limon',
	@Residencia = 'Siquirres',
	@Telefono = 60112211,
	--@FechaCreacion = '2021-11-06',
	@Password = 'Cruz16',
	@Profesion = 'Administrador',
	@NombreConyugue = 'Maria',
	@TelefonoConyugue = 87996655;
go
execute dbo.Agregar_Usuario_Padre
	@Cedula = 701370116,
	@NombrePila ='Maria',
	@Ap1 = 'Lopez',
	@Ap2 = 'Anchia',
	@Rol ='Padre',
	@Sexo ='F',
	@FechaNac = '1980-05-06',
	@Edad = 40,
	@Provincia = 'Limon',
	@Residencia = 'Siquirres',
	@Telefono = 87996655,
	@FechaCreacion = '2021-11-07',
	@Password = 'Cruz16',
	@Profesion = 'Abogada',
	@NombreConyugue = 'Carlos',
	@TelefonoConyugue = 60112277;
--drop procedure Agregar_Usuario_Padre
--update Usuario set Password = 'Maria06'  from Usuario where Cedula = 701370116
--select * from Padre
execute dbo.Agregar_Usuario_Padre
	@Cedula = 701110222,
	@NombrePila ='Cristiano',
	@Ap1 = 'Ronaldo',
	@Ap2 = 'Messi',
	@Rol ='Padre',
	@Sexo ='M',
	@FechaNac = '1986-11-23',
	@Edad = 35,
	@Provincia = 'Alajuela',
	@Residencia = 'Atenas',
	@Telefono = 85456732,
	--@FechaCreacion = '2021-11-06',
	@Password = 'cr71000',
	@Profesion = 'Futbolista',
	@NombreConyugue = 'Ines',
	@TelefonoConyugue = 89001267;
go
-------------------
create procedure dbo.Agregar_Usuario_Profesor
	@Cedula int,
	@NombrePila varchar(50),
	@Ap1 varchar(50),
	@Ap2 varchar(50),
	@Rol varchar(20),
	@Sexo varchar(1),
	@FechaNac date,
	@Edad int,
	@Provincia varchar(50),
	@Residencia varchar(50),
	@Telefono int,
	--@FechaCreacion datetime,
	@Password varchar(20),
	@Salario int
as
begin
	insert into dbo.Usuario(Cedula,NombrePila,Apellido1,Apellido2,Rol,Sexo,FechaNacimiento,Edad,Provincia,Residencia,Telefono,Password) values(@Cedula,@NombrePila,@Ap1,@Ap2,@Rol,@Sexo,@FechaNac,@Edad,@Provincia,@Residencia,@Telefono,@Password)
	insert into dbo.Profesor values(@Cedula,@NombrePila,@Salario)
end
go
execute dbo.Agregar_Usuario_Profesor
	@Cedula = 203450678,
	@NombrePila ='Juan',
	@Ap1 = 'Rojas',
	@Ap2 = 'Suarez',
	@Rol ='Profesor',
	@Sexo ='M',
	@FechaNac = '1986-09-23',
	@Edad = 35,
	@Provincia = 'Cartago',
	@Residencia = 'Paraiso',
	@Telefono = 88902312,
	--@FechaCreacion = '2021-11-06',
	@Password = 'profeJuan23',
	@Salario = 900000;
go
------------------------
create procedure dbo.Agregar_a_HistorialSalarial
(
	@cedula int,
	@FechaIni date,
	@FechaFin date,
	@Monto int
)
as
begin
	insert into HistoricoSalarial values(@cedula,@FechaIni,@FechaFin,@Monto)
end
go
execute dbo.Agregar_a_HistorialSalarial 203450678,'2019-11-13','2021-11-02',900000;
go
execute dbo.Agregar_a_HistorialSalarial 203450678,'2021-11-10','2023-11-09',1050000;
go
-------------------------------
create procedure dbo.Agregar_Usuario_Estudiante
	@Cedula int,
	@NombrePila varchar(50),
	@Ap1 varchar(50),
	@Ap2 varchar(50),
	@Rol varchar(20),
	@Sexo varchar(1),
	@FechaNac date,
	@Edad int,
	@Provincia varchar(50),
	@Residencia varchar(50),
	@Telefono int,
	--@FechaCreacion datetime,
	@Password varchar(20),
	@CedulaPadre int,
	@GradoActual int
as
begin
	insert into dbo.Usuario(Cedula,NombrePila,Apellido1,Apellido2,Rol,Sexo,FechaNacimiento,Edad,Provincia,Residencia,Telefono,Password) values(@Cedula,@NombrePila,@Ap1,@Ap2,@Rol,@Sexo,@FechaNac,@Edad,@Provincia,@Residencia,@Telefono,@Password)
	insert into dbo.Estudiante values(@Cedula,@NombrePila,@CedulaPadre,@GradoActual)
end
go
execute dbo.Agregar_Usuario_Estudiante
	@Cedula = 202900301,
	@NombrePila ='Jesus',
	@Ap1 = 'Cruz',
	@Ap2 = 'Lopez',
	@Rol ='Estudiante',
	@Sexo ='M',
	@FechaNac = '2001-12-27',
	@Edad = 19,
	@Provincia = 'Limon',
	@Residencia = 'Siquirres',
	@Telefono = 85916171,
	--@FechaCreacion = '2021-11-06',
	@Password = 'JesusCrack123',
	@CedulaPadre = 701110283,
	@GradoActual = 1;
go
create procedure dbo.AgregarGrupo
(
	@codigo int,
	@materia varchar(50),
	@numPeriodo int,
	@annoPeriodo int,
	@profesor int,
	@cupo int,
	@estado varchar(50),
	@costoMesualidad int,
	@costoMatricula int
)
as
begin
	insert into Grupo values(@codigo,@materia,@numPeriodo,@annoPeriodo,@profesor,@cupo,@estado,@costoMesualidad,@costoMatricula)
end
go
execute dbo.AgregarGrupo 60,'Matematicas',1,2020,203450678,30,'activo',5000,30000;
go
execute dbo.AgregarGrupo 61,'Matematicas',1,2020,203450678,30,'activo',5000,30000;
go
create procedure dbo.Agregar_EvaluacionGrupo
(
	@NumPeriodo int,
	@AnnoPeriodo int,
	@Materia varchar(50),
	@CodigoGrupo int,
	@Evaluacion varchar(50),
	@Peso decimal(5,2)
)
as
begin
	insert into EvaluacionGrupo values(@NumPeriodo,@AnnoPeriodo,@Materia,@CodigoGrupo,@Evaluacion,@Peso)
end
go
execute dbo.Agregar_EvaluacionGrupo 1,2020,'Matematicas',60,'Proyecto',12.5;
go
execute dbo.Agregar_EvaluacionGrupo 1,2020,'Matematicas',60,'Examen',40;
go
execute dbo.Agregar_EvaluacionGrupo 1,2020,'Matematicas',60,'Tarea',35;
go
delete EvaluacionGrupo where CodigoGrupo  = 60 and NombreEvaluacion = 'Tarea'
go
execute dbo.Agregar_EvaluacionGrupo 1,2020,'Matematicas',61,'Proyecto',50;
go
execute dbo.Agregar_EvaluacionGrupo 1,2020,'Matematicas',61,'Examen',30;
go
execute dbo.Agregar_EvaluacionGrupo 1,2020,'Matematicas',61,'Tarea',20;
go
create procedure dbo.Agregar_EvaluacionGrupoEstudiante
(
	@numGrado int,
	@numPeriodo int,
	@AnnoPeriodo int,
	@Materia varchar(50),
	@CodigoGrupo int,
	@estudiante int,
	@Evaluacion varchar(50),
	@Nota decimal(5,2)
)
as
begin
	insert into EvaluacionGrupoEstudiante values(@numGrado,@numPeriodo,@AnnoPeriodo,@Materia,@CodigoGrupo,@estudiante,@Evaluacion,@Nota)
end
go
execute dbo.Agregar_EvaluacionGrupoEstudiante 1,1,2020,'Matematicas',60,202900301,'Tarea',80;
go
execute dbo.Agregar_EvaluacionGrupoEstudiante 1,1,2020,'Matematicas',60,202900301,'Proyecto',61.6;
go

create procedure dbo.AgregarMatricula
(
	@grado int,
	@numPeriodo int,
	@anno int,
	@estudiante int,
	@estado varchar(50)
)
as
begin
	insert into Matricula values(@grado,@numPeriodo,@anno,@estudiante,@estado)
end
go
execute dbo.AgregarMatricula 1,1,2020,202900301,'activo';
go
create procedure dbo.AgregarGrupoMatricula
(
	@grado int,
	@numPeriodo int,
	@anno int,
	@estudiante int,
	@grupo int,
	@materia varchar(50),
	@estado varchar(50)
)
as
begin
	insert into GrupoMatricula values(@grado,@numPeriodo,@anno,@estudiante,@grupo,@materia,@estado)
end
go
execute dbo.AgregarGrupoMatricula 1,1,2020,202900301,60,'Matematicas','activo';
go

create procedure dbo.AgregarFactura
(
	@codigo int,
	@usuario int,
	@montoTotal int,
	@montoTotalIva int	
)
as
begin
	insert into Factura(Codigo,CedulaUsuario,MontoTotal,MontoTotalIva) values(@codigo,@usuario,@montoTotal,@montoTotalIva)
end
go
execute dbo.AgregarFactura 100,701110222,50000,56500
go
