#
#  Purpose:   Want to test if 2 files *.rda in different directories are the SAME?

#  load:  has sideeffect of putting object into Globalenv;  so one load clobbers prior one.
#  WORKAROUND:   load allows user to select which envir to put the object into. 

# Tags:   load, environment, rda,


# snippet:   2 files, same name, differnt directories, same?
# Load stored objects into environments
# Because `load` places objects in current environment, put old_data in a new environment

# loads into global
load("data/example_qs.rda")

# but this load puts into different env
e <- new_environment()
load("old_data/example_qs.rda", envir = e)


# Now can compare 
identical(example_qs, e$example_qs)

# cleanup: remove e
rm(e)
