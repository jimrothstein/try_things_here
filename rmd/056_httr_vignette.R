---
title: "020_"
output: html_document
editor_options: 
  chunk_output_type: console
---
###  Ref: https://httr.r-lib.org//reference/GET.html
### vignette - uses httpbin.org as practice

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
library(magrittr)
library(httr)
```

#### 001_google
```{r}
r<- GET("http://google.com/", 
        path = "search", 
        query = list(q = "falwell"))
r$headers %>% str(max.level=1 )
```


#### 002_httpbin.org_practice
```{r}
r <- httr::GET("http://httpbin.org/get")
# r
httr::status_code(r)
r %>% str(max.level=1)
r$headers %>% str(max.level=1)


# add header
url <- "http://httpbin.org"
r <- httr::GET("http://httpbin.org/get", add_headers(a="ONE_header", b="TWO_header"))
r              
```
