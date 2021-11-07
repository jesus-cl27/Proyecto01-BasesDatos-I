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
alter table Usuario add Password varchar(20) not null;
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
	FOREIGN KEY (CodigoGrupo) REFERENCES Grupo(Codigo),
);
go
--alter table GrupoMatricula add foreign key (NombreMateria) references Grupo(NombreMateria)

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
	NumeroPeriodo int not null,
	AnnoPeriodo int not null,
	NombreMateria varchar(50) not null,
	CodigoGrupo int not null,
	NombreEvaluacion varchar(50) not null,
	Nota decimal(5,2) not null,
	PRIMARY KEY (NumeroPeriodo,AnnoPeriodo,NombreMateria,CodigoGrupo,NombreEvaluacion),
	FOREIGN KEY (NumeroPeriodo,AnnoPeriodo,NombreMateria,CodigoGrupo,NombreEvaluacion) REFERENCES EvaluacionGrupo(NumeroPeriodo,AnnoPeriodo,NombreMateria,CodigoGrupo,NombreEvaluacion),
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
	@FechaCreacion datetime,
	@Password varchar(20),
	@Profesion varchar(50),
	@NombreConyugue varchar(50),
	@TelefonoConyugue int
as
begin
	insert into dbo.Usuario values(@Cedula,@NombrePila,@Ap1,@Ap2,@Rol,@Sexo,@FechaNac,@Edad,@Provincia,@Residencia,@Telefono,@FechaCreacion,@Password)
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
	@FechaCreacion = '2021-11-06',
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