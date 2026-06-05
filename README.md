# Lab 07 — Trabajo Autónomo: Redes Neuronales Artificiales

Solución completa, en **R**, del Trabajo Autónomo (Sección 8) del Lab 07,
usando el paquete `neuralnet`.

## Puntos resueltos

1. **Implementación de la ANN** sobre el dataset del laboratorio
   (`iris`, clasificación binaria *¿es setosa?*).
2. **Matriz de confusión y métricas** de la ANN, comparadas con un
   **Árbol de Decisión** (`rpart`) y una **SVM** (`e1071`) sobre la misma
   partición.
3. **Clasificador ANN interpretable** sobre un dataset del **UCI ML
   Repository** (*Banknote Authentication*), con todas las métricas y
   análisis de interpretabilidad (pesos generalizados por variable).

## Estructura

```
.
├── main.R                       # Ejecuta todo el flujo
├── R/
│   ├── 00_utils.R               # Normalización, métricas, matriz de confusión
│   ├── 01_reproduccion_lab.R    # Reproducción del lab (diagrama de la red)
│   ├── 02_punto1_2_setosa.R     # Puntos 1 y 2 (iris/setosa)
│   └── 03_punto3_banknote.R     # Punto 3 (UCI, interpretable)
├── data/
│   └── banknote_authentication.csv
├── outputs/
│   ├── plots/                   # Diagramas de red, árbol, gwplot
│   └── tablas/                  # Matrices de confusión y comparativas (CSV)
├── informe/
│   ├── informe.tex              # Informe LaTeX
│   └── informe.pdf              # Informe compilado
├── references.bib
└── requirements.txt             # Paquetes R necesarios
```

## Requisitos e instalación

Requiere R (>= 4.0) y los paquetes `neuralnet`, `e1071`, `rpart`:

```r
install.packages(c("neuralnet", "e1071", "rpart"))
```

(El dataset `iris` ya viene incluido en R; el de banknote está en `data/`.)

## Ejecución

Desde la raíz del proyecto:

```bash
Rscript main.R
```

o, dentro de R/RGui, tras situarse en la carpeta del proyecto:

```r
source("main.R")
```

## Resultados (conjunto de prueba)

**iris/setosa** — clase linealmente separable, los tres modelos aciertan todo:

| Modelo | Exactitud | Precisión | Sensibilidad | Especificidad | F1 |
|---|---|---|---|---|---|
| Red Neuronal (ANN) | 1.0000 | 1.0000 | 1.0000 | 1.0000 | 1.0000 |
| Árbol de Decisión  | 1.0000 | 1.0000 | 1.0000 | 1.0000 | 1.0000 |
| SVM (RBF)          | 1.0000 | 1.0000 | 1.0000 | 1.0000 | 1.0000 |

**Banknote Authentication (UCI)** — clasificador interpretable:

| Modelo | Exactitud | Precisión | Sensibilidad | Especificidad | F1 |
|---|---|---|---|---|---|
| Red Neuronal (ANN) | 1.0000 | 1.0000 | 1.0000 | 1.0000 | 1.0000 |
| Árbol de Decisión  | 0.9684 | 0.9511 | 0.9777 | 0.9614 | 0.9642 |
| SVM (RBF)          | 1.0000 | 1.0000 | 1.0000 | 1.0000 | 1.0000 |
