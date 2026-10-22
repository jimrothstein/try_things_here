--- 
title: Template for .Rmd 
date: "`r paste('last updated', 
    format(lubridate::now(), '%H:%M, %d %B %Y'))`"
output: 
  pdf_document: 
    latex_engine:  lualatex 
toc: TRUE 
toc_depth:  4 
fontsize: 11pt 
geometry: margin=0.4in,top=0.25in 
TAGS:   S3, class, inherits
---

## S3 class: basic
  *  REF:  [Adv-R Ch 13](https://adv-r.hadley.nz/s3.html)  
  *  [my code](~/code/try_things_here/ADVANCED_R)
  *   [but version 1, more concise intro](http://adv-r.had.co.nz/OO-essentials.html)
  *

## Outline:
  *   By adding class attribute to base types can create objects behave
    differently under generic functions (such as when printed).
  *  S3 is relatively simple OO, but ALSO allows easy errors; hence structure
    Hadley seeks to impose.
  * constructor (not called directly for this reason), validator (to check) and
    friendly helper to actually create object (safely).
  * need generic function (as print) to create variants or methods.  
  * which variant applies is determined by dispatch | UseMethod()
  * helpers - numerous to determine dim, class, names, attributes.
  * sloop::  to help see under the hood


## Definitions:
  *  generic function
  *  constructor
  *  objects must be one of classes:  S3, S4, Reference Classes (another OO)
  *  if is.object is F, then  base 

##  Packages
  *  sloop::
  *  base::
  *  ?ReferenceClasses 

```{r setup, include=FALSE		}
knitr::opts_chunk$set(echo = TRUE,  
											comment="      ##",  
											error=TRUE, 
											collapse=TRUE) 
library(sloop)
``` 


#### Create simple S3 class, check
```{r trivial}
  x <- structure("BLUE", author="jim", class="secret")
  y <- structure("BLUE", author="jim", class="top_secret")

get_info  <- function(x){
	cat("class= ", class(x), "\n")
	cat("typeof = ", typeof(x), "\n")
	cat("x without attributes = ", unlist(attributes(x)), "\n")
	cat("inherits = ", inherits(x, c("secret")), "\n")
	unclass(x)		# removes classs attribute
}

get_info(x)


```
###  Simple generic, "reveal" 
```{r adv_r_version1}
## Generic:  Use of `UseMethod` makes `reveal` generic: 
  reveal  <- function(x) UseMethod("reveal")


#	Methods:  user does NOT use these methods
	reveal.secret  <- function(x) as.character(x)
	reveal.top_secret  <- function(x) cat("I can not tell you\n")

#	Do use these:
	reveal(x)
	reveal(y)

reveal
reveal.secret
reveal.top_secret

##	See below for documentation
##
exists("reveal")
exists("x")
exists("y")
exists("reveal.secret")


utils::isS3stdGeneric("reveal")


sloop::ftype(reveal)
sloop::ftype(reveal.secret)
sloop::s3_dispatch(reveal(x))  ## must `call`
sloop::s3_dispatch(reveal(y))

#	but
sloop::s3_dispatch(reveal(3))
```

generic:  f
```{r another example}
f  <- function(x) UseMethod("f")

## give f methods, ie class of x determines f behavior.
  f.a  <- function(x) "Class a"
  f.z  <- function(x) "Class b"



## create S3 objects (use list() as base type)
## Use of `class` makes S3 objects
  a  <- structure(list(), class="a")
  z  <- structure(list(), class="z")


## call f with different objects, behavior depends on class.
  f(x = a)  # f.a() runs b/c "a" is class a
  f(x = z)
```


## Tools to probe S3 clases and related functions

## Given a S3 generic, get info
### generic, methods for S3
  *  methods() | utils::getS3method | class
```{r , S3_methods}

## methods for generic `f` 
  methods(f)

##	available generic functions for  S3 class `a`
	methods(class = "a")

## Methods for generic `print` 
  print  # UseMethod chooses
  head(methods(print),  n = 9L)

## another generic
  head(seq)
  methods(seq)
  methods(mean)
```
### utils::getS3method to see source
```{r, getS3method}
args(getS3method)
body(getS3method)
?getS3method


## get S3 method 
  utils::getS3method(f = "f", class = "a")

## other functions
  utils::getS3method(f = "print", class="aov")
  getS3method(f = "print", class="warnings")
  getS3method(f = "print", "default")
  getS3method("print")

## sameas
  f.a
  print.warnings
```

## probe the object
typeof
    is.object(x)
		exists(x)
    str(x)
    class(x)
    attributes(x)
    sloop::otype(x)
    


```{r useful_functions}
?utils::getAnywhere
?utils::getS3method   # given generic and class
#	Explain 'S3 methods hidden in namespace?'
#
?utils::isS3stdGeneric   # Uses `UseMethod` or not
```
```{r hadley_functions}
#	missing S3 exports (for loaded_all package)
?devtools::missing_s3

#	Explain internal vs regular generics
?sloop::is_s3_generic
?sloop::is_s3_method
?sloop::s3_dispatch

##	missing_s3 is referring to MY Package
?devtools::missing_s3
library(vcr)
?devtools::as.package
devtools::missing_s3(pkg=devtools::as.package("sloop"))
devtools::missing_s3(pkg=devtools::as.package("vcr"))


```{r probe_object}
probe_object  <- function(x) {
cat(is.object(a))
sprint("is.object %s", s=is.object(a))


typeof(a)
str(a)
attributes(a)
sloop::otype(a)
}
## 

is.object(a)
exists("a")

typeof(a)
str(a)
attributes(a)
sloop::otype(a)
```

## probe the constructor or methods
    sloop::ftype(x)


```{r render, eval=FALSE	} 
{
file <- "" 
file  <- basename(file) 
dir <-"rmd"
}

jimTools::ren_pdf(file,dir)
jimTools::ren_github(file, dir)
```
