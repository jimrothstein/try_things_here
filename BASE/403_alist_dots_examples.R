# 0403_alist_dots_examples.R

# --------------------
#   list - evaluates
#   alist - does not evaluate
### alist, like list but does NOT evaluate arguments
# --------------------

a = 2
b = 3

list(x=a) # $x [1] 2
list(y)   # error , y not found

alist(x=a) # $x a
alist(y) # [[1]] y

rm(x)
list(x=2, y=x^2)                       # error x not found 
alist(x = 2, y = x^2)
# $x
# [1] 2
# 
# $y
# x^2


# ---------------------
# and if x is defined, compare list v alist
# ---------------------
x  <- 2
list(x, y=x^2)
# [[1]]
# [1] 2
# 
# $y
# [1] 4
alist(x, y=x^2)
# [[1]]
# x
# 
# $y

# -------------------------------
# lobstr::ast on list vs alist 
# -------------------------------
x=9  # no effect, ast prevents any eval
lobstr::ast(list(x, y=x^2))
lobstr::ast(alist(x, y=x^2))



# BEGIN HERE


## returns `...` 
  g  <- function(x, y, ... ) {
    dots  <- alist(...)
  }
  (r  <- g(x = 1, y = 2,z=3))

## returns what user submitted
  g.1  <- function(x, y, ...) {
    dots  <- substitute(alist(...))
  }

  (r  <- g.1(x = 1, y = 2, z = 3))


## returns what user submitted, evaluated
g.2  <- function(x, y, ...) {
    dots  <- eval(substitute(alist(...)))
  }
  (r  <- g.2(x = 1, y = 2, z = 3)

### dots `...`
```{r dots}
f  <- function(x, y, ...) {
  dots  <- eval(substitute(alist(...)))
  named  <- names(dots)
}

(f(x=3, y=3, z=1))

f  <- function(...) {
  alist(...)
}


s  <- f(x=3)
s



### print line numbers (pdf only?)
if (TRUE) {
  x <- 1:10
  x + 1
}


# REF  style.tidyverse.org

# args MUST line up
sample_function(
                a = xxxx,
                b = xxxx,
                c = xxxx
                )

# OR
verylongfunctions_indent_like_this(
  a = xxxx,
  b = xxx,
  )


