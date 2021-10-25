using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Profesor
    {
        public Profesor()
        {
            Grupos = new HashSet<Grupo>();
        }

        public long Cedula { get; set; }
        public string Nombre { get; set; }
        public long Salario { get; set; }

        public virtual Usuario Usuario { get; set; }
        public virtual HistoricoSalarial HistoricoSalarial { get; set; }
        public virtual ICollection<Grupo> Grupos { get; set; }
    }
}
