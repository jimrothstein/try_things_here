library(rlang)
library(magrittr)


f <- function(x) {
  env_print(current_env())
}
f(x)


g <- function(x) {
  # 				f_list  <- (
  env_print(current_env())
}
g(x)
m <- function(n) {
  pryr::promise_info(n)
  env_print(current_env())
}
m(n)
h <- function(n) {
  n <- 75
  env_print(current_env())
  cat("n = ", n, "\n") # not 100?
  print("=====")
  print("=====")
  {
    k <- function(n) {
      n <- 50
      env_print(current_env())
    }
  }
  n <- 25
  k(n)
}

n <- 100
h(n)
n

n %>%
  g() %>%
  f()

# where am I:
env_print(current_env())
