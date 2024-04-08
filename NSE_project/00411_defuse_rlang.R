
	 vim:linebreak:nowrap:nospell:cul tw=78 fo=tqlnr foldcolumn=3 
	 
--- 
# Spaces, no Tabs
title: Template for .Rmd 
date: "`r paste('last updated', 
    format(lubridate::now(), '%H:%M, %d %B %Y'))`"
output: 
  pdf_document: 
    latex_engine: xelatex
toc: TRUE 
toc_depth:  1 
fontsize: 12pt 
geometry: margin=0.5in,top=0.25in 
---

(Ref defuse)[https://rlang.r-lib.org/reference/nse-defuse.html]

For introduction:   see 400_quasi_
REF:   See Rlang Cheatsheet
REF:   Advr v2  Chaptr 17+


```{r setup, include=FALSE		}
knitr::opts_chunk$set(echo = TRUE,  
											comment="      ##",  
											error=TRUE, 
											collapse=TRUE) 
```

<!--  RENDER:  see bottom -->

```{r library, include=FALSE		}
``` 

#### Not working
```{r simplest}

mtcars
mean(mtcars$mpg)
# [1] 20.1

#  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
# [11] "carb"

mean_col  <- function(db, col=substitute(col)){
    print(db$col)
}
mean_col(mtcars, mpg)

```
(Ref defuse)[https://rlang.r-lib.org/reference/nse-defuse.html]
see EXAMPLE
```{r example}
# expr() and exprs() capture expressions that you supply:
# enexpr() and enexprs() capture expressions that your user supplied:
expr_inputs <- function(arg, ...) {
  user_exprs <- enexprs(arg, ...)
  user_exprs
}
expr_inputs(hello)
#> [[1]]
#> hello
#> expr_inputs(hello, bonjour, ciao)
#> [[1]]
#> hello
#> 
#> [[2]]
#> bonjour
#> 
#> [[3]]
#> ciao
#> 
# ensym() and ensyms() provide additional type checking to ensure
# the user calling your function has supplied bare object names:
sym_inputs <- function(...) {
  user_symbols <- ensyms(...)
  user_symbols
}
sym_inputs(hello, "bonjour")
#> [[1]]
#> hello
#> 
#> [[2]]
#> bonjour
#> ## sym_inputs(say(hello))  # Error: Must supply symbols or strings
expr_inputs(say(hello))
#> [[1]]
#> say(hello)
#> 

# All these quoting functions have quasiquotation support. This
# means that you can unquote (evaluate and inline) part of the
# captured expression:
what <- sym("bonjour")
expr(say(what))
#> say(what)expr(say(!!what))
#> say(bonjour)
# This also applies to expressions supplied by the user. This is
# like an escape hatch that allows control over the captured
# expression:
expr_inputs(say(!!what), !!what)
#> [[1]]
#> say(bonjour)
#> 
#> [[2]]
#> bonjour
#> 

# Finally, you can capture expressions as quosures. A quosure is an
# object that contains both the expression and its environment:
quo <- quo(letters)
quo
#> <quosure>
#> expr: ^letters
#> env:  0x7f884479e828
get_expr(quo)
#> lettersget_env(quo)
#> <environment: 0x7f884479e828>
# Quosures can be evaluated with eval_tidy():
eval_tidy(quo)
#>  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
#> [20] "t" "u" "v" "w" "x" "y" "z"
# They have the nice property that you can pass them around from
# context to context (that is, from function to function) and they
# still evaluate in their original environment:
multiply_expr_by_10 <- function(expr) {
  # We capture the user expression and its environment:
  expr <- enquo(expr)

  # Then create an object that only exists in this function:
  local_ten <- 10

  # Now let's create a multiplication expression that (a) inlines
  # the user expression as LHS (still wrapped in its quosure) and
  # (b) refers to the local object in the RHS:
  quo(!!expr * local_ten)
}
quo <- multiply_expr_by_10(2 + 3)

# The local parts of the quosure are printed in colour if your
# terminal is capable of displaying colours:
quo
#> <quosure>
#> expr: ^(^2 + 3) * local_ten
#> env:  0x7f8844ad1950
# All the quosures in the expression evaluate in their original
# context. The local objects are looked up properly and we get the
# expected result:
eval_tidy(quo)
#> [1] 50
```
