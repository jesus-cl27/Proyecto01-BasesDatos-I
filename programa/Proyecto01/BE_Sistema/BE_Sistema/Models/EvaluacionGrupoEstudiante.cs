using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class EvaluacionGrupoEstudiante
    {
        public int NumeroPeriodo { get; set; }
        public int AnnoPeriodo { get; set; }
        public string NombreMateria { get; set; }
        public int CodigoGrupo { get; set; }
        public string NombreEvaluacion { get; set; }
        public decimal Nota { get; set; }

        public virtual EvaluacionGrupo EvaluacionGrupo { get; set; }
    }
}
