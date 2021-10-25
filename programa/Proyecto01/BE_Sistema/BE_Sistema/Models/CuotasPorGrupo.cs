using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class CuotasPorGrupo
    {
        public int CodigoCobro { get; set; }
        public int CodigoGrupo { get; set; }
        public int Consecutivo { get; set; }
        public string Estado { get; set; }
        public int Monto { get; set; }

        public virtual DetalleCobroPorGrupo Codigo { get; set; }
    }
}
