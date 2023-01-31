
---
title:  ""
output: 
  pdf_document:
    toc: TRUE 
		toc_depth: 2
    latex_engine: xelatex
fontsize: 12pt
geometry: margin=0.5in,top=0.25in
#  md_document:
#  html_document:
#  github_document:
#   toc: true
#  	toc_float: true
#    css: styles.css
params:
  date: !r lubridate::today()
---

### PURPOSE:  Simple regression, well annotated in stackexchange. 
  *  REF:   (cross) stats.stackexchange.com/a/44841/81618
  *  Just code here, the explanation, ideas in SExchange.

## Grab the code


#------generate one data set with epsilon ~ N(0, 0.25)------
seed <- 1152 #seed
n <- 100     #nb of observations
a <- 5       #intercept
b <- 2.7     #slope

set.seed(seed)
epsilon <- rnorm(n, mean=0, sd=sqrt(0.25))
# strange choices for x
x <- sample(x=c(0, 1), size=n, replace=TRUE)
y <- a + b * x + epsilon
#-----------------------------------------------------------

#------using lm------
mod <- lm(y ~ x)
#--------------------


#------insert:  summary(mod)
summary(mod)
#--------------------


#------using the explicit formulas------
X <- cbind(1, x)
betaHat <- solve(t(X) %*% X) %*% t(X) %*% y
var_betaHat <- anova(mod)[[3]][2] * solve(t(X) %*% X)
#---------------------------------------

{  #------comparison------
#estimate
> mod$coef
(Intercept)           x 
   5.020261    2.755577 

> c(betaHat[1], betaHat[2])
[1] 5.020261 2.755577

#standard error (beta/SE(beta))
> summary(mod)$coefficients[, 2]
(Intercept)           x 
 0.06596021  0.09725302 

> sqrt(diag(var_betaHat))
                    x 
0.06596021 0.09725302 

}  #----------------------



### PURPOSE:  Another Simple regression, well annotated in stackexchange. 
  *  REF:   (cross) https://stats.stackexchange.com/questions/5135/interpretation-of-rs-lm-output
  *  Just code here, the explanation, ideas in SExchange.

{
    ## Grab the code
    mod  <- lm(formula = iris$Sepal.Width ~ iris$Petal.Width)

    summary(mod)
}
