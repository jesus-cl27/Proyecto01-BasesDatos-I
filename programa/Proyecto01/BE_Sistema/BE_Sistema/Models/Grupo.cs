using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Grupo
    {
        public Grupo()
        {
            EvaluacionGrupos = new HashSet<EvaluacionGrupo>();
            GrupoMatriculas = new HashSet<GrupoMatricula>();
        }

        public int Codigo { get; set; }
        public string NombreMateria { get; set; }
        public int NumeroPeriodo { get; set; }
        public int Anno { get; set; }
        public int CedulaProfesor { get; set; }
        public string NombreProfesor { get; set; }
        public int Cupo { get; set; }
        public string Estado { get; set; }
        public int CostoMensualidad { get; set; }
        public int CostoMatricula { get; set; }

        public virtual Profesor CedulaProfesorNavigation { get; set; }
        public virtual Materia NombreMateriaNavigation { get; set; }
        public virtual PeriodoLectivo PeriodoLectivo { get; set; }
        public virtual ICollection<EvaluacionGrupo> EvaluacionGrupos { get; set; }
        public virtual ICollection<GrupoMatricula> GrupoMatriculas { get; set; }
    }
}
