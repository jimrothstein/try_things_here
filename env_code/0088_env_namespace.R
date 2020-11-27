
---
title: "088_env_namespace.R"
output:  
  pdf_document:
geometry: "left=2cm,right=2cm,top=2cm,bottom=2cm"
fontsize: 12pt
---

```
# REF: R-pkg  v2 
# NAMESPACE
# chapter 11

# compare search() before/after a package.
old  <- search()
old

# :: loads pkg testthat (not attach)
testthat::expect_equal(1,1)

# no change
setdiff(search(),old)

# load AND attach
library(testthat)
expect_equal(1,1)
new <- search()
new
setdiff(new, old)   # observe "package:testthat"


# 
base::.onLoad(.libPaths(), "ggplot2")

.onLoad  <- function(libname, pkgname)	message ("loading")
# Loads, not attach
requireNamespace("ggplot2")
search()

# -------namespace  -----------

# Usually not done this way, library() will load and attach
loadNamespace("tibble")

loadedNamespaces()
library(fs)
loadedNamespaces()

# unload
unloadNamespace("fs")
loadedNamespaces()


# ------- detach pkg ----------
 search()
library("fs")
search()

detach("package:fs")
search()

# ------- detach #2 ----------
# if ( <cond>, TRUE, FALSE )
check <- function(pkg) 
ifelse((pkg %in% search()), paste0(pkg," is in search"), paste0(pkg, " is NOT in search"))


pkg = "package:fs"
check(pkg)
loadedNamespaces()

library("fs")
check(pkg)
loadedNamespaces()

if("package:fs" %in% search()) detach("package:fs", unload=FALSE)
check(pkg)

check(pkg)
unloadNamespace(pkg)
check(pkg)
```


