using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class Grupo
    {
        public Grupo()
        {
            DetalleCobroPorGrupos = new HashSet<DetalleCobroPorGrupo>();
            MatriculaGrupos = new HashSet<MatriculaGrupo>();
        }

        public int Codigo { get; set; }
        public string Nombre { get; set; }
        public long CedulaProfesor { get; set; }
        public string NombreProfesor { get; set; }
        public int Cupo { get; set; }
        public string Materia { get; set; }
        public int Grado { get; set; }
        public int NumeroPeriodo { get; set; }
        public int Anno { get; set; }

        public virtual PeriodoLectivo PeriodoLectivo { get; set; }
        public virtual Profesor Profesor { get; set; }
        public virtual ICollection<DetalleCobroPorGrupo> DetalleCobroPorGrupos { get; set; }
        public virtual ICollection<MatriculaGrupo> MatriculaGrupos { get; set; }
    }
}
