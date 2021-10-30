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
            HistoricoSalarials = new HashSet<HistoricoSalarial>();
        }

        public int Cedula { get; set; }
        public string Nombre { get; set; }
        public long Salario { get; set; }

        public virtual Usuario CedulaNavigation { get; set; }
        public virtual ICollection<Grupo> Grupos { get; set; }
        public virtual ICollection<HistoricoSalarial> HistoricoSalarials { get; set; }
    }
}
