using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace BE_Sistema.Models
{
    public partial class SistemaGestionEducativaContext : DbContext
    {
        public SistemaGestionEducativaContext()
        {
        }

        public SistemaGestionEducativaContext(DbContextOptions<SistemaGestionEducativaContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Cobro> Cobros { get; set; }
        public virtual DbSet<Estudiante> Estudiantes { get; set; }
        public virtual DbSet<EvaluacionGrupo> EvaluacionGrupos { get; set; }
        public virtual DbSet<EvaluacionGrupoEstudiante> EvaluacionGrupoEstudiantes { get; set; }
        public virtual DbSet<Factura> Facturas { get; set; }
        public virtual DbSet<Grado> Grados { get; set; }
        public virtual DbSet<GradoMaterium> GradoMateria { get; set; }
        public virtual DbSet<GradoPeriodo> GradoPeriodos { get; set; }
        public virtual DbSet<Grupo> Grupos { get; set; }
        public virtual DbSet<GrupoMatricula> GrupoMatriculas { get; set; }
        public virtual DbSet<HistoricoSalarial> HistoricoSalarials { get; set; }
        public virtual DbSet<Materia> Materia { get; set; }
        public virtual DbSet<Matricula> Matriculas { get; set; }
        public virtual DbSet<Padre> Padres { get; set; }
        public virtual DbSet<PeriodoLectivo> PeriodoLectivos { get; set; }
        public virtual DbSet<Profesor> Profesors { get; set; }
        public virtual DbSet<TipoEvaluacion> TipoEvaluacions { get; set; }
        public virtual DbSet<Usuario> Usuarios { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=DESKTOP-UNID0Q0;Database=SistemaGestionEducativa;User Id=sa;Password=Jesus123;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "SQL_Latin1_General_CP1_CI_AS");

            modelBuilder.Entity<Cobro>(entity =>
            {
                entity.HasKey(e => new { e.CodigoFactura, e.CodigoGrupo, e.TipoCobro })
                    .HasName("PK__Cobro__D800B6AD8179103B");

                entity.ToTable("Cobro");

                entity.Property(e => e.TipoCobro)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.NombreMateria)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.CodigoFacturaNavigation)
                    .WithMany(p => p.Cobros)
                    .HasForeignKey(d => d.CodigoFactura)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Cobro__CodigoFac__7A672E12");

                entity.HasOne(d => d.GrupoMatricula)
                    .WithMany(p => p.Cobros)
                    .HasForeignKey(d => new { d.NumeroGrado, d.NumeroPeriodo, d.AnnoPeriodo, d.CedulaEstudiante, d.CodigoGrupo, d.NombreMateria })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Cobro__7B5B524B");
            });

            modelBuilder.Entity<Estudiante>(entity =>
            {
                entity.HasKey(e => e.Cedula)
                    .HasName("PK__Estudian__B4ADFE396F50B0C5");

                entity.ToTable("Estudiante");

                entity.HasIndex(e => e.Cedula, "UQ__Estudian__B4ADFE386ED49E8C")
                    .IsUnique();

                entity.Property(e => e.Cedula).ValueGeneratedNever();

                entity.Property(e => e.GradoActual)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Nombre)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.NombrePadre)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.CedulaNavigation)
                    .WithOne(p => p.Estudiante)
                    .HasForeignKey<Estudiante>(d => d.Cedula)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Estudiant__Cedul__48CFD27E");

                entity.HasOne(d => d.CedulaPadreNavigation)
                    .WithMany(p => p.Estudiantes)
                    .HasForeignKey(d => d.CedulaPadre)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Estudiant__Cedul__49C3F6B7");
            });

            modelBuilder.Entity<EvaluacionGrupo>(entity =>
            {
                entity.HasKey(e => new { e.NumeroPeriodo, e.AnnoPeriodo, e.NombreMateria, e.CodigoGrupo, e.NombreEvaluacion })
                    .HasName("PK__Evaluaci__47424960FC0F1609");

                entity.ToTable("EvaluacionGrupo");

                entity.Property(e => e.NombreMateria)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.NombreEvaluacion)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Peso).HasColumnType("decimal(5, 2)");

                entity.HasOne(d => d.NombreEvaluacionNavigation)
                    .WithMany(p => p.EvaluacionGrupos)
                    .HasForeignKey(d => d.NombreEvaluacion)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Evaluacio__Nombr__0A9D95DB");

                entity.HasOne(d => d.Grupo)
                    .WithMany(p => p.EvaluacionGrupos)
                    .HasForeignKey(d => new { d.CodigoGrupo, d.NombreMateria, d.NumeroPeriodo, d.AnnoPeriodo })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__EvaluacionGrupo__0B91BA14");
            });

            modelBuilder.Entity<EvaluacionGrupoEstudiante>(entity =>
            {
                entity.HasKey(e => new { e.NumeroPeriodo, e.AnnoPeriodo, e.NombreMateria, e.CodigoGrupo, e.NombreEvaluacion })
                    .HasName("PK__Evaluaci__47424960C37D8FDE");

                entity.ToTable("EvaluacionGrupoEstudiante");

                entity.Property(e => e.NombreMateria)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.NombreEvaluacion)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Nota).HasColumnType("decimal(5, 2)");

                entity.HasOne(d => d.EvaluacionGrupo)
                    .WithOne(p => p.EvaluacionGrupoEstudiante)
                    .HasForeignKey<EvaluacionGrupoEstudiante>(d => new { d.NumeroPeriodo, d.AnnoPeriodo, d.NombreMateria, d.CodigoGrupo, d.NombreEvaluacion })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__EvaluacionGrupoE__0E6E26BF");
            });

            modelBuilder.Entity<Factura>(entity =>
            {
                entity.HasKey(e => e.Codigo)
                    .HasName("PK__Factura__06370DAD05A39CD0");

                entity.ToTable("Factura");

                entity.Property(e => e.Codigo).ValueGeneratedNever();

                entity.Property(e => e.FechaCreacion).HasColumnType("datetime");

                entity.HasOne(d => d.CedulaUsuarioNavigation)
                    .WithMany(p => p.Facturas)
                    .HasForeignKey(d => d.CedulaUsuario)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Factura__CedulaU__778AC167");
            });

            modelBuilder.Entity<Grado>(entity =>
            {
                entity.HasKey(e => e.Numero)
                    .HasName("PK__Grado__7E532BC7599C5350");

                entity.ToTable("Grado");

                entity.Property(e => e.Numero).ValueGeneratedNever();
            });

            modelBuilder.Entity<GradoMaterium>(entity =>
            {
                entity.HasKey(e => new { e.NumeroGrado, e.NombreMateria })
                    .HasName("PK__GradoMat__56DD2469298ABB6D");

                entity.Property(e => e.NombreMateria)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.NombreMateriaNavigation)
                    .WithMany(p => p.GradoMateria)
                    .HasForeignKey(d => d.NombreMateria)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__GradoMate__Nombr__29572725");

                entity.HasOne(d => d.NumeroGradoNavigation)
                    .WithMany(p => p.GradoMateria)
                    .HasForeignKey(d => d.NumeroGrado)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__GradoMate__Numer__286302EC");
            });

            modelBuilder.Entity<GradoPeriodo>(entity =>
            {
                entity.HasKey(e => new { e.NumeroGrado, e.NumeroPeriodo, e.AnnoPeriodo })
                    .HasName("PK__GradoPer__B50BD57F5265B17F");

                entity.ToTable("GradoPeriodo");

                entity.HasOne(d => d.NumeroGradoNavigation)
                    .WithMany(p => p.GradoPeriodos)
                    .HasForeignKey(d => d.NumeroGrado)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__GradoPeri__Numer__36B12243");

                entity.HasOne(d => d.PeriodoLectivo)
                    .WithMany(p => p.GradoPeriodos)
                    .HasForeignKey(d => new { d.NumeroPeriodo, d.AnnoPeriodo })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__GradoPeriodo__37A5467C");
            });

            modelBuilder.Entity<Grupo>(entity =>
            {
                entity.HasKey(e => new { e.Codigo, e.NombreMateria, e.NumeroPeriodo, e.Anno })
                    .HasName("PK__Grupo__A8E33E7C2D5661E9");

                entity.ToTable("Grupo");

                entity.HasIndex(e => e.Codigo, "UQ__Grupo__06370DACAC802D5A")
                    .IsUnique();

                entity.Property(e => e.Codigo).ValueGeneratedOnAdd();

                entity.Property(e => e.NombreMateria)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Estado)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.NombreProfesor)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.CedulaProfesorNavigation)
                    .WithMany(p => p.Grupos)
                    .HasForeignKey(d => d.CedulaProfesor)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Grupo__CedulaPro__5EBF139D");

                entity.HasOne(d => d.NombreMateriaNavigation)
                    .WithMany(p => p.Grupos)
                    .HasForeignKey(d => d.NombreMateria)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Grupo__NombreMat__5CD6CB2B");

                entity.HasOne(d => d.PeriodoLectivo)
                    .WithMany(p => p.Grupos)
                    .HasForeignKey(d => new { d.NumeroPeriodo, d.Anno })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Grupo__5DCAEF64");
            });

            modelBuilder.Entity<GrupoMatricula>(entity =>
            {
                entity.HasKey(e => new { e.NumeroGrado, e.NumeroPeriodo, e.AnnoPeriodo, e.CedulaEstudiante, e.CodigoGrupo, e.NombreMateria })
                    .HasName("PK__GrupoMat__67A8DBABF449608B");

                entity.ToTable("GrupoMatricula");

                entity.Property(e => e.NombreMateria)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Estado)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.CodigoGrupoNavigation)
                    .WithMany(p => p.GrupoMatriculas)
                    .HasPrincipalKey(p => p.Codigo)
                    .HasForeignKey(d => d.CodigoGrupo)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__GrupoMatr__Codig__6D0D32F4");

                entity.HasOne(d => d.Matricula)
                    .WithMany(p => p.GrupoMatriculas)
                    .HasForeignKey(d => new { d.NumeroGrado, d.NumeroPeriodo, d.AnnoPeriodo, d.CedulaEstudiante })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__GrupoMatricula__6C190EBB");
            });

            modelBuilder.Entity<HistoricoSalarial>(entity =>
            {
                entity.HasKey(e => new { e.CedulaProfesor, e.FechaInicio })
                    .HasName("PK__Historic__95FE567735D25388");

                entity.ToTable("HistoricoSalarial");

                entity.Property(e => e.FechaInicio).HasColumnType("date");

                entity.Property(e => e.FechaFin).HasColumnType("date");

                entity.HasOne(d => d.CedulaProfesorNavigation)
                    .WithMany(p => p.HistoricoSalarials)
                    .HasForeignKey(d => d.CedulaProfesor)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Historico__Cedul__3F466844");
            });

            modelBuilder.Entity<Materia>(entity =>
            {
                entity.HasKey(e => e.Nombre)
                    .HasName("PK__Materia__75E3EFCE13520FA3");

                entity.Property(e => e.Nombre)
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Matricula>(entity =>
            {
                entity.HasKey(e => new { e.NumeroGrado, e.NumeroPeriodo, e.AnnoPeriodo, e.CedulaEstudiante })
                    .HasName("PK__Matricul__FDBAEDB537EA63E0");

                entity.ToTable("Matricula");

                entity.Property(e => e.Estado)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.CedulaEstudianteNavigation)
                    .WithMany(p => p.Matriculas)
                    .HasForeignKey(d => d.CedulaEstudiante)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Matricula__Cedul__5441852A");

                entity.HasOne(d => d.GradoPeriodo)
                    .WithMany(p => p.Matriculas)
                    .HasForeignKey(d => new { d.NumeroGrado, d.NumeroPeriodo, d.AnnoPeriodo })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Matricula__5535A963");
            });

            modelBuilder.Entity<Padre>(entity =>
            {
                entity.HasKey(e => e.Cedula)
                    .HasName("PK__Padre__B4ADFE3923DDC52A");

                entity.ToTable("Padre");

                entity.HasIndex(e => e.Cedula, "UQ__Padre__B4ADFE382A036EC0")
                    .IsUnique();

                entity.Property(e => e.Cedula).ValueGeneratedNever();

                entity.Property(e => e.Nombre)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.NombreConyugue)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ProfesionOficio)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.CedulaNavigation)
                    .WithOne(p => p.Padre)
                    .HasForeignKey<Padre>(d => d.Cedula)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Padre__Cedula__440B1D61");
            });

            modelBuilder.Entity<PeriodoLectivo>(entity =>
            {
                entity.HasKey(e => new { e.NumeroPeriodo, e.Anno })
                    .HasName("PK__PeriodoL__72E4119A18C68394");

                entity.ToTable("PeriodoLectivo");

                entity.Property(e => e.Estado)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.FechaFinal).HasColumnType("date");

                entity.Property(e => e.FechaInicio).HasColumnType("date");
            });

            modelBuilder.Entity<Profesor>(entity =>
            {
                entity.HasKey(e => e.Cedula)
                    .HasName("PK__Profesor__B4ADFE39623D3506");

                entity.ToTable("Profesor");

                entity.HasIndex(e => e.Cedula, "UQ__Profesor__B4ADFE3805DB4491")
                    .IsUnique();

                entity.Property(e => e.Cedula).ValueGeneratedNever();

                entity.Property(e => e.Nombre)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.CedulaNavigation)
                    .WithOne(p => p.Profesor)
                    .HasForeignKey<Profesor>(d => d.Cedula)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Profesor__Cedula__3B75D760");
            });

            modelBuilder.Entity<TipoEvaluacion>(entity =>
            {
                entity.HasKey(e => e.Nombre)
                    .HasName("PK__TipoEval__75E3EFCEE3D42B38");

                entity.ToTable("TipoEvaluacion");

                entity.Property(e => e.Nombre)
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Usuario>(entity =>
            {
                entity.HasKey(e => e.Cedula)
                    .HasName("PK__Usuario__B4ADFE391EF983A6");

                entity.ToTable("Usuario");

                entity.HasIndex(e => e.Cedula, "UQ__Usuario__B4ADFE384C331F2E")
                    .IsUnique();

                entity.Property(e => e.Cedula).ValueGeneratedNever();

                entity.Property(e => e.Apellido1)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Apellido2)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.FechaCreacion).HasColumnType("datetime");

                entity.Property(e => e.FechaNacimiento).HasColumnType("date");

                entity.Property(e => e.NombrePila)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Provincia)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Residencia)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Rol)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Sexo)
                    .IsRequired()
                    .HasMaxLength(1)
                    .IsUnicode(false);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
