from pathlib import Path

RAIZ = Path(__file__).parent

SRC = RAIZ / "src"

DATA = RAIZ / "data"
DATASET = DATA / "drug_consumption.data"

OUTPUTS = RAIZ / "outputs"
MATRICES = OUTPUTS / "matrices"
PLOTS = OUTPUTS / "plots"

COLUMNAS = ["id", "age", "gender", "education", "country", "ethnicity", 
           "nscore", "escore", "oscore", "ascore", "cscore", "impuslive", 
           "ss", "alcohol", "amphet", "amyl", "benzos", "caff", "cannabis", 
           "choc", "coke", "crack", "ecstasy", "heroin", "ketamine", "legalh", 
           "lsd", "meth", "mushrooms", "nicotine", "semer", "vsa"]

COLUMNA_TRAMPA = "semer"

CARACTERISTICAS = ["age", "gender", "education", "country", "ethnicity", 
           "nscore", "escore", "oscore", "ascore", "cscore", "impuslive", 
           "ss"]

OBJETIVOS = ["alcohol", "amphet", "amyl", "benzos", "caff", "cannabis", 
           "choc", "coke", "crack", "ecstasy", "heroin", "ketamine", "legalh", 
           "lsd", "meth", "mushrooms", "nicotine", "vsa"]

CAMBIO_VARIABLES_OBJETIVO = {
    "CL0" : 0,
    "CL1" : 1,
    "CL2" : 2,
    "CL3" : 3,
    "CL4" : 4,
    "CL5" : 5,
    "CL6" : 6
}

if  __name__ == "__main__" :
    print(RAIZ)

