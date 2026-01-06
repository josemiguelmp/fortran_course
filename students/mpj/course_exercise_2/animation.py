import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# ==========================
# Parámetros
# ==========================
filename = "C:/Users/uSer/Documents/Máster Astrofísica/Segundo curso/Programación/fortran_course/students/mpj/course_exercise_2/output.dat"
gif_name = "C:/Users/uSer/Documents/Máster Astrofísica/Segundo curso/Programación/fortran_course/students/mpj/course_exercise_2/animations/1000particles.gif"
interval = 50   # ms entre frames

# ==========================
# Leer datos
# ==========================
data = np.loadtxt(filename)

time = data[:, 0]
coords = data[:, 1:]

n_particles = coords.shape[1] // 3
positions = coords.reshape(len(time), n_particles, 3)

# ==========================
# Figura 3D
# ==========================
fig = plt.figure()
ax = fig.add_subplot(projection='3d')

scat = ax.scatter([], [], [], s=20)

max_range = np.max(np.abs(positions))
ax.set_xlim(-max_range, max_range)
ax.set_ylim(-max_range, max_range)
ax.set_zlim(-max_range, max_range)

ax.set_xlabel("x")
ax.set_ylabel("y")
ax.set_zlabel("z")

# ==========================
# Animación
# ==========================
def init():
    scat._offsets3d = ([], [], [])
    return scat,

def update(frame):
    x = positions[frame, :, 0]
    y = positions[frame, :, 1]
    z = positions[frame, :, 2]

    scat._offsets3d = (x, y, z)
    ax.set_title(f"t = {time[frame]:.3f}")
    return scat,

ani = FuncAnimation(
    fig,
    update,
    frames=len(time),
    init_func=init,
    interval=interval,
    blit=False
)

# ==========================
# Guardar GIF
# ==========================
print("Guardando GIF...")
ani.save(gif_name, writer="pillow", fps=1000//interval)
print(f"GIF guardado como {gif_name}")

plt.show()