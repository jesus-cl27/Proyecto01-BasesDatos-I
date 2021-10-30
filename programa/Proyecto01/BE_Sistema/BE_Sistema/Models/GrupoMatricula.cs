using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class GrupoMatricula
    {
        public GrupoMatricula()
        {
            Cobros = new HashSet<Cobro>();
        }

        public int NumeroGrado { get; set; }
        public int NumeroPeriodo { get; set; }
        public int AnnoPeriodo { get; set; }
        public int CedulaEstudiante { get; set; }
        public int CodigoGrupo { get; set; }
        public string NombreMateria { get; set; }
        public string Estado { get; set; }

        public virtual Grupo CodigoGrupoNavigation { get; set; }
        public virtual Matricula Matricula { get; set; }
        public virtual ICollection<Cobro> Cobros { get; set; }
    }
}
