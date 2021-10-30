using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Factura
    {
        public Factura()
        {
            Cobros = new HashSet<Cobro>();
        }

        public int Codigo { get; set; }
        public int CedulaUsuario { get; set; }
        public int MontoTotal { get; set; }
        public int MontoTotalIva { get; set; }
        public DateTime FechaCreacion { get; set; }

        public virtual Usuario CedulaUsuarioNavigation { get; set; }
        public virtual ICollection<Cobro> Cobros { get; set; }
    }
}
