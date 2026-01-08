import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# ==========================
# Parámetros
# ==========================
filename = "/home/josemiguelmp/fortran_course/students/mpj/course_exercise_2/output_mpi.dat"
gif_name = "/home/josemiguelmp/fortran_course/students/mpj/course_exercise_2/animations/spherical_collapse_mpi.gif"
limit = 1.2      # Radio inicial de la esfera (un poco más que r_max=1)
skip = 1         # Cambiar a 2 o más si el archivo es muy pesado

# ==========================
# Leer datos
# ==========================
print(f"Leyendo {filename}...")
data = np.loadtxt(filename)

if skip > 1:
    data = data[::skip, :]

time = data[:, 0]
# Calculamos N basándonos en que cada partícula tiene (x, y, z)
n_particles = (data.shape[1] - 1) // 3
positions = data[:, 1:].reshape(len(time), n_particles, 3)

# ==========================
# Figura 3D
# ==========================
fig = plt.figure(figsize=(8, 8), facecolor='black')
ax = fig.add_subplot(projection='3d', facecolor='black')

# Todas las partículas en amarillo
# Usamos un alpha pequeño para ver cómo aumenta la densidad en el centro
scat = ax.scatter([], [], [], s=3, c='yellow', alpha=0.6, edgecolors='none')

# Estética
ax.grid(False)
ax.set_axis_off() 

def init():
    ax.set_xlim(-limit, limit)
    ax.set_ylim(-limit, limit)
    ax.set_zlim(-limit, limit)
    return (scat,)

def update(frame):
    # En el colapso, dibujamos todas las partículas por igual
    x = positions[frame, :, 0]
    y = positions[frame, :, 1]
    z = positions[frame, :, 2]
    
    scat._offsets3d = (x, y, z)
    
    # Título dinámico
    ax.set_title(f"Colapso Esférico | t = {time[frame]:.3f}", 
                 color='white', fontsize=14, pad=-20)
    
    # Rotación suave de la cámara
    #ax.view_init(elev=20, azim=frame * 0.7)
    
    return (scat,)

# ==========================
# Renderizado
# ==========================
ani = FuncAnimation(fig, update, frames=len(time), init_func=init, 
                    interval=30, blit=False)

print(f"Generando {gif_name}...")
# fps=30 para una animación fluida
ani.save(gif_name, writer="pillow", fps=30, dpi=100)
print(f"¡Hecho! Animación guardada en {gif_name}")

plt.show()