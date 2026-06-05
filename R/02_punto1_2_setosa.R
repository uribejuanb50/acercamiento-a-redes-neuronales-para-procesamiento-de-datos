library(neuralnet)
library(rpart)
library(e1071)
source("R/00_utils.R")

ejecutar_setosa_comparacion <- function() {
  titulo("Puntos 1 y 2 - Dataset del lab (iris / setosa)")

  data(iris)
  iris$is_setosa <- ifelse(iris$Species == "setosa", 1, 0)
  caract <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")

  mins <- apply(iris[, caract], 2, min)
  maxs <- apply(iris[, caract], 2, max)
  scaled <- as.data.frame(scale(iris[, caract], center = mins, scale = maxs - mins))
  final_data <- cbind(scaled, is_setosa = iris$is_setosa)

  set.seed(42)
  index <- sample(1:nrow(final_data), 0.7 * nrow(final_data))
  train <- final_data[index, ]
  test  <- final_data[-index, ]
  cat("Instancias:", nrow(final_data),
      "| train:", nrow(train), "| test:", nrow(test),
      "| setosa en test:", sum(test$is_setosa), "\n")

  set.seed(42)
  nn <- neuralnet(is_setosa ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
                  data = train, hidden = 3, linear.output = FALSE)

  prob_nn <- compute(nn, test[, caract])$net.result
  pred_nn <- ifelse(prob_nn > 0.5, 1, 0)
  cm_nn <- matriz_confusion(test$is_setosa, pred_nn)
  m_nn  <- metricas_binarias(test$is_setosa, pred_nn)

  cat("\n-- ANN: matriz de confusion (test) --\n"); print(cm_nn)
  cat("-- ANN: metricas --\n"); print(m_nn)

  arbol <- rpart(as.factor(is_setosa) ~ ., data = train, method = "class")
  pred_dt <- as.integer(as.character(predict(arbol, test[, caract], type = "class")))
  cm_dt <- matriz_confusion(test$is_setosa, pred_dt)
  m_dt  <- metricas_binarias(test$is_setosa, pred_dt)

  png(file.path(RUTA_PLOTS, "01_arbol_setosa.png"), width = 900, height = 650)
  plot(arbol, uniform = TRUE, margin = 0.1, main = "Arbol de decision - setosa")
  text(arbol, use.n = TRUE, all = TRUE, cex = 0.9)
  dev.off()

  svm_mod <- svm(as.factor(is_setosa) ~ ., data = train, kernel = "radial")
  pred_svm <- as.integer(as.character(predict(svm_mod, test[, caract])))
  cm_svm <- matriz_confusion(test$is_setosa, pred_svm)
  m_svm  <- metricas_binarias(test$is_setosa, pred_svm)

  cat("\n-- Arbol de decision: matriz de confusion --\n"); print(cm_dt)
  cat("-- SVM: matriz de confusion --\n"); print(cm_svm)

  comparacion <- rbind(
    cbind(Modelo = "Red Neuronal (ANN)", m_nn),
    cbind(Modelo = "Arbol de Decision",  m_dt),
    cbind(Modelo = "SVM (RBF)",          m_svm)
  )
  cat("\n-- Comparacion de modelos (conjunto de prueba) --\n")
  print(comparacion, row.names = FALSE)

  guardar_tabla(comparacion, "setosa_comparacion.csv")
  guardar_tabla(as.data.frame.matrix(cm_nn), "setosa_cm_ann.csv")

  invisible(list(comparacion = comparacion, cm_nn = cm_nn, modelo_nn = nn))
}
