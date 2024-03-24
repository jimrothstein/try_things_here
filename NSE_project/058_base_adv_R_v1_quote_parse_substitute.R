# 058_adv_R_hadley_non_standard.R 

# TODO:

# https://tomaztsql.wordpress.com/2024/03/23/little-useless-useful-r-functions-reverse-hello-world/
# Explain "hello world", using substitute?



###
#	substitute vs deparse(substitute)
###
f <- function(x) {
	substitute(x)
}
# --------------------------------
# return string with contents of function call
# --------------------------------
g <- function(x) {
	deparse(substitute(x))
}
f(1:10)		# 1:10
g(1:10)		# "1:10" 
g(x+y)   # "x +  y"
g(2 + 3)   # "2 + 3"


x <- 10
f(x)		# x  b/c unevaluated
g(x)		# "x"


y <- 13
f(x + y^2)	# x x y^2
g(x + y^2)


# --------------------------------
## EXPLAIN
# --------------------------------
library(rlang)
h = function(print) {
  z = deparse(substitute(print ))
  cat(z)
  cat("print")
  if (z[[1]] == "print") { print("Hello World")
    } else {print("Well ...")}
}
h("jim")
h(2)
h("hi")
h("print")
h(print)
h(1:10)
h(x+y)
h(2 + 3)
"hello" == "hello"
# --------------------------------
# --------------------------------
e<-quote(`foo bar`)
e  		# `foo bar`
deparse(e)	# "foo bar"
deparse(e, backtick=TRUE) #	"`foo bar`"


###
#	Exercise 1
###
# returns TWO char vectors-fix
g1 <- function(x) {
	deparse(substitute(x), width.cutoff = 100L)
}
g(a + b + c + d + e + f + g + h + i + j + k + l + m +
  	n + o + p + q + r + s + t + u + v + w + x + y + z)
g1(a + b + c + d + e + f + g + h + i + j + k + l + m +
  	n + o + p + q + r + s + t + u + v + w + x + y + z)
z="x$&'"
as.Date.default(z)	# 'z' - why?
deparse(substitute(z))	# "z"
####
#	quote
####

quote(x+y)

quote (x+3)

quote (sinx )
quote ("a" + 3 )
quote ('a' + 3)		# "a" + 3
quote ('a'+"b"+3)	# "a" + "b" +3
quote (\'a\')		# dislikes the \
quote ($ + s)		# disklikes the $
quote (* 2 3)		# disklies *
quote (2 *3)
       
