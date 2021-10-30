using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class TipoEvaluacion
    {
        public TipoEvaluacion()
        {
            EvaluacionGrupos = new HashSet<EvaluacionGrupo>();
        }

        public string Nombre { get; set; }

        public virtual ICollection<EvaluacionGrupo> EvaluacionGrupos { get; set; }
    }
}
