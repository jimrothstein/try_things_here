
REF: https://stackoverflow.com/questions/25235240/r-variable-names-symbols-names-or-something-else/25235365#25235365


##  R allows string or symbol
```{r}
# clear globalenv
rm(list = ls())
```

####    Symbol, aka name
```{r}
q2  <- quote(x)                        # even though x DNE 
is.symbol(q2)       #T
```
# ----------------------------------------------------------------------
####    Symbol represents value or stored object (Hadley, tidyr cheat)
# ----------------------------------------------------------------------

# -------------------------
Constants, even variables are not symbols
# -------------------------
```{r}
is.symbol("hello") # [1] FALSE
is.symbol(x=5) # [1] FALSE
z=10
is.symbol(z) # [1] FALSE

# not
is.symbol(pi) # [1] FALSE
is.symbol(expression(pi)) # [1] FALSE


# ---------------------
##  What is a symbol?
##  not appear in most regular code?
# ---------------------
#
is.symbol(expr(pi)) # [1] TRUE
is.symbol(expr(x)) # [1] TRUE
is.symbol(expr(2)) # [1] FALSE
is.symbol(expr(x + y)) # [1] FALSE
is.symbol(+)  # errro
is.symbol(`+`) # [1] FALSE

# not a function
f = function() 3
sapply(list(`+`, sin, `[`, f), is.symbol) # [1] FALSE FALSE FALSE FALSE

#### Coerce to symbol, or name
##  By itself, x is variable, not symbol, not name
x  <- 4

# appears a little different
z = as.symbol(x); z
is.symbol(z) # [1] TRUE
# `4`


w = as.symbol(x)
is.symbol(w) # [1] TRUE
w # `4`

identical(z,w) # [1] TRUE
```

#### What is `4`
```{r}
typeof(as.name(x))
typeof(`4`)       # not found
is.object(`4`)
typeof(`4`)
is.symbol(`4`)
```

#### convert to symbol name
```{r}
ls()
y = as.name(x)
y

is.object(y)
typeof(y)
is.symbol(y)
is.name(y)

names(y)
attributes(y)
```

```{r}

## for variable, use as.name
is.symbol(as.name(x))
is.symbol(as.name(x))
is.symbol(quote(x))
identical(as.name(x), quote(x))

eval(y)
eval(`4`)
```



####    cast to vector of type symbol
```{r}
z = as.vector(x, "symbol")
z
is.symbol(z)
is.name(z)
typeof(z)
```

####    Not symbol
```{r not_symbol}
is.symbol(4)

## ??
is.symbol(as.name(4))
z  <- as.name(4)

## weird
is.symbol(z)



##  for function, use quote
f  <- function() {}
is.symbol(quote(f))

is.symbol(f)
## error
if (F) is.symbol(as.name(f))
```

<just added:    5 MAY>
### What is Symbol?

 *  Lisp calls it symbol
 *  S calls it name
 *  Symbols refer to R objects. The name of any R object is usually a symbol. Symbols can be created through the functions as.name and quote. They naturally appear as atoms of parsed expressions, try e.g. as.list(quote(x y)).   Ref: R Language 2.1.3.1


#### Create with as.symbol
```{r symbol}
## x is a double
x  <- 5

## turn x into a symbol 
    s  <- as.symbol(x)
    is.symbol(s)
    typeof(s)
    storage.mode(s)
    mode(s)

    if (F) eval(s) #error
```
```{r parse}
p  <- parse(text = "{
## x is a double
x  <- 5

## turn x into a symbol 
    s  <- as.symbol(x)
    is.symbol(s)
    typeof(s)
    storage.mode(s)
    mode(s)

    if (F) eval(s) #error
}"
)
```
####    functions ???
```{r function}
f  <- function() {}

is.symbol(f)
# [1] FALSE

q  <- quote(f)
is.symbol(q)
# [1] TRUE

### FAIL
name  <- as.name(f)
s  <- as.symbol(f)

```


#### Create with as.name 
```{r name}
y  <- 5
name  <- as.name(y)
name
# `5`
is.symbol(name)
# [1] TRUE
storage.mode(name)
typeof(name)
eval(name)  #error
```

#### Create using quote 
```{r quote}
z  <- 5
name  <- quote(z)
# z
typeof(name)
# [1] "symbol"

eval(name)
# [1] 5
```
#### Future shortcut
```{r shortcut}
y  <- 5
name  <- as.name(y)

sapply(list(is.symbol, 
            typeof, 
            mode, 
            storage.mode), 
       do.call, list(quote(name)))

# [1] "TRUE"   "symbol" "name"   "symbol"
```



