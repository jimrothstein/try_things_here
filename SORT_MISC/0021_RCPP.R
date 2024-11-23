---
  TAGS:
---
  # 021_RCPP.R

  # see http://adv-r.had.co.nz/Rcpp.html#rcpp

  library(Rcpp)

# ---- 001 example: add() ----
cppFunction("int add(int x, int y, int z) {
  int sum = x + y + z;
  return sum;
}")

# add works like a regular R function
add # gives C++ outline

add(1, 2, 3) # R


# ---- 002 simplest ----

# R
one <- function() 1L

# in C++
# int one() {
#         return 1;
# }

# in R
cppFunction(
  "int one()
        {
                return 1;
        }"
)

# ---- 003 C++ notes ----
# C++ vectors (common to R) are:
#
# NumericVector,
# IntegerVector,
# CharacterVector, and
# LogicalVector.

# The scalar equivalents of  R numeric, integer, character, and logical vectors
# are C++: double, int, String, and bool.

# ---- 004 sign() ----
cppFunction("int signC(int x) {
  if (x > 0) {
    return 1;
  } else if (x == 0) {
    return 0;
  } else {
    return -1;
  }
}")

# ---- 005 loops cost less in c++ ----
cppFunction("double sumC(NumericVector x) {
  int n = x.size();
  double total = 0;
  for(int i = 0; i < n; ++i) {
    total += x[i];
  }
  return total;
}")
sumC
sum(c(1, 23, 2))

#### ----
