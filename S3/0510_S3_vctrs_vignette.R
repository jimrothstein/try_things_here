--- 
title: Template for .Rmd 
date: "`r paste('last updated', 
    format(lubridate::now(), '%H:%M, %d %B %Y'))`"
output: 
  pdf_document: 
    latex_engine: xelatex
toc: TRUE 
toc_depth:  1 
fontsize: 12pt 
geometry: margin=0.5in,top=0.25in 
TAGS:   S3, vctrs
---

## REF:  S3 vignette from vctrs:: pkg

```{r setup, include=FALSE		}
knitr::opts_chunk$set(echo = TRUE,  
											comment="      ##",  
											error=TRUE, 
											collapse=TRUE) 
library(jimTools) 
library(vctrs)
``` 

### constructor for vctrs_percent class

```{r begin}
new_percent  <- function(x = double()){
  vec_assert(x, double())
  new_vctr(x, class="vctrs_percent")
}
new_percent()
new_percent("a")


  ## examine constructor
  class(new_percent)
  attributes(new_percent)
  inherits(new_percent, "new_vctr")
  sloop::ftype(new_percent)
  # [1] "function"
  methods(new_vctr)
  methods(new_percent)
```
### create instance 
```{r instance}

values  <- c(seq(0,1, length.out=4), NA)

x  <- new_percent(values) # done!


  ## probe the instance
    is.object(x)
    str(x)
    attributes(x)
    sloop::otype(x)
    sloop::ftype(x)


sloop::s3_dispatch(new_percent(values))

```


### helper, easier for user
```{r helper}
percent  <- function(x = double()){
  x  <- vec_cast(x, double())
  new_percent(x)
}

## probe the helper
  sloop::s3_dispatch(percent)
  methods(percent)
  ftype(percent)

## instance
    percent()
    percent(1:5)  # converts int[]

    x  <- percent( c(seq(0,1,length.out=4),NA) )
    x



## probe the instance
    attributes(x)
    class(x)
    inherits(x, "vctrs_vctr")
    [1] TRUE
    inherits(x, "vctrs_percent")
    sloop::otype(x)

    head(methods(vec_cast))
    sloop::s3_dispatch(percent(1:5))
```

is_percent, to check
```{r is_percent }
is_percent  <- function(x) {
  inherits(x, "vctrs_percent")   # based on class of x 
}
is_percent(percent(1:5))  # TRUE  
```
round to 3 signif digits
```{r signif}
signif(.0021234, 3)
signif(.021234, 3)
signif(.21234, 3)
signif(2.1234, 3)
signif(21.234, 3)
signif(212.34, 3)
signif(2123.4, 3)
signif(21234., 3)
```

char
```{r formatC}

formatC(2.1234)
formatC(2.1234, format="E")
```

paste0 to add % suffix
```{r format}

format.vctrs_percent <- function(x, ...) {
  # formatC is style, round to 3 places
  out <- formatC(signif(vec_data(x) * 100, 3))
  out[is.na(x)] <- NA
  out[!is.na(x)] <- paste0(out[!is.na(x)], "%")
  out
}
format.vctrs_percent(rnorm(10))
# x (from above)
format.vctrs_percent(x)

```

```{r render, eval=FALSE, include=F	} 
file <- "" 
file  <- basename(file) 
dir <-"rmd"

jimTools::ren_pdf(file,dir)
jimTools::ren_github(file, dir)
```
