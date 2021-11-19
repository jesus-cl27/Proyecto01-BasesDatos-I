use  SistemaGestionEducativa
go
--cantidad de estudiantes por periodo por grupo
select ge.NumeroPeriodo,ge.AnnoPeriodo,ge.CodigoGrupo,ge.NombreMateria,ge.CedulaEstudiante,count(ge.CedulaEstudiante) as CantEstudiantes
from   EvaluacionGrupoEstudiante as GE
where exists (select distinct ge.CedulaEstudiante
from   EvaluacionGrupoEstudiante as GE
inner join PeriodoLectivo as P
on GE.AnnoPeriodo = P.Anno and GE.NumeroPeriodo = P.NumeroPeriodo
inner join Grupo as G
on GE.CodigoGrupo = G.Codigo and GE.NombreMateria = G.NombreMateria)
group by ge.NumeroPeriodo,ge.AnnoPeriodo,ge.CodigoGrupo,ge.NombreMateria,ge.CedulaEstudiante
--++++++++++++++++++++++++++++++++++++++++++++++++++++

select ge.NumeroPeriodo,ge.AnnoPeriodo,ge.CodigoGrupo,ge.NombreMateria,ge.CedulaEstudiante,count(ge.CedulaEstudiante) as CantEstudiantes
from   EvaluacionGrupoEstudiante as GE,PeriodoLectivo as P,Grupo as G
where exists (select distinct ge.CedulaEstudiante
from   EvaluacionGrupoEstudiante as GE
where GE.AnnoPeriodo = P.Anno and GE.NumeroPeriodo = P.NumeroPeriodo and  GE.CodigoGrupo = G.Codigo and GE.NombreMateria = G.NombreMateria)
group by ge.NumeroPeriodo,ge.AnnoPeriodo,ge.CodigoGrupo,ge.NombreMateria,ge.CedulaEstudiante
