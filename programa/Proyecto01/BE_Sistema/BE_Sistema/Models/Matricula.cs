using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Matricula
    {
        public Matricula()
        {
            Cobros = new HashSet<Cobro>();
            MatriculaGrupos = new HashSet<MatriculaGrupo>();
        }

        public int Codigo { get; set; }
        public long CedulaEstudiante { get; set; }
        public int NumeroPeriodo { get; set; }
        public int AnnoPeriodo { get; set; }

        public virtual Estudiante CedulaEstudianteNavigation { get; set; }
        public virtual PeriodoLectivo PeriodoLectivo { get; set; }
        public virtual ICollection<Cobro> Cobros { get; set; }
        public virtual ICollection<MatriculaGrupo> MatriculaGrupos { get; set; }
    }
}
