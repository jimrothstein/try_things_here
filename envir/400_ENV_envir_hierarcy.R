# ~/code/MASTER_INDEX.md
# file="/home/jim/.config/nvim/templates/skeleton.R"

### CAUTION
#'  rlang uses env();   base uses new.env()
###  remove rlang
      detach(name="package:rlang", unload=T)
/*
     Environments consist of a _frame_, or
     collection of named objects, and a
     pointer to an _enclosing
     environment_.  The most common
     */

#+ simple_env
```r
E1  <- new.env()
E2  <- new.env()
ls()   # E1 E2

# 
environment(E2)  <- E1
environment(E2)  
ls()

# put something in E2
E2$a  <- 1
ls(E1)
ls(E2)
```

### What does parent.env() do?

/*
     ‘parent.env’ returns the enclosing
     environment of its argument.
     */

```r
parent.env(E1)     # global()
parent.env(E2)     # same
parent.env(.GlobalEnv)   # next pkg in search()
```



```r
### Create E3
E3  <- new.env(parent = E2)
# <environment: 0x558f0f268fb0>

### Create E4
E4  <- new.env(parent = E3)
# <environment: 0x558f0f27fd78>


my_ancester  <- function(e = NULL) {
  parent.env(e)
}
```

#### Explain !
my_ancester(E1)
my_ancester(E2)
my_ancester(E3)
my_ancester(E4)


ls_objects  <- function(e = NULL) {
  ls(e)
}
lapply(1:4, function(e) {
    ls(paste0("E", e ))
    }
)

ls_objects(E2)
ls_objects(E3)
ls_objects(E4)



#
#
#
#
#
#
### LOST
/*
     ‘sys.parent’ returns the
     number of the parent frame if ‘n’ is
     1 (the default), the grandparent if
     ‘n’ is 2, and so on.  See also the
     ‘Note’.
*/
sys.parent()
is.environment(sys.parent())
# [1] FALSE
#
sys.parent(n=1) 

/*
     ‘parent.frame(n)’ is a convenient
     shorthand for
     ‘sys.frame(sys.parent(n))’
     (implemented slightly more
     efficiently).
*/
/*
     The parent frame of a function
     evaluation is the environment in
     which the function was called.  It is
     not necessarily numbered one less
     than the frame number of the current
     evaluation, nor is it the environment
     within which the function was
     defined.  
*/
### What does parent.frame() do?
parent.frame()
parent.frame(E1)

