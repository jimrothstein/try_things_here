##  file <- "340_missing_getArg_
##  Turn off Diagnostics in Global | Code | Diagnositcs

# suppose
f = function(x,y) {
  if (missing(y)) print("y has no value ")
}

g = function(x,y, ...) {
  if (missing(y)) print("y has no value ")
}

## f, g same EXCEPT for
f(x=1, y=2, z=3)  # R sees unused argument, throws error


#
g(x=1, y=2, z=3) # R allows
