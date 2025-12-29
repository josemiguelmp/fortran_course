# Makefile para Barnes-Hut en Fortran

# Compilador
FC = gfortran
# Flags de compilación (optimización y advertencias)
FFLAGS = -O2 -Wall -fimplicit-none

# Archivos fuente
MODULES = geometry.f90 particle.f90
MAIN = Barnes_tree.f90

# Archivos objeto generados
OBJ = $(MODULES:.f90=.o) $(MAIN:.f90=.o)

# Ejecutable
EXEC = barnes

# Regla por defecto
all: $(EXEC)

# Cómo generar el ejecutable a partir de los objetos
$(EXEC): $(OBJ)
	$(FC) $(FFLAGS) -o $(EXEC) $(OBJ)

# Cómo generar los objetos de los módulos
%.o: %.f90
	$(FC) $(FFLAGS) -c $<

# Limpieza
clean:
	rm -f *.o *.mod $(EXEC)
