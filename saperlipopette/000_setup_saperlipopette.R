pak::pak("maelle/saperlipopette")
library(saperlipopette)

# /tmp
parent_path <- withr::local_tempdir()


# creates file, but only has 2 of 3 items in list
path <- exo_one_small_change(parent_path)


# what's in path
fs::dir_tree(path)
#> /tmp/RtmpoAeVTm/file152cb747520d9/one-small-change
#> ├── R
#> └── bla

# "bla" is list of 2,  but I wanted list of 3
readLines(file.path(path, "bla"))

# open the bla file, add the 3rd entry

# with Git in a command line: git log
# or the gert R package
gert::git_log(repo = path)
