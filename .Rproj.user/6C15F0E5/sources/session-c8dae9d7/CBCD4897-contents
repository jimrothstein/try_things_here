library(dplyr)
# What is the problem?
#
mtcars[, "hp"]
mtcars[, c("hp")]
mtcars[mtcars$hp > 200, ]
subset(mtcars, hp > 200)
dplyr::filter(mtcars, hp > 200)

# FAILS
mtcars[, hp]
mtcars[hp > 100, ]
mtcars[hp > 200, ]

get("hp", as.environment(mtcars)) # ok
get(hp, as.environment(mtcars)) # error
# not the mean of column created by adding 2 columns !!
mtcars$cyl + mtcars$am |> mean()


# works
hp_expr <- quote(hp > 200)
eval(hp_expr, envir = mtcars)
eval(hp_expr, envir = as.environment(mtcars))

# err
eval(hp_expr, data = mtcars)

# with works
with(mtcars, hp > 200)
mtcars |> with(hp > 200)
with(mtcars, subset(hp, hp > 200))
with(mtcars, mean(cyl + am)) # no meaning

##  How does magic happen?
# Examine subset.default
subset
subset.default
# function (x, subset, ...)
# {
#     if (!is.logical(subset))
#         stop("'subset' must be logical")
#     x[subset & !is.na(subset)]
# }
# <bytecode: 0x56583c450340>
# <environment: namespace:base>
#
eval
# function (expr, envir = parent.frame(), enclos = if (is.list(envir) ||
#     is.pairlist(envir)) parent.frame() else baseenv())
# .Internal(eval(expr, envir, enclos))
# <bytecode: 0x565838577cf8>
# <environment: namespace:base>
##  S3 function with captures what user input for expr
with
with.default
# function (data, expr, ...)
# eval(substitute(expr), data, enclos = parent.frame())
# <bytecode: 0x56583c421258>
# <environment: namespace:base>
#
# Works !
my_f <- function(data, expr) {
  eval(substitute(expr), data, enclos = parent.frame(2))
}
my_f(mtcars, hp > 200)
my_f(mtcars, mean(hp))

# Works
eval(substitute(mean(hp)), envir = mtcars)

e <- expression(mean(hp))

# FAILS
eval(substitute(e), envir = mtcars)
eval(substitute(e), envir = mtcars)
eval(substitute(e), data = mtcars, enclos = parent.frame())
eval(substitute(e), data = mtcars, enclos = parent.frame())
eval((mean(hp)), envir = mtcars)
eval(substitute(e), data = mtcars, enclos = parent.frame(1))

z <- as.environment(mtcars)
is.environment(z)
str(z, envir = parent.frame())

# Errors
mean(hp, envir = z)
mean(hp, envir = z, enclos = parent.frame())
mean(hp, enclos = z)
mean(hp, envir = mtcars)
ls()
ls(envir = parent.frame())
