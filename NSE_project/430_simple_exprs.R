library(rlang)
a = 10
b = 20
# video uses exprs, which will not evaluate correctly
quote1 = expr(a+b)
quote1  # not evalu


# here theQuote is paramater, not exactly the source code
iQuote = function(theQuote){
  exprQuote=enexpr(theQuote)
  print(exprQuote)
  }
iQuote(a+b)


# https://www.youtube.com/watch?v=IaGU2UYeYOU
# Part 4 (evaluation

base::eval(quote1)
rlang::eval_tidy(quote1)

# error
try(!!y)





#
a=10
b=100

x = a + b

y = exprs(x)
eval(y)
!!y```{r}xixixix

a = exprs(10)
b = exprs(100)
x= a+b
x
y= exprs(x)

# Video 5
# https://www.youtube.com/watch?v=a6AC8LMxKvo

# This Works
subset(mtcars, hp > 100, hp)

# But, make column (hp) a variable:  Pattern = quasiquotation. 

# 1) make eveything expression
# 2) before expression for subset is evaluated, use !! (unquote) to insert/expand/substitute a value for column
# 3) then run/evaluate entire expression

myColumn = expr(hp)
# !!hp will substitute (eval) myColumn *before* myExpr is run; aka quasiquotation

myExpr = expr(subset(mtcars, hp > 100, !!myColumn))
myExpr
# subset(mtcars, hp > 100, hp)

# run
eval(myExpr)
