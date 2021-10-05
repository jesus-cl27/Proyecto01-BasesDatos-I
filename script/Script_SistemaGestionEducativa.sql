--creacion de la base de datos
create database SistemaGestionEducativa
go
--indicamos que vamos a trabajar en esa base de datos
use  SistemaGestionEducativa
go

--creacion de las tablas

--Tabla Usuario
--no permite nulos
create table Usuario
(
	Cedula bigint not null UNIQUE,
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
	PRIMARY KEY(Cedula,NombrePila),
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
	Estado varchar(50) not null,
	PRIMARY KEY(NumeroPeriodo,Anno),  --llaves primarias
	CONSTRAINT chk_AnnoPeriodo CHECK(Anno between 1800 and 2500)   --Se le da un rango al Anno
);
go
--tabla Profesor
--no permite nulos
create table Profesor
(
	Cedula bigint not null UNIQUE,
	Nombre varchar(50) not null,
	Salario bigint not null,
	PRIMARY KEY(Cedula,Nombre), --llaves primarias
	FOREIGN KEY(Cedula,Nombre) REFERENCES Usuario(Cedula,NombrePila), --llaves foraneas
	CONSTRAINT chk_Salario CHECK(Salario >= 0) --validar que el salario no sea un numero negativo
);
go

--tabla HistoricoSalarial
--no se permiten nulos
create table HistoricoSalarial
(
	CedulaProfesor bigint not null,
	NombrePRofesor varchar(50) not null,
	FechaInicio date not null,
	FechaFin date not null,
	Monto bigint not null,
	PRIMARY KEY(CedulaProfesor,NombreProfesor),   --llaves primarias
	FOREIGN KEY(CedulaProfesor,NombreProfesor) REFERENCES Profesor(Cedula,Nombre),  --llaves foraneas
	CONSTRAINT chk_Monto CHECK(Monto >= 0) --validar que el monto no sea un numero negativo
);
go

--tabla Padre
--no permite nulos
create table Padre
(
	Cedula bigint not null UNIQUE,
	Nombre varchar(50) not null,
	ProfesionOficio varchar(50) not null,
	NombreConyugue varchar(50) not null,
	TelefonoConyugue int not null,
	PRIMARY KEY (Cedula,Nombre),   --llaves primarias
	FOREIGN KEY (Cedula,Nombre) REFERENCES Usuario(Cedula,NombrePila),  --llaves foraneas
	CONSTRAINT chk_TelefonoConyugue CHECK (TelefonoConyugue >= 10000000 and TelefonoConyugue <= 99999999)  --validacion del numero de telefono de 8 digitos
);
go
--tabla Estudiante
--no se permite nulos
create table Estudiante
(
	Cedula bigint not null UNIQUE,
	Nombre varchar(50) not null,
	CedulaPadre bigint not null,
	NombrePadre varchar(50) not null,
	GradoActual varchar(50) not null,
	PRIMARY KEY (Cedula,Nombre),   --llaves primarias
	FOREIGN KEY (Cedula,Nombre) REFERENCES Usuario(Cedula,NombrePila),   --llaves foraneas
	FOREIGN KEY (CedulaPadre,NombrePadre) REFERENCES Padre(Cedula,Nombre),    --llaves foraneas
);
go
--tabla Grupo
--no se permiten nulos
create table Grupo
(
	Codigo int IDENTITY(1,1) not null UNIQUE, --autoincrementar a partir de 1, incrementando en 1
	Nombre varchar(50) not null,
	CedulaProfesor bigint not null,
	NombreProfesor varchar(50) not null,
	Cupo int not null,
	Materia varchar(50) not null,
	Grado int not null,
	NumeroPeriodo int not null,
	Anno int not null,
	PRIMARY KEY (Codigo),   --llave primaria
	FOREIGN KEY (NumeroPeriodo,Anno) REFERENCES PeriodoLectivo(NumeroPeriodo,Anno),  --llaves foraneas
	FOREIGN KEY (CedulaProfesor,NombreProfesor) REFERENCES Profesor(Cedula,Nombre),  --llaves foraneas
	CONSTRAINT chk_Cupo CHECK (Cupo >=0),  --validar que el cupo sea mayor o igual a cero
	CONSTRAINT chk_Grado CHECK (Grado >=0) --validar que el grado sea mayor o igual a cero
);
go

--tabla Matricula
--no permite nulos
create table Matricula
(
	Codigo int IDENTITY(1000,1) not null UNIQUE,  --autoincrementar a partir de 1000, incrementando en 1
	CedulaEstudiante bigint not null,
	NumeroPeriodo int not null,
	AnnoPeriodo int not null,
	PRIMARY KEY (Codigo),   --llave primaria
	FOREIGN KEY (CedulaEstudiante) REFERENCES Estudiante(Cedula),  --llave foranea
	FOREIGN KEY (NumeroPeriodo,AnnoPeriodo) REFERENCES PeriodoLectivo(NumeroPeriodo,Anno)  --llaves foraneas
);
go
--tabla de Cobros
--no permite nulos
create table Cobro
(
	Codigo int IDENTITY(10000,1) not null UNIQUE,   --autoincrementar a partir de 10000, incrementando en 1
	CodigoMatricula int not null,
	CedulaEstudiante bigint not null,
	Grado int not null,
	NumeroPeriodo int not null,
	AnnoPeriodo int not null,
	CedulaUsuario bigint not null,
	MontoTotal int not null,
	FechaCreacion datetime not null,
	PRIMARY KEY (Codigo),   --llave primaria
	FOREIGN KEY (CedulaEstudiante) REFERENCES Estudiante(Cedula),    --llaves foraneas
	FOREIGN KEY (CodigoMatricula) REFERENCES Matricula(Codigo),    --llaves foraneas
	FOREIGN KEY (CedulaUsuario) REFERENCES Usuario(Cedula),   --llaves foraneas
	FOREIGN KEY (NumeroPeriodo,AnnoPeriodo) REFERENCES PeriodoLectivo(NumeroPeriodo,Anno),  --llaves foraneas
	
);
go
--tabla DetalleCobroMatricula
--no permite nulos
create table DetalleCobroMatricula
(
	CodigoCobro int not null,
	Monto int not null,
	PRIMARY KEY (CodigoCobro),   --llave primaria
	FOREIGN KEY (CodigoCobro) REFERENCES Cobro(Codigo),  --llave foranea
	CONSTRAINT chk_MontoMatricula CHECK (Monto >= 0)  --se valida que el monto no sea negativo
);
go
--tabla DetalleCobroPorGrupo
--no permite nulos
create table DetalleCobroPorGrupo
(
	CodigoCobro int not null,
	CodigoGrupo int not null,
	Grado int not null,
	NumeroPeriodo int not null,
	AnnoPeriodo int not null,
	PRIMARY KEY (CodigoCobro,CodigoGrupo),  --llave primaria
	FOREIGN KEY (CodigoCobro) REFERENCES Cobro(Codigo),  --llave foranea
	FOREIGN KEY (CodigoGrupo) REFERENCES Grupo(Codigo),   --llave foranea
	FOREIGN KEY (NumeroPeriodo,AnnoPeriodo) REFERENCES PeriodoLectivo(NumeroPeriodo,Anno), --llaves foraneas
);
go
--tabla CuotasPorGrupo
--no permite nulos
create table CuotasPorGrupo
(
	CodigoCobro int not null,
	CodigoGrupo int not null,
	Consecutivo int not null,
	Estado varchar(50) not null,
	Monto int not null,
	PRIMARY KEY (CodigoCobro,CodigoGrupo,Consecutivo),  --llaves primarias
	FOREIGN KEY (CodigoCobro,CodigoGrupo) REFERENCES DetalleCobroPorGrupo(CodigoCobro,CodigoGrupo),  --llaves foraneas
	CONSTRAINT chk_MontoCuota CHECK (Monto >= 0),  --se valida que el monto no pueda ser negativo
	CONSTRAINT chk_EstadoCuota CHECK (Estado = 'Pagado' or Estado = 'Pendiente')  --se valida que el estado solo pueda ser 'Pagado' o 'Pendiente'
);
