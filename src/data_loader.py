import pandas as pd

from sklearn.model_selection import train_test_split



def leer_archivo(rutaArchivo, columnas, caracteristicas, objetivos) :
    
    data_frame = pd.read_csv(rutaArchivo, header = None, names = columnas)

    #data_frame =  data_frame[caracteristicas]

    print(data_frame.head())


    return data_frame
