# ==========================================
# Compiladores y Flags
# ==========================================
FC_SERIE = gfortran
FC_OMP   = gfortran
FC_MPI   = mpif90
FFLAGS   = -O3 -Wall -fimplicit-none
OMP_FLAG = -fopenmp

# Ejecutables
GEN_EXE   = input_rotation
EXE_SERIE = tree_serie
EXE_OMP   = tree_omp
EXE_MPI   = tree_mpi

# ==========================================
# Reglas Principales
# ==========================================
all: $(GEN_EXE) $(EXE_SERIE) $(EXE_OMP) $(EXE_MPI)

# 1. Generador de datos (No necesita los módulos de física normalmente)
$(GEN_EXE): input_rotation.f90
	$(FC_SERIE) $(FFLAGS) -o $@ $<

# 2. Versión Serie
$(EXE_SERIE): geometry_s.o particle_s.o tree_p.o
	$(FC_SERIE) $(FFLAGS) -o $@ $^

# 3. Versión OpenMP
$(EXE_OMP): geometry_omp.o particle_omp.o tree_openmp.o
	$(FC_OMP) $(FFLAGS) $(OMP_FLAG) -o $@ $^

# 4. Versión MPI
$(EXE_MPI): geometry_mpi.o particle_mpi.o tree_mpi.o
	$(FC_MPI) $(FFLAGS) -o $@ $^

# ==========================================
# Compilación de Objetos (Específica)
# ==========================================

# NOTA: Al compilar el primer objeto de cada tanda, se genera el .mod
# Añadimos la dependencia manual para asegurar el orden.

# Objetos Serie
geometry_s.o: geometry.f90
	$(FC_SERIE) $(FFLAGS) -c $< -o $@
particle_s.o: particle.f90 geometry_s.o
	$(FC_SERIE) $(FFLAGS) -c $< -o $@
tree_p.o: tree_p.f90 particle_s.o
	$(FC_SERIE) $(FFLAGS) -c $< -o $@

# Objetos OpenMP
geometry_omp.o: geometry.f90
	$(FC_OMP) $(FFLAGS) $(OMP_FLAG) -c $< -o $@
particle_omp.o: particle.f90 geometry_omp.o
	$(FC_OMP) $(FFLAGS) $(OMP_FLAG) -c $< -o $@
tree_openmp.o: tree_openmp.f90 particle_omp.o
	$(FC_OMP) $(FFLAGS) $(OMP_FLAG) -c $< -o $@

# Objetos MPI
geometry_mpi.o: geometry.f90
	$(FC_MPI) $(FFLAGS) -c $< -o $@
particle_mpi.o: particle.f90 geometry_mpi.o
	$(FC_MPI) $(FFLAGS) -c $< -o $@
tree_mpi.o: tree_MPI.f90 particle_mpi.o
	$(FC_MPI) $(FFLAGS) -c $< -o $@

# ==========================================
# Ejecución y Comparativa
# ==========================================
run_all: all
	@echo "--- Generating input_rotation.dat ---"
	@./$(GEN_EXE)
	
	@echo "\n--- Ejecutando VERSIÓN SERIE ---"
	@./$(EXE_SERIE) < input_rotation.dat
	
	@echo "\n--- Ejecutando OPENMP ---"
	@export OMP_NUM_THREADS=8 && ./$(EXE_OMP) < input_rotation.dat
	
	@echo "\n--- Ejecutando MPI ---"
	@mpirun -np 4 ./$(EXE_MPI) < input_rotation.dat

clean:
	rm -f *.o *.mod $(GEN_EXE) $(EXE_SERIE) $(EXE_OMP) $(EXE_MPI) input_rotation.dat output*.dat