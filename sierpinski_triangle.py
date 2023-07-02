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

n = 3
N = 100000
puntos = get_puntos(n)

x = [p[0] for p in puntos]
y = [p[1] for p in puntos]

punto = np.array([0.5, 0.1])
x.append(punto[0])
y.append(punto[1])


for _i in range(N):
    esquina = random.choice(puntos)
    punto = punto + .5 * (esquina - punto)
    x.append(punto[0])
    y.append(punto[1])

plt.figure(figsize=(10, 10))
s = .5
plt.scatter(x, y, s=s)
plt.xlim(-1, 1)
plt.ylim(-1, 1)
plt.savefig(f"other/sierpinski-n={n}-N={N}-s={s}.png")