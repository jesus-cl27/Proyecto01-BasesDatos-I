using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Estudiante
    {
        public Estudiante()
        {
            Matriculas = new HashSet<Matricula>();
        }

        public int Cedula { get; set; }
        public string Nombre { get; set; }
        public int CedulaPadre { get; set; }
        public string NombrePadre { get; set; }
        public string GradoActual { get; set; }

        public virtual Usuario CedulaNavigation { get; set; }
        public virtual Padre CedulaPadreNavigation { get; set; }
        public virtual ICollection<Matricula> Matriculas { get; set; }
    }
}
