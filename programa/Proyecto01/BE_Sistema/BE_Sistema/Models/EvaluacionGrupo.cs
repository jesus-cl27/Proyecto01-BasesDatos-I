using System;
using System.Collections.Generic;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class EvaluacionGrupo
    {
        public int NumeroPeriodo { get; set; }
        public int AnnoPeriodo { get; set; }
        public string NombreMateria { get; set; }
        public int CodigoGrupo { get; set; }
        public string NombreEvaluacion { get; set; }
        public decimal Peso { get; set; }

        public virtual Grupo Grupo { get; set; }
        public virtual TipoEvaluacion NombreEvaluacionNavigation { get; set; }
        public virtual EvaluacionGrupoEstudiante EvaluacionGrupoEstudiante { get; set; }
    }
}
