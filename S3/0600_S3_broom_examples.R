--- 
title: Template for .Rmd 
date: "`r paste('last updated', 
    format(lubridate::now(), '%H:%M, %d %B %Y'))`"
output: 
  pdf_document: 
    latex_engine: lualatex 
toc: TRUE 
toc_depth:  1 
fontsize: 12pt 
geometry: margin=0.5in,top=0.25in 
TAGS:   S3, vctrs
---

library(broom)

#--------------------------------
#	BASE
#--------------------------------
lmfit <- lm(mpg ~ wt, mtcars)
lmfit
cat(typeof(lmfit), class(lmfit), "\n")
# list lm 

summary(lmfit)


#--------------------------------
#		BROOOM,  tidy is S3 generic, lmfit class `lm`
#--------------------------------
tidy(lmfit)

#
sloop::ftype(tidy)
sloop::is_s3_generic("tidy")
sloop::is_s3_method("tidy.lm")
sloop::s3_dispatch(tidy(lmfit))	# use 
# => tidy.lm
#  * tidy.default


exists("lmfit")
exists("lm")


is.object(lmfit)
is.object(lm)

utils::isS3stdGeneric(tidy)
# TRUE 

tidy  # displays generic code
if (F) tidy.lm			# tidy.lm not found
utils::getS3method(f="tidy", class="lm")




#--------------------------------
#		BROOOM,  Show source for all S3 methods
#--------------------------------

#	get:  all tidy.*
methods  <- ls(getNamespace("broom"), pattern="^tidy[.]", sorted=T)
methods


##	check:  all are S3 methods?
unlist(lapply(methods, function(e) sloop::is_s3_method(e) ))

##  show code for specific S3 method
lapply(methods, function(e) utils::getAnywhere(e))[[68]]
