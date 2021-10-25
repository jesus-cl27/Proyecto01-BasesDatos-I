using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class HistoricoSalarial
    {
        public long CedulaProfesor { get; set; }
        public string NombreProfesor { get; set; }
        public DateTime FechaInicio { get; set; }
        public DateTime FechaFin { get; set; }
        public long Monto { get; set; }

        public virtual Profesor Profesor { get; set; }
    }
}
