# given a dataset, ds

help("mtcars")
help(mtcars)

# load a ds  (NOT recommended) use library() to load
data(<ds>)

# What package?     (pkg must be loaded)
getAnywhere("mtcars")
getAnywhere("ae")
?getAnywhere

find("mtcars")
find("ae")
# also find functions
find("mean")
find("sd")


# Given a pkg, find ds
data(package="admiral")
data(package = "admiraldev")
data(package = "datasets")
data(package = "pharmaversesdtm")


# list All datasets in loaded pkgs
?data
data()
