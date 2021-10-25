using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Estudiante
    {
        public Estudiante()
        {
            Cobros = new HashSet<Cobro>();
            Matriculas = new HashSet<Matricula>();
        }

        public long Cedula { get; set; }
        public string Nombre { get; set; }
        public long CedulaPadre { get; set; }
        public string NombrePadre { get; set; }
        public string GradoActual { get; set; }

        public virtual Padre Padre { get; set; }
        public virtual Usuario Usuario { get; set; }
        public virtual ICollection<Cobro> Cobros { get; set; }
        public virtual ICollection<Matricula> Matriculas { get; set; }
    }
}
