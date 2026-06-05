library(neuralnet)
source("R/00_utils.R")

reproducir_lab <- function() {
  titulo("Reproduccion del laboratorio (iris / setosa)")

  data(iris)
  iris$is_setosa <- ifelse(iris$Species == "setosa", 1, 0)

  caract <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")
  mins <- apply(iris[, caract], 2, min)
  maxs <- apply(iris[, caract], 2, max)
  scaled <- as.data.frame(scale(iris[, caract], center = mins, scale = maxs - mins))
  final_data <- cbind(scaled, is_setosa = iris$is_setosa)

  set.seed(42)
  index <- sample(1:nrow(final_data), 0.7 * nrow(final_data))
  train_set <- final_data[index, ]
  test_set  <- final_data[-index, ]

  nn <- neuralnet(is_setosa ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
                  data = train_set, hidden = 3, linear.output = FALSE)

  png(file.path(RUTA_PLOTS, "00_red_setosa.png"), width = 1000, height = 700)
  plot(nn, rep = "best")
  dev.off()

  results <- compute(nn, test_set[, caract])
  predictions <- ifelse(results$net.result > 0.5, 1, 0)
  cm <- matriz_confusion(test_set$is_setosa, predictions)
  print(cm)
  acc <- sum(diag(cm)) / sum(cm)
  cat("Test Accuracy:", round(acc, 4), "\n")

  new_tuple <- data.frame(Sepal.Length = 5.0, Sepal.Width = 3.4,
                          Petal.Length = 1.5, Petal.Width = 0.2)
  new_scaled <- as.data.frame(scale(new_tuple, center = mins, scale = maxs - mins))
  pred_new <- compute(nn, new_scaled)
  cat("Probabilidad de Setosa:", round(pred_new$net.result, 4), "\n")

  invisible(list(modelo = nn, exactitud = acc))
}
