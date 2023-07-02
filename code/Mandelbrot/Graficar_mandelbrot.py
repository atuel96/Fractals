import matplotlib.pyplot as plt
import numpy as np
import matplotlib.colors as mcolors

filepath = "mandelbrot.txt"

image = np.loadtxt(filepath, int)




plt.imshow(image, cmap="hot") 
plt.savefig("man1.png",dpi=300)
plt.show()