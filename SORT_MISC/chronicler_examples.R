library(chronicler)


### 	Goal:  create 2 functions that (1) compose (2) both log results
###
# 	return list
my_sqrt <- function(x, log = "") {
  list(
    sqrt(x),
    c(
      log,
      paste0("Running sqrt with input ", x)
    )
  )
}
r <- my_sqrt(9)
r <- my_sqrt(9, "file")
r
