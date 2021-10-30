using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Matricula
    {
        public Matricula()
        {
            GrupoMatriculas = new HashSet<GrupoMatricula>();
        }

        public int NumeroGrado { get; set; }
        public int NumeroPeriodo { get; set; }
        public int AnnoPeriodo { get; set; }
        public int CedulaEstudiante { get; set; }
        public string Estado { get; set; }

        public virtual Estudiante CedulaEstudianteNavigation { get; set; }
        public virtual GradoPeriodo GradoPeriodo { get; set; }
        public virtual ICollection<GrupoMatricula> GrupoMatriculas { get; set; }
    }
}
