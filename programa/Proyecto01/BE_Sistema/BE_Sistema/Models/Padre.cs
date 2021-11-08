using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Padre
    {
        public Padre()
        {
            Estudiantes = new HashSet<Estudiante>();
        }
        public int Cedula { get; set; }
        public string Nombre { get; set; }
        public string ProfesionOficio { get; set; }
        public string NombreConyugue { get; set; }
        public int TelefonoConyugue { get; set; }

        public virtual Usuario CedulaNavigation { get; set; }
        public virtual ICollection<Estudiante> Estudiantes { get; set; }

    }
}
