# 001_vector_practice.R

# http://r4ds.had.co.nz/vectors.html
## https://adv-r.hadley.nz/vectors-chap.html

#######
## GOAL: Vector practice ~advr v2 Chapter 3
# 
#### Begin ####
library(tidyverse)
library(sloop)
#

##  Ch 3.2.2 (advr)
lgl_var <- c(TRUE, FALSE)
int_var <- c(1L, 6L, 10L)
dbl_var <- c(1, 2.5, 4.5)
chr_var <- c("these are", "some strings")

## JR(TODO) NULL is drop from the list, just disappears, including nam, including name
get_info <- function (var) {
    z <- c(
        typeof(var),
        sloop::otype(var), # base
        obj = is.object(var),  ## FALSE
        attr = is.null(attributes(var)), ## NULL,  no class
        cls = attr(var, "class"),
    
        all.names = TRUE, use.names=TRUE
    ) ## NULL  
    return(z)
}
z <- get_info(1:3)
z
##  MOVE ON
z <- Sys.Date()
typeof(z)   ## double
is_double(z) ## TRUE
sloop::otype(z) # S3

## OO Object (and double vector)
is.object(z) # T
attributes(z)  # class=Date

##  MOVE ON
z <- 1:3
typeof(z)   ## integer
sloop::otype(z) # base

## OO Object (and double vector)
is.object(z) # FAlSE    
attributes(z)  # NULL

##  MOVE ON
z <- environment()
typeof(z)   ## environment
sloop::otype(z) # base

## OO Object (and double vector)
is.object(z) # FAlSE    
attributes(z)  # NULL
##  MOVE ON
z <- '['  ## can't do
typeof(z)   ## environment
sloop::otype(z) # base

## OO Object (and double vector)
is.object(z) # FAlSE    
attributes(z)  # NULL
##  MOVE ON
z <- mtcars  ## 
typeof(z)   ## list 
sloop::otype(z) # base

## OO Object 
is.object(z) # TRUE
attributes(z)  # many!  and class=data.frame

##  MOVE ON
z <- as_tibble(mtcars)
typeof(z)   ## list 
sloop::otype(z) # S3

## OO Object 
is.object(z) # TRUE
attributes(z)  # many!  and class=tbl_df tbl data.frame

##  MOVE ON
#   z <- as_tibble  #error!
typeof(as_tibble)   ## closure  
sloop::otype(as_tibble) # base??

## OO Object 
is.object(as_tibble) # T 
attributes(as_tibble)  # NULL        
methods(as_tibble)  # several
isS4(as_tibble)     # F
s##  MOVE ON
#   z <- as.integer  #error!
typeof(as.integer)   ## builtin  
sloop::otype(z) # S3

## OO Object 
is.object(z) # TRUE
attributes(z)  # many!  and class=tbl_df tbl data.frame
methods(as_tibble)  #10


## recreate problem -- FAILS
var <- c(1:3)
is.object(var) # FALSE
purrr::is_integer(var) # TRUE
attr(var, "class") # NULL

l <- list(object=is.object(var), 
          integer=purrr::is_integer(var),
          attr=attr(var,"class")
          )
l
t <- as_tibble(l)    ## ERROR
######
#WORKS
var <- mtcars   
is.object(var) # FALSE
purrr::is_integer(var) # TRUE
attr(var, "class") # NULL

l <- list(object=is.object(var), 
          integer=purrr::is_integer(var),
          attr=attr(var, "class")
          )
l

t <- dplyr::as_tibble(l)
t
reprex()
########
# Working through Hadley's Adv R, Chapter 12, vectors and OO
# https://adv-r.hadley.nz/base-types.html#base-vs-oo


# For list of various R objects, such as 
test_objects <- list(a=c(1:3), b=mtcars, c=Sys.Date())
t <- tibble::tibble(col1 = list("integer vector","data.frame", "double")) 
# Examine gather attributes or object types or methods,
# for instance here "class" attribute:

f <- function(x) attr(x,"class")
l <- map(test_objects, f)

# NOTE c(1:3) has no "class" attribute, ie NULL

t %>% mutate (attr_class = l)
# Goal is build a tibble where each row is one R object and each 
# column represents a different attribute or information.

l <- list(a = NULL,
          b = "word",
          c = list("a", "b", "c" ),
          d = c(1.1, 2.0, 3.0)
)
l          
# But immediately run in this:
%>% 
    mutate(l=l)
## next
l$c

#### function 			#####
# ---- what_is_it ----
what_is_it  <- function ( v) {
    testName<-c("list",
                "vector",
		        "typeof",
		        "length",
                   "atomic", 
		   #       "numeric",
                   "integer",
                   "double",
                   "character",
                   "logical")

        result <-
                c(is_list(v),
                  is_vector(v), 
                  typeof(v),
                  length(v),
                  is_atomic(v),
		  #                   is_numeric(v), deprecated
                  is_integer(v),
                  is_double(v),
                  is_character(v),
                  is_logical(v))
        
        
        t<-tibble(testName,result)
        print(t)
        print("----names ----")
        print(names(v))
        print("---str----")
        print(str(v))
        print("---attributes--")
        print(attributes(v))
        print("----object----")
        print(v)
    
        #print(paste(c("typeof=",typeof(v)))    )
}
#### 1 example   ####

x1 <- c("one","two","three")
what_is_it(x1) # char vector

x2 <- NULL
x2 <- c(1,2,3)
what_is_it(x2) # dbl vector

x3 <- list("one","two","three")
what_is_it(x3)  # list (and vector), type=list (not char)
#
####  names ####
#

# ---- give names to elements ----
n<-c("a","b","c")
is_character(n)         # T
names(x2)               # NULL, no names
x2<-purrr::set_names(x2,n)
names(x2)               # still NULL? no "a" "b" "c"
what_is_it(x2 )		# dbl vector, with names

#
# ---- check things ----
x2[2]  			# returns b 2 (vertical) , preserves vector
what_is_it(x2[2])	# dbl vector, but length=1

names(x2[2])            # names is "b"
str(x2[2])              # num and has attr names ("b")
attributes(x2[2])       # $names, "b"
print(attributes(x2[2]))

#
# ----		unname?----
#
z<-unname(x2[2])           # returns 2, not b 2
z			# 2
what_is_it(z)		# dbl vector of length 1
names(z)                # NULL
str(z)                  # num 2, ie no attr
attributes(z)           # NULL
#
# ----			----
# NEXT TIME 			----

# ---- simplify [[]]----
# so MUST use ..
x2[[2]]   # 2 only
what_is_it(x2[[2]])     # vector, double 1 element
names(x2[[2]])          # NULL
str(x2[[2]])            # num 2
attributes(x2[[2]])     # NULL


x2[["c"]]  # 3 only
x2[[2]]

