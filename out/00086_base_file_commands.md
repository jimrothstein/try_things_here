

## base:: files and dir commands

## Collect HERE

### (Except package commands: see 0088)

### Includes, base commands to rename files in directory.

\#\#\#base:: commands (why use fs:: ?)

    # the_dir  <- "~/mp3/from_youtube/"
    the_dir  <- "~/mp3_files"
    pat  <-  "^_[:digit:]{5}"

    # mp3 files only, R requires \\ to create literal
    pat  <- "\\.mp3$"
    list.files(the_dir, pattern=pat)


    # files in this project
    list.files("./rmd", pattern="*.Rmd")
    list.files("./rmd", full.names = TRUE ,pattern="*.Rmd")

    if (FALSE)
      # file.rename()
      # file.create()
      # basename()
      # dirname()
      #
      # file.copy(from, to, overwrite = recursive, recursive = FALSE,
      #               copy.mode = TRUE, copy.date = FALSE)
      # list.dirs()
      # dir()
          ## Error: <text>:24:0: unexpected end of input
          ## 22:   # list.dirs()
          ## 23:   # dir()
          ##    ^

WOKRING CODE special case \* pat = "^\_\[\[:digit:\]\]{5}"


    if (FALSE ) {
      pat  <-  "^_[[:digit:]]{4,6}"
      pat  <-  "^_"
      pat <- `"^_00056"`

      pat <- "^_[[:digit:]]{5}"
    }

### Example: Use gsub to rename mp3 files

### prepend

    prepend  <- "0"
    old  <- list.files("./rmd", pattern="*.Rmd")
    new  <- paste0(prepend, old)

### sprintf has some nice features!

    sprintf("hello %s", "jim")
          ## [1] "hello jim"

    sprintf("hello %s", 23)
          ## [1] "hello 23"

    sprintf("hello %04s", 23)         # min of 4
          ## [1] "hello   23"
    sprintf("hello %04f", 23)         # 23.000000
          ## [1] "hello 23.000000"

    sprintf("hello %04i", 23)         # int, min of 4 digits
          ## [1] "hello 0023"

regex, sub(), gsub will work stringr is easier?

    the_dir  <- "./rmd"
    the_files  <- list.files(the_dir)
    the_files
          ## character(0)
    library(stringr)
    # regex
    the_prefixes  <- stringr::str_extract(the_files, "^[0-9]*[A-Z]?_" )
    the_prefixes
          ## character(0)

    knitr::knit_exit() 
