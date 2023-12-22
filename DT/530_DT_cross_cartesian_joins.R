---
  title: test
---


##  cross join  (ie all combinations)
df1  <- data.frame(ONE=letters[1:3])
df1

df2  <- data.frame(TWO=letters[24:26])
df2

merge(df1, df2, by=NULL)
#   ONE TWO
# 1   a   x
# 2   b   x
# 3   c   x
# 4   a   y
# 5   b   y
# 6   c   y
# 7   a   z
# 8   b   z
# 9   c   z

# ------------------------------------------


##  outer join? FAILS
merge(df1, df2, by="ONE", all=T)





# ------------------------------------------
##  data.table:  cross join on TWO vectors

library(data.table)

ONE=letters[1:3]
TWO=letters[24:26]

CJ(ONE, TWO)
#    ONE TWO
# 1:   a   x
# 2:   a   y
# 3:   a   z
# 4:   b   x
# 5:   b   y
# 6:   b   z
# 7:   c   x
# 8:   c   y
# 9:   c   z



