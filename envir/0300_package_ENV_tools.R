TAGS:  namespace, rlang, environment
# 065A_env_pkg_tools.R

# PURPOSE:  tools for env, probing pkg environment

##-----------------------------------------
# Where is package installed? (pkgload:: part of devtools::)
pkgload::inst("ggplot2") #/home/jim/R/x86...-library/3.6/ggplot2
pkgload::inst("base")   #/usr/lib/R/library/base

##-----------------------------------------
##  IS PACKAGE LOADED & ATTACHED?

# env (Ref: Adv R v2  Chapter 7.4)
# each is entry is PARENT of prior
base::search()
#
# insert env, single ":"
base::objects("package:stats")

# OR, a bit easier to read
rlang::search_envs()

# library(ggplot).  As last to be installed, it becomes parent of 'workspace'
library(ggplot2)
rlang::search_envs()

library(magrittr)	# now this will be parent of 'workspace'
rlang::search_envs()


```{r render, eval=FALSE, include=FALSE 	} 
# TODO:  file is found when knitr runs (see above)

# file must be of form:
# dir/name_of_this_file    where dir is relative to project root

file  <- here("", "")
file  <- "env_code/0088_env_namespace.Rmd"

# in general, pdf will look nicer
rmarkdown::render(file,
                  #output_format = "pdf_document",
                  output_format = "html_document",
                  output_file = "~/Downloads/print_and_delete/out")
```
