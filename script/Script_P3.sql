use  SistemaGestionEducativa
go
--cantidad de estudiantes por periodo por grupo 
--funcion que retorna la cantidad de estudiantes por periodo
--parametros(numero de periodo, anno de periodo)
create function CantEstudiantesPorPeriodo (@numPeriodo int,@annoPeriodo int)
returns Table  --retorna una tabla
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
--vista que despliega la cantidad de grupos por periodo
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
--funcion que retorna la cantidadde grupos por estudiante por periodo
--paramentros(numero de periodo, anno de periodo)
create function CantGruposEstudiantePeriodo (@numPeriodo int, @annoPeriodo int)
returns Table
as
return
(
select p.NumeroPeriodo,p.Anno,e.Cedula,count(g.CodigoGrupo) as CantGrupos
from PeriodoLectivo p
inner join GrupoMatricula g
on p.NumeroPeriodo = g.NumeroPeriodo and p.Anno = g.AnnoPeriodo
left join Estudiante e
on g.CedulaEstudiante = e.Cedula
where p.NumeroPeriodo = @numPeriodo and p.Anno = @annoPeriodo
group by p.NumeroPeriodo,p.Anno,e.Cedula
)
go
----------------------------------------
--ingresos por grado por periodo
--funcion que despliega una tabla con los ingresos por grado por periodo
--parametros(numero de periodo, anno del periodo)
create function IngresosGradoPeriodo (@numPeriodo int, @anno int)
returns Table
as
return
(
select p.NumeroPeriodo, p.Anno, gdo.Numero as Grado,sum(g.CostoMatricula + (g.CostoMensualidad * 12)) as Ingresos
from PeriodoLectivo p
inner join Grupo g on
p.NumeroPeriodo = g.NumeroPeriodo and p.Anno = g.Anno
inner join GrupoMatricula gm on
g.NumeroPeriodo = gm.NumeroPeriodo and g.Anno = gm.AnnoPeriodo and g.Codigo = gm.CodigoGrupo and g.NombreMateria = gm.NombreMateria
inner join Grado gdo on
gm.NumeroGrado = gdo.Numero
where p.NumeroPeriodo = @numPeriodo and p.Anno =@anno
group by p.NumeroPeriodo, p.Anno, gdo.Numero
)
go

--vista que obtiene la nota de los estudiantes por grupo
create view NotaEstudianteGrupo
as
select es.Cedula,ege.CodigoGrupo,ege.NombreMateria,sum(ege.Nota * eg.Peso / 100) as nota
from EvaluacionGrupoEstudiante as ege
left join Estudiante as es
on es.Cedula = ege.CedulaEstudiante
inner join EvaluacionGrupo as eg
on ege.NumeroPeriodo = eg.NumeroPeriodo and ege.AnnoPeriodo = eg.AnnoPeriodo and ege.CodigoGrupo = eg.CodigoGrupo and ege.NombreMateria = eg.NombreMateria and ege.NombreEvaluacion = eg.NombreEvaluacion
group by es.Cedula,ege.CodigoGrupo,ege.NombreMateria
go


--proyecto 2
--procedimiento almacenado que cierra un grupo de un periodo, esto solo si el grupo tiene todaslas notas de los estudiantes
--paramentros(numero de perido,anno de periodo,materia y codigo que conforma el grupo)
-----------------------------
create procedure CierrePeriodoGrupo @numPeriodo int, @anno int, @materia varchar(50), @codigoGrupo int
as
begin
declare @cantEstudiantes int, @cantEvaluaciones int,@total int, @totalRegistros int
set @cantEstudiantes = (select count(*) from (select distinct CedulaEstudiante
											from GrupoMatricula
											where NumeroPeriodo = @numPeriodo and AnnoPeriodo = @anno and NombreMateria = @materia and CodigoGrupo = @codigoGrupo) A)
print @cantEstudiantes
set @cantEvaluaciones = (select count(*) from EvaluacionGrupo
						where NumeroPeriodo = @numPeriodo and AnnoPeriodo = @anno and NombreMateria = @materia and CodigoGrupo = @codigoGrupo)
print @cantEvaluaciones
set @totalRegistros = (select count(*) from EvaluacionGrupoEstudiante
						where NumeroPeriodo = @numPeriodo and AnnoPeriodo = @anno and NombreMateria = @materia and CodigoGrupo = @codigoGrupo)
print @totalRegistros
set @total = @cantEstudiantes * @cantEvaluaciones
print @total
	if @total = @totalRegistros
	begin 
	update Grupo set Estado = 'cerrado' where NumeroPeriodo = @numPeriodo and Anno = @anno and NombreMateria = @materia and Codigo = @codigoGrupo
	print 'grupo cerrado con exito'
	end
	else
	begin
	print 'el grupo no se puede cerrar'
	end
end
go

--reportes no funcionales
---------------------------------
select p.Cedula, (select sum((ege.Nota * eg.Peso) /100) as promedioNotas
from Profesor p,Grupo g  
inner join EvaluacionGrupo eg on
g.Anno = eg.AnnoPeriodo and g.NumeroPeriodo = eg.NumeroPeriodo and g.Codigo = eg.CodigoGrupo and g.NombreMateria = eg.NombreMateria
inner join EvaluacionGrupoEstudiante ege on
eg.AnnoPeriodo = ege.AnnoPeriodo and eg.NumeroPeriodo = ege.NumeroPeriodo and eg.CodigoGrupo = ege.CodigoGrupo and eg.NombreMateria = ege.NombreMateria and eg.NombreEvaluacion = ege.NombreEvaluacion
where p.Cedula = g.CedulaProfesor)
from Profesor p
group by p.Cedula
go


----------------------------------------

select sub.NumeroPeriodo,sub.Anno,Usuario.Sexo,count(Usuario.Sexo) / (sub.Total) as Porcentaje
from Usuario,
(select p.NumeroPeriodo,p.Anno,count(all u.Sexo) as Total
from PeriodoLectivo p
left join GrupoMatricula g on
p.NumeroPeriodo = g.NumeroPeriodo and p.Anno = g.AnnoPeriodo
inner join Usuario u on
g.CedulaEstudiante = u.Cedula
--where u.Sexo = 'F' or u.Sexo = 'M'
group by p.NumeroPeriodo,p.Anno) as sub
group by sub.NumeroPeriodo,sub.Anno,sub.Total,Usuario.Sexo




