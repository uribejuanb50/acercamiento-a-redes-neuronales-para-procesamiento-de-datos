import src.data_loader as data_loader
import src.preprocessing as preprocessing

from config import (DATASET,
                    COLUMNAS,
                    COLUMNA_TRAMPA,
                    CARACTERISTICAS,
                    OBJETIVOS,
                    CAMBIO_VARIABLES_OBJETIVO
                    )


def main() :

    data_frame = data_loader.leer_archivo(DATASET, COLUMNAS)

    print(data_frame)

    data_frame = preprocessing.cambiar_variables(data_frame, [COLUMNA_TRAMPA], CAMBIO_VARIABLES_OBJETIVO, False)

    print( f"semer:\n{data_frame['semer'].value_counts(normalize = True)}" )

    data_frame = preprocessing.dejar_solo_tuplas_por_valor(data_frame, 0, COLUMNA_TRAMPA)
    data_frame = preprocessing.cambiar_variables(data_frame, OBJETIVOS, CAMBIO_VARIABLES_OBJETIVO)
    
    print(data_frame.head())
    
    


    data_loader.splitter(data_frame, CARACTERISTICAS, OBJETIVOS)
    return 

if __name__ == "__main__" :
    main()