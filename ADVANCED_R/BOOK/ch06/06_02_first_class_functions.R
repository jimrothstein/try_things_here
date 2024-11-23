# 06_02_first_class_functions.R


# --------------------------------------------
#  functions do NOT need to be bound to name
# 		Example: anonymous functions
# --------------------------------------------

# anonymous functions
lapply(mtcars, function(x) length(unique(x)))
lapply(mtcars, \(x) length(unique(x)))

Filter(function(x) !is.numeric(x), mtcars)
integrate(function(x) sin(x)^2, 0, pi)
