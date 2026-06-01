import pandas as pd

from sklearn.model_selection import train_test_split

def leer_archivo(rutaArchivo, columnas) :
    
    data_frame = pd.read_csv(rutaArchivo, header = None, names = columnas)

    return data_frame

def splitter(data_frame, caracteristicas, objetivos) :
    df_caracteristicas = data_frame[caracteristicas]
    df_objetivos = data_frame[objetivos]

    print(f"{df_caracteristicas}\n{df_objetivos}")

    x_train, x_test, y_train, y_test = train_test_split(df_caracteristicas,
                                                        df_objetivos,
                                                        random_state = 42,
                                                        test_size = 0.3)
    
    x_validar,  x_test, y_validar, y_test = train_test_split(x_test,
                                                            y_test,
                                                            random_state= 42,
                                                            test_size = 0.5)
    
    return x_train, y_train, x_validar, y_validar, x_test, y_test