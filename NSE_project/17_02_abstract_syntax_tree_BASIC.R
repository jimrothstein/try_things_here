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
)##### parse
ast(q1)  # appears as q1


ast - more advanced, lobstr, lobstr + injection  EXPAIN!

```r
## Compare
x = quote(a + b + c) # call

q1 = lobstr::ast(x)   
q1  # looks like just x 

typeof(q1) # character    ??
typeof(x)  # language 

str(q1)  # 'lobstr_raw' chr  followed by terminal codes (will mess up printing) 
str(x)  # language a + b + c

lobstr::ast(!!q1)  # structure of terminal codes; class = "lobstr_raw"
lobstr::ast(!!x)   # ast diagram of x




q2=parse(text=q1) # expression(+ a b)
parse(text=quote(a+b)) # expression(+ a b) (same)



kexpression(+
a, b)
> x3=parse(text="quote(a+b)")
> typeof(x3)
[1] "expression"

cex3 <- c("NULL", "1", "1:1", "1i", "list(1)", "data.frame(x = 1)",
  "pairlist(pi)", "c", "lm", "formals(lm)[[1]]",  "formals(lm)[[2]]",
  "y ~ x","expression((1))[[1]]", "(y ~ x)[[1]]",
  "expression(x <- pi)[[1]][[1]]",
  "quote(2+3)")

cex3

lex3 <- sapply(cex3, function(x) eval(str2lang(x)))             ## list, 15

mex3 <- t(sapply(lex3,
                 function(x) c(typeof(x), storage.mode(x), mode(x), is.language(x))))
mex3
dimnames(mex3) <- list(cex3, c("typeof(.)","storage.mode(.)","mode(.)"))
mex3
```



