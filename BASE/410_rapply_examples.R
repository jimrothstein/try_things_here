#	file <- "0410_rapply_examples.R"
 
#	----------------------------------------------------------------------------------
#	PURPOSE:	rapply (for lsits)
#	REF:https://www.r-bloggers.com/2016/02/rapply-function-explanation-and-examples/
#	
#	SEE   rrapply
#	----------------------------------------------------------------------------------
#
#
#
#------------------------------------------------------------------------
args(rapply)
# function (object, f, classes = "ANY", deflt = NULL, how = c("unlist", 
#     "replace", "list"), ...) 
# NULL
#------------------------------------------------------------------------
#
#
#	class is condition
x=list(1,2,3,4, "A")
rapply(x, function(x) {x^2}, class="numeric")


x=list(1,list(2,3),4,list(5,list(6,7)))
dput(x)

str(x)
# List of 4
#  $ : num 1
#  $ :List of 2
#   ..$ : num 2
#   ..$ : num 3
#  $ : num 4
#  $ :List of 2
#   ..$ : num 5
#   ..$ :List of 2
#   .. ..$ : num 6
#   .. ..$ : num 7
# NULL
#
##	returns vector
rapply(x,function(x){x^2},class=c("numeric"))
[1]  1  4  9 16 25 36 49

##  SAME, but keep same structure (list)
rapply(x,function(x){x^2},class=c("numeric"), how="list")
# [[1]]
# [1] 1
# 
# [[2]]
# [[2]][[1]]
# [1] 4
# 
# [[2]][[2]]
# [1] 9
# 
# 
# [[3]]
# [1] 16
# 
# [[4]]
# [[4]][[1]]
# [1] 25
# 
# [[4]][[2]]
# [[4]][[2]][[1]]
# [1] 36
# 
# [[4]][[2]][[2]]
# [1] 49
# 
#
#	----------------------------------------------------------------------
#		useflt, how="list"
x=list(1,list(2),"f")
a=rapply(x,function(x){x^2},class=c("numeric"),how="list",deflt="p")
# 
#
#	----------------------------------------------------------------------
#		useflt, how="unlist", --> vector
rapply(x,function(x){x^2},class=c("numeric"),how="unlist",deflt="p")


#	----------------------------------------------------------------------
#		how="replace", to keep original values?  (can not combine unlist and replace??)
a=rapply(x,function(x){x^2},class=c("numeric"),how=c("replace"),deflt="p")
unlist(a)



#	----------------------------------------------------------------------
#		From rapply help
     X <- list(LevelI=list(a = pi, b = list(c = 1L)), d = "a test")

     rapply(X, function(x) x, how = "replace") -> X.
		 unlist(X.)
stopifnot(identical(X, X.))

		#	deparse:  takes `expression` returns string (unevaluated)
     rapply(X, deparse, control = "all") # passing extras. argument of deparse()
