using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Cobro
    {
        public Cobro()
        {
            DetalleCobroPorGrupos = new HashSet<DetalleCobroPorGrupo>();
            Facturas = new HashSet<Factura>();
        }

        public int Codigo { get; set; }
        public int CodigoMatricula { get; set; }
        public long CedulaEstudiante { get; set; }
        public int Grado { get; set; }
        public int NumeroPeriodo { get; set; }
        public int AnnoPeriodo { get; set; }
        public long CedulaUsuario { get; set; }
        public int MontoTotal { get; set; }
        public DateTime FechaCreacion { get; set; }

        public virtual Estudiante CedulaEstudianteNavigation { get; set; }
        public virtual Usuario CedulaUsuarioNavigation { get; set; }
        public virtual Matricula CodigoMatriculaNavigation { get; set; }
        public virtual PeriodoLectivo PeriodoLectivo { get; set; }
        public virtual DetalleCobroMatricula DetalleCobroMatricula { get; set; }
        public virtual ICollection<DetalleCobroPorGrupo> DetalleCobroPorGrupos { get; set; }
        public virtual ICollection<Factura> Facturas { get; set; }
    }
}
