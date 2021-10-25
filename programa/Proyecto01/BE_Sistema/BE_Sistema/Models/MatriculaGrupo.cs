using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class MatriculaGrupo
    {
        public int CodigoMatricula { get; set; }
        public int CodigoGrupo { get; set; }

        public virtual Grupo CodigoGrupoNavigation { get; set; }
        public virtual Matricula CodigoMatriculaNavigation { get; set; }
    }
}
