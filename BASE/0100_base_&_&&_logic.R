--- 
title: Template for .Rmd 
date: "`r paste('last updated', 
    format(lubridate::now(), '%H:%M, %d %B %Y'))`"
output: 
  pdf_document: 
    latex_engine: xelatex
toc: TRUE 
toc_depth:  4 
fontsize: 10pt 
geometry: margin=0.4in,top=0.25in 
TAGS:  &, &&
---

 
#### Logic:    & vs &&


#### & is vectorized, compares 2 boolean vectors, element-by-elemnt

# simple
{
x = c(1,2,3) 
y = c(1,2,-3)
(x > 0) & (x < 4)
# [1] TRUE TRUE TRUE


( (-2:2) >= 0) & ( (-2:2) <=0)
# [1] FALSE FALSE  TRUE FALSE FALSE


( c(T,F,F) )  & (c(T,T,T))
# [1]  TRUE FALSE FALSE
}

####  && is used to avoid evaluated 2nd item if 1st is FALSE
##      If you give && a vector, it will work on 1st element only
{
if ( (1>0) && (T)) print('hi')

if ( (1<0) && (T)) print('hi')
# NULL

## lazy, no error, no need to evaluate x
if ( (1<0) && (x)) print('hi')
# NULL
}
