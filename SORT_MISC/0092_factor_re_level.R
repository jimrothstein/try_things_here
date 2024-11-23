# ===================
# base::factor ONLY
# ===================

# NO GSS
# NO forcats:: here (see 016)

#### function Details
# =====================
details <- function(x) {
	if (!is.factor(x))	stop("x is not a factor")
	cat(" ====== ", "\n")
	cat("x = ", x, "\n")
	cat("levels(x) = ", levels(x), "\n")
	cat("labels(x) = ", labels(x), "\n")
	cat("sort(x) = " , sort(x), "\n")
	cat ("x is factor ", is.factor(x),"\n")
	cat ("x is vector ", is.vector(x),"\n")
	cat ("x is ordered", is.factor(x),"\n")
	cat ("x is class", class(x), "\n")
	cat("x is typeof ", typeof(x), "\n")
	cat("str(x) = ", str(x), "\n")
	cat("attributes(x) = ",  "\n")
	attributes(x)  # cat can't handle list?

}

# 001
B  <- 10
v <- sample(letters[1:5],B, replace=TRUE)
details(v)


v  <- factor(v)
details(v)
str(v)
attributes(v)

unclass(v) # prints, but if class were removed
class(v)
sort(v)
v

levels(v)
print(levels(v))

# new level 1, use old 4, levels(v)[4]
# new level 2, use old 5
v <- factor(v, levels(v)[c(4:5,1:3)] 
)

levels(v)
print(levels(v))
v
sort(v)


#  L O S T  !!

# SIMPLE (see r4ds Ch15-factors)
# ================================
# not in 'order'
x1 <- c("Dec", "Apr", "Jan", "Mar")
x1

# dictionary order?
month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)
x2 <- factor(x1, levels=month_levels)
x2

,
# in school year order?
school_levels <- c(
									 "Sep","Oct","Nov","Dec","Jan",
									 "Feb","Mar","Apr","May","Jun")
x4 <- factor(x1, levels=school_levels)
x4






# Structure
# ===========
structure(c(first=c("a","b"),second=c("x","y")), names =c("joe", "jim"))
as.character ("a")	
	

#### 0010_create_tibble

# use tribble
t <- tribble(
	~key, ~value,
	"A", 1,
	"A", 2,
	"A", 2,
	"B", 3,
	"B", 4,
	"C", 10,
	"C", 20,
	"C", 30,
	"C", 40
)
# make key a factor
t
t %>% mutate(key = factor(key))

# key, n=count(each key)
s <- t %>% count(key, sort=TRUE)
s
# s lost the factor!
s %>% glimpse()

# now s has factor
s %>% mutate( key = forcats::fct_reorder(key,n))

# months
# ========

t  <- tribble(
~month, ~order, ~school_order,
"JAN", 1, 5,
"FEB", 2, 6,
"MAR", 3, 7,
"APR", 4, 8,  
"DEC", 12, 4)



v <- NULL
v  <- c("Red","Blue","Blue","Green")
details(v)

v1 <-NULL
v  <- NULL
v  <- c("Red","Blue","Blue","Green")
v1 <- factor(v, levels=c("Red","Blue","Green"), ordered=TRUE)
details(v1)

v2 <- factor(v, labels=c(10,20,30))
details(v2)
sort(v2)

v
v3 <- factor(v, levels=c("Blue","Green","Red"), ordered=TRUE)
details(v3)
sort(v3)
v3

# HERE
#  integer vector
(
 academic_levels	<- c(9:12,1:8)
)
details(academic_levels)


# covert to char vector
(

 academic_levels	<- as.character(academic_levels)
)
details(academic_levels)


v <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)



v1  <- factor(v, levels  = academic_levels, ordered=TRUE)
v1
v2  <- sort(v1)
v2

# something wrong
v3  <- factor(v2, labels = v)
v3
```

```{r}

str(fdata)
typeof(fdata)
details(x = fdata) 
#
data  <- c(1,2,3,1)  # double[]

# factor
fdata <- factor(data)
fdata  # integer (internal)
levels(fdata) # char[] "1" "2" "3"
as.integer(fdata)

# factor with different labels
rdata <- factor(data, labels = c("A","B","C"))
rdata # returns A B C A
levels(rdata) # char[]  "A" "B" "C"
as.integer(rdata) # returns the internal values:   1 2 3 1

# something is happening;
levels(rdata)  <-  c("C","B", "A")
rdata
is.ordered(rdata)
is.factor(rdata)

odata <- factor(data, ordered=TRUE)
odata # displays same,   but ....
levels(odata) # same,  EXCEPT  1 < 2 <3

# HERE is difference,  odata knows 1 is lower value than 3
odata[4] < odata[3]

ldata  <- factor(data, levels=sort(unique(data), decreasing=TRUE))
ldata

sort(unique(data))   # 1 2 3
# factor:  internal stored as vector of ints
# factor:  displayed as character []


f  <- factor(c(1,2,3,3,3,2),levels=3:1)
f
typeof(f)

```
#### R INFERNO
# ==============

# R Inferno
## NOT THE SAME !
# =================

x1  <- c(1,2,3,4)
x2  <- 1:4

# look the same
x1; x2

# nope!  double vs integer!
details(x1)
details(x2)

# not!
identical(x1,x2)


# NOT Working
f.me <- function(v, .l=levels(v),.la, ordered=FALSE) {
	#rlang::track_back()
	factor(v, levels= .l, labels= .la,  ordered = ordered)
}
v  <- c("A","B","B")
levels(v) # NULL	
labels(v) # "1" "2" "3"

f.me(v)


# Blah
# ======
v  <- factor(1:4,levels=1:4,labels = 'Blah')
v
cat(v)

v  <- factor(v, levels= c("Blah4", "Blah3", "Blah2", "Blah1"),
													ordered=TRUE)
v
cat(v)
sort(v)
```


