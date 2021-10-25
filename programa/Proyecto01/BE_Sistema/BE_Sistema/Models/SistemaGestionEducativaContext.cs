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
        public virtual DbSet<CuotasPorGrupo> CuotasPorGrupos { get; set; }
        public virtual DbSet<DetalleCobroMatricula> DetalleCobroMatriculas { get; set; }
        public virtual DbSet<DetalleCobroPorGrupo> DetalleCobroPorGrupos { get; set; }
        public virtual DbSet<Estudiante> Estudiantes { get; set; }
        public virtual DbSet<Factura> Facturas { get; set; }
        public virtual DbSet<Grupo> Grupos { get; set; }
        public virtual DbSet<HistoricoSalarial> HistoricoSalarials { get; set; }
        public virtual DbSet<Matricula> Matriculas { get; set; }
        public virtual DbSet<MatriculaGrupo> MatriculaGrupos { get; set; }
        public virtual DbSet<Padre> Padres { get; set; }
        public virtual DbSet<PeriodoLectivo> PeriodoLectivos { get; set; }
        public virtual DbSet<Profesor> Profesors { get; set; }
        public virtual DbSet<Usuario> Usuarios { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=.\\;Database=SistemaGestionEducativa; User Id = sa; Password = Jesus123;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "SQL_Latin1_General_CP1_CI_AS");

            modelBuilder.Entity<Cobro>(entity =>
            {
                entity.HasKey(e => new { e.Codigo, e.MontoTotal })
                    .HasName("PK__Cobro__B5F59524C9A6D882");

                entity.ToTable("Cobro");

                entity.HasIndex(e => e.Codigo, "UQ__Cobro__06370DACF5463265")
                    .IsUnique();

                entity.Property(e => e.Codigo).ValueGeneratedOnAdd();

                entity.Property(e => e.FechaCreacion).HasColumnType("datetime");

                entity.HasOne(d => d.CedulaEstudianteNavigation)
                    .WithMany(p => p.Cobros)
                    .HasPrincipalKey(p => p.Cedula)
                    .HasForeignKey(d => d.CedulaEstudiante)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Cobro__CedulaEst__4E53A1AA");

                entity.HasOne(d => d.CedulaUsuarioNavigation)
                    .WithMany(p => p.Cobros)
                    .HasPrincipalKey(p => p.Cedula)
                    .HasForeignKey(d => d.CedulaUsuario)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Cobro__CedulaUsu__503BEA1C");

                entity.HasOne(d => d.CodigoMatriculaNavigation)
                    .WithMany(p => p.Cobros)
                    .HasForeignKey(d => d.CodigoMatricula)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Cobro__CodigoMat__4F47C5E3");

                entity.HasOne(d => d.PeriodoLectivo)
                    .WithMany(p => p.Cobros)
                    .HasForeignKey(d => new { d.NumeroPeriodo, d.AnnoPeriodo })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Cobro__51300E55");
            });

            modelBuilder.Entity<CuotasPorGrupo>(entity =>
            {
                entity.HasKey(e => new { e.CodigoCobro, e.CodigoGrupo, e.Consecutivo })
                    .HasName("PK__CuotasPo__C07136C4FFA57CF6");

                entity.ToTable("CuotasPorGrupo");

                entity.Property(e => e.Estado)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.Codigo)
                    .WithMany(p => p.CuotasPorGrupos)
                    .HasForeignKey(d => new { d.CodigoCobro, d.CodigoGrupo })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__CuotasPorGrupo__5CA1C101");
            });

            modelBuilder.Entity<DetalleCobroMatricula>(entity =>
            {
                entity.HasKey(e => e.CodigoCobro)
                    .HasName("PK__DetalleC__86E1331643A728C7");

                entity.ToTable("DetalleCobroMatricula");

                entity.Property(e => e.CodigoCobro).ValueGeneratedNever();

                entity.HasOne(d => d.CodigoCobroNavigation)
                    .WithOne(p => p.DetalleCobroMatricula)
                    .HasPrincipalKey<Cobro>(p => p.Codigo)
                    .HasForeignKey<DetalleCobroMatricula>(d => d.CodigoCobro)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__DetalleCo__Codig__540C7B00");
            });

            modelBuilder.Entity<DetalleCobroPorGrupo>(entity =>
            {
                entity.HasKey(e => new { e.CodigoCobro, e.CodigoGrupo })
                    .HasName("PK__DetalleC__A6DAB7CBCA2BE73A");

                entity.ToTable("DetalleCobroPorGrupo");

                entity.HasOne(d => d.CodigoCobroNavigation)
                    .WithMany(p => p.DetalleCobroPorGrupos)
                    .HasPrincipalKey(p => p.Codigo)
                    .HasForeignKey(d => d.CodigoCobro)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__DetalleCo__Codig__57DD0BE4");

                entity.HasOne(d => d.CodigoGrupoNavigation)
                    .WithMany(p => p.DetalleCobroPorGrupos)
                    .HasForeignKey(d => d.CodigoGrupo)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__DetalleCo__Codig__58D1301D");

                entity.HasOne(d => d.PeriodoLectivo)
                    .WithMany(p => p.DetalleCobroPorGrupos)
                    .HasForeignKey(d => new { d.NumeroPeriodo, d.AnnoPeriodo })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__DetalleCobroPorG__59C55456");
            });

            modelBuilder.Entity<Estudiante>(entity =>
            {
                entity.HasKey(e => new { e.Cedula, e.Nombre })
                    .HasName("PK__Estudian__43F3C0C509C8B24C");

                entity.ToTable("Estudiante");

                entity.HasIndex(e => e.Cedula, "UQ__Estudian__B4ADFE38D30ECBC1")
                    .IsUnique();

                entity.Property(e => e.Nombre)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.GradoActual)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.NombrePadre)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.Usuario)
                    .WithOne(p => p.Estudiante)
                    .HasForeignKey<Estudiante>(d => new { d.Cedula, d.Nombre })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Estudiante__52593CB8");

                entity.HasOne(d => d.Padre)
                    .WithMany(p => p.Estudiantes)
                    .HasForeignKey(d => new { d.CedulaPadre, d.NombrePadre })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Estudiante__534D60F1");
            });

            modelBuilder.Entity<Factura>(entity =>
            {
                entity.HasKey(e => e.CodigoCobro)
                    .HasName("PK__Factura__86E133165FDAB6BA");

                entity.ToTable("Factura");

                entity.Property(e => e.CodigoCobro).ValueGeneratedNever();

                entity.Property(e => e.FechaCreacion).HasColumnType("datetime");

                entity.HasOne(d => d.CedulaUsuarioNavigation)
                    .WithMany(p => p.Facturas)
                    .HasPrincipalKey(p => p.Cedula)
                    .HasForeignKey(d => d.CedulaUsuario)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Factura__CedulaU__65370702");

                entity.HasOne(d => d.Cobro)
                    .WithMany(p => p.Facturas)
                    .HasForeignKey(d => new { d.CodigoCobro, d.MontoTotalCobro })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Factura__6442E2C9");
            });

            modelBuilder.Entity<Grupo>(entity =>
            {
                entity.HasKey(e => e.Codigo)
                    .HasName("PK__Grupo__06370DAD9E5A3CDF");

                entity.ToTable("Grupo");

                entity.HasIndex(e => e.Codigo, "UQ__Grupo__06370DAC473E22A4")
                    .IsUnique();

                entity.Property(e => e.Materia)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Nombre)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.NombreProfesor)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.Profesor)
                    .WithMany(p => p.Grupos)
                    .HasForeignKey(d => new { d.CedulaProfesor, d.NombreProfesor })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Grupo__68487DD7");

                entity.HasOne(d => d.PeriodoLectivo)
                    .WithMany(p => p.Grupos)
                    .HasForeignKey(d => new { d.NumeroPeriodo, d.Anno })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Grupo__6754599E");
            });

            modelBuilder.Entity<HistoricoSalarial>(entity =>
            {
                entity.HasKey(e => new { e.CedulaProfesor, e.NombreProfesor })
                    .HasName("PK__Historic__7728B9C85455A646");

                entity.ToTable("HistoricoSalarial");

                entity.Property(e => e.NombreProfesor)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("NombrePRofesor");

                entity.Property(e => e.FechaFin).HasColumnType("date");

                entity.Property(e => e.FechaInicio).HasColumnType("date");

                entity.HasOne(d => d.Profesor)
                    .WithOne(p => p.HistoricoSalarial)
                    .HasForeignKey<HistoricoSalarial>(d => new { d.CedulaProfesor, d.NombreProfesor })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__HistoricoSalaria__440B1D61");
            });

            modelBuilder.Entity<Matricula>(entity =>
            {
                entity.HasKey(e => e.Codigo)
                    .HasName("PK__Matricul__06370DADC42917D6");

                entity.ToTable("Matricula");

                entity.HasIndex(e => e.Codigo, "UQ__Matricul__06370DAC766BE97C")
                    .IsUnique();

                entity.HasOne(d => d.CedulaEstudianteNavigation)
                    .WithMany(p => p.Matriculas)
                    .HasPrincipalKey(p => p.Cedula)
                    .HasForeignKey(d => d.CedulaEstudiante)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Matricula__Cedul__6E01572D");

                entity.HasOne(d => d.PeriodoLectivo)
                    .WithMany(p => p.Matriculas)
                    .HasForeignKey(d => new { d.NumeroPeriodo, d.AnnoPeriodo })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Matricula__6EF57B66");
            });

            modelBuilder.Entity<MatriculaGrupo>(entity =>
            {
                entity.HasKey(e => new { e.CodigoMatricula, e.CodigoGrupo })
                    .HasName("PK__Matricul__6DCBE2C8F3F0C9B7");

                entity.HasOne(d => d.CodigoGrupoNavigation)
                    .WithMany(p => p.MatriculaGrupos)
                    .HasForeignKey(d => d.CodigoGrupo)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Matricula__Codig__1EA48E88");

                entity.HasOne(d => d.CodigoMatriculaNavigation)
                    .WithMany(p => p.MatriculaGrupos)
                    .HasForeignKey(d => d.CodigoMatricula)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Matricula__Codig__1DB06A4F");
            });

            modelBuilder.Entity<Padre>(entity =>
            {
                entity.HasKey(e => new { e.Cedula, e.Nombre })
                    .HasName("PK__Padre__43F3C0C56CB9F762");

                entity.ToTable("Padre");

                entity.HasIndex(e => e.Cedula, "UQ__Padre__B4ADFE3848EA50DC")
                    .IsUnique();

                entity.Property(e => e.Nombre)
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

                entity.HasOne(d => d.Usuario)
                    .WithOne(p => p.Padre)
                    .HasForeignKey<Padre>(d => new { d.Cedula, d.Nombre })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Padre__48CFD27E");
            });

            modelBuilder.Entity<PeriodoLectivo>(entity =>
            {
                entity.HasKey(e => new { e.NumeroPeriodo, e.Anno })
                    .HasName("PK__PeriodoL__72E4119A6F310228");

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
                entity.HasKey(e => new { e.Cedula, e.Nombre })
                    .HasName("PK__Profesor__43F3C0C5B6E1FA3C");

                entity.ToTable("Profesor");

                entity.HasIndex(e => e.Cedula, "UQ__Profesor__B4ADFE38B1381BAE")
                    .IsUnique();

                entity.Property(e => e.Nombre)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.Usuario)
                    .WithOne(p => p.Profesor)
                    .HasForeignKey<Profesor>(d => new { d.Cedula, d.Nombre })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Profesor__403A8C7D");
            });

            modelBuilder.Entity<Usuario>(entity =>
            {
                entity.HasKey(e => new { e.Cedula, e.NombrePila })
                    .HasName("PK__Usuario__FFF39CD8D8A26E19");

                entity.ToTable("Usuario");

                entity.HasIndex(e => e.Cedula, "UQ__Usuario__B4ADFE38B21E6E92")
                    .IsUnique();

                entity.Property(e => e.NombrePila)
                    .HasMaxLength(50)
                    .IsUnicode(false);

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
