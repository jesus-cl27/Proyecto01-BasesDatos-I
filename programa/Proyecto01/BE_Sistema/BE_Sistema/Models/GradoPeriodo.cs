using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class GradoPeriodo
    {
        public GradoPeriodo()
        {
            Matriculas = new HashSet<Matricula>();
        }

        public int NumeroGrado { get; set; }
        public int NumeroPeriodo { get; set; }
        public int AnnoPeriodo { get; set; }

        public virtual Grado NumeroGradoNavigation { get; set; }
        public virtual PeriodoLectivo PeriodoLectivo { get; set; }
        public virtual ICollection<Matricula> Matriculas { get; set; }
    }
}
