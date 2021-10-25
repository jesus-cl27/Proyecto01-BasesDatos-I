using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class DetalleCobroMatricula
    {
        public int CodigoCobro { get; set; }
        public int Monto { get; set; }

        public virtual Cobro CodigoCobroNavigation { get; set; }
    }
}
