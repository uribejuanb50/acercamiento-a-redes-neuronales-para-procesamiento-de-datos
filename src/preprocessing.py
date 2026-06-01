def cambiar_variables(data_frame, columnas, mapa_cambios, validar = True) :
    data_frame_copia = data_frame.copy()

    esperados = set(mapa_cambios.keys())

    for col in columnas :
        valores_unicos = set(data_frame_copia[col].dropna().unique())

        if validar : validar_valores_unicos(col, esperados, valores_unicos)

        data_frame_copia[col] = data_frame_copia[col].map(mapa_cambios).astype(int)
    
    return data_frame_copia


def validar_valores_unicos(col, esperados, valores_unicos) :

    if valores_unicos != esperados :
        raise ValueError(
            f"los valores no coincide en {col}\n"
            f"esperados: {esperados}\n"
            f"valores únicos: {valores_unicos}"
        )
    
def dejar_solo_tuplas_por_valor(data_frame, valor, columna) :

    data_frame_copia = data_frame.copy()

    data_frame_copia = data_frame_copia[data_frame_copia[columna] == valor]

    return data_frame_copia.drop(columns = [columna])
