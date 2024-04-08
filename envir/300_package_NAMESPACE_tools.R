#
##-------------------------------------
## NAMESPACES - See Ch 7.4.3
##-------------------------------------

##  Code to probe namespace
REF: R-pkg  v2 
NAMESPACE
chapter 11

compare search() before/after adding package.
  * before 
  * after loading a package

```{r search}
##-------------------------------------
### search path (shows attached pkgs)
##-------------------------------------
#
old  <- search()
old

# :: loads pkg tinytest (not attach)
tinytest::expect_equal(1,1)

# no change, tinytest:: not attached
base::setdiff(search(),old)

##-------------------------------------
# load AND attach
##-------------------------------------
library(tinytest)
new <- search()
new
setdiff(new, old)   # observe "package:tinytest"
```
```{r namespaces}
# show loaded 
loadedNamespaces()

# show loadd AND attached
search()
# remove prefix `package:`
attached_pkgs  <- sub(pattern="package:", replacement="", x=search())

setdiff(attached_pkgs, loadedNamespaces())
```

##	Attached, Loaded 
sessionInfo()

## Loaded and attached:



### To load/unload namespace
*  library("pkg") # loads and attaches
*  loadNamespace(pkg) # does NOT attach
```{r load_namespace }

# setdiff(x, y)  # lists elements in x, but not in y

x  <- c(0,1) 
y  <- c(0,1,2)
setdiff(x, y)  # no elements in x, but not in y
setdiff(y, x)

old  <- loadedNamespaces()
old

# load, NOT attach (Usually not done this way, library() will load and attach)
loadNamespace("jimTools")
new  <- loadedNamespaces()
new
base::setdiff(new, old)

# unload (detach 1st)

#	longley

library(jimTools)
search()
unloadNamespace("jimTools")
search()
tinytest::expect_false("jimTools" %in% search())

loadedNamespaces()

setdiff(old, loadedNamespaces())




```

### detach pkg
*  default, leaves loaded
*  use unload=TRUE to detach & unload
```{r detach}

search()
library("fs")
old  <- search()

detach("package:fs", unload = FALSE )
setdiff(old, search())
```

NEXT:
```{r detach2}

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

### HOOKS
.onLoad
     .onLoad(libname, pkgname)
     .onAttach(libname, pkgname)
     .onUnload(libpath)
     .onDetach(libpath)
     .Last.lib(libpath)
```{r hooks, eval = FALSE }

.onLoad  <- function(libname, pkgname)	message ("loading")

.onLoad(.libPaths(), "ggplot2")


# Loads  (returns t/f) does NOT attach
(requireNamespace("ggplot2"))
search()   # no change

```
