

     vim:linebreak:nowrap:nospell:cul tw=78 fo=tqlnr foldcolumn=3 

### base:: files and dir commands

### Includes, base commands to rename files in directory.

### base:: files and dir commands

    this_file  <- knitr::current_input() 

    output_file  <- paste0("'", this_file, "'")
    print(output_file)
          ## [1] "'0086_base_file_commands.Rmd'"
    print(knitr::all_labels())
          ##  [1] "setup"             "print_labels"      "begin"            
          ##  [4] "examples_regex"    "find.package"      "prepend_file_name"
          ##  [7] "sprint"            "unnamed-chunk-1"   "examle"           
          ## [10] "special"           "unnamed-chunk-2"   "unnamed-chunk-3"  
          ## [13] "knit_exit()"       "render"

### base:: commands (why use fs:: ?)

    ##  patterns are regex

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
          ## Error: <text>:26:0: unexpected end of input
          ## 24:   # list.dirs()
          ## 25:   # dir()
          ##    ^


    if (FALSE ) {
      pat  <-  "^_[[:digit:]]{4,6}"
      pat  <-  "^_"
      pat <- `"^_00056"`

      pat <- "^_[[:digit:]]{5}"
    }

### base::find.package()

    find.package("jimTools")
          ## [1] "/home/jim/R/x86_64-pc-linux-gnu-library/4.0/jimTools"
    find.package("purrr")
          ## [1] "/home/jim/R/x86_64-pc-linux-gnu-library/4.0/purrr"


    path.package("jimTools")
          ## [1] "/home/jim/R/x86_64-pc-linux-gnu-library/4.0/jimTools"

### prepend “0” to file names (put into jimTools)

    prepend  <- "0"
    old  <- list.files("./rmd", pattern="*.Rmd")
    old
    new  <- paste0(prepend, old)
    new
    file.rename(here("rmd", old), here("rmd", new))

## sprintf has some nice features!

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

ToDO Propose new numbering prefix for all files


    OLD_NAMES  <- list.files("./rmd", pattern="^[0-9]*")
    OLD_NAMES
    the_files   <- OLD_NAMES
    N  <- length(the_files)
    N

    # remove current prefix
    the_files  <- base::sub(pattern = "^[0-9]*","", the_files)
    the_files

    # propose new prefix, min of 5 digits

    # sprintf("hello %04i", 23)         # int, min of 4 digits
    sprintf("%05i", 1:N)

    the_prefixs  <- sprintf("%05i", 1:N)
    the_prefixs

    # glue together 
    NEW_NAMES  <- paste0("./rmd/",the_prefixs, the_files)

    OLD_NAMES  <- paste0("./rmd/", OLD_NAMES)

    # change on disk
    OLD_NAMES
    NEW_NAMES
    base::file.rename( OLD_NAMES, NEW_NAMES)

### Example: Use gsub to rename mp3 files


    regex, sub(), gsub will work
    stringr is easier?
          ## Error: <text>:2:6: unexpected ','
          ## 1: 
          ## 2: regex,
          ##         ^

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
