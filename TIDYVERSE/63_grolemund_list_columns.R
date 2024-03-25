# REF:  video-
# https://resources.rstudio.com/webinars/how-to-work-with-list-columns-garrett-grolemund"

library(tidyr)

#library(babynames)

x  <- c(1L, 2L, 3L)
typeof(x) # integer
# Create new data types by adding class or other attribute
# Date
# make it Date (actually S3) 
class(x)   <- "Date"

# but still integer[]
typeof(x) # STILL an integer
attributes(x) # only class




##  Array
# make an array
    a  <- array(1:8)
    a

# What is array?
  typeof(a)   # integer[]
  attributes(a) # dim: 8 
  class(a)    # array

Matrix
# array again
  a  <- array(1:8)

# make a matrix
  attr(a, "dim")  <- c(2,4)

# What is matrix?  
  typeof(a)  # integer[]
  class(a)   # matrix, array
  attributes(a) # 2, 4

matrix - slight difference
# Begin with integer[]
x  <- c(1L, 2L, 3L)


# Add attributes
  dim(x)  <- c(3,1)
  # same as
  # attr(x, "dim")  <- c(3,1)

# What is matrix? 
  typeof(x)   # STILL an integer
  class(x)    # matrix, array
  attributes(x)  #  now 3,1



## factor or categorical variable
# Begin with integer[]
  x  <- c(1L, 2L, 3L)

# Add attributes & class
  levels(x)  <- c("BLUE", "BROWN", "BLACK")
  class(x)  <- "factor"

# What is factor?
  typeof(x)   # STILL an integer
  attributes(x) # now 2!, levels and class=factor


# -------------------------------------
HOW TO MIX data types in 1 container?

use list
# Begin list of named atomic vectors.
l  <- list(a=c(1,2,3), b=c(TRUE, TRUE, FALSE	))

#  named list
is.list(l) 
names(l)

# Check
typeof(l)  # list
attributes(l) #names

##  data.frame
## data tables, is  a named LIST of vectors.
# Begin list of named atomic vectors.
  l  <- list(a=c(1,2,3), b=c(TRUE, TRUE, FALSE	))

# Add class, attributes
  class(l)  <- "data.frame"
  str(l)  # 0 rows !!
  rownames(l)  <- c("1", "2", "3") 
  str(l)  # 3 rows

# What is data.frame?
  typeof(l) # STILL a list
  attributes(l)   #names, row and class


# data.frame with list as column works, but problem
# lists ARE vectors and therefore can be  column  table. 
  l  <- list(a=c(1,2,3), b=c(TRUE, TRUE, FALSE	))
  l$d  <- list(p=1:3, q=4:5, r=c(letters[10:12]))

# Add class, attributes, as above
  class(l)  <- "data.frame"
  rownames(l)  <- c("1", "2", "3") 


# What is data.frame?
  typeof(l) # STILL a list
  attributes(l)   #names, row and class

  str(l)   # data.frame !
  l




# ----------------------------------------------------------------------
# Here's the problem:
# Did what we said, made column d list, but not so easy to manipulate.
# ----------------------------------------------------------------------




##  try again, but as tibble  - not exactly
  l  <- list(a=c(1,2,3), b=c(TRUE, TRUE, FALSE	))
  l$d  <- list(p=1:3, q=4:5, r=c(letters[10:12]))

  m  <- l

# Add class, attributes, as above
  class(l)  <- c( "tbl_df", "tbl", "data.frame")

# REPLACE:
# rownames(m)  <- c("1", "2", "3")   Depreciated
  attr(l, "row.names")  <- c("1", "2", "3") 

  typeof(l)
  attributes(l)
  l

# tibble: much better, why?
# now comes in as <named list>
# Better way
  m  <- as_tibble(m)

# What is tibble?
  typeof(m)
  attributes(m)

  m

# different row.names !
  attributes(l)$row.names
  attributes(m)$row.names


# Compare!   Tibble does it better than df.
y <- tibble(
		a = c(1.0, 2.0, 3.14),
		b = c( "a","b","c"),
		c = c(TRUE, FALSE, FALSE),
		d = list(as.integer(c(1,2,3)), TRUE, 2L)
	)
y   # note d  is a list-column

df <- data.frame(
		a = c(1.0, 2.0, 3.14),
		b = c( "a","b","c"),
		c = c(TRUE, FALSE, FALSE),
		d = list(as.integer(c(1,2,3)), TRUE, 2L)
	)
df   # note d  is a  MESS
# -------------------------------


# ---------------------------------------------
## R has tools for atomic vectors and for data tables.
## Less so for lists.
## Compare sqrt(list) just fails to purrr:map(list, sqrt) tries to convert and much more tolerant.
# ---------------------------------------------

dplyr::mutate: tibble->tibble;   
# challenge:   convert to 10 x 3 tibble, all int[]
test <- tibble(a = 1:10, b = tibble(x = 11:20, y = 21:30))
typeof(test)
str(test)

sqrt: vector -> dbl vector
y %>% dplyr::mutate(asc_a =  sqrt(a)) %>% print()
*
Error:  sqrt rejects list
y %>% dplyr::mutate(asc_d = sqrt(d) %>% print())

# - **instead**, dplyr::map applies list to sqrt, element-by-element, converts if necessary and repackages as list.
y %>% dplyr::mutate(asc_d = purrr::map(d, sqrt)) %>% print()


# ---------------------------------------------
## Babynames, filter names present every year
# ---------------------------------------------
library(babynames)
str(babynames)
everpresent <- babynames %>%
	dplyr::group_by(name, sex) %>%
	dplyr::summarize(years = n) %>%
	dplyr::ungroup() %>%
	filter(years == max(years))

## Keep all rows (and fields) in x which match group_by in y
babynames <- babynames %>%
	semi_join(everpresent)

## most popular, each year
babynames %>%
	group_by(year,sex) %>% 
	filter(prop == max(prop))
## (test)
mtcars %>%
	group_by(cyl)  %>%
	top_n(1,hp)
babynames %>%
	group_by(year,sex) %>% 
	top_n(1,prop) %>%
	arrange(desc(year))

## select joe, all years
joe <- babynames %>%
	filter(name == "Joe")
joe %>%
	ggplot(aes(x=year,y=prop)) +
	geom_point() +
	geom_line() +
	geom_smooth(method=lm,se=FALSE)


## is linear a good fit for joe?
fit <-  lm (prop ~ year, data=joe)
library(broom)
pluck(coef(fit),"year")
pluck(glance(fit), "r.squared")

@32:00
model for every name in babynames
babynames %>%
	group_by(name,sex) %>%
	nest()

retrieve Mary
babynames %>%
	group_by(name,sex) %>%
	nest() %>%
	pluck("data") %>%
	pluck(1)

use map to run lm interatively over list "data"
d<-babynames %>%
	group_by(name,sex) %>%
	nest() %>%
	mutate(model =
		   	map(data,
				 ~lm(prop ~ year, data=.x)),
		   slope =
		   	map_dbl(model,
		   			~pluck(coef(.x), "year")),
			r2 =
				map_dbl(model, 
					~pluck(glance(.x), "r.squared"))
	)
save(d,file="baby_model")


verify "Mary"

d %>% pluck("name") %>% pluck(1)
d %>% pluck("model") %>% pluck(1)
