###
###file <- "BASE/0400_base_Reduce_Map_Filter_Gatto.R"
###
###
###
```
----------------
S E E    /VECTOR
----------------

http://www.johnmyleswhite.com/notebook/2010/09/23/higher-order-functions-in-r/
https://github.com/lgatto/TeachingMaterial/blob/master/_R-functional-programming/functional-programming.pdf

Good Intro various functional operations on lists (uses haskell)
https://www.cantab.net/users/antoni.diller/haskell/units/unit02.html
```
#### Simple functional examples in Base R
###
###  Trivial Examples since I always forget:
###
Reduce(`+`, list(1,2,3))
# [1] 6
#
# Seems to be y1 = f(x1), y2=f(y1, x2), y3=f(y2, x3) .... 
Reduce(`+`, list(1,2,3), accumulate=T)
# [1] 1 3 6
# 
Reduce(`+`, list(1,2,3), accumulate=T, init =100)
# [1] 100 101 103 106
#
#
####    Filter  for vector x, return x[f(x) == T]
f  <- function(x) x %% 2 ==0

Filter(f, 1:10)
# [1]  2  4  6  8 10
Filter(f, seq(10))
# [1]  2  4  6  8 10



#### Map

f  <- function(x,y,z) x+y+z

unlist(Map(f, 0:9, 100:109, 1000:1009))
#  [1] 1100 1103 1106 1109 1112 1115 1118 1121 1124 1127
