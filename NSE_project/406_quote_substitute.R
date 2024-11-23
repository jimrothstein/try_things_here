##    406_quote_substitute.R
#   TAGS:  quote, substitute 

Extremely useful !so
https://stackoverflow.com/questions/46834655/whats-the-difference-between-substitute-and-quote-in-r

# ---------------------------------
##    1) Explain quote vs substitute
# ---------------------------------
## quote:      suppresses evaluation of argX
## substitute(argX):     substitutes symbol (user provided), no evaluation
## argX:                 evalutes !

f <- function(argX) {
   list(quote(argX),          # is.symbol = T  ??
        substitute(argX),     # is.symbol is TRUE
        argX)
}
    
suppliedArgX <- 100
z=f(argX = suppliedArgX); dput(z)

# list(argX, suppliedArgX, 100)

# ------------------------------------
## STOP, be sure to understand above
## Why is 1st argX not 100?
# ------------------------------------


suppliedArgX  <- "hello"
f(argX = suppliedArgX)




