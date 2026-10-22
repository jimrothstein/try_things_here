# simple functional

### Purpose:   Write a simple functional FUN(x, .f), where .f is a function, FUN returns a vector

# nice way to run many checks on `x`
FUN = function(x, .f) .f(x)

FUN(1, \(x) x>10)
FUN(1, is.na)
FUN(1,  is.integer)

# example with pre-made function
.f = function(x) sin(x)
FUN(pi/2, .f)

FUN(pi/2, sin)
