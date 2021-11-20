use  SistemaGestionEducativa
go
--cantidad de estudiantes por periodo por grupo --LISTO
create function CantEstudiantesPorPeriodo (@numPeriodo int,@annoPeriodo int)
returns Table
as
return
(
	select M.NumeroPeriodo,M.AnnoPeriodo,M.CodigoGrupo,M.NombreMateria,count(M.CedulaEstudiante) as CantEstudiantes
	from   GrupoMatricula as M

	inner join PeriodoLectivo as P
	on M.AnnoPeriodo = P.Anno and M.NumeroPeriodo = P.NumeroPeriodo
	inner join Grupo as G
	on M.CodigoGrupo = G.Codigo and M.NombreMateria = G.NombreMateria
	where P.NumeroPeriodo = @numPeriodo and P.Anno = @annoPeriodo
	group by M.NumeroPeriodo,M.AnnoPeriodo,M.CodigoGrupo,M.NombreMateria
);
select * from CantEstudiantesPorPeriodo(1,2020);
--++++++++++++++++++++++++++++++++++++++++++++++++++++


select * from Estudiante
execute Agregar_Usuario_Estudiante 702340988,'Jose','Rodriguez','Guevara','Estudiante','M','2001-12-20',20,'Puntarenas','Golfito',70234590,'Rodri20',701110222,1
go
execute Agregar_Usuario_Estudiante 304560318,'Sofia','Jimenez','Torres','Estudiante','F','2002-11-21',19,'Puntarenas','Golfito',85674512,'SofiJim21',701370116,1
go
execute AgregarMatricula 1,1,2020,304560318,'activo'
go
execute AgregarMatricula 1,1,2020,702340988,'activo'
go
execute AgregarGrupoMatricula 1,1,2020,304560318,60,'Matematicas','activo'
go
execute AgregarGrupoMatricula 1,1,2020,702340988,61,'Matematicas','activo'
go
Select * from Usuario
go
select * from Estudiante
go
select * from GrupoMatricula
go
select * from Matricula
go
select * from Grupo