using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class PeriodoLectivo
    {
        public PeriodoLectivo()
        {
            GradoPeriodos = new HashSet<GradoPeriodo>();
            Grupos = new HashSet<Grupo>();
        }

        public int NumeroPeriodo { get; set; }
        public int Anno { get; set; }
        public DateTime FechaInicio { get; set; }
        public DateTime FechaFinal { get; set; }
        public int NotaMinima { get; set; }
        public string Estado { get; set; }

        public virtual ICollection<GradoPeriodo> GradoPeriodos { get; set; }
        public virtual ICollection<Grupo> Grupos { get; set; }
    }
}
