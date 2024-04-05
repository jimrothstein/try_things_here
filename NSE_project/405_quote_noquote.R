##  405_quote_noquote.R
##  TODO:  noquote is NOT what I think.
##  noquote returns string, without quotes and as type `noquote`
##  nothing more ....
# -------------
####    Quote
# -------------
  x <-6

  quote(x)
  y  <- quote(x); y

  quote(6) # [1] 6
  quote(y) # y
identical(quote(x), y <- quote(x)) # [1] TRUE

# -------------------
#### mutliple quote  expands !
# -------------------
quote(x)
quote(quote(x))
quote(quote(quote(x)))
quote(quote(quote(quote(x))))

# ----------------
## SAME, multiple quote, save as list
# ----------------
z = list(
quote("hello"),
quote(quote("hello")),
quote(quote(quote("hello"))),
quote(quote(quote(quote("hello"))))
)
names(z)  <- LETTERS[1:4]

identical(z$D, z[[4]]) # [1] TRUE


# ------------
#### Noquote - not quite invervse
##  What does noquote return?  object of type `noquote` , strings without quotes
# ------------
noquote("jim") # [1] jim
class(noquote("jim")# [1] "noquote"

identical(noquote(z$A), "hello") # [1] FALSE

identical(z$B, noquote(z$B))
identical(noquote(z$B), z$A)

## What does this reutrn??
noquote(quote(quote("hello")))
typeof(noquote(quote(quote("hello"))))
is.symbol(noquote(quote(quote("hello"))))

quote("hello")   # char vector
identical(noquote(quote(quote("hello"))), quote("hello"))
noquote(noquote(quote(quote("hello"))))

y  <- quote("hello"); y
noquote(y)

identical(noquote(quote("hi")), "hi")
identical(quote(noquote("hi")), "hi")

noquote(quote(hello))
is.symbol(quote(hello)) # [1] TRUE
quote("hello")

noquote(quote("hello"))

eval(quote("hello"))
quote(eval("hello"))





With book open I can follow `quasiquotation`
I was taught functions are mappings between 2 sets
f: A-->B


If f has an inverse, then
f o finv = finv o f = identify function = e


quote("hello")
quote(quote("hello"))
quote("hello") |> noquote()
"hello" |> quote() |> noquote()
"hello" |> quote() |> quote() |> noquote()
"hello" |> quote() |> quote() |> noquote() |> noquote()


eval(quote("hello"))
eval("hello")




# ---------------------------
### quote, eval not inverse
# ---------------------------


quote(2*2) # 2 * 2
eval(quote(2*2)) # [1] 4
quote(eval(2*2)) # eval(2 * 2)
 

{r}

### Are eval() and quote() inverses?
{r}
library(reprex)
reprex({
# ----------------------------------------
# eval() and quote() are NOT inverses
# ----------------------------------------
    z = 2*3

    eval(z)
    quote(z)

    eval(quote(z))
    quote(eval(z))
#
#
# ----------------------------------------
# quote() and noquote() are NOT inverses
# ----------------------------------------
    z = 2*3

    noquote(z)
    quote(z)

    noquote(quote(z))
    quote(noquote(z))
})


### Are noquote() and quote() inverses?
{r}
reprex({
z = 2*3

noquote(z)
quote(z)

eval(quote(z))
quote(eval(z))
})



{r}

eval("hello")

noquote(quote(hello))
noquote("hello")
z = noquote("hello")
noquote(z)



####    Eval is opposite of Quote
{r eval}
eval(y) # [1] 6


##    What does quote return?
{r}
is.expression(quote(1+2))       # F
is.character(quote(1 + 2))      # F


##  Example; Exercise:   how to capture log(2+3)
{r}
x = 2; y = 3
z= x + y

log(z)              # 1.61
quote(log(z))       # log(z)
quote(log(z=x+y))       ## log(z = x + y)


##  To capture a call (function + evaluated arguments)
call("log", list(z)) # log(list(5))
call("log", list(z=x+y)) # log(list(z = 5))




####  Use case:   plot title
{r}
a  <- 2
bquote(a == .(a))           # a == 2
plot(1:10, a*(1:10), main = bquote(a == .(a)))

####  Assignment, at run-time
{r}
##  as an assignment
a = "A"
bquote('=' (.(as.name(a)), 4))
bquote('<-' (.(as.name(a)), 4))

# construct an assignment
x = 1000
bquote('<-' (.(as.name(a)), .(x)))

# eval or run the code!
eval(bquote('<-' (.(as.name(a)), .(x))))
A
# [1] 1000




####  Use case:  partial insert? 
{r}
name = "jim"
bquote(name == .(name))
# name == "jim"

bquote(.(name))


paste0("hi, my name is ", bquote(.(name)))

if (F) print("hi")

# bquote will throw error, but do not understand why ignores `if`

if (F) {
  bquote(value is .(name))
}   # FAILS


bquote('=' (.(as.name(a)), 4))
####  Quote, repeated use adds "layers"
{r properties}
x  <- 6

quote(x)
# x

quote(quote(x))
# quote(x)

##  quote adds "layers"
identical(quote(x), quote(quote(x)))
# [1] FALSE


##  eval each "layer"
eval(quote(x))
# [1] 6

eval(quote(quote(x)))
# x

eval(eval(quote(quote(x))))
# [1] 6



#### Referencial Transparency
{r ref_transparent}

### Rmk:  Lack of referential transparency, is result for x and its value the
### same?
###
x  <- 6
quote(x)
# x

quote(x  <- 6)
# x <- 6

quote(6)
# [1] 6


#### Quote, to form unevaluated expression
{r example3}
## capture unevaluated expression
     z = quote(mtcars |> subset(cyl == 4) |> nrow())

##  to evaluate it
    eval(z)


