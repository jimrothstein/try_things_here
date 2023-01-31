## file <- "144_dcast_.R "
## long to wide, dcast
library(data.table)
DT <- data.table(v1 = c(1.1, 1.1, 1.1, 2.2, 2.2, 2.2),
                 v2 = factor(c(1L, 1L, 1L, 3L, 3L, 3L), levels=1:3),
                 v3 = factor(c(2L, 3L, 5L, 1L, 2L, 6L), levels=1:6),
                 v4 = c(3L, 2L, 2L, 5L, 4L, 3L)
)

DT
long=DT

## key fields c(1,2)  v1+v2
## field v3 holds future column headings
## field v4 holds future values, for each future columnn heading
wide=dcast(long, v1+v2~v3, value.var='v4')             

