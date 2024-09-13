	 
 ##  Namespaces
 ##  Collect examples here

#
##-------------------------------------
## NAMESPACES - See Ch 7.4.3
##-------------------------------------


## all attached packages vs search()
```{r}
(.packages())
search()
```

### getNamespace, returns environment
```{r}
?help.start
?getAnywhere
argsAnywhere(derive_params)
getAnywhere(filter)
getAnywhere(ae)

library(pkgload)
getNamespace("admiral")   # namespace::admiral
```
### objects in NameSpace
```{r} 
ls(getNamespace("dplyr"))
ls(getNamespace("admiral"))

```
### test, is object in ns?
```{r}
z=ls(getNamespace("admiral"))

c("slice_derivation") %in% z   # TRUE
```


### ds in pkg
```{r}
data()   # all loaded ds

data(package = "admiral")  # load ds in this pkg
search()

c("admiral_adlb") %in% z

library(admiral)

### char[] loaded namespaces
```{r}
loadedNamespaces()
sort(loadedNamespaces())

?loadedNamespaces
requireNamespace("teal")

```
### unloadNamespace

```{r}
unloadNamespace("teal")  # and removes search()
unloadNamespace("teal.slice")
loadedNamespaces()
search()


# put it back in.
library(teal)


```
### Given a ds, find package,  pkg must be at least loaded
```{r}
?pharmaversesdtm
?admiral

loadNamespace("pharmaversesdtm")
search()
loadedNamespaces()
data(package = "pharmaversesdtm")   # loads

?ae
help(ae)
findAnywhere("ae")

unloadNamespace("pharmaversesdtm")
```


### Given a package
```{r}

library(pharmaversesdtm)
help("ae")
data(package="pharmaversesdtm")  # many
data(package="pharmaversesdtm") |> class()   # packageIQR?

ls(getNamespace("pharmaversesdtm"))


```

?getNamespaceExports()
getNamespaceExports("dplyr") # 285
getNamespaceExports("admiral") # 285

"db_commit" %in% getNamespaceExports("admiral") # 285

get

?getNamespace
# returns named data.frame x, freq
getNamespaceExports("dplyr") %>% length()

## ?
root <- rprojroot::is_r_package
root
root$find_file()
root$find_file("DESCRIPTION")
root$find_file("09009_namespace_example.Rmd")
```

# PURPOSE:  misc tools for env, NS  (namespace)
-   getAnywhere()
-   exists()
-   makeActiveBinding
-   assign()    

##  assign variable x value in current env()
```{r}
ls()
assign("x", 10)   # x must be quoted
ls()  # x in envi
x    # 10
search()


```
## now assign higher in search()
## does not work
```{r}

x=10
assign("x", 100, "ESSR", inherits=T)
ls(parent.env(environment()))
getAnywhere(x)
search()


##    Given an object, base::getAnywhere() finds pkg, NS, and code
```{r}


utils::getAnywhere(aes)
getAnywhere(vapply)
getAnywhere(getAnywhere)
getAnywhere(.rs.restart)
getAnywhere(ae)
getAnywhere(sv)

```
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

# will not attach admiral
admiral::ae_event
search()
base::setdiff(search(),old)

##-------------------------------------
# To load AND attach
##-------------------------------------
library(tinytest)
new <- search()
```
```{r namespaces}
# show loaded 
?loadedNamespaces
loadedNamespaces()
isNamespaceLoaded("admiral")


# search vs attached?   same?
attached_pkgs  <- sub(pattern="package:", replacement="", x=search())
attached_pkgs
search()

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
