## 060_here_examples.R

# 
#  start  ---------------------------------
library(here)
##	not completely sure I understand benefit

# supposed to "find" root directory of project
# by finding .Rproj or .here file

here()	# should return prject "root"	

# details
dr_here()

# Examples work IF descending  -------------------------------

# construct and display a relative path (from 'root')
here("data_norm", "ALL_lab_data.csv") # constructs correct path, from root	

# example -----------------------------------

dir()   # list files in working dir.

# this lists files in dir pdf/ relative to root
dir(here("pdf/"))
dir(here("pdf"))

# example files in source pkg ---------------
here("~/code/r_mp3_files/")   # FAILS! can't go up

# i dunno
set_here(path = "~/code/r_mp3_files")
here()

#  compare to -------------------------------

# but I think, just as easy (and clear)
# not run
result <-read_csv("./data_norm/ALL_lab_data.csv")


