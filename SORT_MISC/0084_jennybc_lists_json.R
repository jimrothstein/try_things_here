---
  title:" 084_jennybc_lists_json.R"
output:
html_document:
df_print:paged
editor_options:
chunk_output_type:console
---

  # 024_tidyverse_str_list.R

  ## BELOW:  not reviewed

  # see:
  # https://jennybc.github.io/purrr-tutorial/ls00_inspect-explore.html

  # old 024_jennny_jsonedit_repurrrsive.R_
  # ---- 001 prelim ----
  library(tidyverse)
library(devtools) # install_github()
library(datasets)
# her pkg
install_github("jennybc/repurrrsive") # many example lists?
library(repurrrsive) # db
?repurrrsive()


# study lists?
install.packages("listviewer")
library(listviewer)
?listviewer()
# ---- 002 review str() ----

?str() # many options
str(str) # show object str is function
str(lm) # function & its args

x <- rnorm(100, 0, 1) # mean 0, sd=1    100 values
x
summary(x)
glimpse(x)
str(x) # num vector


# generate, example
gl(2, 8, labels = c("Control", "Treat"))
# generate factor levels
f <- gl(n = 40, k = 10) # generate 40 levels, each with 10 rows
levels(f)
str(f)

str(airquality) # df, 6 columns
# split on Month, returns list (5 months have data)
# each item in list is data.frame, 6 columns

s <- split(airquality, airquality$Month) # split on Month

# messy
glimpse(s)
str(s)
str(s, max.level = 1) # cleaner
str(s[1]) # 1st element only, Month=5
listviewer::jsonedit(s)



# ---- 001 - trivial list ----

l <- list(a = c(1), b = "jim", c = c(3, 2))
str(l)
str(l[3]) # list
str(l[[3]]) # num vector
str(l[[3]][2])
# much nicer!
listviewer::jsonedit(l, mode = "view")

# ---- 002- lists she put together
# lists she has put together
wesanderson
gh_users

listviewer::jsonedit(wesanderson)
