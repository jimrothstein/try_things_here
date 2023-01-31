
SEE  https://tidyr.tidyverse.org/articles/rectangle.html
- unnest_wider
- unnest_longer
- rectangle
- hoist (drop cols, unnest others)
- gh_users
- gh_repos


### ALSO, JennyBC, Reference:
- >>Step #1  https://jennybc.github.io/purrr-tutorial/ls02_map-extraction-advanced.html
- Step #2 (if need) https://jennybc.github.io/purrr-tutorial/
- Step #3 https://github.com/jennybc/repurrrsive

####  01-setup
library(tidyverse)
library(purrr)
library(repurrrsive)  # recursive lists, R, JSON, ...
library(listviewer)   # interactive exam


##  helper?
  g <- function(x,max.level=1,list.len=3, vec.len=1, give.attr=F, ...) {
    cat("max.level=", max.level, "list.len=", list.len, "\n")
    str(x, max.level, list.len, vec.len, give.attr, ...)
  }
g(gh_repos)

# show list of datasets
data(package="repurrrsive") 

##  examine
    listviewer::jsonedit(gh_users)

is.list(gh_users),   # list of 6 users
# [1] TRUE
#
users  <- gh_users %>% tibble(user = .)


# ---------------  Optional ---------------------------------------------
##  what is users?  6 x 1 tibble, column `user` list-column of 6 elemnts
  is.tibble(users)
# [1] TRUE

  dim(users)
# [1] 6 1

  length(users$user)
# [1] 6


  # save some trial and error by focusing on column `user`
  glimpse(users$user)
  glimpse(users$user[1])


  # OR,  trial & error, but tighter control
  str(users$user, max.level=2, list.len=3)
# ------------------------------------------------------------
#
#
##  KEY STEP
##  break out list in col `user`  6 x 30,  but not normal or tidy
users %>% unnest_wider(user)

##  hoist:  select only specific cols to break out
x  <- users %>% hoist(user, 
  followers = 'followers', login = 'login', url = 'html_url')

##  everything NOT broken out (<named_list [27]) 
glimpse(x$user[[1]])


# ----------------------------- gh_repos-------------------------------
repos  <- tibble(repo = gh_repos)
repos   # tibble 6 x 1, col is <list> each row is <list[30])

# probe,  tedious till figure it out
#
##  first col, first row, 1st elent of list of 30 entries, show names
names(repos[[1]][[1]][[1]])
g(repos, max.level=2)
g(repos$repo[[1]], max.level=2, list.len=10, vec.len=2)

repos  <- repos  %>% unnest_longer(repo)  # 106  x 1

##  some probing
  repos
  str(repos$repo[[1]], list.len=10, max.level=1)


##  unnest wider, specific cols only
repos %>% hoist(repo, 
  login = c("owner", "login"), 
  name = "name",
  homepage = "homepage",
  watchers = "watchers_count"
  )



#   --------------------- LEGACY, JennyBC:  ------------------------------------------------
# ------------------------------------------------------------
#
#
#
#
#
# ---------------- LEGACY --------------------------------------------
#### 03_gh_users:   list of 6, each is list of 30 singletons
# ------------------------------------------------------------

# List of 6 unamed lists
gh_users %>% str(max.level = 1) # list of 6 lists

##  STOP
## -------------------------------------------------------------------------
##  WRONG APPROACH, might work, but ... JUMP to unnest_wider list-column,
##  tibble
##
# examine first list: list of 30 singletons
gh_users[[1]] %>% str(max.level = 1) # "gaborscardi"
gh_users[[1]]$name

x  <- gh_users[[1]]

## remove
  x$bio  <- NULL
  x$hireable  <- NULL

x
as_tibble(x)

gh_users[[1]] %>% str(max.level = 1, list.len =2) # trunc after first 2
gh_users[[1]] %>% str(max.level = 1, list.len =2) # trunc after first 2

# play -------

s <- function(t, max.level=1, list.len=2){
  t %>% str(max.level=max.level, list.len=list.len)
}
s(gh_users[[1]], 1, 2)

#   ---------------------------------------------------------------------

#### 04_exercises-set I
# 1 str()
# Practice str(x, max.level= , list.len= )
f <- function(x,i) str(x,max.level=i)
f(gh_users, 0)
f(gh_users, 1)
f(gh_users, 2)

# 2 list.len (default 99)
g <- function(x,i,j) str(x, max.level=i, list.len=j)

g(gh_users, 0, 1)
g(gh_users, 1, 1)
g(gh_users, 1, 3)

g(gh_users, 2, 3)

# play -------
# try this!
g(gh_users, 0,2)
g(gh_users, 1,2)
g(gh_users, 2,2)
map(c(0,1,2), ~g(gh_users, ., 2))

# Explain output!
l <- map(c(0,1,2), ~g(gh_users, ., 2))

# max.level (default is ALL)  
str(gh_users, list.len = 2)

# single component
str(gh_users[[5]], list.len =2)

# Exercise #3 (1, 2, 6, 18, 21, and 24)
# Find specific fields
find <- c(1,2,6,18,21,24)
gh_users[[5]][[1]]
gh_users[[5]][[2]]
gh_users[[5]][[6]]

# 3 ways to get specific fields from [[5]]
gh_users[[5]][[1:3]]
gh_users[[5]][c(1,2,6)]
gh_users[[5]][find]

# play -------
f <- function(x,i) str(x,max.level=i, list.len=2)
map(gh_users, ~f(.,c(2)))

# Exercise #4 (skip)

#### 05_Name and position shortcuts (map)

# GOAL:   extract "login" from ALL 6
# map (<list,<FUN>) -> <list>  

# SHORTCUT for applying function(x) x[["login"]], x[[18]] to each element
map(gh_users, "login")
map(gh_users, 18)

#### 06_EXERCISES
#1 - find "created_at"
names(gh_users[[5]])   # item [29]

# created at , for each user
map(gh_users, 29)
map_chr(gh_users, 29) # better (chr vector)
map_chr(gh_users, "created_at") # better (chr vector)


#2   try "fake"
map_chr(gh_users, "fake")  # nasty error

#3    try  99, outof bounds
map_chr(gh_users, 99)  # also, nasty error

#4,#5 skip


#### 07_Type-specific map
# omit (done above)


#### 08_Extract multiple values
# example, note: returns <list> 
gh_users[[5]][c(1,2,3,4)]


# 2  methods
# map(<df>, <FUN>, ...) -> <list> 
map(gh_users, `[`, c(1,2,3,4))
map(gh_users, `[`, c("id","avatar_url"))

# magrittr::extract

# JR:fix   
map(gh_users,c(2))  # each element, find 2nd element


# But!
map(gh_users,c(1,2)) #  all NULL
map(gh_users,c(c(1), c(2)) )  # NULL  
map(gh_users,c(c(1), c(2)) )  # NULL  

# Almost!
c(map(gh_users,c(1)),
  map(gh_users,c(2))
)


#### 09_map_df -> <tibble>
map_dfr(gh_users, `[`, c(1,2,3))   # note:  conversion

# 
gh_users %>% { 
  tibble(login = map_chr(., "login"),
         id    = map_int(., "id"),
         avatar_url = map_chr(.,"avatar_url")
  )
} 

# explain!
gh_users %>%  
  tibble(login = map_chr(., "login"),
         id    = map_int(., "id"),
         avatar_url = map_chr(.,"avatar_url")
  )
 


#### 10_gh_users: use_tibble_tools
# tibble 6 x 1, each item is <named list [30]>
users   <- tibble (user = gh_users)
s(users,1)
s(users, 2, 4)

# users[[1]] contents of first (and only) column: list of 6, each is list of 30
# users[[1]][1] contents of first row (of6), which is a list of 30

s(users[[1]][1],max.level= 2, list.len=10)  # first char, show first 2 levels, only 10/30 in each
# better!
s(users$user[1], 2, 10)


## best
names(users$user[[1]])

#### 11_Tidyr 1.0 break_tibble_into_multiple_column
# JennyBC written prior to Tidyr 1.0
users   <- tibble (user = gh_users)

# unnest_wider(<df>, <list-column>)
users %>% unnest_wider(user)  # 6 x 30, not normalized

#### 12_Tidyr 1.0 redo - using hoist
# put out 3 columns + last with remainer [27]
# tibble 6 x 4
users %>% hoist(user, 
  followers = "followers", 
  login = "login", 
  url = "html_url"
)

#### (JennyBC) 13_gh_repos, increase list complexity
# return to JennyBC:

##  PROBE STRUCTURE 
# user info approx 30
# repo tied to that user ~60
gh_repos %>% str(max.level=1)


# first element is list of 30; 
gh_repos[[1]] %>% str(max.level=1)

# and first of these is a list of 68, mostly singletons, some lists
gh_repos[[1]][[1]] %>% str(max.level=1)
gh_repos[[1]] %>% str(max.level=2, list.len= 3)

c <- gh_repos[[1]]

#### 15_vector_input
# "navigating"?
# Each element (total 6), check first element (out of 30), and third element (of 68)
map_chr(gh_repos, c(1,3))  # <chr_vector>
map(gh_repos, c(1,3)) # <list>



# each user has multiple repositories
# still tibble of 6 x 1, but each row list of variable length (# reposit)
repos <- tibble(repo = gh_repos)
repos


length(repos$repo[[1]])  # 30

# each user (login) has mulitple.....
# but ...  each row is list of 30, containng a list of68
s(repos$repo[[1]], 2, 2)
s(repos$repo[[2]], 2, 2)

#### 15_vector_input_EXERCISe
# ain't easy
# for each of 6 users, choose 1 repo (of 30), then 4th element of 68 ($owner), then 1st ($login)
map_chr(gh_repos,
        c(1,4,1))


# work!!
h <- function(x,s)x[[1]][[1]][[4]][[s]]
h(gh_repos, 1)
h(gh_repos, "login")

g <- function(x,s)x[[1]][[1]][[4]]$login
g(gh_repos) 



# nope
map_chr(gh_repos,
        c(1,4,"login"))


#### 14_tidyr - easier

# hoist(<tibble>, <list-column>, <specifc name>) -> <tibble> with <list_c

repos <- tibble(repo = gh_repos)

# each user has up to 30 repos, we want list of all the repos
unnest_longer(repos, repo)

repos %>% unnest_longer(repo) %>% 
  hoist(repo, 
  login = c("owner", "login"), 
  name = "name",
  homepage = "homepage",
  watchers = "watchers_count")

repos %>% 
  hoist(repo, owner = "owner")

knitr::knit_exit()

