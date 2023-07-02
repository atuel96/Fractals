import matplotlib.pyplot as plt
import numpy as np
import matplotlib.colors as mcolors

filepath = "newton.txt"

image = np.loadtxt(filepath, int)
alpha = np.loadtxt("alpha.txt", float)



def hex_to_rgb(value):
    '''
    convierte hex a rgb
    value: string de 6 characteres representando un color hex.
    return: lista con los valores RGB'''
    value = value.strip("#") # borra el hash si está presente
    lv = len(value)
    return tuple(int(value[i:i + lv // 3], 16) for i in range(0, lv, lv // 3))


def rgb_to_dec(value):
    '''
    Convierte RGB a valores decimes (divide cada valor en 256)
    value: lista con los valores RGB
    Returns: lista con los valores decimales'''
    return [v/256 for v in value]
    
def get_continuous_cmap(hex_list, float_list=None):
    ''' crea y regresa un mapa de color para ser utilizado en las figuras.
        Si float_list no está presente, el mapa de color gradua linealmente entre cada color de la hex_list.
        Si float_list está presnte, cada color es mapeado a la respectiva localizacion.
    '''

    rgb_list = [rgb_to_dec(hex_to_rgb(i)) for i in hex_list]
    if float_list:
        pass
    else:
        float_list = list(np.linspace(0,1,len(rgb_list)))
        
    cdict = dict()
    for num, col in enumerate(['red', 'green', 'blue']):
        col_list = [[float_list[i], rgb_list[i][num], rgb_list[i][num]] for i in range(len(float_list))]
        cdict[col] = col_list
    cmp = mcolors.LinearSegmentedColormap('my_cmp', segmentdata=cdict, N=256)
    return cmp


hexs = ["ae2012", "ca6702", "55a630", "03045e", "000000"] 

plt.imshow(image, alpha=alpha, cmap=get_continuous_cmap(hexs)) 
plt.savefig("newton.png",dpi=300)
plt.show()