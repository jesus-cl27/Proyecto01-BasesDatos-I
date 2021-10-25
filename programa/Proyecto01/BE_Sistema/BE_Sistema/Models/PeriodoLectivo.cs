using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class PeriodoLectivo
    {
        public PeriodoLectivo()
        {
            Cobros = new HashSet<Cobro>();
            DetalleCobroPorGrupos = new HashSet<DetalleCobroPorGrupo>();
            Grupos = new HashSet<Grupo>();
            Matriculas = new HashSet<Matricula>();
        }

        public int NumeroPeriodo { get; set; }
        public int Anno { get; set; }
        public DateTime FechaInicio { get; set; }
        public DateTime FechaFinal { get; set; }
        public string Estado { get; set; }

        public virtual ICollection<Cobro> Cobros { get; set; }
        public virtual ICollection<DetalleCobroPorGrupo> DetalleCobroPorGrupos { get; set; }
        public virtual ICollection<Grupo> Grupos { get; set; }
        public virtual ICollection<Matricula> Matriculas { get; set; }
    }
}
