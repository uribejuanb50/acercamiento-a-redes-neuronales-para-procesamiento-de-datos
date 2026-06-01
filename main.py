import src.data_loader as data_loader

from config import (DATASET,
                    COLUMNAS,
                    CARACTERISTICAS,
                    OBJETIVOS
                    )

def main() :

    data_loader.leer_archivo(DATASET, COLUMNAS, CARACTERISTICAS, OBJETIVOS)
    return 

if __name__ == "__main__" :
    main()