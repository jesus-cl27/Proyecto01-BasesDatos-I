using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Grado
    {
        public Grado()
        {
            GradoMateria = new HashSet<GradoMateria>();
            GradoPeriodos = new HashSet<GradoPeriodo>();
        }

        public int Numero { get; set; }

        public virtual ICollection<GradoMateria> GradoMateria { get; set; }
        public virtual ICollection<GradoPeriodo> GradoPeriodos { get; set; }
    }
}
