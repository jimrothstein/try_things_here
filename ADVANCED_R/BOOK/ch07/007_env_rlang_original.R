#### My tutorial on functions, env, rlang (~ Ch6 & Ch7)

# REF: rlang: https://rlang.r-lib.org/reference/search_envs.html
# REF: from adv-r v2 Chapter 7

library(rlang)
# --------------
#	Ch 7.1
# create child env (to global)
# --------------
env <- env(a = 1, b = "foo")
env
env$b
env$a

# ---------------------------------
# show all objects in an env
#	rlang::env_print() much detail
# ---------------------------------
ls()
rlang::env_print()
rlang::env_names(rlang::current_env())

# env just created
rlang::env_print(env)                  # much  more info! 


# ---------------------------
#	Ch 7.2
# Where am I?   Global_env 
# NOTE:   env are NOT vectors
# 
rlang::global_env()
rlang::current_env()
identical(global_env(), current_env())
# ---------------------------


# ------------------
#	Ch 7.2.3 Parents
#	Hadley draw arrow FROM child TO parent!
# ------------------
rlang::env(a=1)                        #default:   current_env is parent of new env
rlang::env_parent(rlang::env(a=1))     # here parent  is global_env

j=rlang::env(emptyenv(), a=2)          # j is child of TOP parent emptyenv() 
env_parent(j) # <environment: R_EmptyEnv>
j$a

rlang::current_env()

What value for x prints?
# value of x depends upon <env> sent to f
f  <- function(env = global_env()){
	env$x
}

rm(x)
x  <- 5
f()

e  <- env(base_env(), x = 500)
f(e)


parent <- child_env(NULL, foo = "foo")
env <- child_env(parent, bar = "bar")
env_has(env, "foo")
```

#### reference symantecs - how ref work - modify-in-place
```{r ref_sym }# 
e  <- env(a=1)
f  <- e
g   <- e

ref(e)
ref(f)
ref(g)
g$a #1

# change a, ALL show the change
e$a  <- 5
f$a
g$a
# no changes
ref(e)
ref(f)
ref(g)


fn  <- function() list(current = current_env(),
											 caller = caller_env(),
											 parent = env_parent())

g  <- function() fn()
g()

#### YOU decide the env to evaluate f
x <- 0
f  <- function(a) {
	a + x
}
f(1)
# create NEW function based on f, with an env
with_env  <- function(f, e=env_parent()){
	stopifnot(is.function(f))
	# set environment for f to evaluate in
	environment(f)  <- e
	f
} 
# create 2 new environments
a  <- env(x=10)
b  <- env(x=20)

# wow, you can choose where to evalute!
with_env(f, current_env())(1)
with_env(f, a)(1)
with_env(f, b)(1)
with_env(f)(1) # defaults to calling_env (Global)

from 1st ed  (Environments)

# value when i() runs?

h <- function() {
  x <- 10
  function() {   
    x          # what env ?
  }
}
i <- h()  # is a now function
x <- 20
i()
```
Notation:
parent.frame = CALLING ENVIRONMENT 
We can access this environment using the unfortunately named parent.frame(). This function returns the environment where the function was called. 
```{r env_where_fun_called}
f2 <- function() {
  x <- 10
  function() {
    def <- get("x", environment())   # x in env where executing
    name  <- environment() 
    cll <- get("x", parent.frame())   # x in env where anony function called
    list(defined = def, name = name, called = cll)
  }
}

environment()   # Global
g2 <- f2()
x <- 20
str(g2())

# don' undrestand.
f  <- function() {
  def  <- environment() 
  cll  <- parent.frame()
  list (defined = def, called = cll) 
    function( ){
      list (defined = def, called = cll, anony_defined = environment()) 
    }
}
inner  <- f()
inner
inner()

	enclosing_env# 
# ```{r enclosing_env}
Environment(f) == enclosing env (where created)
# env_print()
# 
# sd()  always :environment(sd) (stats)
# 
# environment(sd) #namespace::stats
# 
find("sd")  
# 
actually making copy
# environment(sd)  <- global_env()
# environment(sd)  #Global
# env_names(current_env()
# 
find("sd") 
rm("sd")


#### parent.frame()# 

```{r frame}
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
parent_ls()

# in R, a functions env depends where it was called
# COMPARE: a() to .G variable a 
a <- function(){
	x  <- 5
	#parent_ls()
	where_am_i()
}
a()


## begin here -- TODO	

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

# 

```

::: Review basics, repeat of Examples in rlang Ref :::# 

#### base::search()	--> char[], 
#### all env names, beginning with lowest, .GlobalEnv
base::search()

#### add package (note: search path increases)
library(rlang)

#### rlang::search_envs()--> list
#### list of actual env objects on search path
rlang::search_envs()

#### first & last env
####
l  <- rlang::search_envs()
# first & last
l[1]
l[length(l)]

#### shortcuts: first & last env obj
global_env()
base_env()

#### rlang::pkg_env_name("pkg") --> char[]
#### takes bare pkg name; returns formal: 'package:pkg'
rlang::pkg_env_name("rlang")

##### formal name & attributes
##### note:  attributes(formal) is NULL?
```{r}
formal <-  pkg_env_name("rlang")
search_env(formal)
```

#### problems with pkg_env_name("rlang")
#### Should Return  ERROR,  not F?
#### arg must be 'search name' or 'package environment' 

```{r what_is_this, eval=FALSE	 }

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

#### function's env depends upon ????? ToDo# 
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

7.2.3 - create env(), env_parents()# 
Note:  use of last=   and subsetting the returned list
```{r 7.2.3}
e1  <- rlang::env(a=1)
rlang::is_environment(e1)
env_parent(e1)
env_parent(e1, n=2)
env_parent(e1, n=3)

N  <- length(env_parents(e1, last=empty_env()))
N

# subset!
env_parents(e1, last=empty_env())[c(1,3,N-2,N-1,N)]
env_tail(e1, last=empty_env())

# follow book, STUDY ... we can create env from any(?) parent?
e2c  <- env(empty_env(), d=4, e=5)
e2d  <- env(e2c, a=1,b=2, c=3)
env_parents(e2d)
env_parents(e2c)
N <- length(env_parents(e2d,last=empty_env()))
N


# env can point to itsefl! 
e  <- env()
env_names(current_env())
env_names(e)

e$self  <- e
env_names(e)
ref(e)

``` 

#### 7.2.4 <<- SUPER
```{r 7.2.4}
# What is value of x AFTER f01() is run?
x <- 0
f01 <- function() {
  x <<- 1
}
f01()
x   # 1, not 0

# 2nd verson, NO Promise, where is x found?
x <- 0
f02  <- function() {
	cat(env_has(env=env_parent(),"x"),"\n", fill=TRUE	  , labels = c("1", "2", "3"))
	cat(env_has(env=fn_env(f02), "x"),"\n")
	cat(env_has(env=current_env(),"x"),"\n")
}
f02()
x

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
cat("global_env(), x= ", x, "\n")
``` 

7.2.5   `env` -- not exactly `list`
- no subset
- can use [[]] but NOT by position

rlang list?
env_has()
env and binding
env_get()
env_poke()  - to modify-in-place just ONE name-value
env_bind()  - to bind one or more name-value pairs

env_unbind()
gcinfo()
gc() + sideeffects
lobstr::mem_used() wrapper for gc()


7.2.6 Advanced
env_bind_lazy(env)
env_bind_active()

```{r 7.2.7 exercises}
library(rlang)

#2
e1 <- env()

e1$loop <- e1
env_print()

#3 
e1 <- env()
e2  <- env(e1)

e1$dedoop  <- e2
e2$loop  <-  e1
env_print()
env_print(e1)
env_print(e2)
```

```{r aside_binding}
f  <- function(x) x
find("f") #G
environment(f) #G

e  <-  env()
e$x  <-  10
environment(f)  <- e

find("f") #G
environment(f) # e  (0x321....)
env_print(e)

x <- 0
# dont get it.
f(x) #0 ??

```


7.4.2
```{r 7.4.2_code}
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
h(x)
```

```{r 7.4.2 }
library(rlang)
y <- 1
f1 <- function(x) x+y
rlang::fn_env(f1)
env_names(current_env()) 
f2 <- function(x) env_parent(current_env())
f2()
rlang::fn_env(f2)

# case II
e <- env()
e$g <- function() x+y
fn_env(e$g)
env_names(current_env())
env_names(e)
```
#### 7.4.5 Exercises
```{r 7.4.5, error=TRUE}
# my_str()
my_str  <- function(f) {
	if (!is.function(f)) abort(" f must be a function")
	where(f)	# find f
	fn_env(f)  # enclosing 
	str(f)
}
my_str("mean")
```

#### 7.5.2 call stack, lazy, lobstr::cst()
```{r 7.5.2}

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

# Explain:   c must evaluate x, 
# combine, 2 branches!
a(f())
``` 


#### 7.5.5 EXERCISE 
```{r 7.5.5_exercise}
# list all objects in caller_env()
f  <- function(){
	e  <- caller_env()
	environment(e)
	env_print(e)
}
environment()
f()
ls()
``` 

#### most env have no intrinsic name; setting attr(., "name") is different#  
```{r env.name, eval=FALSE	 }
C  <- current_env() # TRUE
identical(C, current_env())

env_name(C)		# global
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


#### 7.6 get(), set() env  Maintain `state`# 
```{r 7.6}
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
x <- set_a(12)
get_a()
set_a(x)
get_a()
``` 


#### report all env f_report(env)# 
```{r report_all}
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
environment(f)
``` 

```{r}
reprex({
	#' HEADING	

  #+ setup, include = FALSE
  knitr::opts_chunk$set(outdir = "output_is", comment = "#####" )

  #+ actual-reprex-code
  (y <- 1:4)
  median(y)
})
```
