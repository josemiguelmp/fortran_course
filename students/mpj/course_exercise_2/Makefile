# =========================
# Compilador y flags
# =========================
FC = gfortran
FFLAGS = -O2 -Wall -fimplicit-none

# =========================
# Módulos
# =========================
MODULES = geometry.f90 particle.f90
MOD_OBJ = $(MODULES:.f90=.o)

# =========================
# Programas
# =========================
INPUT_SRC = input.f90
TREE_SRC  = tree_p.f90

INPUT_OBJ = $(INPUT_SRC:.f90=.o)
TREE_OBJ  = $(TREE_SRC:.f90=.o)

INPUT_EXE = input.exe
TREE_EXE  = tree_p.exe

# =========================
# Regla por defecto
# =========================
all: $(INPUT_EXE) $(TREE_EXE)

# =========================
# Ejecutables
# =========================
$(INPUT_EXE): $(MOD_OBJ) $(INPUT_OBJ)
	$(FC) $(FFLAGS) -o $@ $^

$(TREE_EXE): $(MOD_OBJ) $(TREE_OBJ)
	$(FC) $(FFLAGS) -o $@ $^

# =========================
# Compilación genérica
# =========================
%.o: %.f90
	$(FC) $(FFLAGS) -c $<

# =========================
# Flujo completo
# =========================
run: $(INPUT_EXE) $(TREE_EXE)
	./$(INPUT_EXE)
	./$(TREE_EXE)

# =========================
# Limpieza
# =========================
clean:
	rm -f *.o *.mod $(INPUT_EXE) $(TREE_EXE) input.txt output.dat