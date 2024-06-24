
## TAGS:  tools, namespace, rlang, environment


# PURPOSE:  misc tools for env, NS  (namespace)
-   getAnywhere()
-   exists()
-   makeActiveBinding
-   assign()    

---


##    Given an object, base::getAnywhere() finds pkg, NS, and code
```{r}

library(pkgload)
library(rlang)
library(ggplot2)

utils::getAnywhere(aes)
getAnywhere(vapply)
getAnywhere(getAnywhere)
getAnywhere(.rs.restart)

```

##-----------------------------------------
##  Given a package, list All objects :

```{r}
base::objects("package:stats")
base::objects("package:sdtmchecks")
base::objects(package:tibble)

```
##-----------------------------------------


# Where is package installed? (pkgload:: part of devtools::)
```{r}

pkgload::inst("ggplot2") #/home/jim/R/x86...-library/3.6/ggplot2
pkgload::inst("base")   #/usr/lib/R/library/base

##  IS PACKAGE LOADED & ATTACHED?

base::search()

# OR, a bit easier to read
rlang::search_envs()

library(ggplot2)
rlang::search_envs()

library(magrittr)	# now this will be parent of 'workspace'
rlang::search_envs()

```


