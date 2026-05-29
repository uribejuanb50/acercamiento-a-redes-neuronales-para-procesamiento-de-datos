from pathlib import Path

RAIZ = Path(__file__).parent

SRC = RAIZ / "src"

DATA = RAIZ / "data"
DATASET = DATA / "setdatos.csv"

OUTPUTS = RAIZ / "outputs"
MATRICES = OUTPUTS / "matrices"
PLOTS = OUTPUTS / "plots"



if  __name__ == "__main__" :
    print(RAIZ)

