010_environment_definitions_CHEAT_examples.R

### Environment consists of 
  - frame:  set of named objects (is frame a `bag`? list?)
  - pointer:  to enclosing frame.


Visually, environemnts appear tree-like
TODO:  insert latex


<e> notation for environment

Scope: Rules R uses to find objects by name
  - R first looks in runtime <e>
  - Then to parent.env()

### env is `container` that can hold objects, in a list-like structure
```{r env}
# e represents current environment

e  <- environment()
ls(e)
is.list(e) # F

```
```{r add}
x  <- 4
ls(e)
e$x

```

### env have hierarchy (varies based on attached packages)
```{r}
search()
parent.env(e)
e.1  <- parent.env(e)
e.1


e.2  <- parent.env(e.1)
e.2
```


Two environment equal if:
```{r identical}
e  <- environment()
f   <- environment()
identical(e, f)
```

Special Environments
```{r special}
emptyenv()
baseenv()
globalenv()
identical(e, globalenv())

```

See objects in Environment
```{r ls}
ls(envir = environment())
ls(envir = emptyenv())
head(ls(envir = baseenv()), n = 10L)
ls(envir = parent.env(environment() ))
```

### Hierarchy extends below:
###  To see that active function has its own environment:
```{r function_env}

g  <- function() {
  # identify current, active environemnt
  e  <- environment()
}

e  <- g()
e
environment()
parent.env(e)
current.env()
```
### Practice Examples
```{r}
f  <- function() { print(x) }

environment(f)
identical(globalenv(), environment(f))  # T

# What this means is that if f is looking for an object, it can look find it
is environment for it.
f()

```



```






