## vim:linebreak:nowrap:nospell:cul tw=78 fo=tqlnr foldcolumn=3

title: “title” date: “last updated 22:44, 04 June 2021” output:
pdf\_document: latex\_engine: xelatex toc: TRUE toc\_depth: 1 fontsize:
12pt geometry: margin=0.5in,top=0.25in TAGS:
data.table,example,vignette, —

PURPOSE: simple, reference examples : \* nest, unnest, normalize,
list-column etc.

    # practice dt,  use function so easy to re-create
    create_dt  <- function() {
      data.table(ID = rep(c("b", "a", "c"), each = 3),
                      x = c(1, 3, 6),
                      y = 1:9)
    }
    dt  <- create_dt()
    dt
          ##    ID x y
          ## 1:  b 1 1
          ## 2:  b 3 2
          ## 3:  b 6 3
          ## 4:  a 1 4
          ## 5:  a 3 5
          ## 6:  a 6 6
          ## 7:  c 1 7
          ## 8:  c 3 8
          ## 9:  c 6 9

### Normalized!

    dt[,.SD, by=ID]
          ##    ID x y
          ## 1:  b 1 1
          ## 2:  b 3 2
          ## 3:  b 6 3
          ## 4:  a 1 4
          ## 5:  a 3 5
          ## 6:  a 6 6
          ## 7:  c 1 7
          ## 8:  c 3 8
          ## 9:  c 6 9

    # `concatinate two chr[] for each ID` (into new variable)
    dt[, .(c(x,y)), by = ID]
          ##     ID V1
          ##  1:  b  1
          ##  2:  b  3
          ##  3:  b  6
          ##  4:  b  1
          ##  5:  b  2
          ##  6:  b  3
          ##  7:  a  1
          ##  8:  a  3
          ##  9:  a  6
          ## 10:  a  4
          ## 11:  a  5
          ## 12:  a  6
          ## 13:  c  1
          ## 14:  c  3
          ## 15:  c  6
          ## 16:  c  7
          ## 17:  c  8
          ## 18:  c  9
    dt
          ##    ID x y
          ## 1:  b 1 1
          ## 2:  b 3 2
          ## 3:  b 6 3
          ## 4:  a 1 4
          ## 5:  a 3 5
          ## 6:  a 6 6
          ## 7:  c 1 7
          ## 8:  c 3 8
          ## 9:  c 6 9

    dt  <- create_dt()
    dt[,.(list(x,y))      , by=ID]
          ##    ID    V1
          ## 1:  b 1,3,6
          ## 2:  b 1,2,3
          ## 3:  a 1,3,6
          ## 4:  a 4,5,6
          ## 5:  c 1,3,6
          ## 6:  c 7,8,9


    # max packed
    dt[,.(list(c(x,y))), by = id]
          ## Error in eval(bysub, parent.frame(), parent.frame()): object 'id' not found

    # $v1 is list of 3 num[]
    str(dt[,.(list(c(x,y))), by = id]$v1)
          ## Error in eval(bysub, parent.frame(), parent.frame()): object 'id' not found

### simple: reshape, list-column

    # practice dt,  use function so easy to re-create
    create_dt  <- function() {
      data.table(ID = rep(c("b", "a", "c"), each = 3),
                      x = c(1, 3, 6),
                      y = 1:9)
    }
    dt  <- create_dt()
    dt
          ##    ID x y
          ## 1:  b 1 1
          ## 2:  b 3 2
          ## 3:  b 6 3
          ## 4:  a 1 4
          ## 5:  a 3 5
          ## 6:  a 6 6
          ## 7:  c 1 7
          ## 8:  c 3 8
          ## 9:  c 6 9

### group and head()

    # 3lines for each grouping
    dt[,.SD, by=ID]
          ##    ID x y
          ## 1:  b 1 1
          ## 2:  b 3 2
          ## 3:  b 6 3
          ## 4:  a 1 4
          ## 5:  a 3 5
          ## 6:  a 6 6
          ## 7:  c 1 7
          ## 8:  c 3 8
          ## 9:  c 6 9


    # for each ID, choose max y
    dt[, .SD[which.max(y)], by = ID]
          ##    ID x y
          ## 1:  b 6 3
          ## 2:  a 6 6
          ## 3:  c 6 9

    # here limit to 2 lines (not 3), for each grouping
    dt[,head(.SD, 2), by =ID]
          ##    ID x y
          ## 1:  b 1 1
          ## 2:  b 3 2
          ## 3:  a 1 4
          ## 4:  a 3 5
          ## 5:  c 1 7
          ## 6:  c 3 8

    # break out by ID
    dt[,print(.SD), by =ID]
          ##    x y
          ## 1: 1 1
          ## 2: 3 2
          ## 3: 6 3
          ##    x y
          ## 1: 1 4
          ## 2: 3 5
          ## 3: 6 6
          ##    x y
          ## 1: 1 7
          ## 2: 3 8
          ## 3: 6 9
          ## Empty data.table (0 rows and 1 cols): ID

    # for each grouping, show val
    dt[, .(val = y), by =ID]
          ##    ID val
          ## 1:  b   1
          ## 2:  b   2
          ## 3:  b   3
          ## 4:  a   4
          ## 5:  a   5
          ## 6:  a   6
          ## 7:  c   7
          ## 8:  c   8
          ## 9:  c   9

    # THINK
    dt[, .(val = c(x,y)), by=ID]
          ##     ID val
          ##  1:  b   1
          ##  2:  b   3
          ##  3:  b   6
          ##  4:  b   1
          ##  5:  b   2
          ##  6:  b   3
          ##  7:  a   1
          ##  8:  a   3
          ##  9:  a   6
          ## 10:  a   4
          ## 11:  a   5
          ## 12:  a   6
          ## 13:  c   1
          ## 14:  c   3
          ## 15:  c   6
          ## 16:  c   7
          ## 17:  c   8
          ## 18:  c   9

    # THINK
    dt[, .(val = list(x,y)), by=ID]
          ##    ID   val
          ## 1:  b 1,3,6
          ## 2:  b 1,2,3
          ## 3:  a 1,3,6
          ## 4:  a 4,5,6
          ## 5:  c 1,3,6
          ## 6:  c 7,8,9
    dt[, .(val = list(c(x,y))), by=ID]
          ##    ID         val
          ## 1:  b 1,3,6,1,2,3
          ## 2:  a 1,3,6,4,5,6
          ## 3:  c 1,3,6,7,8,9

### Group on ID, display list-column of data.tables!

-   make list of each SD, then list all the results

<!-- -->


    # 3 the SAME
    dt[, list(dt.xy=list(.SD)), by=ID]
          ##    ID             dt.xy
          ## 1:  b <data.table[3x2]>
          ## 2:  a <data.table[3x2]>
          ## 3:  c <data.table[3x2]>
    dt[, .(dt.xy=list(.SD)), by=ID]
          ##    ID             dt.xy
          ## 1:  b <data.table[3x2]>
          ## 2:  a <data.table[3x2]>
          ## 3:  c <data.table[3x2]>
    dt[, .(dt.xy=.(.SD)), by=ID]
          ##    ID             dt.xy
          ## 1:  b <data.table[3x2]>
          ## 2:  a <data.table[3x2]>
          ## 3:  c <data.table[3x2]>


    # FAILS b/c do not have every subset
    if (F) dt[, .(dt.xy=.SD), by=ID]

### undo/unwind list-column


    dt2  <- dt[, .(dt.xy=.(.SD)), by=ID]

    # each ID, pop off 1st entry (there is only 1)
    dt3  <- dt2[, dt.xy[[1]], by = ID]
    identical(dt,dt3)
          ## [1] TRUE

    dt[,c("ID","x","y")]
          ##    ID x y
          ## 1:  b 1 1
          ## 2:  b 3 2
          ## 3:  b 6 3
          ## 4:  a 1 4
          ## 5:  a 3 5
          ## 6:  a 6 6
          ## 7:  c 1 7
          ## 8:  c 3 8
          ## 9:  c 6 9

    # SAME, easier!
    dt[, .(ID,x,y)]
          ##    ID x y
          ## 1:  b 1 1
          ## 2:  b 3 2
          ## 3:  b 6 3
          ## 4:  a 1 4
          ## 5:  a 3 5
          ## 6:  a 6 6
          ## 7:  c 1 7
          ## 8:  c 3 8
          ## 9:  c 6 9

    # shortcut?
    col  <- c("ID","x","y")
    dt[, ..col]
          ##    ID x y
          ## 1:  b 1 1
          ## 2:  b 3 2
          ## 3:  b 6 3
          ## 4:  a 1 4
          ## 5:  a 3 5
          ## 6:  a 6 6
          ## 7:  c 1 7
          ## 8:  c 3 8
          ## 9:  c 6 9

    # FAIL
    if (F) {
      dt[, col]
      dt[, .col]
    }

    dt[, .(col)]
          ##    col
          ## 1:  ID
          ## 2:   x
          ## 3:   y

### normalize example3

-   Study NA, NULL
-   Here we will several situations to solve

<!-- -->


    #
    dt3  <- function() {
      data.table( ID = c(1,2,3,4,5,6),
          tags= list(
                     "a,b,c",
                     NULL,    # blank
                     NA,      # NA
                     x,       # NA
                     "x",
                     "y,z,NULL,NA")
          )
    }

    dt  <- dt3()
    dt
          ##    ID        tags
          ## 1:  1       a,b,c
          ## 2:  2            
          ## 3:  3          NA
          ## 4:  4         a,b
          ## 5:  5           x
          ## 6:  6 y,z,NULL,NA


    # Step 1 (remove blank)
    f  <- function(e) ifelse(is.null(e), return(NA), return(e))
    dt  <- dt[,.(ID, tags = lapply(tags, f)) ]
    dt
          ##    ID        tags
          ## 1:  1       a,b,c
          ## 2:  2          NA
          ## 3:  3          NA
          ## 4:  4         a,b
          ## 5:  5           x
          ## 6:  6 y,z,NULL,NA
    dt[is.na(dt$tags)]
          ##    ID tags
          ## 1:  2   NA
          ## 2:  3   NA
    dt[is.na(tags)]
          ##    ID tags
          ## 1:  2   NA
          ## 2:  3   NA


    # Step 2  use NA_character_ version of NA
    #base::strsplit() works with NA_character_, but not NA
    f  <- function(e) ifelse(is.character(e),return(e), return(c(NA_character_)))
    dt  <- dt[, .(ID, tags = lapply(tags, f)) ]
    dt
          ##    ID        tags
          ## 1:  1       a,b,c
          ## 2:  2          NA
          ## 3:  3          NA
          ## 4:  4         a,b
          ## 5:  5           x
          ## 6:  6 y,z,NULL,NA


    # Step 3, split and normalized
    split_up  <- function(e) base::strsplit(e, split="[,]")

    {
      # test 
    # list, with chr[]
    split_up(c("a,b,c"))
    # same
    split_up("a,b,c")

    split_up(c(NA, "b"))
    split_up(c(NA, NA, NA, "b"))
    split_up(NA_character_)
    split_up(c(NA_character_))


    # error
    if (F){
    split_up(NA)
    split_up(c(NA))
    split_up(c(NA, NA))
    }

    # remove unneeded lis
    unlist(split_up("a,b,c"))
    }
          ## [1] "a" "b" "c"


    # Line by Line, check
    # normalized! unlist
    dt[ID == "1",.(ID, tags = unlist(lapply(tags, split_up) ))]
          ##    ID tags
          ## 1:  1    a
          ## 2:  1    b
          ## 3:  1    c

    #  compare
    dt[ID == "1",.(ID, tags = lapply(tags, split_up) )]
          ##    ID      tags
          ## 1:  1 <list[1]>




    dt[ID == "2",.(ID, tags = unlist(lapply(tags, split_up) ))]
          ##    ID tags
          ## 1:  2 <NA>
    dt[ID == "3",.(ID, tags = unlist(lapply(tags, split_up) ))]
          ##    ID tags
          ## 1:  3 <NA>
    dt[ID == "4",.(ID, tags = unlist(lapply(tags, split_up) ))]
          ##    ID tags
          ## 1:  4    a
          ## 2:  4    b
    dt[ID == "5",.(ID, tags = unlist(lapply(tags, split_up) ))]
          ##    ID tags
          ## 1:  5    x
    dt[ID == "6",.(ID, tags = unlist(lapply(tags, split_up) ))]
          ##    ID tags
          ## 1:  6    y
          ## 2:  6    z
          ## 3:  6 NULL
          ## 4:  6   NA

    dt[, .(tags = unlist(lapply(tags, split_up) )), by=ID]
          ##     ID tags
          ##  1:  1    a
          ##  2:  1    b
          ##  3:  1    c
          ##  4:  2 <NA>
          ##  5:  3 <NA>
          ##  6:  4    a
          ##  7:  4    b
          ##  8:  5    x
          ##  9:  6    y
          ## 10:  6    z
          ## 11:  6 NULL
          ## 12:  6   NA

    dt
          ##    ID        tags
          ## 1:  1       a,b,c
          ## 2:  2          NA
          ## 3:  3          NA
          ## 4:  4         a,b
          ## 5:  5           x
          ## 6:  6 y,z,NULL,NA

### normalize - votes

    # each=2, each element repeated twice, before moving on.
    votes <- function() {
      data.table(issue = rep(c("issue1", "issue2"),times=1, each=2),
                 A = rep(c("Y",NA), 2),
                 B = rep(c(NA,"N"),2)
                 )
    }
    dt = votes()
    dt
          ##     issue    A    B
          ## 1: issue1    Y <NA>
          ## 2: issue1 <NA>    N
          ## 3: issue2    Y <NA>
          ## 4: issue2 <NA>    N

    dt  <- votes()
    dt_A  <- dt[!is.na(A), .(country = "A", vote=A), by = issue]
    dt_A
          ##     issue country vote
          ## 1: issue1       A    Y
          ## 2: issue2       A    Y
    dt_B  <- dt[!is.na(B), .(country = "B", vote=B), by = issue]
    dt_B
          ##     issue country vote
          ## 1: issue1       B    N
          ## 2: issue2       B    N

------------------------------------------------------------------------

    knitr::knit_exit() 
