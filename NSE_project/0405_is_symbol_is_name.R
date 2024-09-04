# 0405_is_symbol_is_name.R


# PURPOSE:  Explain what `name` really is
# SEE:  https://bityl.co/O4wK

# Two things going on.   A variable points to object. That is NOT the name.
#
# First R, lookup up the object itself.
# Second R reports if the object itself is a name or NOT.
# Third,  this useful mostly when computing on the language.

# ----------------------------------------------------------------
#   First, is.name and is.symbol - ARE same function (check it!)
# ----------------------------------------------------------------
is.name
# function (x)  .Primitive("is.symbol")
is.symbol
# function (x)  .Primitive("is.symbol")

# ----------------------------------------------------------------
# USE is.name in this file
# ----------------------------------------------------------------

# ------------------------------------
# is.name is NOT what I think it is. | Study carefully ... this is key
# ------------------------------------
x <- "hello"
is.name(x) # [1] FALSE
is.character(x) # [1] TRUE

#  Compare to this:
y <- as.name("hello")
is.name(y) # [1] TRUE
is.character(y) # [1] FALSE

print(x)
# [1] "hello"

print(y)
# hello

# --------------------------------------------------------------------
# Not positive, but is.name refers to object that useful as language
# --------------------------------------------------------------------
identical(x, y)
# [1] FALSE

library(rlang)
x=2

paste0("AVAL.", x)
sym(paste0("AVAL.", x))


# evaluate sym("cyl") in context or environ of mtcars
?sym
eval(sym("cyl"), mtcars)
eval(as.name("cyl"), mtcars) # base R
eval(expr= as.name("cyl"), envir= mtcars) # base R


# thinks "cyl" is just a string
eval("cyl", mtcars)

