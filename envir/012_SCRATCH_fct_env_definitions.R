
## Concise, basic Definitions Related to R **Functions & Environments:**
(1 page?)

* pairlist:  R structure functionally similar to *lists* but key difference, lists have
  clear length(), pairlist only know next node so transversing may be slow.
  (Pairlists mostly used internally, concerned very efficient)

* function:  Some **properties?** 
    formals(f)  - returns pairlist of arg and initial value, if any.
    body(f)     - code  
    environment(f) - where f 1st looks for variables, etc
To find what "user" actually sent to function, use rlang::enexprs(), inside f.

* Environment

  * frame - set of named objects (or is it symbols and BINDINGS to the object?)
  * pointer - parent 

  from Peng 2019, 
  https://bookdown.org/rdpeng/rprogdatascience/scoping-rules-of-r.html

  " An environment is a collection of (symbol, value) pairs, i.e. x is a symbol
  and 3.14 might be its value. Every environment has a parent environment and
  it is possible for an environment to have multiple “children”. The only
  environment without a parent is the empty environment.  "

* Global Environment

```{r global}
ls()
objects()
```

### basic:  change FUN environment
```{r simple_change}
x  <- "hello"
f  <- function() x
f()  # "hello"

# create practice env, e
e  <- new.env()
e$x  <- "bye"

# change f's environment
environment(f)  <- e
f()  # "bye"


environment(f)  <- globalenv()
f()  # "hello"

#  NOTE: Can not change f environment this way: WRONG, all give errors
# f(env = )
# f(envir =)
```

### change FUN environment, programmatically:
```{r 0001  }
x  <- "hello"
f  <- function() x
f()  #hello

# change
g  <- function(.f, .e = globalenv() ) {
    environment(.f)  <- .e
    .f()
}
g(f)  # returns "hello"


# create practice env, e
e  <- new.env()
e$x  <- "bye"

environment(f)  <- e
f()
g(f,.e=e) # "bye" 
g(f, .e = globalenv()) # "hello"

if (FALSE ) g(f, .e = baseenv())   # Error:  no `x` in baseenv

```

* Hierachcy of Environments
```{r heirarchy}
  search()
```

* Calling Environment (aka parent.frame())
```{r calling}
x  <- 2
y  <- 3
f  <- function() {
  x  <- 20
  y  <- 30
  g(x,y)
}

g  <- function(x,y) {x + y}

# g carries it's calling env with it  and this differs!
g(x,y)  # 5
f()     # 50
```

carries it's env around, here:  explicitly!
```{r }
x  <- 2
y  <- 3

  f  <- function(x,y, env = environment()){
    x  <- env$x
    y  <- env$y
    x + y
  }
f(x,y)

e  <- env()
e$x  <- 200
e$y  <- 300
f(x,y, e)


```

Guess the env
try env_X  as notation
```{r guess}
f  <- function() {
        function() { x }
      }

x  <- 2
g  <- f()   # g is a closure
typeof(g)
g()

# study
formals(g)
body(g)
G  <- environment(g)   # returns an environment
parent.env(G)


# WATCH This!
J  <- new.env()
J$x  <- 20
environment(g)  <- J
g()
ls(envir  = J)
objects(J)
```

AAA Example:   objects in calling env() (or parent.frame())
https://stackoverflow.com/questions/28641395/what-is-parent-frame-of-r
```{r}


# objects in parent.frame (calling env)
parentls <- function() {
  ls(envir = parent.frame())
}

a<-function() {
    x <- 5
    parentls()
}

b <- function() {
    z <- 10
    parentls()
 }

a() # objects in a's environment
b()
parentls()
```

AAA How many levels down ?  0=GlobalEnv
```{r nframe}
parentls <- function() {
  cat("nframe = ", sys.nframe() , "\n")
}


a  <- function() {
  cat("nframe = ", sys.nframe() , "\n")
  b()
}

b   <- function(){ 
  cat("nframe = ", sys.nframe() , "\n")
  c()
}

c  <- function(){ 
  cat("nframe = ", sys.nframe() , "\n")
}


cat("nframe = ", sys.nframe() , "\n")
a() # objects in a's environment
```
recursive!
sys.nframe()
```{r loop}
a  <- function() {
  if (sys.nframe() == 9) return()
  cat("nframe = ", sys.nframe() , "\n")
  a()
}
a()
```



Should give 200, it does NOT ???
```{r}
f  <- function() {
        function(envir = ENV_X) { x}
      }

ENV_X   <- environment()
x  <- 2
g  <- f()   # g is a closure
typeof(g)
g()

ENV_J   <- new.env()
ENV_J$x   <- 200

ENV_X   <- ENV_J
ENV_X$x

g  <- f()
g()

```

This works, why not above??
```{r}
f  <- function() {
        function() { x}
      }

ENV_J   <- new.env()
ENV_J$x   <- 200


x <- 2

g  <- f()
environment(g)  <- ENV_J
g()

```

STUDY !
```{r simple_env}
x  <- 2
f  <- function(env = NULL ) {x}
f(env = environment())

f()
f(env = ENV_J)  # why 2??
ENV_J$x   #200

parent.env(ENV_J)   # calling env

```

Another version
```{r}
x  <- 2
current_env  <- parent.frame()  # this is current env (despite name)
f  <- function(env = NULL ) { 
  environment()  <- env
  x
}
f (env = environment())

```



* Enclosing Environment

* Executing Environment

* Parent Environment


* Dis efining Environment
  Peng: 
  Typically, you work in  Global Env, where x = is defined and likewise
  function are defined.

```{r defining_env}
# typical just the Global environemtn:basename
x  <-  5
f  <- function() {
  y  <- 2
  x
}
f()

# and check f's defining evn
environment(f)
ls(environment(f))
get("x", environment(f))
get("x", environment(f))
```
  R adds a twist:   Inside a function, you can define another function, so its
  defining environment is NOT Global, but the enviornmnt of the function.

```{r example_defining}
  f  <- function() {
    function() {
      cat("hi from inner \n")
    }
  }

g  <- f()
typeof(g)
g()
```

* Scope
* Closure
  from Peng:

  "The function closure model can be used to create functions that “carry"
  around data with them."


* Permant vs Temporal Environments




