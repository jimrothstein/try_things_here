# for package a
# When sourced, aa.R creates 3 functions.
#     c() hides (masks) the base::c()
#     b and a point (bind) to same function

if (FALSE) {
  # clean
  if (exists("a")) rm("a")
  if (exists("b")) rm("b")
  if (exists("c")) rm("c")
}

c <- function() 'Hello from package a!'
a <- function() paste('A+', c())
b <- a

##  NOTES
#   change a()?   then a() changes; but b() continues refers to orginal function

library(pkgA)
aa()
