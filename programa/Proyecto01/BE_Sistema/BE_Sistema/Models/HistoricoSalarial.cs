using System;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class HistoricoSalarial
    {
        public int CedulaProfesor { get; set; }
        public DateTime FechaInicio { get; set; }
        public DateTime FechaFin { get; set; }
        public long Monto { get; set; }

        public virtual Profesor CedulaProfesorNavigation { get; set; }
    }
}
