# 024_purrr_c_wickham

# keywords:  subset, vector, lists

#https://channel9.msdn.com/Events/useR-international-R-User-conferences/useR-International-R-User-2017-Conference/Solving-iteration-problems-with-purrr


# ---- 000-begin ----
library(purrr)
library (devtools)

# her pkg
install_github("jennybc/repurrrsive")  # many example lists?
library(repurrrsive)  # db

# 000-show datasets ----
data(package = "repurrrsive") # lists in new tab
browseVignettes(package="repurrrsive") # none
help.search("repurrrsive") # opens help


# ---- 001-vector practice ----
# vectors, atomic or lists (either can be named or not) 
v <- c(a = 100, b = 200, c = 300) # double[]

# [ returns subset, vector for v
v[2]  # 200
v[b]  # error
v['b'] # 200
typeof(v['b']) #, double[]
v[c("a","c") # double[]]

# ---- 001A-list practice ----
l <- list(a=c(1,2,3),
          b=c("jim", "joe", "john"),
          c=data.frame(col1= rnorm(5),
                              col2=rnorm(5)+1,
                              col3=rnorm(5)+2 )
)
typeof(l)	# "list"
l[[1]]
l[[2]]
l[[3]]
str(l[[3]])
dim(l[[3]])

l[[3]][[3]]
l[[3]][[3]][[1]] # 4.314267  element [1,3] of c

#-----------------
# 001A_more_practice
#-----------------

# [] returns subset (ie same typeof)
# [[]] returns content 
l  <- list(red = 1:4, blue = c(1,2,3), green= list(dark_green=c("a","b")))
  
# l is list, all return list, a subset of l
l["red"] # return list
l["blue"] # return list
l["green"]	# return subset of l,  list.     This contains inner list.


# return contents, could be anything
l[["red"]]	# return contents, a int[]
l$red # return contents, a vector
l[["green"]] # return contents, a list in this case

# -----002-examine sw_people ----

class(sw_people)        # list
class(sw_people[1])     # list
class(sw_people[[1]])   # list
str(sw_people[[1]])
dim(sw_people[[1]])     # NULL
sw_people[[1]]          # 1st person
sw_people[[2]]          # 2nd person

print(sw_people[[1]]$films) # 3 films??
length(sw_people)       # 87 objects
str(sw_people, max.level = 1)  #87 objects

sw_people[1]          # 1 list object
sw_people[[1]]          # contents
length(sw_people[[1]])  # 16

# ---- 003-# starships for each person ----

# for sw_people[[1]], luke
length(sw_people[[1]]$starships) #2
sw_people[[1]]$starships # 12, 22

luke <- sw_people[[1]]

# starships
length(sw_starships)  # 37 elements, 

# for each of 87 ppl, find  number elments in $starship
# as formula: ~length( .x$starships)
map(sw_people, ~length( .x$starships))

# lookup
planet_lookup <-
        map_chr(sw_planets, "name")    %>%
                set_names(map_chr(sw_planets, "url"))
planet_lookup
typeof(planet_lookup)  # character
is_list(planet_lookup) # FALSE
is_atomic(planet_lookup) # TRUE
is_character(planet_lookup) # TRUE
# 2 ways to get same:
planet_lookup[1]   # Alderaan
planet_lookup["http://swapi.co/api/planets/2/"] # Aldernaan
planet_lookup["Alderaan"]  # NA

str(planet_lookup)  # named vector, url:name


luke$homeworld   # "http://swapi.co/api/planets/1/
planet_lookup[luke$homeworld]

# get homeworld for EACH of 87 people
hw <- map(.x=sw_people,
    .f=~planet_lookup[.x$homeworld]) # finds planet by url
is_list(hw) # TRUE
is_vector(hw) # TRUE
is_atomic(hw) # FALSE


sw_planets    # list of  61 elements

sw_people
m <- as.numeric(map(sw_people, ~.x$mass))  # remove non-numeric
m
h <- as.numeric(map(sw_people, ~.x$height))
bmi <- m/(h**2)
bmi
# ---- 004 - homeworld for each ----
sw_people[[1]]$homeworld   #  planet 1
l<-map(sw_people, ~.x$homeworld)

# ---- 005 -name each element, 87
sw_people[1] # works
sw_people["Luke Skywalker"]  # error

new_people <- sw_people %>% set_names(map_chr(.x=sw_people,.f="name"))
str(new_people, max.level = 1)  # names!

new_people[1]
new_people["Luke Skywalker"]  # yes!


