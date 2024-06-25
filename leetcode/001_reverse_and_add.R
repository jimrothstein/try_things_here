# 10_reverse_and_add.R
# LEETCODE # 2
# https://leetcode.com/problemset/ (no official R solutions)
#
# Given two sets of digits, add the two.   However, the digits are in REVERSE order
# - create the two numbers (reverse digits, concatenate)
# - add
# - split number in digits and reverse order

# Example c(1,2,3)  and c(5,5) becomes 321+55 = 376 or c(6,7,3)
#'  reverse digits of vector

#'  @param x atomic vector of digits
#'  @example
#'  x=c(1,2,3)
#'  rev(x)
#'  @export
rev <- function(x) {
  len <- length(x)
  y <- x[len:1]
  y
}

#'  convert integer to integet vector
#'
#'  @param x integer
#'  @example
#'  x=321
#'  i2v(x)
#'
#'  @export

i2v <- function(x) {
  stopifnot(is.numeric(x))
  as.character(x)
  strsplit(as.character(x), split = "")
  unlist(strsplit(as.character(x), split = ""))
  rev(unlist(strsplit(as.character(x), split = "")))
}
#'  convert integer vector to integer

#' @param x integer vector concatinate to number.
#' @export
v2i <- function(x) {
  as.integer(Reduce(f = paste0, x))
}

#' @example
v2i(c(1:3)) # [1] 123


#'  @param x integer vector
#'  @param y integer vector
#'  @example
#' x= c(1,2,3)
#' y= c(5,4)
#' add1(x,y)

add1 <- function(x, y) {
  i2v(v2i(rev(x)) + v2i(rev(y)))
}


###  can int vector hold repeatd values? YES
X=c(1,2,1)
X

## sort
sort.int(X)

sort(X)

# which index have same value
which(1 == X)[[1]]
which(1 == X)[[2]]

which(1 == X)
