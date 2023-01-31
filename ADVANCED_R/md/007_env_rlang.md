
#### My tutorial on functions, env, rlang (~ Ch6 & Ch7)

``` r
from rlang: https://rlang.r-lib.org/reference/search_envs.html
from adv-r v2 Chapter 7
```

**To Render:**\#

``` r
source("./000_useful_functions.R")  
# create child
env <- env(a = 1, b = "foo")
env
```

    ## <environment: 0x684c520>

``` r
env$b
```

    ## [1] "foo"

``` r
env$a
```

    ## [1] 1

``` r
# all objects in current env
ls()
```

    ## [1] "dir"  "env"  "file"

``` r
env_print(env)
```

    ## <environment: 0x684c520>
    ## parent: <environment: 0x61ec6f0>
    ## bindings:
    ##  * a: <dbl>
    ##  * b: <chr>

``` r
# Where am I?   Global_env 
global_env()
```

    ## <environment: R_GlobalEnv>
    ## attr(,"name")
    ## [1] "h_env"

``` r
current_env()
```

    ## <environment: 0x61ec6f0>

``` r
identical(global_env(), current_env())
```

    ## [1] FALSE

What value for x prints?

``` r
# value of x depends upon <env> sent to f
f  <- function(env = global_env()){
    env$x
}

rm(x)
```

    ## Warning in rm(x): object 'x' not found

``` r
x  <- 5
f()
```

    ## [1] 1

``` r
e  <- env(base_env(), x = 500)
f(e)
```

    ## [1] 500

``` r
parent <- child_env(NULL, foo = "foo")
env <- child_env(parent, bar = "bar")
env_has(env, "foo")
```

    ##   foo 
    ## FALSE

#### reference symantecs - how ref work - modify-in-place

\`\`\`{r ref\_sym }\# e &lt;- env(a=1) f &lt;- e g &lt;- e

ref(e) ref(f) ref(g) g$a \#1

change a, ALL show the change
=============================

e*a* &lt; −5*f*a g$a \# no changes ref(e) ref(f) ref(g) \`\`\`\#

\`\`\`{r caller\_env }\# fn &lt;- function() list(current = current\_env(), caller = caller\_env(), parent = env\_parent())

g &lt;- function() fn() g() \`\`\`\#

#### YOU decide the env to evaluate f

\`\`\`{r function\_3\_frames \# x &lt;- 0 f &lt;- function(a) { a + x } f(1) \# create NEW function based on f, with an env with\_env &lt;- function(f, e=env\_parent()){ stopifnot(is.function(f)) \# set environment for f to evaluate in environment(f) &lt;- e f } \# create 2 new environments a &lt;- env(x=10) b &lt;- env(x=20)

wow, you can choose where to evalute!
=====================================

with\_env(f, current\_env())(1) with\_env(f, a)(1) with\_env(f, b)(1) with\_env(f)(1) \# defaults to calling\_env (Global) \`\`\`\#

    enclosing_env# 

`{r enclosing_env} Environment(f) == enclosing env (where created) # env_print() #  # sd()  always :environment(sd) (stats) #  # environment(sd) #namespace::stats #  find("sd")   #  actually making copy # environment(sd)  <- global_env() # environment(sd)  #Global # env_names(current_env() #  find("sd")  rm("sd") #`
=============================================================================================================================================================================================================================================================================================================================

#### parent.frame()

``` r
## TODO   .... use rlang::
## ,fd   source functions!
parent_ls  <- function() {
    env_print(env_parent())
}

where_am_i  <- function(env = caller_env()){
    env_print(env)
    lobstr::cst()
}

where_am_i()
```

    ## <environment: 0x61ec6f0>
    ## parent: <environment: global>
    ## bindings:
    ##  * where_am_i: <fn>
    ##  * parent_ls: <fn>
    ##  * parent: <env>
    ##  * e: <env>
    ##  * x: <dbl>
    ##  * f: <fn>
    ##  * env: <env>
    ##  * file: <chr>
    ##  * dir: <chr>
    ##      █
    ##   1. └─global::ren_github(file, dir)
    ##   2.   ├─rmarkdown::render(...) ./000_useful_functions.R:131:8
    ##   3.   │ └─knitr::knit(knit_input, knit_output, envir = envir, quiet = quiet)
    ##   4.   │   └─knitr:::process_file(text, output)
    ##   5.   │     ├─base::withCallingHandlers(...)
    ##   6.   │     ├─knitr:::process_group(group)
    ##   7.   │     └─knitr:::process_group.block(group)
    ##   8.   │       └─knitr:::call_block(x)
    ##   9.   │         └─knitr:::block_exec(params)
    ##  10.   │           ├─knitr:::in_dir(...)
    ##  11.   │           └─knitr:::evaluate(...)
    ##  12.   │             └─evaluate::evaluate(...)
    ##  13.   │               └─evaluate:::evaluate_call(...)
    ##  14.   │                 ├─evaluate:::timing_fn(...)
    ##  15.   │                 ├─base:::handle(...)
    ##  16.   │                 ├─base::withCallingHandlers(...)
    ##  17.   │                 ├─base::withVisible(eval(expr, envir, enclos))
    ##  18.   │                 └─base::eval(expr, envir, enclos)
    ##  19.   │                   └─base::eval(expr, envir, enclos)
    ##  20.   └─where_am_i()
    ##  21.     └─lobstr::cst()

``` r
parent_ls()
```

    ## <environment: 0x61ec6f0>
    ## parent: <environment: global>
    ## bindings:
    ##  * where_am_i: <fn>
    ##  * parent_ls: <fn>
    ##  * parent: <env>
    ##  * e: <env>
    ##  * x: <dbl>
    ##  * f: <fn>
    ##  * env: <env>
    ##  * file: <chr>
    ##  * dir: <chr>

``` r
# in R, a functions env depends where it was called
# COMPARE: a() to .G variable a 
a <- function(){
    x  <- 5
    #parent_ls()
    where_am_i()
}
a()
```

    ## <environment: 0x45c7e48>
    ## parent: <environment: 0x61ec6f0>
    ## bindings:
    ##  * x: <dbl>
    ##      █
    ##   1. └─global::ren_github(file, dir)
    ##   2.   ├─rmarkdown::render(...) ./000_useful_functions.R:131:8
    ##   3.   │ └─knitr::knit(knit_input, knit_output, envir = envir, quiet = quiet)
    ##   4.   │   └─knitr:::process_file(text, output)
    ##   5.   │     ├─base::withCallingHandlers(...)
    ##   6.   │     ├─knitr:::process_group(group)
    ##   7.   │     └─knitr:::process_group.block(group)
    ##   8.   │       └─knitr:::call_block(x)
    ##   9.   │         └─knitr:::block_exec(params)
    ##  10.   │           ├─knitr:::in_dir(...)
    ##  11.   │           └─knitr:::evaluate(...)
    ##  12.   │             └─evaluate::evaluate(...)
    ##  13.   │               └─evaluate:::evaluate_call(...)
    ##  14.   │                 ├─evaluate:::timing_fn(...)
    ##  15.   │                 ├─base:::handle(...)
    ##  16.   │                 ├─base::withCallingHandlers(...)
    ##  17.   │                 ├─base::withVisible(eval(expr, envir, enclos))
    ##  18.   │                 └─base::eval(expr, envir, enclos)
    ##  19.   │                   └─base::eval(expr, envir, enclos)
    ##  20.   └─a()
    ##  21.     └─where_am_i()
    ##  22.       └─lobstr::cst()

``` r
## begin here -- TODO   

b   <- function() {
    z  <- 10
    parent_ls()
}
# SAME
ls()
```

    ##  [1] "a"          "b"          "dir"       
    ##  [4] "e"          "env"        "f"         
    ##  [7] "file"       "parent"     "parent_ls" 
    ## [10] "where_am_i" "x"

``` r
parent_ls()
```

    ## <environment: 0x61ec6f0>
    ## parent: <environment: global>
    ## bindings:
    ##  * b: <fn>
    ##  * a: <fn>
    ##  * where_am_i: <fn>
    ##  * parent_ls: <fn>
    ##  * parent: <env>
    ##  * e: <env>
    ##  * x: <dbl>
    ##  * f: <fn>
    ##  * env: <env>
    ##  * file: <chr>
    ##  * dir: <chr>

``` r
parent.frame()
```

    ## <environment: 0x635ad00>

``` r
# depends where called
a()
```

    ## <environment: 0x7697478>
    ## parent: <environment: 0x61ec6f0>
    ## bindings:
    ##  * x: <dbl>
    ##      █
    ##   1. └─global::ren_github(file, dir)
    ##   2.   ├─rmarkdown::render(...) ./000_useful_functions.R:131:8
    ##   3.   │ └─knitr::knit(knit_input, knit_output, envir = envir, quiet = quiet)
    ##   4.   │   └─knitr:::process_file(text, output)
    ##   5.   │     ├─base::withCallingHandlers(...)
    ##   6.   │     ├─knitr:::process_group(group)
    ##   7.   │     └─knitr:::process_group.block(group)
    ##   8.   │       └─knitr:::call_block(x)
    ##   9.   │         └─knitr:::block_exec(params)
    ##  10.   │           ├─knitr:::in_dir(...)
    ##  11.   │           └─knitr:::evaluate(...)
    ##  12.   │             └─evaluate::evaluate(...)
    ##  13.   │               └─evaluate:::evaluate_call(...)
    ##  14.   │                 ├─evaluate:::timing_fn(...)
    ##  15.   │                 ├─base:::handle(...)
    ##  16.   │                 ├─base::withCallingHandlers(...)
    ##  17.   │                 ├─base::withVisible(eval(expr, envir, enclos))
    ##  18.   │                 └─base::eval(expr, envir, enclos)
    ##  19.   │                   └─base::eval(expr, envir, enclos)
    ##  20.   └─a()
    ##  21.     └─where_am_i()
    ##  22.       └─lobstr::cst()

``` r
# to see contents of a
a
```

    ## function(){
    ##  x  <- 5
    ##  #parent_ls()
    ##  where_am_i()
    ## }
    ## <environment: 0x61ec6f0>

``` r
b()
```

    ## <environment: 0x61ec6f0>
    ## parent: <environment: global>
    ## bindings:
    ##  * b: <fn>
    ##  * a: <fn>
    ##  * where_am_i: <fn>
    ##  * parent_ls: <fn>
    ##  * parent: <env>
    ##  * e: <env>
    ##  * x: <dbl>
    ##  * f: <fn>
    ##  * env: <env>
    ##  * file: <chr>
    ##  * dir: <chr>

``` r
b
```

    ## function() {
    ##  z  <- 10
    ##  parent_ls()
    ## }
    ## <environment: 0x61ec6f0>

``` r
rlang::env_print()
```

    ## <environment: 0x61ec6f0>
    ## parent: <environment: global>
    ## bindings:
    ##  * b: <fn>
    ##  * a: <fn>
    ##  * where_am_i: <fn>
    ##  * parent_ls: <fn>
    ##  * parent: <env>
    ##  * e: <env>
    ##  * x: <dbl>
    ##  * f: <fn>
    ##  * env: <env>
    ##  * file: <chr>
    ##  * dir: <chr>

``` r
# 
```

::: Review basics, repeat of Examples in rlang Ref :::\#

#### base::search() --&gt; char[](#section),

#### all env names, beginning with lowest, .GlobalEnv

``` r
base::search()
```

    ##  [1] ".GlobalEnv"        "package:purrr"    
    ##  [3] "package:nvimcom"   "package:stats"    
    ##  [5] "package:graphics"  "package:grDevices"
    ##  [7] "package:utils"     "package:datasets" 
    ##  [9] "package:sloop"     "package:here"     
    ## [11] "package:lobstr"    "package:rlang"    
    ## [13] "package:devtools"  "package:usethis"  
    ## [15] "package:reprex"    "package:methods"  
    ## [17] "Autoloads"         "package:base"

#### add package (note: search path increases)

``` r
library(rlang)
```

#### rlang::search\_envs()--&gt; list

#### list of actual env objects on search path

``` r
rlang::search_envs()
```

    ##  [[1]] $ <env: global>
    ##  [[2]] $ <env: package:purrr>
    ##  [[3]] $ <env: package:nvimcom>
    ##  [[4]] $ <env: package:stats>
    ##  [[5]] $ <env: package:graphics>
    ##  [[6]] $ <env: package:grDevices>
    ##  [[7]] $ <env: package:utils>
    ##  [[8]] $ <env: package:datasets>
    ##  [[9]] $ <env: package:sloop>
    ## [[10]] $ <env: package:here>
    ## [[11]] $ <env: package:lobstr>
    ## [[12]] $ <env: package:rlang>
    ## [[13]] $ <env: package:devtools>
    ## [[14]] $ <env: package:usethis>
    ## [[15]] $ <env: package:reprex>
    ## [[16]] $ <env: package:methods>
    ## [[17]] $ <env: Autoloads>
    ## [[18]] $ <env: package:base>

#### first & last env

#### 

``` r
l  <- rlang::search_envs()
# first & last
l[1]
```

    ## [[1]] $ <env: global>

``` r
l[length(l)]
```

    ## [[1]] $ <env: package:base>

#### shortcuts: first & last env obj

``` r
global_env()
```

    ## <environment: R_GlobalEnv>
    ## attr(,"name")
    ## [1] "h_env"

``` r
base_env()
```

    ## <environment: base>

#### rlang::pkg\_env\_name("pkg") --&gt; char[](#section)

#### takes bare pkg name; returns formal: 'package:pkg'

``` r
rlang::pkg_env_name("rlang")
```

    ## [1] "package:rlang"

##### formal name & attributes

##### note: attributes(formal) is NULL?

``` r
formal <-  pkg_env_name("rlang")
search_env(formal)
```

    ## <environment: package:rlang>
    ## attr(,"name")
    ## [1] "package:rlang"
    ## attr(,"path")
    ## [1] "/home/jim/R/x86_64-pc-linux-gnu-library/3.6/rlang"

#### problems with pkg\_env\_name("rlang")

#### Should Return ERROR, not F?

#### arg must be 'search name' or 'package environment'

``` r
# note is attched ? F, T, T
rlang::is_attached("rlang") 
rlang::is_attached("package::rlang")
rlang::is_attached("formal")

# arg should be 'bare package name'
# why Errors?
pkg_env(formal) #why error?
pkg_env(formal[[1]]) #why error?

# devtools::is.package()
is.package("rlang") # F
is.package("package::rlang") # F
is.package(formal) #F
is.package("tidyverse") #F

rlang::pkg_env("base")
```

#### function's env depends upon ????? ToDo

``` r
parent_ls  <- function() {
    ls (parent.frame())
}

# in R, a function's env depends where it was called
# here: env of parent_ls() is inside function a
a <- function(){
    x  <- 5
    parent_ls()
}

b   <- function() {
    z  <- 10
    parent_ls()
}
# SAME
ls()
parent_ls()
parent.frame()

# depends where called
a()
# to see contents of a
a

b()
b

rlang::env_print()
```

7.2.3 - create env(), env\_parents()\# Note: use of last= and subsetting the returned list

``` r
e1  <- rlang::env(a=1)
rlang::is_environment(e1)
```

    ## [1] TRUE

``` r
env_parent(e1)
```

    ## <environment: 0x61ec6f0>

``` r
env_parent(e1, n=2)
```

    ## <environment: R_GlobalEnv>
    ## attr(,"name")
    ## [1] "h_env"

``` r
env_parent(e1, n=3)
```

    ## <environment: package:purrr>
    ## attr(,"name")
    ## [1] "package:purrr"
    ## attr(,"path")
    ## [1] "/home/jim/R/x86_64-pc-linux-gnu-library/3.6/purrr"

``` r
N  <- length(env_parents(e1, last=empty_env()))
N
```

    ## [1] 20

``` r
# subset!
env_parents(e1, last=empty_env())[c(1,3,N-2,N-1,N)]
```

    ## [[1]]   <env: 0x61ec6f0>
    ## [[2]] $ <env: package:purrr>
    ## [[3]] $ <env: Autoloads>
    ## [[4]] $ <env: package:base>
    ## [[5]] $ <env: empty>

``` r
env_tail(e1, last=empty_env())
```

    ## <environment: base>

``` r
# follow book, STUDY ... we can create env from any(?) parent?
e2c  <- env(empty_env(), d=4, e=5)
e2d  <- env(e2c, a=1,b=2, c=3)
env_parents(e2d)
```

    ## [[1]]   <env: 0x675b248>
    ## [[2]] $ <env: empty>

``` r
env_parents(e2c)
```

    ## [[1]] $ <env: empty>

``` r
N <- length(env_parents(e2d,last=empty_env()))
N
```

    ## [1] 2

``` r
# env can point to itsefl! 
e  <- env()
env_names(current_env())
```

    ##  [1] "e2d"        "e2c"        "N"         
    ##  [4] "e1"         "formal"     "l"         
    ##  [7] "b"          "a"          "where_am_i"
    ## [10] "parent_ls"  "parent"     "e"         
    ## [13] "x"          "f"          "env"       
    ## [16] "file"       "dir"

``` r
env_names(e)
```

    ## character(0)

``` r
e$self  <- e
env_names(e)
```

    ## [1] "self"

``` r
ref(e)
```

    ## █ [1:0x60faed8] <env> 
    ## └─self = [1:0x60faed8]

#### 7.2.4 &lt;&lt;- SUPER

``` r
# What is value of x AFTER f01() is run?
x <- 0
f01 <- function() {
  x <<- 1
}
f01()
x   # 1, not 0
```

    ## [1] 1

``` r
# 2nd verson, NO Promise, where is x found?
x <- 0
f02  <- function() {
    cat(env_has(env=env_parent(),"x"),"\n", fill=TRUE     , labels = c("1", "2", "3"))
    cat(env_has(env=fn_env(f02), "x"),"\n")
    cat(env_has(env=current_env(),"x"),"\n")
}
f02()
```

    ## 1 TRUE 
    ## 
    ## TRUE 
    ## FALSE

``` r
x
```

    ## [1] 0

``` r
## What is value for x, AFTER f03 is run?
## Run as is, x will be NULL 
## Comment out x  <- 0 (in outer),  x will be 1
##  Ans:  when x <<- 1 runs, R will search for for x; 
##  if it find x in a parent, it will replace value with 1, and stop
##  if R does NOT find, it will create  one at .Global
rm(x)
f03  <- function() {
    # run with and without next line
    x  <- 0
    inner  <- function(){
        x  <- 0
        x  <<- 1
        cat("inner, x= ", x, "\n")
    }
    inner()
    cat("outer, x= ", x, "\n")
}
f03()
```

    ## inner, x=  0 
    ## outer, x=  1

``` r
cat("global_env(), x= ", x, "\n")
```

    ## global_env(), x=  1

7.2.5 `env` -- not exactly `list` - no subset - can use \[[](#section)\] but NOT by position

rlang list? env\_has() env and binding env\_get() env\_poke() - to modify-in-place just ONE name-value env\_bind() - to bind one or more name-value pairs

env\_unbind() gcinfo() gc() + sideeffects lobstr::mem\_used() wrapper for gc()

7.2.6 Advanced env\_bind\_lazy(env) env\_bind\_active()

``` r
library(rlang)

#2
e1 <- env()

e1$loop <- e1
env_print()
```

    ## <environment: 0x61ec6f0>
    ## parent: <environment: global>
    ## bindings:
    ##  * f03: <fn>
    ##  * f02: <fn>
    ##  * f01: <fn>
    ##  * e2d: <env>
    ##  * e2c: <env>
    ##  * N: <int>
    ##  * e1: <env>
    ##  * formal: <chr>
    ##  * l: <S3: rlang_envs>
    ##  * b: <fn>
    ##  * a: <fn>
    ##  * where_am_i: <fn>
    ##  * parent_ls: <fn>
    ##  * parent: <env>
    ##  * e: <env>
    ##  * f: <fn>
    ##  * env: <env>
    ##  * file: <chr>
    ##  * dir: <chr>

``` r
#3 
e1 <- env()
e2  <- env(e1)

e1$dedoop  <- e2
e2$loop  <-  e1
env_print()
```

    ## <environment: 0x61ec6f0>
    ## parent: <environment: global>
    ## bindings:
    ##  * e2: <env>
    ##  * f03: <fn>
    ##  * f02: <fn>
    ##  * f01: <fn>
    ##  * e2d: <env>
    ##  * e2c: <env>
    ##  * N: <int>
    ##  * e1: <env>
    ##  * formal: <chr>
    ##  * l: <S3: rlang_envs>
    ##  * b: <fn>
    ##  * a: <fn>
    ##  * where_am_i: <fn>
    ##  * parent_ls: <fn>
    ##  * parent: <env>
    ##  * e: <env>
    ##  * f: <fn>
    ##  * env: <env>
    ##  * file: <chr>
    ##  * dir: <chr>

``` r
env_print(e1)
```

    ## <environment: 0x5d948c0>
    ## parent: <environment: 0x61ec6f0>
    ## bindings:
    ##  * dedoop: <env>

``` r
env_print(e2)
```

    ## <environment: 0x4cedb08>
    ## parent: <environment: 0x5d948c0>
    ## bindings:
    ##  * loop: <env>

``` r
f  <- function(x) x
find("f") #G
```

    ## [1] ".GlobalEnv"

``` r
environment(f) #G
```

    ## <environment: 0x61ec6f0>

``` r
e  <-  env()
e$x  <-  10
environment(f)  <- e

find("f") #G
```

    ## [1] ".GlobalEnv"

``` r
environment(f) # e  (0x321....)
```

    ## <environment: 0x628cf70>

``` r
env_print(e)
```

    ## <environment: 0x628cf70>
    ## parent: <environment: 0x61ec6f0>
    ## bindings:
    ##  * x: <dbl>

``` r
x <- 0
# dont get it.
f(x) #0 ??
```

    ## [1] 0

7.4.2

``` r
# Closure of function
# When created, a function binds to current env.
# fn_env() returns this as  `function environment`.
# BETTER:
# env where a function can keep its state variables.

f  <- function(x) g(x) 
g   <- function(y) {fn_env(g)}

h  <- function(x) {
    q  <- current_env()
    attr(q ,"name") <- "h_env"
    k  <- function(x) {fn_env(k)}
    k(x)
}

# can' not change name of Global?
C  <- current_env()
attr(C, "name")  <- "h_env"
current_env()
```

    ## <environment: 0x61ec6f0>
    ## attr(,"name")
    ## [1] "h_env"

``` r
h(x)
```

    ## <environment: 0x3c19a58>
    ## attr(,"name")
    ## [1] "h_env"

``` r
library(rlang)
y <- 1
f1 <- function(x) x+y
rlang::fn_env(f1)
```

    ## <environment: 0x61ec6f0>
    ## attr(,"name")
    ## [1] "h_env"

``` r
env_names(current_env()) 
```

    ##  [1] "f1"         "y"          "C"         
    ##  [4] "h"          "g"          "x"         
    ##  [7] "e2"         "f03"        "f02"       
    ## [10] "f01"        "e2d"        "e2c"       
    ## [13] "N"          "e1"         "formal"    
    ## [16] "l"          "b"          "a"         
    ## [19] "where_am_i" "parent_ls"  "parent"    
    ## [22] "e"          "f"          "env"       
    ## [25] "file"       "dir"

``` r
f2 <- function(x) env_parent(current_env())
f2()
```

    ## <environment: 0x61ec6f0>
    ## attr(,"name")
    ## [1] "h_env"

``` r
rlang::fn_env(f2)
```

    ## <environment: 0x61ec6f0>
    ## attr(,"name")
    ## [1] "h_env"

``` r
# case II
e <- env()
e$g <- function() x+y
fn_env(e$g)
```

    ## <environment: 0x61ec6f0>
    ## attr(,"name")
    ## [1] "h_env"

``` r
env_names(current_env())
```

    ##  [1] "f2"         "f1"         "y"         
    ##  [4] "C"          "h"          "g"         
    ##  [7] "x"          "e2"         "f03"       
    ## [10] "f02"        "f01"        "e2d"       
    ## [13] "e2c"        "N"          "e1"        
    ## [16] "formal"     "l"          "b"         
    ## [19] "a"          "where_am_i" "parent_ls" 
    ## [22] "parent"     "e"          "f"         
    ## [25] "env"        "file"       "dir"

``` r
env_names(e)
```

    ## [1] "g"

#### 7.4.5 Exercises

``` r
# my_str()
my_str  <- function(f) {
    if (!is.function(f)) abort(" f must be a function")
    where(f)    # find f
    fn_env(f)  # enclosing 
    str(f)
}
my_str("mean")
```

    ## Error:  f must be a function

#### 7.5.2 call stack, lazy, lobstr::cst()

``` r
# nice stack trace, in order
f <- function(x) {
    print("inside f")
    print(current_env())
    print(env_parent())
  g(x = 2)
}
g <- function(x) {
  h(x = 3)
}
h <- function(x) {
  #stop()
    lobstr::cst()
}
f(1)
```

    ## [1] "inside f"
    ## <environment: 0x6954a20>
    ## <environment: 0x61ec6f0>
    ## attr(,"name")
    ## [1] "h_env"
    ##      █
    ##   1. └─global::ren_github(file, dir)
    ##   2.   ├─rmarkdown::render(...) ./000_useful_functions.R:131:8
    ##   3.   │ └─knitr::knit(knit_input, knit_output, envir = envir, quiet = quiet)
    ##   4.   │   └─knitr:::process_file(text, output)
    ##   5.   │     ├─base::withCallingHandlers(...)
    ##   6.   │     ├─knitr:::process_group(group)
    ##   7.   │     └─knitr:::process_group.block(group)
    ##   8.   │       └─knitr:::call_block(x)
    ##   9.   │         └─knitr:::block_exec(params)
    ##  10.   │           ├─knitr:::in_dir(...)
    ##  11.   │           └─knitr:::evaluate(...)
    ##  12.   │             └─evaluate::evaluate(...)
    ##  13.   │               └─evaluate:::evaluate_call(...)
    ##  14.   │                 ├─evaluate:::timing_fn(...)
    ##  15.   │                 ├─base:::handle(...)
    ##  16.   │                 ├─base::withCallingHandlers(...)
    ##  17.   │                 ├─base::withVisible(eval(expr, envir, enclos))
    ##  18.   │                 └─base::eval(expr, envir, enclos)
    ##  19.   │                   └─base::eval(expr, envir, enclos)
    ##  20.   └─f(1)
    ##  21.     └─g(x = 2)
    ##  22.       └─h(x = 3)
    ##  23.         └─lobstr::cst()

``` r
# introduce lazy
a <- function(x) b(x)
b <- function(x) {y <- 2; c(x)}
c <- function(x) {
    print(paste0("inside c", y))
    print(current_env())
    print(env_parent()) # Global,  not b!
    x 
    #cst()
}
y  <- 3
# also nice stack trace
a(x <- 2)
```

    ## [1] "inside c3"
    ## <environment: 0x629c4f0>
    ## <environment: 0x61ec6f0>
    ## attr(,"name")
    ## [1] "h_env"

``` r
# Explain:   c must evaluate x, 
# combine, 2 branches!
a(f())
```

    ## [1] "inside c3"
    ## <environment: 0x5df3b40>
    ## <environment: 0x61ec6f0>
    ## attr(,"name")
    ## [1] "h_env"
    ## [1] "inside f"
    ## <environment: 0x5c1c0b8>
    ## <environment: 0x61ec6f0>
    ## attr(,"name")
    ## [1] "h_env"
    ##      █
    ##   1. └─global::ren_github(file, dir)
    ##   2.   ├─rmarkdown::render(...) ./000_useful_functions.R:131:8
    ##   3.   │ └─knitr::knit(knit_input, knit_output, envir = envir, quiet = quiet)
    ##   4.   │   └─knitr:::process_file(text, output)
    ##   5.   │     ├─base::withCallingHandlers(...)
    ##   6.   │     ├─knitr:::process_group(group)
    ##   7.   │     └─knitr:::process_group.block(group)
    ##   8.   │       └─knitr:::call_block(x)
    ##   9.   │         └─knitr:::block_exec(params)
    ##  10.   │           ├─knitr:::in_dir(...)
    ##  11.   │           └─knitr:::evaluate(...)
    ##  12.   │             └─evaluate::evaluate(...)
    ##  13.   │               └─evaluate:::evaluate_call(...)
    ##  14.   │                 ├─evaluate:::timing_fn(...)
    ##  15.   │                 ├─base:::handle(...)
    ##  16.   │                 ├─base::withCallingHandlers(...)
    ##  17.   │                 ├─base::withVisible(eval(expr, envir, enclos))
    ##  18.   │                 └─base::eval(expr, envir, enclos)
    ##  19.   │                   └─base::eval(expr, envir, enclos)
    ##  20.   ├─a(f())
    ##  21.   │ └─b(x)
    ##  22.   │   └─c(x)
    ##  23.   └─f()
    ##  24.     └─g(x = 2)
    ##  25.       └─h(x = 3)
    ##  26.         └─lobstr::cst()

#### 7.5.5 EXERCISE

``` r
# list all objects in caller_env()
f  <- function(){
    e  <- caller_env()
    environment(e)
    env_print(e)
}
environment()
```

    ## <environment: 0x61ec6f0>
    ## attr(,"name")
    ## [1] "h_env"

``` r
f()
```

    ## <environment: h_env>
    ## parent: <environment: global>
    ## bindings:
    ##  * c: <fn>
    ##  * my_str: <fn>
    ##  * f2: <fn>
    ##  * f1: <fn>
    ##  * y: <dbl>
    ##  * C: <env>
    ##  * h: <fn>
    ##  * g: <fn>
    ##  * x: <dbl>
    ##  * e2: <env>
    ##  * f03: <fn>
    ##  * f02: <fn>
    ##  * f01: <fn>
    ##  * e2d: <env>
    ##  * e2c: <env>
    ##  * N: <int>
    ##  * e1: <env>
    ##  * formal: <chr>
    ##  * l: <S3: rlang_envs>
    ##  * b: <fn>
    ##    * ... with 9 more bindings

``` r
ls()
```

    ##  [1] "a"          "b"          "c"         
    ##  [4] "C"          "dir"        "e"         
    ##  [7] "e1"         "e2"         "e2c"       
    ## [10] "e2d"        "env"        "f"         
    ## [13] "f01"        "f02"        "f03"       
    ## [16] "f1"         "f2"         "file"      
    ## [19] "formal"     "g"          "h"         
    ## [22] "l"          "my_str"     "N"         
    ## [25] "parent"     "parent_ls"  "where_am_i"
    ## [28] "x"          "y"

#### most env have no intrinsic name; setting attr(., "name") is different

``` r
C  <- current_env() # TRUE
identical(C, current_env())

env_name(C)     # global
#attr(C, "name") #NULL
env_names(C)
env_length(env=C)
attributes(C)

attr(C, "name")  <- "env_C"

env_get_list(env = C, nms= "name") 
fn_env(C)
f  <- function() {}
fn_env(f)# 


e1  <- C
e2  <- C
e3  <- C
identical(C, e1)
# attr(e3, "name")
```

#### 7.6 get(), set() env Maintain `state`

``` r
# temp change value of a, then return to original
env  <- env()
env$a  <- 1
get_a  <- function() env$a

set_a  <- function(value) {
    old  <- env$a
    env$a  <- value
    invisible(old)
}

get_a()
```

    ## [1] 1

``` r
x <- set_a(12)
get_a()
```

    ## [1] 12

``` r
set_a(x)
get_a()
```

    ## [1] 1

#### report all env f\_report(env)

``` r
r  <- function(f, env) {
    lobstr::cst()
    list(Current  = env,
             Parent  = env_parent(env),
             B  = "binding env",
             Env = environment(f), # env of f
             Cl =  fn_env(f), 
             Caller = caller_env()
             )
}
f  <- function(x) {
    r(f,current_env()) 
}



e1  <- env(empty_env())
e1$g  <- function(z=0) r(e1$g,current_env()) 
(e1$g)(1)
```

    ##      █
    ##   1. └─global::ren_github(file, dir)
    ##   2.   ├─rmarkdown::render(...) ./000_useful_functions.R:131:8
    ##   3.   │ └─knitr::knit(knit_input, knit_output, envir = envir, quiet = quiet)
    ##   4.   │   └─knitr:::process_file(text, output)
    ##   5.   │     ├─base::withCallingHandlers(...)
    ##   6.   │     ├─knitr:::process_group(group)
    ##   7.   │     └─knitr:::process_group.block(group)
    ##   8.   │       └─knitr:::call_block(x)
    ##   9.   │         └─knitr:::block_exec(params)
    ##  10.   │           ├─knitr:::in_dir(...)
    ##  11.   │           └─knitr:::evaluate(...)
    ##  12.   │             └─evaluate::evaluate(...)
    ##  13.   │               └─evaluate:::evaluate_call(...)
    ##  14.   │                 ├─evaluate:::timing_fn(...)
    ##  15.   │                 ├─base:::handle(...)
    ##  16.   │                 ├─base::withCallingHandlers(...)
    ##  17.   │                 ├─base::withVisible(eval(expr, envir, enclos))
    ##  18.   │                 └─base::eval(expr, envir, enclos)
    ##  19.   │                   └─base::eval(expr, envir, enclos)
    ##  20.   └─(e1$g)(1)
    ##  21.     └─r(e1$g, current_env())
    ##  22.       └─lobstr::cst()

    ## $Current
    ## <environment: 0x692f3f8>
    ## 
    ## $Parent
    ## <environment: 0x61ec6f0>
    ## attr(,"name")
    ## [1] "h_env"
    ## 
    ## $B
    ## [1] "binding env"
    ## 
    ## $Env
    ## <environment: 0x61ec6f0>
    ## attr(,"name")
    ## [1] "h_env"
    ## 
    ## $Cl
    ## <environment: 0x61ec6f0>
    ## attr(,"name")
    ## [1] "h_env"
    ## 
    ## $Caller
    ## <environment: 0x692f3f8>

``` r
environment(f)
```

    ## <environment: 0x61ec6f0>
    ## attr(,"name")
    ## [1] "h_env"
