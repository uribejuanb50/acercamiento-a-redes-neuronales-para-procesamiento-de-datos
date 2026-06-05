library(neuralnet)
library(rpart)
library(e1071)
source("R/00_utils.R")

ejecutar_banknote <- function() {
  titulo("Punto 3 - Dataset UCI Banknote Authentication")

  datos <- read.csv(file.path(RUTA_DATA, "banknote_authentication.csv"))
  colnames(datos) <- c("variance", "skew", "curtosis", "entropy", "class")
  caract <- c("variance", "skew", "curtosis", "entropy")
  cat("Instancias:", nrow(datos),
      "| Genuinos (0):", sum(datos$class == 0),
      "| Falsos (1):",  sum(datos$class == 1), "\n")

  set.seed(42)
  index <- sample(1:nrow(datos), 0.7 * nrow(datos))
  train_raw <- datos[index, ]
  test_raw  <- datos[-index, ]

  norm <- ajustar_normalizador(train_raw, caract)
  train <- cbind(aplicar_normalizador(train_raw, norm), class = train_raw$class)
  test  <- cbind(aplicar_normalizador(test_raw, norm),  class = test_raw$class)

  set.seed(42)
  nn <- neuralnet(class ~ variance + skew + curtosis + entropy,
                  data = train, hidden = 3, linear.output = FALSE, stepmax = 1e6)

  png(file.path(RUTA_PLOTS, "03_red_banknote.png"), width = 1000, height = 700)
  plot(nn, rep = "best")
  dev.off()

  prob <- compute(nn, test[, caract])$net.result
  pred <- ifelse(prob > 0.5, 1, 0)
  cm <- matriz_confusion(test$class, pred)
  m  <- metricas_binarias(test$class, pred)

  cat("\n-- ANN: matriz de confusion (test) --\n"); print(cm)
  cat("-- ANN: metricas --\n"); print(m)
  cat("Pasos de entrenamiento:", nn$result.matrix["steps", 1],
      "| Error:", round(nn$result.matrix["error", 1], 5), "\n")

  guardar_tabla(as.data.frame.matrix(cm), "banknote_cm_ann.csv")
  guardar_tabla(cbind(Modelo = "Red Neuronal (ANN)", m), "banknote_metricas.csv")

  png(file.path(RUTA_PLOTS, "04_gwplot_banknote.png"), width = 1000, height = 800)
  par(mfrow = c(2, 2))
  for (v in caract) gwplot(nn, selected.covariate = v, min = -3, max = 3)
  par(mfrow = c(1, 1))
  dev.off()

  arbol <- rpart(as.factor(class) ~ ., data = train, method = "class")
  pred_dt <- as.integer(as.character(predict(arbol, test[, caract], type = "class")))
  m_dt <- metricas_binarias(test$class, pred_dt)

  svm_mod <- svm(as.factor(class) ~ ., data = train, kernel = "radial")
  pred_svm <- as.integer(as.character(predict(svm_mod, test[, caract])))
  m_svm <- metricas_binarias(test$class, pred_svm)

  comparacion <- rbind(
    cbind(Modelo = "Red Neuronal (ANN)", m),
    cbind(Modelo = "Arbol de Decision",  m_dt),
    cbind(Modelo = "SVM (RBF)",          m_svm)
  )
  cat("\n-- Comparacion de modelos (banknote, test) --\n")
  print(comparacion, row.names = FALSE)
  guardar_tabla(comparacion, "banknote_comparacion.csv")

  nuevo_raw <- data.frame(variance = 2.0, skew = 5.0, curtosis = -1.0, entropy = 0.5)
  nuevo <- aplicar_normalizador(nuevo_raw, norm)
  prob_nuevo <- compute(nn, nuevo)$net.result
  cat(sprintf("\nTupla nueva -> P(falso) = %.4f -> clase %d (%s)\n",
              prob_nuevo, as.integer(prob_nuevo > 0.5),
              ifelse(prob_nuevo > 0.5, "falso", "genuino")))

  invisible(list(comparacion = comparacion, cm = cm, modelo = nn))
}
