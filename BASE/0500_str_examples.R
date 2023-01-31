####	PURPOSE:
###				Consolidate str() examples here:
###		-	basic syntax of str()
###		-	THIS IS MAIN COLLECTECTION
###		- examples drawn from elsewhere (
###
###
###		- REF https://rdrr.io/r/utils/str.html
###
###		TO DO
###		-	example from gh, VECTOR, from purrr
###

?str

##	atomic, data.frame
{
v  <- letters[1:10]
str(v)


df  <- data.frame(x=v,
									y=v,
									z=v)

df
str(df)
}

{  ##	list.len specifies number of columns of df
f  <- function(x, list.len=NULL) str(x, list.len=list.len)
f(df, 1)  # 1 col
f(df, 2)  # 2
f(df, 3)  # 3
}

##	Number of rows, specified by vec.len
f  <- function(x, list.len=NULL, vec.len=NULL, max.depth=NULL) str(x, list.len=list.len, vec.len=vec.len, max.depth=max.depth)

f(df, 3, 5) # 3 col, 1st 5 elements
f(df, 3, 2) # 3 col, 1st 2 elements
##		-----------------------------------
##

##	df more complicated



###	Giant structure, Hadley
{
hadley_repos <- jsonlite::fromJSON("https://api.github.com/users/hadley/repos")
hadley_repos


#	learn 30 x 70; list.len is # of cols
str(hadley_repos, 
		list.len=5,
		max.level=1, 
		vec.len=1      
)

f(hadley_repos, 5)

length(hadley_repos)
# [1] 78
#
str(hadley_repos, 
		list.len=78,
		max.level=1, 
		vec.len=0      
)

X=hadley_repos$topics
length(X)
str(X,
		max.level=1,
		vec.len=1
		)


#### opensecrets (error)
###
apikey  <- Sys.getenv("API_KEY")
nj  <- jsonlite::fromJSON( 
paste0("http://www.opensecrets.org/api/?method=getLegislators&id=NJ&apikey=", 
       apikey, "&output=json"))
nj


###
###
devtools::install_github("jennybc/repurrrsive")
library(repurrrsive)
data(package = "repurrrsive") # lists in new tab
browseVignettes(package="repurrrsive") # none
help.search("repurrrsive") # opens help

library(purrr)
data(package = "purrr") # none
# browser opens!
browseVignettes(package="purrr") # none
help.search("purrr") # opens help

#	-------------------------------------------
###	root object
x  <- discog

## too huge
if (F) str(x)

###	# elements
str(x, max.level=0)
# List of 155

length(x)
# [1] 155
#
#
-------------------------------------------
####	poke, each is list of 5 elments
str(x[[1]])
str(x[[2]])
str(x[[155]])


#	function to help poke!
f  <- function(x, a,b,c) {
	str(x, 
			max.level=a,
			list.len=b, 
			vec.len=c
	)

}

#	
f(x, 0,0,0)
# List of 155


#	show all 155 elements, but .. listtle of each
f(x, 1,155,1)


# now include singletons (ie to level 2)
f(x, 2,155,1)


# examine 'base_information"  a list
#
f(x = x[[1]], 1, 3, 1)

#	all elements of this x[[1]], no further
f(x = x[[1]], 1, 5, 1)


#	all 5 elment of x[[1]], but 1 level deeper
f(x = x[[1]], 2, 5, 2)


f(x = x[[1]], 3, 5, 2)

f(x = x[[1]], 5, 5, 2)

-------------------------------------------


#	assemble list of lists
A = list("one", "two")
B = letters[1:5]
C = character()
D = matrix(1:9, ncol=3)

L3 = letters[1:3]
E = data.frame(item=1:10, value=sample(L3, 10, replace = TRUE))

X = list(A,B,C,D, E)
str(X)
str(X, max.level = 0)
str(X, max.level = 2, vec.len=1)

# assign something to 3rd element
X[[3]]  <- c("hello", "bue")

#	walk the tree, find 3 element then its 2nd element
X[[c(3,2)]]


