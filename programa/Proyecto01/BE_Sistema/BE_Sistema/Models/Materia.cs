using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Materia
    {
        public Materia()
        {
            GradoMateria = new HashSet<GradoMaterium>();
            Grupos = new HashSet<Grupo>();
        }

        public string Nombre { get; set; }

        public virtual ICollection<GradoMaterium> GradoMateria { get; set; }
        public virtual ICollection<Grupo> Grupos { get; set; }
    }
}
