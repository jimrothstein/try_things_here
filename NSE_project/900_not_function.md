# not function


Operator Precedence came up in today’s discussion of this code from
Advanced R 18.4.1 <a
href="https://adv-r.hadley.nz/expressions.html?q=%in%#operator-precedence"
class="uri">https://adv-r.hadley.nz/expressions.html?q=%in%#operator-precedence</a>

``` r
knitr::opts_chunk$set(echo = TRUE,  
                      comment="      ##", 
                      collapse=TRUE)

lobstr::ast(!x %in% y)
```

    █─`!` 
    └─█─`%in%` 
      ├─x 
      └─y 

The reason this works, if I followed the discussion correctly, is due to
“operator precedence”, %in% is evaluated before !

SEE <https://rdrr.io/r/base/Syntax.html>

I want to suggest another way to see this.

`!` is a function and, of course, functions take arguments, in this case
exactly one argument. **If you mentally parse functions as lists, the
function is first, followed by arguments.** lobstr::ast shows this.

If you remember `!` is a function, then it’s argument must be what
remains: x %in% y.

# Background !not function

``` r
library(lobstr)

## usage examples
x = TRUE
!x
      ## [1] FALSE
! x    # spacing not important
      ## [1] FALSE

`!` (x)
      ## [1] FALSE
`!`(x)
      ## [1] FALSE

## class
`!` |> class()   # function
      ## [1] "function"

## structure
lobstr::ast(!x)
      ## █─`!` 
      ## └─x

## source code
`!`
      ## function (x)  .Primitive("!")

#error
# `!` x
 
```

``` r

## first argument, as string
## 2nd arugment as expression (otherwise, call will try to evaluate this argument)
call("!", quote(x %in% y))
      ## !x %in% y

call("`!`", quote(x %in% y))
      ## `\`!\``(x %in% y)
call("`!`", "x %in% y")
      ## `\`!\``("x %in% y")


rlang::call2(`!`, quote(x))
      ## .Primitive("!")(x)
```

``` r
lobstr::ast(! x)
      ## █─`!` 
      ## └─x
```
