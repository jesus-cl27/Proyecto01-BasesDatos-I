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
--Cantidad de grupos por periodo
create view CantidadGruposPeriodo
as
select P.NumeroPeriodo,P.Anno,count(G.Codigo) as CantidadGrupos
from  PeriodoLectivo P
left join Grupo G
on P.NumeroPeriodo = G.NumeroPeriodo and P.Anno = G.Anno
group by P.NumeroPeriodo,P.Anno
go
----------------------------------------------------------
--cantidad de grupos por estudiante por periodo, seleccionar periodo
select p.NumeroPeriodo,p.Anno,e.Cedula,count(g.Codigo) as CantGrupos
from Grupo g,PeriodoLectivo  p
inner join GrupoMatricula as gm
on p.NumeroPeriodo = gm.NumeroPeriodo and p.Anno = gm.AnnoPeriodo
go
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
go
select * from PeriodoLectivo