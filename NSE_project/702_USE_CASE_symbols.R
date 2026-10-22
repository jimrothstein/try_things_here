702_USE_CASE_symbols.R

##  PURPOSE:  June Choe explains benefits of symbols: tidy_select vs tidy_
library(tidyverse)

# ----------------------
# Convert to  a symbol
# ----------------------
#   Note: return is symbol, NOT vector
#	  ensym demands return is simple symbol
#	  ?rlang::ensym
# ---------------
g  <- function(df, string_or_symbol) {
  symbol  <- rlang::ensym(string_or_symbol) #  
  symbol
  }
g(mtcars, hp) # hp    
g(mtcars, "hp") # hp
identical(g(mtcars, hp), g(mtcars, "hp")) # [1] TRUE

# ALSO, [[ wants a SYMBOL
identical(mtcars[["hp"]], mtcars[[sym("hp")]] ) # [1] TRUE

# ---------------
##  Pass df and specific col to function
# ---------------
f <- function(df, string_or_symbol) {
  # Resolve column input to symbol immediately
  symbol <- rlang::ensym(string_or_symbol)
  # Then, the data wrangling logic
  df %>% 
    head() %>% 
    dplyr::select(tidyselect::all_of(symbol)) %>% # `all_of()` for tidyselect
    mutate(x = .data[[symbol]] * 10) # `.data[[` for tidyeval
}

# ------
# WORKS
# ------
f(mtcars, hp)
f(mtcars, "hp")

df=mtcars
f(df, "hp")
f(df, hp)
f(df, !!var)

# ----------
## BUT NOT
# ----------
var = "hp"
f(df, var)





# From top-level, column can be specified as string or symbol
identical(
  f(mtcars, hp),
  f(mtcars, "hp")
)
#> [1] TRUE

# ------------------
##  WHEN to USE !!
# ------------------
f <- function(x) {
  rlang::ensym(x)
}
f("mycol")
#> mycol
f(mycol)
#> mycol

# Uh oh
map(c("my_col"), \(x) f(x))
#> [[1]]
#> x
# Works with `!!` - yay!
map(c("my_col"), \(x) f(!!x))
#> [[1]]
#> my_col

# ---------------------------------
##  plain vanilla extract by NAME (name or symbol)
# ---------------------------------
x = letters[1:5]
names(x)   <- LETTERS[1:5]
x
x[["A"]]   # "a"
x[[sym("A")]]
y = "A"	                            
x[[sym(y)]]
x[[y]]



# sym, {{}} 
# NEXT:  Suppose we do not know in advance what the criteria will be

# Pass column to filter, but which column is unknown till run-time

# filter based on column `birth_year == 19`
dplyr::filter(starwars, birth_year == 19)


s = rlang::sym("birth_year")

dplyr::filter(starwars, !!s == 19)
dplyr::filter(starwars, !!s > 19)

# {{}} notation
dplyr::filter(starwars, {{s}} > 19)

