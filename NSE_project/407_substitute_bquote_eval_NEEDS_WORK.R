## 407_substitute_bquote_eval_NEEDS_WORK.R

##  TODO:
##  -  What is useful?   EXTRACT pieces and move to appropriate files.
##  -  substitute, inside AND outside function, bquote, eval, ....

# ---------------------------------------
####    substitute(expr, envir or list)
# ---------------------------------------
        substitute does NOT evaluae any arguments


####   Create expression, using expression
{r simple}

    x <- 1
    y <- 2
    a <- expression(10 + x + y)
    a
    is.expression(a)
    
    a[[1]]
    eval(a)


####    Substitute and then eval
{r sub}

substitute(x+y, list(x=quote(1), y=quote(2)))
# 1 + 2


eval( substitute(x+y, list(x=quote(1), y=quote(2))))
# [1] 3

ans  <- substitute(x+y, list(x=quote(1), y=quote(z)))
# 1 + z

## why?
eval( substitute(ans, list(z=2)))
# 1 + z

eval(substitute(x+y, list(y=2)))
# [1] 3



{r}

## why
ans  <- quote(x + y + 10)
substitute(ans, list(x=2))
# ans
y  <- NULL
eval(ans)



#### substitute, inside function retrieve value user sent
  *  deparse as quoted; character string 
{r substitute}

# =========================
#deparse, substitute KEEP
# =========================
f  <- function(x)	substitute(x)
g   <-function(x) deparse(substitute(x)) 

f(unknown) # returns unquoted
# unknown
g(unknown) # returns in quotes, as char[1]
# [1] "unknown"


                      
f(a + b + c)
g(a + b + c)

# quite differnt
typeof(f(a + b + c))
typeof(g(a + b + c))


#### bquote,  partial evaluation in expression
{r bquote}
##  bquote(expr, where=, slice)
  a =2
  quote(a == a)
  bquote(a == a)

## partial: evaluat .( ) 
  bquote(a == .(a))
  
  substitute(a == A)
  
##    If it is a list, the equivalent of list2env(x, parent = emptyenv()) is returned    
  substitute(expr = a == A, env = list(A = a))
  
##  Check environment  
  z = as.environment(list(A = a))
  z
  ls(envir = z)
  ls.str(envir = z)
  parent.env(z) 
#   >   z
# <environment: 0x55d7743de420>
# >   ls(envir = z)
# [1] "A"
# >   ls.str(envir = z)
# A :  num 2
# >   parent.env(z) 
# <environment: R_EmptyEnv>
 
  substitute(expr = a == A, env = list(A = a))
  



#### Compare sustitute vs bquote
#### !so 63231060, bquote return call with only partial evaluation, not
expression!
{r partial}

## accepted ans (substitute)
    a <- 2
    b <- 1
    y = substitute(expression(b + a),list(b=1))
    # expression(1 + a)

typeof(y)
# [1] "language"


y[[1]]
# expression

is.call(y)
# [1] TRUE

is.expression(y)  # what?
# [1] FALSE

eval(y)
# expression(1 + a)

## another way, nope, not an expression
    a  <- 2
    b  <- 1
    x  <- bquote(.(b) + a)
    # 1 + a

    typeof(x)
    # [1] "language"

    is.pairlist(x)
# [1] FALSE

    x[[1]]
# `+`
    x[[2]]
# [1] 1

    is.call(x)
    # [1] TRUE

    is.expression(x)
    # [1] FALSE

    eval(x)
# [1] 3

    


vim:linebreak:nospell:nowrap:cul tw=78 fo=tqlnrc foldcolumn=1 cc=+1
