---
title: " 081_basic_recursive_lists.Rmd" 
output:
  html_document:
    df_print: paged
editor_options:
  chunk_output_type: console
---

### Main example:  https://github.com/jennybc/repurrrsive
### Tidyr 1.0.0 tools to unpack nested Lists

### Reference:
	# -https://tidyr.tidyverse.org/articles/rectangle.html
	# -https://jennybc.github.io/purrr-tutorial/
	# -https://github.com/jennybc/repurrrsive
	# -https//bookdown.org/rpeng/rprogdatascience/subsetting-r-objects.html
	# 
	# [  returns object of same type, subset
	# [[, $  not so

####  01-setup
library(tidyverse)
library(purrr)
library(repurrrsive)

#### 0010_FOUR_basic_tools
l  <- list(a="1", b="2")

# length()
length(l)  #2

# names()
names(l)	# "a"  "b"

# str(object, max.level=1, list.len= 2)
str(l)

# glimpse()
tibble::glimpse(l)  # 

# TWO MORE
pluck(l,"b") # 2

l["b"]	# list (same as type l)

#### 0020_simple_lists
# PROBE - USE above tools 
l  <- list(title = "some Title")
l$title # "some Title"

l  <- list(item1 = "1", item2 = "2", item3 = "3")
l[2]    # returns list (subset)
l$item2 # "2"  value
l[[2]]  # "2"		value
pluck(l,2) # returns value

l  <- list(list("1","2","3","4"))
l[1]
l[2]   # DNE element 2

l[[1]][[4]] #4

l  <- list(items = list("1","2","3","4"))
l$items[[4]] #4


l  <- list(items = list("1",
					"2",
					 list("A","B"), 
					 list(A="100", B="200"))
)
l[1]		# subset list (in this case, whole thing)	
l$items[2:4]		# returns list (subset)

l$items[[2]] #2
l$items[[3]] # list("A","B")
l$items[[3]][[2]] # "B"
l$items[[4]]$B #200


#### 02_construct_list
level3 <- list("last", z = letters)
level2 <- list(A="second", B= level3)
level1 <- list(a="first", b= level2)


#### 03_decontruct_list

# just the letters (char[26])
level1 %>% pluck("b") %>% pluck("B") %>% pluck("z")
#
# just letter "a" (char[1])
level1 %>% pluck("b") %>% pluck("B") %>% pluck("z") %>% pluck(1)

# extract just list level2?
level1 %>% pluck("b")

# SAME as level2
level2

# also SAME as 
level1[["b"]]

# want container, too
level1["b"]

# Go crazy ...
# a few other ways to get char[26]
level1[["b"]][["B"]]$z
level1[["b"]][["B"]][["z"]]

# 024_tidyverse_str_list.R

## BELOW:  not reviewed

# see:
# https://jennybc.github.io/purrr-tutorial/ls00_inspect-explore.html

# old 024_jennny_jsonedit_repurrrsive.R_
# ---- 001 prelim ----
library(tidyverse)
library(devtools)       # install_github()
library(datasets)
# her pkg
install_github("jennybc/repurrrsive")  # many example lists?
library(repurrrsive)  # db
?repurrrsive()


# study lists?
install.packages("listviewer")
library(listviewer)
?listviewer()
# ---- 002 review str() ----

?str()  # many options
str(str)        # show object str is function
str(lm)         # function & its args

x<- rnorm(100,0,1)      # mean 0, sd=1    100 values
x
summary(x)
glimpse(x)
str(x)                  # num vector


# generate, example
gl(2, 8, labels = c("Control", "Treat"))
# generate factor levels
f<- gl(n = 40,k = 10)           # generate 40 levels, each with 10 rows
levels(f)
str(f)

str(airquality)         # df, 6 columns
# split on Month, returns list (5 months have data)
# each item in list is data.frame, 6 columns

s <- split(airquality, airquality$Month)        # split on Month

# messy
glimpse(s)
str(s)
str(s, max.level=1)     # cleaner
str(s[1])               # 1st element only, Month=5
listviewer::jsonedit(s)



# ---- 001 - trivial list ----

l <- list(a=c(1), b="jim", c=c(3,2))
str(l)
str(l[3])       # list
str(l[[3]])     # num vector
str(l[[3]][2])
# much nicer!
listviewer::jsonedit(l, mode = "view")

# ---- 002- lists she put together
# lists she has put together
wesanderson
gh_users

listviewer::jsonedit(wesanderson)


