---
title:  "4020_DT_example.R"
author:  "jim"
output: 
  pdf_document:
    toc: TRUE 
		toc_depth: 2
    latex_engine: xelatex
fontsize: 10pt
geometry: margin=0.5in,top=0.25in
TAGS:  DT, tutorial, 
---


    ##  Code here is example(data.table)
    ##  STUDY:   do not run;  OUTPUT of example(data.table) 
    ##
    ##
{  ##
  # select|compute columns data.table way
  DT[, v]                        # v column (as vector)
# [1] 1 2 3 4 5 6 7 8 9

  DT[, list(v)]                  # v column (as data.table)
  #    v
  # 1: 1
  # 2: 2
  # 3: 3
  # 4: 4
  # 5: 5
  # 6: 6
  # 7: 7
  # 8: 8
  # 9: 9

  DT[, .(v)]                     # same as above, .() is a shorthand alias to list()
#    v
# 1: 1
# 2: 2
# 3: 3
# 4: 4
# 5: 5
# 6: 6
# 7: 7
# 8: 8
# 9: 9


<snip  BEGIN HERE>


DT[, sum(v)]                   # sum of column v, returned as vector
# [1] 45

DT[, .(sum(v))]                # same, but return data.table (column autonamed V1)
#    V1
# 1: 45

DT[, .(sv=sum(v))]             # same, but column named "sv"
#    sv
# 1: 45
#
tables()
}



#### CAUTION:   This changes DT (in-place) AND changes any ref to DT, NULL
{
DT[, sv := .(sum(v))]
#    x y v sv
# 1: b 1 1 45
# 2: b 3 2 45
# 3: b 6 3 45
# 4: a 1 4 45
# 5: a 3 5 45
# 6: a 6 6 45
# 7: c 1 7 45
# 8: c 3 8 45
# 9: c 6 9 45

tables()

#
# To remove  
DT[, sv := NULL]
#    x y v
# 1: b 1 1
# 2: b 3 2
# 3: b 6 3
# 4: a 1 4
# 5: a 3 5
# 6: a 6 6
# 7: c 1 7
# 8: c 3 8
# 9: c 6 9

tables()
}


#### more calculations, columns, naming, ..cols
{

DT[, .(v, v*2)]                # return two column data.table, v and v*2
#    v V2
# 1: 1  2
# 2: 2  4
# 3: 3  6
# 4: 4  8
# 5: 5 10
# 6: 6 12
# 7: 7 14
# 8: 8 16
# 9: 9 18


# subset rows and select|compute data.table way
DT[2:3, sum(v)]                # sum(v) over rows 2 and 3, return vector
[1] 5

 DT[2:3, .(sum(v))]             # same, but return data.table with column V1
#    V1
# 1:  5

 DT[2:3, .(sv=sum(v))]          # same, but return data.table with column sv
#    sv
# 1:  5


## DO NOT UNDERSTAND,   cat do not handle list()
DT[2:5, cat("v = ", v, "\n")]          # just for j's side effect
# v =  2 3 4 5 
# NULL
#
DT[2:5, .(cat(v, "\n"))]          # just for j's side effect
# 2 3 4 5 
# Null data.table (0 rows and 0 cols)


dt.tbl> # select columns the data.frame way
dt.tbl> DT[, 2]                        # 2nd column, returns a data.table always
   y
1: 1
2: 3
3: 6
4: 1
5: 3
6: 6
7: 1
8: 3
9: 6


dt.tbl> colNum = 2                     # to refer vars in `j` from the outside of data use `..` prefix

dt.tbl> DT[, ..colNum]                 # same, equivalent to DT[, .SD, .SDcols=colNum]
   y
1: 1
2: 3
3: 6
4: 1
5: 3
6: 6
7: 1
8: 3
9: 6

## better way, by name, sameas 
colV  <- c('v')
# ALL SAME
DT[, .SD, .SDcols=colV]
DT[, .SD, .SDcols=c("v")]
DT[, ..colV]
#    v
# 1: 1
# 2: 2
# 3: 3
# 4: 4
# 5: 5
# 6: 6
# 7: 7
# 8: 8
# 9: 9



DT[["v"]]                      # same as DT[, v] but much faster
[1] 1 2 3 4 5 6 7 8 9

}



#### Grouping
{ ## 
dt.tbl> # grouping operations - j and by
DT[, sum(v), by=x]             # ad hoc by, order of groups preserved in result
#    x V1
# 1: b  6
# 2: a 15
# 3: c 24

DT[, sum(v), keyby=x]          # same, but order the result on by cols
#    x V1
# 1: a 15
# 2: b  6
# 3: c 24

DT[, sum(v), by=x][order(x)]   # same but by chaining expressions together
#    x V1
# 1: a 15
# 2: b  6
# 3: c 24
}

#### simple join to subset, notation issues.
{ ## 
dt.tbl> # fast ad hoc row subsets (subsets as joins)
DT["a", on="x"]                # same as x == "a" but uses binary search (fast)
#    x y v
# 1: a 1 4
# 2: a 3 5
# 3: a 6 6
#

# ERROR, x not found
if (F) DT["a", on=x]                

if (F) DT["a", on=.x]              

# but here no problem
DT["a", on=.(x)]               # same, for convenience, no need to quote every column
#    x y v
# 1: a 1 4
# 2: a 3 5
# 3: a 6 6
#

dt.tbl> DT[.("a"), on="x"]             # same
   x y v
1: a 1 4
2: a 3 5
3: a 6 6

dt.tbl> DT[x=="a"]                     # same, single "==" internally optimised to use binary search (fast)
   x y v
1: a 1 4
2: a 3 5
3: a 6 6

dt.tbl> DT[x!="b" | y!=3]              # not yet optimized, currently vector scan subset
   x y v
1: b 1 1
2: b 6 3
3: a 1 4
4: a 3 5
5: a 6 6
6: c 1 7
7: c 3 8
8: c 6 9

dt.tbl> DT[.("b", 3), on=c("x", "y")]  # join on columns x,y of DT; uses binary search (fast)
   x y v
1: b 3 2

dt.tbl> DT[.("b", 3), on=.(x, y)]      # same, but using on=.()
   x y v
1: b 3 2

dt.tbl> DT[.("b", 1:2), on=c("x", "y")]             # no match returns NA
   x y  v
1: b 1  1
2: b 2 NA

dt.tbl> DT[.("b", 1:2), on=.(x, y), nomatch=NULL]   # no match row is not returned
   x y v
1: b 1 1

dt.tbl> DT[.("b", 1:2), on=c("x", "y"), roll=Inf]   # locf, nomatch row gets rolled by previous row
   x y v
1: b 1 1
2: b 2 1

dt.tbl> DT[.("b", 1:2), on=.(x, y), roll=-Inf]      # nocb, nomatch row gets rolled by next row
   x y v
1: b 1 1
2: b 2 2

dt.tbl> DT["b", sum(v*y), on="x"]                   # on rows where DT$x=="b", calculate sum(v*y)
[1] 25

}


#### TODO
{
dt.tbl> # all together now
dt.tbl> DT[x!="a", sum(v), by=x]                    # get sum(v) by "x" for each i != "a"
   x V1
1: b  6
2: c 24

dt.tbl> DT[!"a", sum(v), by=.EACHI, on="x"]         # same, but using subsets-as-joins
   x V1
1: b  6
2: c 24

dt.tbl> DT[c("b","c"), sum(v), by=.EACHI, on="x"]   # same
   x V1
1: b  6
2: c 24

dt.tbl> DT[c("b","c"), sum(v), by=.EACHI, on=.(x)]  # same, using on=.()
   x V1
1: b  6
2: c 24

dt.tbl> # joins as subsets
dt.tbl> X = data.table(x=c("c","b"), v=8:7, foo=c(4,2))

dt.tbl> X
   x v foo
1: c 8   4
2: b 7   2

dt.tbl> DT[X, on="x"]                         # right join
   x y v i.v foo
1: c 1 7   8   4
2: c 3 8   8   4
3: c 6 9   8   4
4: b 1 1   7   2
5: b 3 2   7   2
6: b 6 3   7   2

dt.tbl> X[DT, on="x"]                         # left join
   x  v foo y i.v
1: b  7   2 1   1
2: b  7   2 3   2
3: b  7   2 6   3
4: a NA  NA 1   4
5: a NA  NA 3   5
6: a NA  NA 6   6
7: c  8   4 1   7
8: c  8   4 3   8
9: c  8   4 6   9

dt.tbl> DT[X, on="x", nomatch=NULL]           # inner join
   x y v i.v foo
1: c 1 7   8   4
2: c 3 8   8   4
3: c 6 9   8   4
4: b 1 1   7   2
5: b 3 2   7   2
6: b 6 3   7   2

dt.tbl> DT[!X, on="x"]                        # not join
   x y v
1: a 1 4
2: a 3 5
3: a 6 6

dt.tbl> DT[X, on=c(y="v")]                    # join using column "y" of DT with column "v" of X
      x y  v i.x foo
1: <NA> 8 NA   c   4
2: <NA> 7 NA   b   2

dt.tbl> DT[X, on="y==v"]                      # same as above (v1.9.8+)
      x y  v i.x foo
1: <NA> 8 NA   c   4
2: <NA> 7 NA   b   2

dt.tbl> DT[X, on=.(y<=foo)]                   # NEW non-equi join (v1.9.8+)
   x y v i.x i.v
1: b 4 1   c   8
2: b 4 2   c   8
3: a 4 4   c   8
4: a 4 5   c   8
5: c 4 7   c   8
6: c 4 8   c   8
7: b 2 1   b   7
8: a 2 4   b   7
9: c 2 7   b   7

dt.tbl> DT[X, on="y<=foo"]                    # same as above
   x y v i.x i.v
1: b 4 1   c   8
2: b 4 2   c   8
3: a 4 4   c   8
4: a 4 5   c   8
5: c 4 7   c   8
6: c 4 8   c   8
7: b 2 1   b   7
8: a 2 4   b   7
9: c 2 7   b   7

dt.tbl> DT[X, on=c("y<=foo")]                 # same as above
   x y v i.x i.v
1: b 4 1   c   8
2: b 4 2   c   8
3: a 4 4   c   8
4: a 4 5   c   8
5: c 4 7   c   8
6: c 4 8   c   8
7: b 2 1   b   7
8: a 2 4   b   7
9: c 2 7   b   7

dt.tbl> DT[X, on=.(y>=foo)]                   # NEW non-equi join (v1.9.8+)
   x y v i.x i.v
1: b 4 3   c   8
2: a 4 6   c   8
3: c 4 9   c   8
4: b 2 2   b   7
5: b 2 3   b   7
6: a 2 5   b   7
7: a 2 6   b   7
8: c 2 8   b   7
9: c 2 9   b   7

dt.tbl> DT[X, on=.(x, y<=foo)]                # NEW non-equi join (v1.9.8+)
   x y v i.v
1: c 4 7   8
2: c 4 8   8
3: b 2 1   7

dt.tbl> DT[X, .(x,y,x.y,v), on=.(x, y>=foo)]  # Select x's join columns as well
   x y x.y v
1: c 4   6 9
2: b 2   3 2
3: b 2   6 3

dt.tbl> DT[X, on="x", mult="first"]           # first row of each group
   x y v i.v foo
1: c 1 7   8   4
2: b 1 1   7   2

dt.tbl> DT[X, on="x", mult="last"]            # last row of each group
   x y v i.v foo
1: c 6 9   8   4
2: b 6 3   7   2

dt.tbl> DT[X, sum(v), by=.EACHI, on="x"]      # join and eval j for each row in i
   x V1
1: c 24
2: b  6

dt.tbl> DT[X, sum(v)*foo, by=.EACHI, on="x"]  # join inherited scope
   x V1
1: c 96
2: b 12

dt.tbl> DT[X, sum(v)*i.v, by=.EACHI, on="x"]  # 'i,v' refers to X's v column
   x  V1
1: c 192
2: b  42

dt.tbl> DT[X, on=.(x, v>=v), sum(y)*foo, by=.EACHI] # NEW non-equi join with by=.EACHI (v1.9.8+)
   x v V1
1: c 8 36
2: b 7 NA

dt.tbl> # setting keys
dt.tbl> kDT = copy(DT)                        # (deep) copy DT to kDT to work with it.

dt.tbl> setkey(kDT,x)                         # set a 1-column key. No quotes, for convenience.

dt.tbl> setkeyv(kDT,"x")                      # same (v in setkeyv stands for vector)

dt.tbl> v="x"

dt.tbl> setkeyv(kDT,v)                        # same

dt.tbl> # key(kDT)<-"x"                       # copies whole table, please use set* functions instead
dt.tbl> haskey(kDT)                           # TRUE
[1] TRUE

dt.tbl> key(kDT)                              # "x"
[1] "x"

dt.tbl> # fast *keyed* subsets
dt.tbl> kDT["a"]                              # subset-as-join on *key* column 'x'
   x y v
1: a 1 4
2: a 3 5
3: a 6 6

dt.tbl> kDT["a", on="x"]                      # same, being explicit using 'on=' (preferred)
   x y v
1: a 1 4
2: a 3 5
3: a 6 6

dt.tbl> # all together
dt.tbl> kDT[!"a", sum(v), by=.EACHI]          # get sum(v) for each i != "a"
   x V1
1: b  6
2: c 24

dt.tbl> # multi-column key
dt.tbl> setkey(kDT,x,y)                       # 2-column key

dt.tbl> setkeyv(kDT,c("x","y"))               # same

dt.tbl> # fast *keyed* subsets on multi-column key
dt.tbl> kDT["a"]                              # join to 1st column of key
   x y v
1: a 1 4
2: a 3 5
3: a 6 6

dt.tbl> kDT["a", on="x"]                      # on= is optional, but is preferred
   x y v
1: a 1 4
2: a 3 5
3: a 6 6

dt.tbl> kDT[.("a")]                           # same, .() is an alias for list()
   x y v
1: a 1 4
2: a 3 5
3: a 6 6

dt.tbl> kDT[list("a")]                        # same
   x y v
1: a 1 4
2: a 3 5
3: a 6 6

dt.tbl> kDT[.("a", 3)]                        # join to 2 columns
   x y v
1: a 3 5

dt.tbl> kDT[.("a", 3:6)]                      # join 4 rows (2 missing)
   x y  v
1: a 3  5
2: a 4 NA
3: a 5 NA
4: a 6  6

dt.tbl> kDT[.("a", 3:6), nomatch=NULL]        # remove missing
   x y v
1: a 3 5
2: a 6 6

dt.tbl> kDT[.("a", 3:6), roll=TRUE]           # locf rolling join
   x y v
1: a 3 5
2: a 4 5
3: a 5 5
4: a 6 6

dt.tbl> kDT[.("a", 3:6), roll=Inf]            # same as above
   x y v
1: a 3 5
2: a 4 5
3: a 5 5
4: a 6 6

dt.tbl> kDT[.("a", 3:6), roll=-Inf]           # nocb rolling join
   x y v
1: a 3 5
2: a 4 6
3: a 5 6
4: a 6 6

dt.tbl> kDT[!.("a")]                          # not join
   x y v
1: b 1 1
2: b 3 2
3: b 6 3
4: c 1 7
5: c 3 8
6: c 6 9

dt.tbl> kDT[!"a"]                             # same
   x y v
1: b 1 1
2: b 3 2
3: b 6 3
4: c 1 7
5: c 3 8
6: c 6 9

dt.tbl> # more on special symbols, see also ?"special-symbols"
dt.tbl> DT[.N]                                  # last row
   x y v
1: c 6 9

dt.tbl> DT[, .N]                                # total number of rows in DT
[1] 9

dt.tbl> DT[, .N, by=x]                          # number of rows in each group
   x N
1: b 3
2: a 3
3: c 3

dt.tbl> DT[, .SD, .SDcols=x:y]                  # select columns 'x' through 'y'
   x y
1: b 1
2: b 3
3: b 6
4: a 1
5: a 3
6: a 6
7: c 1
8: c 3
9: c 6

dt.tbl> DT[ , .SD, .SDcols = !x:y]              # drop columns 'x' through 'y'
   v
1: 1
2: 2
3: 3
4: 4
5: 5
6: 6
7: 7
8: 8
9: 9

dt.tbl> DT[ , .SD, .SDcols = patterns('^[xv]')] # select columns matching '^x' or '^v'
   x v
1: b 1
2: b 2
3: b 3
4: a 4
5: a 5
6: a 6
7: c 7
8: c 8
9: c 9

dt.tbl> DT[, .SD[1]]                            # first row of all columns
   x y v
1: b 1 1

dt.tbl> DT[, .SD[1], by=x]                      # first row of 'y' and 'v' for each group in 'x'
   x y v
1: b 1 1
2: a 1 4
3: c 1 7

dt.tbl> DT[, c(.N, lapply(.SD, sum)), by=x]     # get rows *and* sum columns 'v' and 'y' by group
   x N  y  v
1: b 3 10  6
2: a 3 10 15
3: c 3 10 24

dt.tbl> DT[, .I[1], by=x]                       # row number in DT corresponding to each group
   x V1
1: b  1
2: a  4
3: c  7

dt.tbl> DT[, grp := .GRP, by=x]                 # add a group counter column

dt.tbl> DT[ , dput(.BY), by=.(x,y)]             # .BY is a list of singletons for each group
list(x = "b", y = 1)
list(x = "b", y = 3)
list(x = "b", y = 6)
list(x = "a", y = 1)
list(x = "a", y = 3)
list(x = "a", y = 6)
list(x = "c", y = 1)
list(x = "c", y = 3)
list(x = "c", y = 6)
   x y x y
1: b 1 b 1
2: b 3 b 3
3: b 6 b 6
4: a 1 a 1
5: a 3 a 3
6: a 6 a 6
7: c 1 c 1
8: c 3 c 3
9: c 6 c 6

dt.tbl> X[, DT[.BY, y, on="x"], by=x]           # join within each group
   x V1
1: c  1
2: c  3
3: c  6
4: b  1
5: b  3
6: b  6

dt.tbl> DT[, {
dt.tbl+   # write each group to a different file
dt.tbl+   fwrite(.SD, file.path(tempdir(), paste0('x=', .BY$x, '.csv')))
dt.tbl+ }, by=x]
Empty data.table (0 rows and 1 cols): x

dt.tbl> dir(tempdir())
[1] "pdf49d17e2d1b70" "Rex49d12bfedba8" "x=a.csv"        
[4] "x=b.csv"         "x=c.csv"        

dt.tbl> # add/update/delete by reference (see ?assign)
dt.tbl> print(DT[, z:=42L])                   # add new column by reference
   x y v grp  z
1: b 1 1   1 42
2: b 3 2   1 42
3: b 6 3   1 42
4: a 1 4   2 42
5: a 3 5   2 42
6: a 6 6   2 42
7: c 1 7   3 42
8: c 3 8   3 42
9: c 6 9   3 42

dt.tbl> print(DT[, z:=NULL])                  # remove column by reference
   x y v grp
1: b 1 1   1
2: b 3 2   1
3: b 6 3   1
4: a 1 4   2
5: a 3 5   2
6: a 6 6   2
7: c 1 7   3
8: c 3 8   3
9: c 6 9   3

dt.tbl> print(DT["a", v:=42L, on="x"])        # subassign to existing v column by reference
   x y  v grp
1: b 1  1   1
2: b 3  2   1
3: b 6  3   1
4: a 1 42   2
5: a 3 42   2
6: a 6 42   2
7: c 1  7   3
8: c 3  8   3
9: c 6  9   3

dt.tbl> print(DT["b", v2:=84L, on="x"])       # subassign to new column by reference (NA padded)
   x y  v grp v2
1: b 1  1   1 84
2: b 3  2   1 84
3: b 6  3   1 84
4: a 1 42   2 NA
5: a 3 42   2 NA
6: a 6 42   2 NA
7: c 1  7   3 NA
8: c 3  8   3 NA
9: c 6  9   3 NA

dt.tbl> DT[, m:=mean(v), by=x][]              # add new column by reference by group
   x y  v grp v2  m
1: b 1  1   1 84  2
2: b 3  2   1 84  2
3: b 6  3   1 84  2
4: a 1 42   2 NA 42
5: a 3 42   2 NA 42
6: a 6 42   2 NA 42
7: c 1  7   3 NA  8
8: c 3  8   3 NA  8
9: c 6  9   3 NA  8

dt.tbl>                                       # NB: postfix [] is shortcut to print()
dt.tbl> # advanced usage
dt.tbl> DT = data.table(x=rep(c("b","a","c"),each=3), v=c(1,1,1,2,2,1,1,2,2), y=c(1,3,6), a=1:9, b=9:1)

dt.tbl> DT[, sum(v), by=.(y%%2)]              # expressions in by
   y V1
1: 1  9
2: 0  4

dt.tbl> DT[, sum(v), by=.(bool = y%%2)]       # same, using a named list to change by column name
   bool V1
1:    1  9
2:    0  4

dt.tbl> DT[, .SD[2], by=x]                    # get 2nd row of each group
   x v y a b
1: b 1 3 2 8
2: a 2 3 5 5
3: c 2 3 8 2

dt.tbl> DT[, tail(.SD,2), by=x]               # last 2 rows of each group
   x v y a b
1: b 1 3 2 8
2: b 1 6 3 7
3: a 2 3 5 5
4: a 1 6 6 4
5: c 2 3 8 2
6: c 2 6 9 1

dt.tbl> DT[, lapply(.SD, sum), by=x]          # sum of all (other) columns for each group
   x v  y  a  b
1: b 3 10  6 24
2: a 5 10 15 15
3: c 5 10 24  6

dt.tbl> DT[, .SD[which.min(v)], by=x]         # nested query by group
   x v y a b
1: b 1 1 1 9
2: a 1 6 6 4
3: c 1 1 7 3

dt.tbl> DT[, list(MySum=sum(v),
dt.tbl+           MyMin=min(v),
dt.tbl+           MyMax=max(v)),
dt.tbl+     by=.(x, y%%2)]                    # by 2 expressions
   x y MySum MyMin MyMax
1: b 1     2     1     1
2: b 0     1     1     1
3: a 1     4     2     2
4: a 0     1     1     1
5: c 1     3     1     2
6: c 0     2     2     2

dt.tbl> DT[, .(a = .(a), b = .(b)), by=x]     # list columns
   x     a     b
1: b 1,2,3 9,8,7
2: a 4,5,6 6,5,4
3: c 7,8,9 3,2,1

dt.tbl> DT[, .(seq = min(a):max(b)), by=x]    # j is not limited to just aggregations
    x seq
 1: b   1
 2: b   2
 3: b   3
 4: b   4
 5: b   5
 6: b   6
 7: b   7
 8: b   8
 9: b   9
10: a   4
11: a   5
12: a   6
13: c   7
14: c   6
15: c   5
16: c   4
17: c   3

dt.tbl> DT[, sum(v), by=x][V1<20]             # compound query
   x V1
1: b  3
2: a  5
3: c  5

dt.tbl> DT[, sum(v), by=x][order(-V1)]        # ordering results
   x V1
1: a  5
2: c  5
3: b  3

dt.tbl> DT[, c(.N, lapply(.SD,sum)), by=x]    # get number of observations and sum per group
   x N v  y  a  b
1: b 3 3 10  6 24
2: a 3 5 10 15 15
3: c 3 5 10 24  6

dt.tbl> DT[, {tmp <- mean(y);
dt.tbl+       .(a = a-tmp, b = b-tmp)
dt.tbl+       }, by=x]                        # anonymous lambda in 'j', j accepts any valid
   x      a      b
1: b -2.333  5.667
2: b -1.333  4.667
3: b -0.333  3.667
4: a  0.667  2.667
5: a  1.667  1.667
6: a  2.667  0.667
7: c  3.667 -0.333
8: c  4.667 -1.333
9: c  5.667 -2.333

dt.tbl>                                       # expression. TO REMEMBER: every element of
dt.tbl>                                       # the list becomes a column in result.
dt.tbl> pdf("new.pdf")

dt.tbl> DT[, plot(a,b), by=x]                 # can also plot in 'j'
Empty data.table (0 rows and 1 cols): x

dt.tbl> dev.off()
pdf 
  2 

dt.tbl> ## Don't show: 
dt.tbl> file.remove("new.pdf")
[1] TRUE

dt.tbl> ## End(Don't show)
dt.tbl> 
dt.tbl> # using rleid, get max(y) and min of all cols in .SDcols for each consecutive run of 'v'
dt.tbl> DT[, c(.(y=max(y)), lapply(.SD, min)), by=rleid(v), .SDcols=v:b]
   rleid y v y a b
1:     1 6 1 1 1 7
2:     2 3 2 1 4 5
3:     3 6 1 1 6 3
4:     4 6 2 3 8 1

dt.tbl> # Support guide and links:
dt.tbl> # https://github.com/Rdatatable/data.table/wiki/Support
dt.tbl> 
dt.tbl> ## Not run: 
dt.tbl> ##D if (interactive()) {
dt.tbl> ##D   vignette(package="data.table")  # 9 vignettes
dt.tbl> ##D 
dt.tbl> ##D   test.data.table()               # 6,000 tests
dt.tbl> ##D 
dt.tbl> ##D   # keep up to date with latest stable version on CRAN
dt.tbl> ##D   update.packages()
dt.tbl> ##D 
dt.tbl> ##D   # get the latest devel version
dt.tbl> ##D   update.dev.pkg()
dt.tbl> ##D   # read more at:
dt.tbl> ##D   # https://github.com/Rdatatable/data.table/wiki/Installation
dt.tbl> ##D }
dt.tbl> ## End(Not run)
dt.tbl> 
dt.tbl> 
}
