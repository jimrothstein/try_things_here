# 057_adv_R_hadley_environment.R


#####
# 	environments
# 	http://adv-r.had.co.nz/Environments.html#environments
#####

require(dplyr)

search() # ~ 19 packages! tidyverse etc

# create new env
e <- new.env()
parent.env(e) # <environment: R_GlobalEnv>
ls(e) # character(0)

# add names and objects to new env
e$a <- 1
e$b <- "jim"
e$c <- x # error!
ls(e) # "a" "b"
ls(e, all.names = TRUE) # "a" "b"
e$b # "jim"

str(e) # <environment: 0x8cf5978>
ls.str(e)
# a :  num 1
# b :  chr "jim"

# check various environments
baseenv() # <environment: base>
globalenv() # <environment: R_GlobalEnv>
env.profile(e) # 3 lists? $size,    $nchains, $counts

# $ (this env only) vs get (climbs tree)
