ellipsis_length_function <- function(...) {
  ellipsis_length <- ...length()
  cat("... length: ", ellipsis_length, "\n")
}



ellipsis_length_function(a = 1, b = 2)
