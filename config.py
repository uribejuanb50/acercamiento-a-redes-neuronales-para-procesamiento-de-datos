from pathlib import Path

RAIZ = Path(__file__).parent

SRC = RAIZ / "src"

DATA = RAIZ / "data"
DATASET = DATA / "drug_consumption.data"

OUTPUTS = RAIZ / "outputs"
MATRICES = OUTPUTS / "matrices"
PLOTS = OUTPUTS / "plots"

COLUMNAS = ["lettr", "x-box", "y-box", "width", "high", "onpix",
           "x-bar", "y-bar", "x2bar", "y2bar", "xybar",
           "x2ybr", "xy2br", "x-ege", "xegvy", "y-ege", "yegvx"]

CARACTERISTICAS = ["x-box", "y-box", "width", "high", "onpix",
           "x-bar", "y-bar", "x2bar", "y2bar", "xybar",
           "x2ybr", "xy2br", "x-ege", "xegvy", "y-ege", "yegvx"]

OBJETIVOS = ["lettr"]

CAMBIO_VARIABLES_OBJETIVO = {
    'A': 0, 'B': 1, 'C': 2, 'D': 3, 'E': 4, 'F': 5, 'G': 6, 'H': 7, 'I': 8, 
    'J': 9, 'K': 10, 'L': 11, 'M': 12, 'N': 13, 'O': 14, 'P': 15, 'Q': 16, 
    'R': 17, 'S': 18, 'T': 19, 'U': 20, 'V': 21, 'W': 22, 'X': 23, 'Y': 24, 'Z': 25
}

if  __name__ == "__main__" :
    print(RAIZ)

