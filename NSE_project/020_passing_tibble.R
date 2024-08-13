
## tags:  !!, eval, exprs, pass to function
 
## Function g accepts a tibble and unknown variable y
## Function f creates a tibble, then passes it to g, along with various expression

## y is exprs passed to g;  note difference bet t$hp and !!t$hp in output

g = function(ds=NULL,
             y=NULL) {
  list(nrow(ds), y)
  cat(y$A, "\n")
#  cat(y$B, "\n")  # error
  
  cat(y$C, "\n")

  }
  

f = function(ds) {
  t = tibble(hp = c(1,2)) 

  g(ds = ds, 
    y = exprs(A = 3,
              B= t$hp,
              C= !!t$hp,
              D= eval(t$hp)
              )
                          
                          
    )
}

#  dplyr has data storms
debug(f)
f(storms)
undebug(f)
########################



## Pass tibble to function

## Example 1
## t is variable

f = function(ds) nrow(ds)

# both work
f(mtcars)

t=storms
f(t)


##  Both work
g = function(ds) ds$hp

g(mtcars)

t=mtcars
g(t)


e = new.env()
e$a = 10

a <- expr(2)
b <- expr(3)

expr(a + b)

expr(!!a + b)
bquote(.(a)+b)
# not
expr(bquote(.(a)+b))


# different env
bquote(.(a) + b, where = e)


expr(unquote(a) + b)
expr(eval(a) + b)
expr(deparse(substitute(a)) + b)
eval(a)


bquote(.(a) + b)

?`!!`
?bquote

## from bquote help
a = 2
     bquote(a == a)
     quote(a == a)
     
     bquote(a == .(a))
     substitute(a == A, list(A = a))
     
     
     ## to set a function default arg
     default <- 1
     bquote( function(x, y = .(default)) x+y )
     
     exprs <- expression(x <- 1, y <- 2, x + y)
     bquote(function() {..(exprs)}, splice = TRUE)
     bquote(function() {..(exprs)}, splice = F)  # supresses



## do not understand !!

  inner = function(ds = ds, value) {
    list(
                   is.expression(value),
                   is.expression(value$a),
                   is.expression(value$b)
                   )
   } 


outer = function(ds) {
  t=tibble(x=c(1,2),
           y=c(10,12))

  inner(ds=ds, value =
                 exprs(a=t$x,
                       b=!!t$y)
        )


}

(outer(mtcars))

# works
mtcars |> mutate(diff = hp - disp)

a="hp"
b="disp"

# error
mtcars |> mutate(diff = a - b)

# works
mtcars |> mutate(diff = .data[[a]] - .data[[b]])

# error
mtcars |> mutate(diff = sym(a) - sym(b)) 

# works
mtcars |> mutate(diff = !!sym(a) - !!sym(b)) 

sym(a)  # symbol, hp
eval(sym(a)) # error

# errors
x=expr("hp")
y=expr("disp")

# invalid
!!x

# errors
mtcars |> mutate(diff = !!x -  !!y) 
mtcars |> mutate(diff = !!( x -  y)) 
