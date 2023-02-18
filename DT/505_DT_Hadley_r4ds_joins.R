
---
title: "`r knitr::current_input()`"
date: "`r paste('last updated', 
    format(lubridate::now(), ' %d %B %Y'))`"
output:   
  html_document:  
        code_folding: show
        toc: true 
        toc_depth: 4
        toc_float: true
  pdf_document:   
    latex_engine: xelatex  
    toc: true
    toc_depth:  4   
fontsize: 11pt   
geometry: margin=0.4in,top=0.25in   
TAGS:  
---
~/code/MASTER_INDEX.md
file="/home/jim/.config/nvim/templates/skeleton.R"

# R
# (19APR 2022 -  r4ds now uses dplyr; no sign of data.table )
#https://r4ds.had.co.nz/relational-data.html#understanding-joins
#
#
#			NOTES:    
#			nomatch=NULL (0 for backward) means inner join. if row i has no match;
#			then no row appears.
#
#			nomatch=NA means row is returned, but value reported as NA.
#
#			?data.table is good.
#
library(data.table)

# id, not key b/c table not keyed.
# A, B refer to datatables
A  <- data.table(id=c(1,2,3), x_val = c("x1", "x2", "x3"))
#    id x_val
# 1:  1    x1
# 2:  2    x2
# 3:  3    x3
#
B  <- data.table(id=c(1,2,4), y_val = c("y1", "y2", "y3"))
#    id y_val
# 1:  1    y1
# 2:  2    y2
# 3:  4    y3
#
#
#
## inner join:  (equi-join)  B inner join A
## OBSERVE:   selecting all from B where `nomatch=0` demands a match
A[B, on="id", nomatch=0]
#    id x_val y_val
# 1:  1    x1    y1
# 2:  2    x2    y2


# But this is not quite inner join. (b/c returns a no-match)
# B right join A
# SAME:
A[B, on="id"]
A[B, on = .(id ==id)]
#    id x_val y_val
# 1:  1    x1    y1
# 2:  2    x2    y2
# 3:  4  <NA>    y3
#
#
#		Why fail?
# A[B, on = .(A$id ==B$id)]
#
B[A, on="id"]  # A right join B
#    id y_val x_val
# 1:  1    y1    x1
# 2:  2    y2    x2
# 3:  3  <NA>    x3
#
#
# =========================
#				FOLLWING is sequence (see below for my !so post)
# =========================
#
packageVersion("data.table") #1.14.3

A[B, on="id"]
#    id x_val y_val
# 1:  1    x1    y1
# 2:  2    x2    y2
# 3:  4  <NA>    y3
#

# Add column for both id's to see what's going on. 
A[B, .(A.id = A$id, B.id = B$id), on="id"]
#     A.id  B.id
#    <num> <num>
# 1:     1     1
# 2:     2     2
# 3:     3     4


# i.VARIABLE   refers to columns of table B in  A[B]
#
A[B, .(B.id = B$id), on="id"]
A[B, .(B$id), on="id"]  #SAME, except col name
A[B, .(i.id), on="id"]  #SAME, except col name
#     B.id
#    <num>
# 1:     1
# 2:     2
# 3:     4
#
A[B, .(i.id, i.y_val), on="id"]  #SAME, just add columsn

# why is A.id match?
A[B, .(A.id = A$id, A$x_val, B$id, B$y_val), on="id"]
#       V1     V2    V3     V4
#    <num> <char> <num> <char>
# 1:     1     x1     1     y1
# 2:     2     x2     2     y2
# 3:     3     x3     4     y3
A[B, .(id, A.id = A$id, A$x_val, B$id, B$y_val), on="id"]
# Remove the row without match.
#
A[B, on="id", nomatch=NULL]
A[B, on=.(id == id), nomatch=NULL]  # SAME
# FAIL A[B, on=.(B$id == A$id), nomatch=NULL]  # SAME
#    id x_val y_val
# 1:  1    x1    y1
# 2:  2    x2    y2
#

#
#


A[B, .(A$id, B$id), on="id", nomatch=NULL]



# WHY 3 rows?  Compare to ** (above)
A[B, .(B.id = B$id), on="id", nomatch=NULL]
A[B, .(B.id = B$id), on=.(id), nomatch=NULL]
A[B, .(B$id), on=.(id), nomatch=NULL]  # SAME exept col Name

## FAIL
# A[B, on=.(A$id == B$id), nomatch=NULL]
# A[B, on=.(B$id == A$id), nomatch=NULL]
#     B.id
#    <num>
# 1:     1
# 2:     2
# 3:     4
A$id
B$id
# do not understand - isn't this inner join?
A[B, .(A.id = A$id, B.id=B$id), on="id", nomatch=NULL]
#     A.id  B.id
#    <num> <num>
# 1:     1     1
# 2:     2     2
# 3:     3     4

#  Don't understand 
A[B, .(A.id = A$id, A.x = A$x_val, B.id = B$id, B.y = B$y_val), on= "id", nomatch=0]
#    V1 V2 V3 V4
# 1:  1 x1  1 y1
# 2:  2 x2  2 y2
# 3:  3 x3  4 y3
#
# same:
A[B, .(A.id = A$id, A.x = A$x_val, B.id = B$id, B.y = B$y_val), on= "id", nomatch=NULL]
#     A.id    A.x  B.id    B.y
#    <num> <char> <num> <char>
# 1:     1     x1     1     y1
# 2:     2     x2     2     y2
# 3:     3     x3     4     y3

# ===========================
## 13.4.4 Matching when duplicates
# ===========================
## (Hadley says keys, but again table are not
##    keyed)   So this is 1:n 
##
##
# TODO  ...look at column names (not want want ! EXPLAIN)
A   <- data.table(id  <- c(1,2,2,1),x  <- c("x1", "x2", "x3", "x4")) 
A

# This is what we want.
A   <- data.table(id = c(1,2,2,1),x  = c("x1", "x2", "x3", "x4")) 
#    id  x
# 1:  1 x1
# 2:  2 x2
# 3:  2 x3
# 4:  1 x4
B   <- data.table(id = c(1,2), y = c("y1", "y2"))
#    id  y
# 1:  1 y1
# 2:  2 y2
#
# INNER JOIN, what will we get?
# id is from A
B[A, on = .(id)]
#    id  y  x
# 1:  1 y1 x1
# 2:  2 y2 x2
# 3:  2 y2 x3
# 4:  1 y1 x4


# now match on id from B, Select from B where id=id
A[B, on = .(id)] 
#    id  x  y
# 1:  1 x1 y1
# 2:  1 x4 y1
# 3:  2 x2 y2
# 4:  2 x3 y2

# ======================================================================
#		!so
#  I am adding columns to an inner join and not understanding the result.
# ======================================================================

#  I am adding columns to an inner join and not understanding the result.
#
Consider tables A,B:

A  <- data.table(id=c(1,2,3), x_val = c("x1", "x2", "x3"))

#    id x_val
# 1:  1    x1
# 2:  2    x2
# 3:  3    x3
#
B  <- data.table(id=c(1,2,4), y_val = c("y1", "y2", "y3"))

#    id y_val
# 1:  1    y1
# 2:  2    y2
# 3:  4    y3
#
# rows=3 This join is what I expect.  The last row of B is included, but A has match. 
A[B, on=.(id)]
#       id  x_val  y_val
#    <num> <char> <char>
# 1:     1     x1     y1
# 2:     2     x2     y2
# 3:     4   <NA>     y3
#
#	rows=2 To remove the umatching row use nomatch=NULL (ie inner join)
A[B, on=.(id), nomatch=NULL]
#       id  x_val  y_val
#    <num> <char> <char>
# 1:     1     x1     y1
# 2:     2     x2     y2


# Done with rows, now focus on columns:
# To My Suprise:  Adding columns returns 3 rows. A few cases:   
#
# What am I missing? 
#
A[B, .(A.id = A$id), on=.(id), nomatch=NULL]
#     A.id
#    <num>
# 1:     1
# 2:     2
# 3:     3
A[B, .(B$id), on=.(id), nomatch=NULL]#
#       V1
#    <num>
# 1:     1
# 2:     2
# 3:     4
A[B, .(A.id = A$id, B.id= B$id,  A.x_val = A$x_val, B$y_val), on=.(id), nomatch=NULL]
#     A.id  B.id A.x_val     V4
#    <num> <num>  <char> <char>
# 1:     1     1      x1     y1
# 2:     2     2      x2     y2
# 3:     3     4      x3     y3


