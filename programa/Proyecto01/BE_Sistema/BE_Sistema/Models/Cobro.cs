using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Cobro
    {
        public int CodigoFactura { get; set; }
        public int NumeroGrado { get; set; }
        public int NumeroPeriodo { get; set; }
        public int AnnoPeriodo { get; set; }
        public int CedulaEstudiante { get; set; }
        public int CodigoGrupo { get; set; }
        public string NombreMateria { get; set; }
        public string TipoCobro { get; set; }
        public int Monto { get; set; }
        public bool Estado { get; set; }

        public virtual Factura CodigoFacturaNavigation { get; set; }
        public virtual GrupoMatricula GrupoMatricula { get; set; }
    }
}
