library(data.table)
library(rrapply)
library(jsonlite)
library(listviewer)
library(tibble)


the_dir  <- "~/Downloads/to_Drive"
the_dir
the_file  <- paste0(the_dir, "/", "bookmarks-2023-01-22.json")

the_file
x  <- jsonlite::read_json(the_file)

is.list(list(x$children$children))
str(x$children[[2]], list.len=3)
z  <- rrapply::rrapply(list(x$children[[2]]),
                classes = "character",
                how  = "flatten",
                options = list(namesep=".", simplify = T)
) 

|> str(list.len=10, give.attr=F) 
z[1:30]

##	read, figure out structure, saveas df
{

##  Note  tibble's z1 and t1 are identical!
  X1  <- jsonlite::fromJSON(the_file)
  z1  <- as_tibble(X1)
  z1

X <- jsonlite::fromJSON(the_file, 
    simplifyVector = T, 
    simplifyDataFrame = T, flatten=T)

t1  <- as_tibble(X)
t1
glimpse(t1)
is.data.frame(t1)

# ----------------------------------------------------------------------------------------
t2  <- as_tibble(X$children)   # 4 x 10 (1 row each type: bookmark, toolbar, mobile....)
t2
colnames(t2)
glimpse(t2)
is.data.frame(t2)

t2$root
length(t2$children)
# ----------------------------------------------------------------------------------------
# BOOKMARKS MENU, no nested

t3  <- as_tibble(X$children$children[[1]])  # bookmarksFolder, 11 x 12 looks like singletons 
t3
glimpse(t3)
t3$title
t3$uri
t3$tags


# -------------------------------------------------------------------------------------------------------
#  BOOKMARKS TOOLBAR, has NESTED
t3  <- as_tibble(X$children$children[[2]])  # toolbar bookmarks 19 x 12 looks like singletons + children
glimpse(t3)

t3$title
t3$uri
t3$tags

##  return later, this is where recursion begins
  length(t3$children)
# [1] 19
Z = t3$children  #
length(Z)
names(Z)
Z[[1]]
# NULL

# Folder `G-`
pillar::glimpse(Z[[4]])  # G-
pillar::glimpse(Z[[4]]["children"])
pillar::glimpse(Z[[4]][1:5, "children"])
pillar::glimpse(Z[[4]][3, "children"])  # maps nonG

pillar::glimpse(Z[[5]])
pillar::glimpse(Z[[5]])
is.na(Z[[5]][1:10])
  anyNA(Z[[5]], recursive = F)

# -------------------------------------------------------------------------------------------------------
# OTHER BOOKMARKS, no nested
t3  <- as_tibble(X$children$children[[3]])  # OTHER bookmarks, all singletons 
t3
glimpse(t3)

# -------------------------------------------------------------------------------------------------------
# OTHER BOOKMARKS, no nested
t3  <- as_tibble(X$children$children[[4]])  # OTHER bookmarks, all singletons 
glimpse(t3)

# 
#-----------------------------------------------------
# next level
  # see, only elements 3,4
str(t3$children, vec.len=1, list.len=11, max.level=3)
#-----------------------------------------------------




# ------------t3$children[[3]]---------------------------------
# t3$children[[3]]  # list of 11, has children
length(t3$children[[3]])
# [1] 11
 
z <- as_tibble(t3$children[[3]])
z
z$title   # top level of bookmarks (singletons + myTech + R_program ...)

length(t3$children[[4]])
# [1] 11

# is this OTHER?
zz <- as_tibble(t3$children[[4]])
zz   # 103 x 11
as_tibble(zz$title)   # top level of bookmarks (singletons + myTech + R_program ...)



# ------------END t3$children[[3]]---------------------------------

  str(X, vec.len=1, list.len=11, max.level=3)
  X$cildren
  str(X$children, list.length=10, vec.len=2 ,max.level=1)

    str(X$children$children[[1]], list.len=12, vec.len=1, max.level =3)
    str(X$children$children[[2]], list.len=10, vec.len=2)
    str(X$children$children[[3]], list.len=10, vec.len=2)
    str(X$children$children[[4]], list.len=10, vec.len=2)

  X$children
listviewer::jsonedit(Y  <- jsonlite::fromJSON(the_file))
Y
##  R begins with 1 
  ##  Json begins with 0
# help! 
df1  <- Y$children$children[[1]]$children

df1 = Y$children$children[[1]]$children[[3]]$children[[10]]
head(df1)

df3 = Y$children$children[[3]]
head(df3)



flatten(Y$children$children[[4]])
df4 = Y$children$children[[4]]
head(df4)


View(Y)

  n=10
  str(Y, list.len=n, give.attr=F)
  m=9
  str(Y[[10]], list.len=m, give.attr=F)
Y[[10]][1:9]

  str(Y[[10]][[10]], list.len=3, give.attr=F)
  str(Y[[10]][[10]][[1]], list.len=3, give.attr=F)
  str(Y[[10]][[10]][[3]], list.len=3, give.attr=F)
##	root?
length(X)
# [1] 10
#
#

X[[1]]
X[[2]]

X[[9]]
# [1] "placesRoot"
#
X[[10]] ## huge
str(X[[10]], list.len=3, give.attr=F)
  df1  <- as.data.table(X[[10]])
  df1

## some progress here
## work on mobile first, 389 x 14
  (df2  <- as.data.table(X[[10]]$children[[4]]))
  str(df2, list.len=3, give.attr=F)
  df2[, c("uri",  "title")] |> head()


  ##  hmmm, list of 4214  
  Z= rrapply::rrapply(Y,
how="flatten",
options=list(namesep=".", simplify=F)
) 

  |> str(list.len=10, give.attr=F)
ZZ  <- as.data.table(Z)
str(ZZ, list.len=4, give.attr=F)

