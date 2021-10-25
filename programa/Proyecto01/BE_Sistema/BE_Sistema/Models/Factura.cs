using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Factura
    {
        public int CodigoCobro { get; set; }
        public long CedulaUsuario { get; set; }
        public int MontoTotalCobro { get; set; }
        public DateTime FechaCreacion { get; set; }

        public virtual Usuario CedulaUsuarioNavigation { get; set; }
        public virtual Cobro Cobro { get; set; }
    }
}
