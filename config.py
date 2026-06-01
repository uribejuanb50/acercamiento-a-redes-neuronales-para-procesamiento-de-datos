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

CARACTERISTICAS = ["age", "gender", "education", "country", "ethnicity", 
           "nscore", "escore", "oscore", "ascore", "cscore", "impuslive", 
           "ss"]

OBJETIVOS = ["alcohol", "amphet", "amyl", "benzos", "caff", "cannabis", 
           "choc", "coke", "crack", "ecstasy", "heroin", "ketamine", "legalh", 
           "lsd", "meth", "mushrooms", "nicotine", "semer", "vsa"]




if  __name__ == "__main__" :
    print(RAIZ)

