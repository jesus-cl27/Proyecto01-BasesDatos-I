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
create table Grado
(
	Numero int not null PRIMARY KEY
);
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

create table TipoEvaluacion
(
	Nombre varchar(50) not null PRIMARY KEY
);
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
--tabla Grupo
--no se permiten nulos
create table Grupo
(
	Codigo int IDENTITY(1,1) not null UNIQUE, --autoincrementar a partir de 1, incrementando en 1
	NombreMateria varchar(50) not null,
	CedulaProfesor int not null,
	NombreProfesor varchar(50) not null,
	Cupo int not null,
	NumeroPeriodo int not null,
	Anno int not null,
	Estado varchar(50) not null,
	CostoMensualidad int not null,
	CostoMatricula int not null,
	PRIMARY KEY (Codigo,NombreMateria,NumeroPeriodo,Anno),   --llave primaria
	FOREIGN KEY (NombreMateria) REFERENCES Materia(Nombre),
	FOREIGN KEY (NumeroPeriodo,Anno) REFERENCES PeriodoLectivo(NumeroPeriodo,Anno),  --llaves foraneas
	FOREIGN KEY (CedulaProfesor) REFERENCES Profesor(Cedula),  --llaves foraneas
	FOREIGN KEY (NombreMateria) REFERENCES Materia(Nombre),
	CONSTRAINT chk_Cupo CHECK (Cupo >=0),  --validar que el cupo sea mayor o igual a cero
);
go

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
	FOREIGN KEY (CodigoGrupo,NombreMateria) REFERENCES Grupo(Codigo,NombreMateria),

);
go
create table EvaluacionGrupo
(
	NumeroPeriodo int not null,
	AnnoPeriodo int not null,
	NombreMateria varchar(50) not null,
	CodigoGrupo int not null,
	NombreEvaluacion varchar(50) not null,
	Tipo varchar(50) not null,
	Peso decimal(5,2) not null,
	PRIMARY KEY (NumeroPeriodo,AnnoPeriodo,NombreMateria,CodigoGrupo,NombreEvaluacion),
	FOREIGN KEY (CodigoGrupo,NombreMateria,NumeroPeriodo,AnnoPeriodo) REFERENCES Grupo(Codigo,NombreMateria,NumeroPeriodo,Anno),
);
go
