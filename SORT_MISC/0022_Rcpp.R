# 022_RCPP.R

# deleted!
# start with

# ---- 000 See: ----
# http://adv-r.had.co.nz/Rcpp.html#rcpp


# ---- 000 prep -----
library(Rcpp)
library(microbenchmark)

# ---- 001-simple ----
# ...wait .... must compile
cppFunction("int signC(int x) {
  if (x > 0) {
    return 1;
  } else if (x == 0) {
    return 0;
  } else {
    return -1;
  }
}")

# R
signC(-100) # -1


#---- 002-loops in C ----
# Unlike R, Loops are efficient in C++
cppFunction("double sumC(NumericVector x) {
  int n = x.size();
  double total = 0;
  for(int i = 0; i < n; ++i) {
    total += x[i];
  }
  return total;
}")

sumC(c(1, 2, 3))
sumC(c("a", "b", "c")) # error

# ---- 003-loops in R ----
sumR <- function(x) {
  total <- 0
  for (i in seq_along(x)) {
    total <- total + x[i]
  }
  total
}
sumR(c(1, 2, 3))

# ---- 004-microbench sumC v sumR ----
x <- runif(1e4)
head(x)
microbenchmark::microbenchmark(
  sumC(x), # median ~20.4 microseconds
  sumR(x) # meaidan ~ 1241.7 microseconds!
)

# ---- 005-Euclidean Distance ----
# in R:
pdistR <- function(x, ys) {
  sqrt((x - ys)^2)
}
# Ambiguous!  distance between 2 vectors?
# or distance between 2 real numbers?
pdistR(c(0, 0), c(1, 1)) # 1,1  or really sqrt(2  ??)

# or is x a scalar ?
pdistR(c(0), c(1, 1))

# C++ much more demanding:
cppFunction("NumericVector pdistC(double x,
        NumericVector ys) {
  int n = ys.size();
  NumericVector out(n);

  for(int i = 0; i < n; ++i) {
    out[i] = sqrt(pow(ys[i] - x, 2.0));
  }
  return out;
}")
pdistC(0, c(1, 1)) # 1, 1

pdistC(c(0, 0), c(1, 1)) # error!  x must be scalar

# ---- 006-Matrix ----
