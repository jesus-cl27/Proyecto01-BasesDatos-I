using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Usuario
    {
        public Usuario()
        {
            Cobros = new HashSet<Cobro>();
            Facturas = new HashSet<Factura>();
        }

        public long Cedula { get; set; }
        public string NombrePila { get; set; }
        public string Apellido1 { get; set; }
        public string Apellido2 { get; set; }
        public string Rol { get; set; }
        public string Sexo { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public int Edad { get; set; }
        public string Provincia { get; set; }
        public string Residencia { get; set; }
        public int Telefono { get; set; }
        public DateTime FechaCreacion { get; set; }

        public virtual Estudiante Estudiante { get; set; }
        public virtual Padre Padre { get; set; }
        public virtual Profesor Profesor { get; set; }
        public virtual ICollection<Cobro> Cobros { get; set; }
        public virtual ICollection<Factura> Facturas { get; set; }
    }
}
