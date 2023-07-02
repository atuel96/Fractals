import random
import numpy as np
import matplotlib.pyplot as plt


def get_cartesian(r, theta):
    return [r*np.cos(theta), r*np.sin(theta)]

def get_puntos(n):
    theta = np.pi*.5
    r = 1
    puntos = [get_cartesian(r, theta)]
    vuelta = 2*np.pi
    for i in range(n-1):
        theta += vuelta/n
        puntos.append(get_cartesian(r, theta))
    return puntos

n = 4
N = 10000
esquinas = get_puntos(n)
last = True # constrait
automatic = False

colors = ["blue", "orange", "red", "magenta", "cyan"]

x = [p[0] for p in esquinas]
y = [p[1] for p in esquinas]

punto = np.array([0.5, 0.1])
x.append(punto[0])
y.append(punto[1])

if automatic:
    r = n/(n+3)
else:
    r = .5
ultimo_punto = esquinas[0]
last_index = 0
for _i in range(N):
    if last:
        indice_esquina = random.choice(range(n)) 
        while indice_esquina == last_index:
            indice_esquina = random.choice(range(n)) 
        esquina = esquinas[indice_esquina]
        last_index = indice_esquina
    else:
        esquina = esquinas[random.choice(range(n))]
    punto = punto + r * (esquina - punto)
    x.append(punto[0])
    y.append(punto[1])

plt.figure(figsize=(10, 10))
s = .5
plt.scatter(x, y, s=s)
plt.xlim(-1, 1)
plt.ylim(-1, 1)
plt.savefig(f"figs/chaos-game-n={n}-N={N}-s={s}-last-constrait{last}.png")