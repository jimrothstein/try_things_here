

#### Package Info ?   See jimTools.
###  Sat  15 May 2021, This file 085 is MESS.
  *  sort out :  useful vs not
  *  sort out:  base vs add-on package
  *  Much good info here, but needs update!


##  Mon 20Feb2023
TODO

- CLEAN UP, so mostly BASE tools, R ENV 
- PUT non-BASE, tidyverse, etc.  into separate file, OR clearly separate
##  PURPOSE:    use BASE 


library(tibble)
library(tidyr)
library(purrr)
library(dplyr)
library(magrittr)

# list packages  .. anything to remove?
devtools::session_info(c("tidyverse"))

lobstr::mem_used()/1e6
xfun::is_unix()
system.time vs proc.time()
# returns dbl[3]
system.time( r  <- rnorm(1000))
  {
    begin  <- proc.time()
    r  <- rnorm(1000)
    end  <- proc.time() - begin
    end
  }

## ENV variables
*  See: https://stat.ethz.ch/R-manual/R-devel/library/base/html/EnvVar.html

# /usr/lib/R
(r_home <-R.home(component="home"))
Sys.getenv("R_HOME") 			# /usr/lib/R ; where R installed
Sys.getenv("R_LIBS_USER") # ~R/x86 .../4.0
Sys.getenv("R_HIST_SIZE")
Sys.getenv("R_BROWSER")   # croutonurlhandler

# too lengthy
if  (FALSE) Sys.getenv()		

# search(), vector: gives all env + attached pkgs
(t_search <- search())

file.exists(
  file.path(r_home, 
  "etc", 
  "Rprofile.site")
)	

file.exists("~/dotfiles/.Rprofile")                     # TRUE
file.exists("~/.Rprofile")

file.exists(file.path(r_home, "etc", "Renviron.site"))  # TRUE,empty
file.exists("~/dotfiles/.Renviron")                     # TRUE
file.exists("~/.Renviron")                     # TRUE

options()
# options() (returns <list>)
# Tibble 87 x 2.  values is list-column.
# Goal:  longer tibble, with 1 row for each value

l  <- options()
# find TRUE



Versions

packageVersion("rmarkdown") # 2.20
R.version.string     # 3.5.1
getwd()                 # ~/code/r_
list.files()            # list filesin wd
dir()
Dependncies
TODO:   utils::depends(pkg =  c(), dependencies=c ())

# For each installed pkg, find its dependencies
#### return list of character vectors, ~15,293 
	
l <- tools::package_dependencies(
							"tibble",
							db=installed.packages(),
							reverse=TRUE	)
l

# And "tibble" is dependenat upon:
l <- tools::package_dependencies("tibble", reverse=FALSE)
str(l) # named list, 1 elemnt named tibble,  a chr[12]
l

t  <- tibble(pkg=l$tibble)
t
##### 010-for <pkg>, find packages dependent upon it

if (FALSE) remove.packages("cellranger")






#### 016_Internactive session?
base::interactive() #### TRUE (run a line at a time) 

#### 017_R_LIBS_USER
Sys.getenv("R_LIBS_USER")

#### OR, 1st element of 
.libPaths()

#### 018_List all files in project/pkg
#### current dir
base::dir()
base::dir(recursive = TRUE)  #### recurse directories
base::dir(all.files = TRUE)	 #### include hidden

#### examine project (source) directory
base::dir(path = "../r_mp3_files/", all.files = TRUE)	 #### include hidden

base::dir(path = "../r_mp3_files/", all.files = TRUE, recursive = TRUE)	 #### includ directories 


R help
# REF https://csgillespie.github.io/efficientR/set-up.html

?mpg   # mpg is dataset (if loaded)
?stats  # package
?reprex # function
?ggplot   # function
??reprex  # topic
??ggplot   # topic 
??pch      # topic 
??regression

help.search("pch")  # long form


# returns named named chr[]: attr(l, "names")
l  <- Sys.info()  # Linux 4.4.52 - ....
t  <- tibble(name = names(l),
							value = l)


list.files(all.files = TRUE) # show hidden too

# ---- 001 monitor -----
# BIG

elements <- 1e8   # 1e9 and laptop crashes, rebootsS
X <- as.data.frame(
        matrix(rnorm(elements), nrow=elements/10)
)

r1 <- lapply(X,median)

r2 <- parallel::mclapply(X, median)



# ---- 002 update  all R packages ----
#update.packages(ask = FALSE)


# ----  003 view all installed R packages? ----
# at cmd line  which needed?
# apt-get cache search "^r-*" | sort





file.exists("~/.Rprofile") # True, also

options()
# 2 sign digits  (3.7)
options(prompt = "R> ", digits = 2, show.signif.stars = FALSE, continue = "  ")

getOption("repos")  # cran.rstudio.com

# fortunes::fortune(50)  # error
.Last = function() {
        
        message("Goodbye at ", date(), "\n")
}
.Last()


##  old 0514_R_ENV variables
 includes:  021_efficient_coding	

### PURPOSE:  understand how R uses options() and Sys.getenv()
###  Uses of Sys.getenv() and options()
knitr::opts_chunk$set(echo = TRUE, 
                      comment = "        ..##")


library(tibble)
library(tidyr)
library(dplyr)
library(magrittr)
library(xfun)

## R environment variables
*  See: https://stat.ethz.ch/R-manual/R-devel/library/base/html/EnvVar.html
*  get/set , listing, searching for 


### examine Sys.getenv()

l  <- c("R_HOME", "R_LIBS_USER", "R_HIST_SIZE", "R_BROWSER")
sapply(l, Sys.getenv)

.libPaths()



# examine character vector
x  <- Sys.getenv()

library(data.table)
dt  <- data.table(x)
dt[1:5,]



## grep on names of R environment variables. 
grep(x=names(Sys.getenv()),
     pattern = "dirs",
     value=TRUE,
     ignore.case=TRUE)


# get elment #
n  <- grep(x=names(Sys.getenv()),
     pattern = "dirs",
     value=FALSE,
     ignore.case=TRUE)
# display
Sys.getenv()[n]


# for "libs"
n  <- grep(x=names(Sys.getenv()),
     pattern = "libs",
     value=TRUE,
     ignore.case=TRUE)
Sys.getenv()[n]





#### 4-.libPaths(), list all paths, purpose, name

.libPaths()
# fix:

# t_libPaths <- tibble(.libPaths()) %>% 
#   mutate(
#   purpose =  c("added packages", 
#                ".Library.site", 
#                ".Library.site", 
#                "base R pkgs"),  
# 
#   quantity  = c("many", "Empty", "Empty", "many")  ,
#   env_var = c("R_LIBS_USER","","","R_LIBS?"),
#   aka = c("",".Library.site", ".Library.site", ".Library.site, .Library"))
# 
# t_libPaths

## Each path in .libPaths(), list installed packages

.Library
if (FALSE)
  .Library
  lapply(.libPaths(), list.dirs, recursive=FALSE)



### Session_info

# yihui's improved
xfun::session_info()

# note:  results is S3 object
(z  <- utils::sessionInfo())
sloop::otype(z)
# methods that handle this object?
sloop::s3_methods_class(z)

# stack is generic function for object z



session_info()





## R help
# REF https://csgillespie.github.io/efficientR/set-up.html

?mpg   # mpg is dataset (if loaded)
?stats  # package
?reprex # function
?ggplot   # function
??reprex  # topic
??ggplot   # topic 
??pch      # topic 
??regression

help.search("pch")  # long form


## R Startup

# In this order, R seeks .Rprofile $R_HOME, $HOME, project directory
?Startup
R.home() 
site_path = R.home(component = "home") # 
fname = file.path(site_path, "etc", "Rprofile.site") # /usr/lib/R/etc/Rprofile.site

file.exists(fname) # True


## .Rprofile

file.exists("~/.Rprofile") # True, also

options()
# 2 sign digits  (3.7)
options(prompt = "R> ", digits = 2, show.signif.stars = FALSE, continue = "  ")

getOption("repos")  # cran.rstudio.com


# -----------------------------jennyBC ------------------------------------------------------------------
##### 013_jennyBC
####  from https://github.com/smithjd/explore-libraries/blob/master/01_explore-libraries_jenny.R
ipt <- installed.packages() %>%
  as_tibble()

installed_pkgs  <- ipt %>% select("Package")
print(installed_pkgs, n=200)

ipt %>% glimpse()
nrow(ipt)
dim(ipt)

####' 014_Exploring the packages

####   * tabulate by LibPath, Priority, or both
#### base: 14, recommended:15, my library:165
ipt %>%
  count(LibPath, Priority)

####   * what proportion need compilation?
####   2nd line produces 3 rows x 2 (NeedCompliation n)
ipt %>%
  count(NeedsCompilation) %>%
  mutate(prop = n / sum(n))

#### 015_remove pkg
# uninstall()  vs remove.packages() ??
#### Find (and remove) package BH (it is gone!)
ipt %>% filter(Package=="BH") 

uninstall(BH)




# -----------  Useful tidyverse code:  probe options() --------------------------------------------
#
l  <- options()
##  remove functions
l2  <- purrr::discard(l, ~is_function(.x))
l2
##  find lanuage
l3   <- purrr::discard(l2, ~(typeof(.x) == "language"))
length(l3)

l3[31:40]
l  <- l3
t <- tibble(name = names(l), values = l)
map(t$values, ~typeof(pluck(1)))
t$typeof  <- typeof(pluck(t$values, 1)) 
head(t)

# Problem, options()[[5]] is 'closure' and not a vector, list.
t %>% tidyr::unchop(values)

options() %>% dplyr::filter(rlang::is_list(values))


typeof(options()[[5]])
t %>% unchop(values)


typeof(pluck(t,2,1))
typeof(pluck(t,2,2))
typeof(pluck(t,2,5))
pluck(t,2,5)
pluck(t,2,10, 1)
pluck(t,2,10, 1)

#### TODO
t %>% tidyr::unnest_wider(options)
tidyr::unnest_auto(t, options)

#### another way
l  <- options()
names(l) #88

#### find element of vector
l["warning.length"]
l["pdfviewer"]	  # /usr/bin/xdg-open
l["keep.source"]  # TRUE
l["browser"]	 # croutonurlhandler





# ----------------   more tidyverse--------------------------------------------
library(tidyverse)
l <- options() %>% 
  list() %>% 
  tibble() %>% 
  unnest_longer(1,indices_to = "option",values_to = "value")
l
library(tibble)
library(purrr)
options()
# list  -> nested tibble?
t  <- tibble::enframe(options())
head(t)

l  <- map(t$value, ~typeof(.))
l[41:60]
c   <- map_chr(t$value, ~typeof(.))
c
# add column for typeof
t$c  <- c
head(t)

# examine t$value[[5]] # closure
t$value[[5]]


# make it expr
z  <- rlang::expr(t$value[[5]])
# return original state 
eval(z)

# easier?
get_typeof  <- function(o) {
  typeof(o)}
get_typeof("a")
get_typeof(z)
get_typeof(t$value[[5]])
get_typeof(function(x) {x})  # closure

map_chr(t$value, ~get_typeof(.))


#
# define process!
# process  <- function(type){
#   if (type == logical)
#   if (type == closure)
#     ...
# 
 
map(t$value, ~process)
t$value[[1]]
