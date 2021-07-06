source("000_useful_functions.R")

# function with same name

# use where code (recursive)

where("mean")
find("mean")


mean  <-  function (x) x^2

find("mean")
where("mean")
# ============

# read global, can't change global
g1  <- 100
f1  <- function(x) {
	print(g1)
	g1  <- 10
}

f1(0)
g1

##
g2  <- 100
f2  <- function(x) {
	print(g2)
	g2  <<- 10
}

f2(0)
g2


# check env in debugq
x  <- 10
f3  <- function(a) {
			
			f4  <- function(b) {
				browser() # check value for x!
				x  <<- b
			}
			f4(2*a)
}
f3(20)
x

### BINDING ENV of function, aka current_env()
e1  <- env()
set_env_name(e1)
env_name(e1)

e1$g  <- function()1

# run
e1$g()
environment(e1$g) 

### EXECUTION ENV of function
h  <- function (x){
	set_env_name(current_env(), "h_env")
	browser()	
	a <- 2
	x+a}
y <- h(1)
y


### ENCLOSING ENV
plus  <- function(x) {
	
	function(y) {
	browser()	
		x+y
	}
}
# plus_one is a function 
# its enclosing env is environment of plus.

plus_one  <- plus(1)
plus_one
plus_one(3)


# Look!
global_env()
global_env()$plus
global_env()$plus_one
fn_env(global_env()$plus_one) # enclosing env is plus()!

system.time( for(i in 1:1e9) break)

e2  <- env(e1)
e2$f  <- function(name) where(name)
e2$f("g")
ls(e2)
ls(e1)
