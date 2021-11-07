using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class GradoMateria
    {
        public int NumeroGrado { get; set; }
        public string NombreMateria { get; set; }

        public virtual Materia NombreMateriaNavigation { get; set; }
        public virtual Grado NumeroGradoNavigation { get; set; }
    }
}
