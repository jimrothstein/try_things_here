# 130_modular_arithmetic.R

# return quotient + remainder (modulo b)
foo <- function(a, b) c(modulo = b, quotient = floor(a / b), remainder = a %% b)

foo(731, 11)



# 	actual digits of integer (base 10)
each_digit <- function(x) {
  if (n_digits(x) == 1) {
    return(x)
  }
  if (n_digits(x) > 1) {
    #floor(x / (10^n_digits))
    z=trunc(x / (10^(n_digits(x)-1)))
		x =  x-z*10^(n_digits(x) - 1)
		cat("next = ", z)
		each_digit(x)
  }
}

each_digit(5)
each_digit(20)
each_digit(321)
each_digit(123456)
# number digits of integer
n_digits <- function(x) {
  x <- as.integer(x)
  stopifnot(is.integer(x))
  if (x < 0) x <- -x
  if (x == 0) {
    return(1)
  }
#  digits <- floor(log10(x)) + 1
	digits  <- trunc(log10(x)) + 1
}

z=n_digits(731)

n_"igits(0)
n_"igits(7)
n_"igits(-6)
n_"igits(10^3)


# 	calc the control digit
control <- function(d = NULL, v) {
  d <- c(1, 1)
  v <- c(3, 2)
  z <- d %*% v
  z
}
d <- c(1, 1)
v <- c(3, 2)
control(d, v)


# --------------------
# reverse the digits
# --------------------
rev  <- function(x){
  len=nchar(x)
  y=x[len:1]
  y
  }
# Examples
x = c(1:4)
# [1] 1 2 3 4
nchar(x)
v2i(x) 
# [1] 1234
rev(v2i(x))
# [1] 1 1 1 1
rev(x)
rev(1:4)
rev(c(1,2,8,9))

# -------------------
# vector to integer
# -------------------

v2i  <- function(x) {  
  as.integer(Reduce(f=paste0, x))
}
v2i(c(1:3))


# reverse and make single number
# Example
X = c(3,4,5,6)
v2i(rev(X))


Y = c(1,1,2)
ans = v2i(rev(X)) + v2i(rev(Y))
ans
# [1] 6754
length(ans)
# [1] 1
length(ans[[1]])
nchar(ans[[1]])
rev(ans)
