# 030_class_useMethod_functions.R
# Alt - z
# <- 

# learn about a function
seq   # calls UseMethod()
UseMethod  # function

class(seq)   # it is  function, object
class(5)     # numeric
class("jim")  # character
class(mean)   # function

View(seq)       # appears in new TAB

seq
# R code!
seq.Date
seq.default


# [generic].[class]
class(seq.Date) # function
class(seq.default) # function
class(seq.int)   # function
class(seq.POSIXt) # function

