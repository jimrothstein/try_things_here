
## TAGS:  tools, namespace, rlang, environment


# PURPOSE:  misc tools for env, NS  (namespace)
-   getAnywhere()
-   exists()
-   makeActiveBinding
-   assign()    

---


##    base::getAnywhere() finds pkg, NS, and code
```{r}

library(pkgload)
library(rlang)

utils::getAnywhere(aes)
getAnywhere(vapply)
getAnywhere(getAnywhere)
getAnywhere(.rs.restart)

```
##-----------------------------------------

# Where is package installed? (pkgload:: part of devtools::)
``

```{r}

pkgload::inst("ggplot2") #/home/jim/R/x86...-library/3.6/ggplot2
pkgload::inst("base")   #/usr/lib/R/library/base

##  IS PACKAGE LOADED & ATTACHED?

base::search()

#
# insert env, single ":"
base::objects("package:stats")
base::objects("package:sdtmchecks")

# OR, a bit easier to read
rlang::search_envs()

library(ggplot2)
rlang::search_envs()

library(magrittr)	# now this will be parent of 'workspace'
rlang::search_envs()

```


