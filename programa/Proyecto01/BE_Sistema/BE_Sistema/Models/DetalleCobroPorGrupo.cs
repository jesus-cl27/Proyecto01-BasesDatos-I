using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class DetalleCobroPorGrupo
    {
        public DetalleCobroPorGrupo()
        {
            CuotasPorGrupos = new HashSet<CuotasPorGrupo>();
        }

        public int CodigoCobro { get; set; }
        public int CodigoGrupo { get; set; }
        public int Grado { get; set; }
        public int NumeroPeriodo { get; set; }
        public int AnnoPeriodo { get; set; }

        public virtual Cobro CodigoCobroNavigation { get; set; }
        public virtual Grupo CodigoGrupoNavigation { get; set; }
        public virtual PeriodoLectivo PeriodoLectivo { get; set; }
        public virtual ICollection<CuotasPorGrupo> CuotasPorGrupos { get; set; }
    }
}
