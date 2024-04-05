#   17_02_abstract_syntax_tree_BASIC.R

# ---------------------------------------------------
##    PURPOSE:   simplest examples of lobstr::ast()
# ---------------------------------------------------

library(rlang)
library(lobstr)


# -----------
# DRAW TREE
# -----------

lobstr::ast(f(x, "y", 1))   # knitr complains about character
# █─f 
# ├─x 
# ├─"y" 
# └─1 

lobstr::ast(
    f(g(1, 2), h(3, 4, i()))
)


lobstr::ast(
    f(g(h(2)))
)

# -------------------------------------------------
## lobstr::ast does no subsitution, no evaluation
# -------------------------------------------------

lobstr::ast(1+2)
# █─`+` 
# ├─1 
# └─2 

x=3
lobstr::ast(1+x)
# █─`+` 
# ├─1 
# └─x 

# ----------------------------------
##  Build tree from smaller pieces
# ----------------------------------
# Example 1:   build ratio of 2 quantities:

# first, capture, defuse, quote (all the same)
xx <- expr(x + x)
yy <- expr(y + y)
Q  <- expr(!!xx/!!yy); Q

identical(lobstr::ast(!!Q), lobstr::ast(!!xx/!!yy))
# [1] TRUE

# █─`/` 
# ├─█─`+` 
# │ ├─x 
# │ └─x 
# └─█─`+` 
#   ├─y 
#   └─y 

# NOTE: create expression that represents xx/yy
lobstr::ast(xx/yy)
# █─`/` 
# ├─xx 
# └─yy 


# ------------------------------
# NOTE:   !!A is not recursive
# ------------------------------
A  <- expr(xx/yy); A
lobstr::ast(!!A)  ## does not ALSO expand xx, yy

# ----------------------------------------------------
# deparse?   haha structure of ast's visual output !
# ----------------------------------------------------
deparse(lobstr::ast(!!xx/!!yy))

# EXAMPLE:   longer example calculation
zz  <- expr(z*z)
qq  <- expr(sin)

# build an expression actually call?
Q = expr(!!xx + !!yy + !!zz/!!qq); Q

# display (identical)
lobstr::ast(!!Q)
lobstr::ast(!!xx + !!yy + !!zz/!!qq)
# █─`+` 
# ├─█─`+` 
# │ ├─█─`+` 
# │ │ ├─x 
# │ │ └─x 
# │ └─█─`+` 
# │   ├─y 
# │   └─y 
# └─█─`/` 
#   ├─█─`*` 
#   │ ├─z 
#   │ └─z 
#   └─sin 





## BUILD
z= expr(!!xx / !!yy); z
#> (x + x)/(y + y)

lobstr::ast(expr(!!z))
```

##  no eval till !! 
z= 2
lobstr::ast(f(z))
lobstr::ast(f(z = 3))

lobstr::ast(f(!!z))   # evaluates !

## why not evaluate?
lobstr::ast(
  f(eval(z)) # does not evaluate !
)


