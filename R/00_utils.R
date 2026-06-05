RUTA_DATA   <- "data"
RUTA_PLOTS  <- "outputs/plots"
RUTA_TABLAS <- "outputs/tablas"

ajustar_normalizador <- function(train, columnas) {
  list(
    mins = apply(train[, columnas, drop = FALSE], 2, min),
    maxs = apply(train[, columnas, drop = FALSE], 2, max),
    columnas = columnas
  )
}

aplicar_normalizador <- function(df, norm) {
  escalado <- scale(df[, norm$columnas, drop = FALSE],
                    center = norm$mins, scale = norm$maxs - norm$mins)
  as.data.frame(escalado)
}

metricas_binarias <- function(real, pred) {
  real <- as.integer(real)
  pred <- as.integer(pred)

  VP <- sum(pred == 1 & real == 1)
  VN <- sum(pred == 0 & real == 0)
  FP <- sum(pred == 1 & real == 0)
  FN <- sum(pred == 0 & real == 1)

  exactitud     <- (VP + VN) / (VP + VN + FP + FN)
  precision     <- ifelse((VP + FP) > 0, VP / (VP + FP), NA)
  sensibilidad  <- ifelse((VP + FN) > 0, VP / (VP + FN), NA)
  especificidad <- ifelse((VN + FP) > 0, VN / (VN + FP), NA)
  f1 <- ifelse(!is.na(precision) & !is.na(sensibilidad) & (precision + sensibilidad) > 0,
               2 * precision * sensibilidad / (precision + sensibilidad), NA)

  data.frame(
    Exactitud     = round(exactitud, 4),
    Precision     = round(precision, 4),
    Sensibilidad  = round(sensibilidad, 4),
    Especificidad = round(especificidad, 4),
    F1            = round(f1, 4)
  )
}

matriz_confusion <- function(real, pred) {
  table(Real = factor(real, levels = c(0, 1)),
        Prediccion = factor(pred, levels = c(0, 1)))
}

guardar_tabla <- function(obj, nombre) {
  write.csv(obj, file.path(RUTA_TABLAS, nombre), row.names = TRUE)
}

titulo <- function(txt) {
  cat("\n", strrep("=", 70), "\n", txt, "\n", strrep("=", 70), "\n", sep = "")
}
